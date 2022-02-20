package iit.lims.util.sync.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@Service("syncScheduling")
public class SyncScheduling {
	@Resource
	private SyncService syncService;

	/**
	 * 식품정보 홈페이지 아이디 / 패스워드
	 * id : interfaceit
	 * password : inter123
	 * key : 01a86f3a97fb47429586
	 */
	
	private static String XML_URL = "http://openapi.foodsafetykorea.go.kr/api/";
	private static String XML_KEY = "01a86f3a97fb47429586";
	private static String XML_RESULT = "INFO-000";
	private static int PAGE_COUNT = 1000;
	
	public void syncDailyReserve() throws Exception {
		//품목분류(PRDLST_CL) : I2510
		sync("I2510");

		//시함항목코드(ANALYSIS) : I2530
		sync("I2530");

		//개별기준규격(INDV_SPEC) : I2580
		sync("I2580");
		
		//공통기준종류(CMMN_SPEC_KIND) : I2590
		sync("I2590");

		//공통기준규격(CMMN_SPEC) : I2600
		sync("I2600");

		//공통기준제외(CMMN_SPEC_KIND_EXPT_PRDLST) : I2610
		sync("I2610");

	}

	public void sync(String category) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar workCal = new GregorianCalendar();
        workCal.add(Calendar.DATE, -1);
        String workDate = sdf.format(workCal.getTime());

		HashMap map = new HashMap();
		map.put("sync_code", category);
		String lastSyncKey = syncService.selectLastSyncLog(map);
		int returnData = 0;
		if(lastSyncKey == null){
			map.put("sync_key", workDate);
			map.put("sync_range", "ALL");
			syncService.insertSyncLog(map);
			
			returnData = parseXML(category, "");
			if(returnData != -1){
				map.put("sync_cnt", returnData);
				syncService.updateSyncLog(map);
			}
		}else{
			int sYear = Integer.parseInt(lastSyncKey.substring(0, 4));
			int sMonth = Integer.parseInt(lastSyncKey.substring(4, 6))-1;
			int sDate = Integer.parseInt(lastSyncKey.substring(6, 8));

			int eYear = Integer.parseInt(workDate.substring(0, 4));
			int eMonth = Integer.parseInt(workDate.substring(4, 6))-1;
			int eDate = Integer.parseInt(workDate.substring(6, 8));

			Calendar startCal = Calendar.getInstance();
	        Calendar endCal = Calendar.getInstance();
			startCal.set(sYear, sMonth, sDate);
			startCal.set(Calendar.HOUR_OF_DAY, 1);

			endCal.set(eYear, eMonth, eDate);
	        endCal.set(Calendar.HOUR_OF_DAY, 0);

			String nextDate = ""; 
			while (!startCal.after(endCal)){
				startCal.add(Calendar.DATE, 1);
				nextDate = sdf.format(startCal.getTime());

				Date a = startCal.getTime();
				Date b = endCal.getTime();
				
				map.put("sync_key", nextDate);
				map.put("sync_range", nextDate);
				syncService.insertSyncLog(map);
				
				returnData = parseXML(category, nextDate);
				if(returnData != -1){
					map.put("sync_cnt", returnData);
					syncService.updateSyncLog(map);
				}
				//System.out.println ( lastCal.get ( Calendar.YEAR ) + "년 " + ( lastCal.get ( Calendar.MONTH ) + 1 ) + "월 " + lastCal.get ( Calendar.DATE ) + "일" );
			}
		}
	}

	public int parseXML(String category, String updtDtm) throws Exception {
		int returnData = 0;
		try {
			String url_tail = "";
			if(!updtDtm.equals("")){
				url_tail = "LAST_UPDT_DTM=" + updtDtm;
			}
			
			String xml_url = XML_URL + XML_KEY + "/" + category + "/xml/1/"+ PAGE_COUNT +"/" + url_tail;
			HttpClient httpClient = new DefaultHttpClient();
			HttpGet httpGet = new HttpGet(xml_url);
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();

			Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(entity.getContent());
			doc.getDocumentElement().normalize();

			//결과코드
			NodeList resultList = doc.getElementsByTagName("RESULT");
			Element resultElement = (Element) resultList.item(0);
			String result = getTagValue("CODE", resultElement);
			
			if(result.equals(XML_RESULT)){
				//전체 레코드수
				int totalCount = Integer.parseInt(getTagValue("total_count",doc.getDocumentElement()));
				int totalPage = (int) Math.ceil(totalCount/(double)PAGE_COUNT);

				ArrayList<HashMap> syncListAll = new ArrayList<HashMap>();
				//1000건 이상
				if(totalCount > PAGE_COUNT){
					for (int i = 1; i <= totalPage; ++i) {
						xml_url = XML_URL + XML_KEY + "/" + category + "/xml/"+ (((i-1)*PAGE_COUNT)+1) +"/"+ i*PAGE_COUNT +"/" + url_tail;
						httpGet = new HttpGet(xml_url);
						response = httpClient.execute(httpGet);
						entity = response.getEntity();
						doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(entity.getContent());
						doc.getDocumentElement().normalize();

						//결과코드
						resultList = doc.getElementsByTagName("RESULT");
						resultElement = (Element) resultList.item(0);
						result = getTagValue("CODE", resultElement);
						
						if(result.equals(XML_RESULT)){
							syncListAll.addAll(makeDataList(category, doc.getElementsByTagName("row")));
						}
					}
				}else{
					syncListAll.addAll(makeDataList(category, doc.getElementsByTagName("row")));
				}
				
				syncService.insertSyncTarget(category, syncListAll);
				returnData = totalCount;
			}

		} catch (Exception e) {
			//커넥션 오류
			returnData = -1;
		}
		return returnData;

	}

	/**
	 * 품목분류(PRDLST_CL) : I2510
	 * 공통기준종류(CMMN_SPEC_KIND) : I2590
	 * 시함항목코드(ANALYSIS) : I2530
	 * 개별기준규격(INDV_SPEC) : I2580
	 * 공통기준규격(CMMN_SPEC) : I2600
	 * 공통기준제외(CMMN_SPEC_KIND_EXPT_PRDLST) : I2610
	 */
	public ArrayList<HashMap> makeDataList(String category, NodeList rowIdList) throws Exception {
		
		ArrayList<HashMap> syncList = new ArrayList<HashMap>();
		
		for (int i = 0; i < rowIdList.getLength(); ++i) {
			Element rowElement = (Element) rowIdList.item(i);
			HashMap rowMap = new HashMap();
			if(category.equals("I2510")){
				String prdlst_cd      = getTagValue("PRDLST_CD", rowElement);
				String kor_nm         = getTagValue("KOR_NM", rowElement);
				String lv             = getTagValue("LV", rowElement);
				String use_yn         = getTagValue("USE_YN", rowElement);
				String eng_nm         = getTagValue("ENG_NM", rowElement);
				String vald_end_dt    = getTagValue("VALD_END_DT", rowElement);
				String vald_begn_dt   = getTagValue("VALD_BEGN_DT", rowElement);
				String rm             = getTagValue("RM", rowElement);
				String prdlst_yn      = getTagValue("PRDLST_YN", rowElement);
				String dfn            = getTagValue("DFN", rowElement);
				String attrb_seq      = getTagValue("ATTRB_SEQ", rowElement);
				String updt_prvns     = getTagValue("UPDT_PRVNS", rowElement);
				String last_updt_dtm  = getTagValue("LAST_UPDT_DTM", rowElement);
				String piam_kor_nm    = getTagValue("PIAM_KOR_NM", rowElement);
				String htrk_prdlst_cd = getTagValue("HTRK_PRDLST_CD", rowElement);
				String hrnk_prdlst_cd = getTagValue("HRNK_PRDLST_CD", rowElement);
				String mxtr_prdlst_yn = getTagValue("MXTR_PRDLST_YN", rowElement);
	
				rowMap.put("prdlst_cd", prdlst_cd);
				rowMap.put("kor_nm", kor_nm);
				rowMap.put("lv", lv);
				rowMap.put("use_yn", use_yn);
				rowMap.put("eng_nm", eng_nm);
				rowMap.put("vald_end_dt", vald_end_dt);
				rowMap.put("vald_begn_dt", vald_begn_dt);
				rowMap.put("rm", rm);
				rowMap.put("prdlst_yn", prdlst_yn);
				rowMap.put("dfn", dfn);
				rowMap.put("attrb_seq", attrb_seq);
				rowMap.put("updt_prvns", updt_prvns);
				rowMap.put("last_updt_dtm", last_updt_dtm);
				rowMap.put("piam_kor_nm", piam_kor_nm);
				rowMap.put("htrk_prdlst_cd", htrk_prdlst_cd);
				rowMap.put("hrnk_prdlst_cd", hrnk_prdlst_cd);
				rowMap.put("mxtr_prdlst_yn", mxtr_prdlst_yn);
			}else if(category.equals("I2530")){
				String testitm_cd       = getTagValue("TESTITM_CD", rowElement);
				String eng_nm           = getTagValue("ENG_NM", rowElement);
				String testitm_nm       = getTagValue("TESTITM_NM", rowElement);
				String use_yn           = getTagValue("USE_YN", rowElement);
				String ncknm            = getTagValue("NCKNM", rowElement);
				String abrv             = getTagValue("ABRV", rowElement);
				String l_kor_nm         = getTagValue("L_KOR_NM", rowElement);
				String last_updt_dtm    = getTagValue("LAST_UPDT_DTM", rowElement);
				String testitm_lclas_cd = getTagValue("TESTITM_LCLAS_CD", rowElement);
				String remn_mttr_dfn    = getTagValue("REMN_MTTR_DFN", rowElement);
				String m_kor_nm         = getTagValue("M_KOR_NM", rowElement);
				String kor_nm           = getTagValue("KOR_NM", rowElement);
				String testitm_mlsfc_cd = getTagValue("TESTITM_MLSFC_CD", rowElement);

				rowMap.put("testitm_cd", testitm_cd);
				rowMap.put("eng_nm", eng_nm);
				rowMap.put("testitm_nm", testitm_nm);
				rowMap.put("use_yn", use_yn);
				rowMap.put("ncknm", ncknm);
				rowMap.put("abrv", abrv);
				rowMap.put("l_kor_nm", l_kor_nm);
				rowMap.put("last_updt_dtm", last_updt_dtm);
				rowMap.put("testitm_lclas_cd", testitm_lclas_cd);
				rowMap.put("remn_mttr_dfn", remn_mttr_dfn);
				rowMap.put("m_kor_nm", m_kor_nm);
				rowMap.put("kor_nm", kor_nm);
				rowMap.put("testitm_mlsfc_cd", testitm_mlsfc_cd);
			}else if(category.equals("I2580")){
				String testitm_cd             = getTagValue("TESTITM_CD", rowElement);
				String prdlst_cd              = getTagValue("PRDLST_CD", rowElement);
				String sorc                   = getTagValue("SORC", rowElement);
				String vald_end_dt            = getTagValue("VALD_END_DT", rowElement);
				String mxmm_val               = getTagValue("MXMM_VAL", rowElement);
				String fnprt_itm_nm           = getTagValue("FNPRT_ITM_NM", rowElement);
				String prdlst_cd_nm           = getTagValue("PRDLST_CD_NM", rowElement);
				String mxmm_val_dvs_cd        = getTagValue("MXMM_VAL_DVS_CD", rowElement);
				String attrb_seq              = getTagValue("ATTRB_SEQ", rowElement);
				String updt_prvns             = getTagValue("UPDT_PRVNS", rowElement);
				String last_updt_dtm          = getTagValue("LAST_UPDT_DTM", rowElement);
				String mcrrgnsm_2n            = getTagValue("MCRRGNSM_2N", rowElement);
				String mcrrgnsm_2m            = getTagValue("MCRRGNSM_2M", rowElement);
				String spec_val               = getTagValue("SPEC_VAL", rowElement);
				String mcrrgnsm_2c            = getTagValue("MCRRGNSM_2C", rowElement);
				String vald_manli             = getTagValue("VALD_MANLI", rowElement);
				String a082_cf_fnprt_cd_nm    = getTagValue("A082_CF_FNPRT_CD_NM", rowElement);
				String testitm_nm             = getTagValue("TESTITM_NM", rowElement);
				String choic_impropt          = getTagValue("CHOIC_IMPROPT", rowElement);
				String a082_ci_fnprt_cd_nm    = getTagValue("A082_CI_FNPRT_CD_NM", rowElement);
				String spec_val_sumup         = getTagValue("SPEC_VAL_SUMUP", rowElement);
				String vald_begn_dt           = getTagValue("VALD_BEGN_DT", rowElement);
				String injry_yn               = getTagValue("INJRY_YN", rowElement);
				String a080_fnprt_cd_nm       = getTagValue("A080_FNPRT_CD_NM", rowElement);
				String fnprt_itm_incls_yn     = getTagValue("FNPRT_ITM_INCLS_YN", rowElement);
				String indv_spec_seq          = getTagValue("INDV_SPEC_SEQ", rowElement);
				String mimm_val_dvs_cd        = getTagValue("MIMM_VAL_DVS_CD", rowElement);
				String ntr_prsec_itm_yn       = getTagValue("NTR_PRSEC_ITM_YN", rowElement);
				String montrng_testitm_yn     = getTagValue("MONTRNG_TESTITM_YN", rowElement);
				String unit_cd                = getTagValue("UNIT_CD", rowElement);
				String choic_fit              = getTagValue("CHOIC_FIT", rowElement);
				String piam_kor_nm            = getTagValue("PIAM_KOR_NM", rowElement);
				String emphs_prsec_testitm_yn = getTagValue("EMPHS_PRSEC_TESTITM_YN", rowElement);
				String jdgmnt_fom_cd          = getTagValue("JDGMNT_FOM_CD", rowElement);
				String mimm_val               = getTagValue("MIMM_VAL", rowElement);
				String unit_nm                = getTagValue("UNIT_NM", rowElement);
				String rvlv_else_testitm_yn   = getTagValue("RVLV_ELSE_TESTITM_YN", rowElement);
				String mcrrgnsm_3m            = getTagValue("MCRRGNSM_3M", rowElement);
				String a081_fnprt_cd_nm       = getTagValue("A081_FNPRT_CD_NM", rowElement);
				String a079_fnprt_cd_nm       = getTagValue("A079_FNPRT_CD_NM", rowElement);
				
				rowMap.put("testitm_cd", testitm_cd);
				rowMap.put("prdlst_cd", prdlst_cd);
				rowMap.put("sorc", sorc);
				rowMap.put("vald_end_dt", vald_end_dt);
				rowMap.put("mxmm_val", mxmm_val);
				rowMap.put("fnprt_itm_nm", fnprt_itm_nm);
				rowMap.put("prdlst_cd_nm", prdlst_cd_nm);
				rowMap.put("mxmm_val_dvs_cd", mxmm_val_dvs_cd);
				rowMap.put("attrb_seq", attrb_seq);
				rowMap.put("updt_prvns", updt_prvns);
				rowMap.put("last_updt_dtm", last_updt_dtm);
				rowMap.put("mcrrgnsm_2n", mcrrgnsm_2n);
				rowMap.put("mcrrgnsm_2m", mcrrgnsm_2m);
				rowMap.put("spec_val", spec_val);
				rowMap.put("mcrrgnsm_2c", mcrrgnsm_2c);
				rowMap.put("vald_manli", vald_manli);
				rowMap.put("a082_cf_fnprt_cd_nm", a082_cf_fnprt_cd_nm);
				rowMap.put("testitm_nm", testitm_nm);
				rowMap.put("choic_impropt", choic_impropt);
				rowMap.put("a082_ci_fnprt_cd_nm", a082_ci_fnprt_cd_nm);
				rowMap.put("spec_val_sumup", spec_val_sumup);
				rowMap.put("vald_begn_dt", vald_begn_dt);
				rowMap.put("injry_yn", injry_yn);
				rowMap.put("a080_fnprt_cd_nm", a080_fnprt_cd_nm);
				rowMap.put("fnprt_itm_incls_yn", fnprt_itm_incls_yn);
				rowMap.put("indv_spec_seq", indv_spec_seq);
				rowMap.put("mimm_val_dvs_cd", mimm_val_dvs_cd);
				rowMap.put("ntr_prsec_itm_yn", ntr_prsec_itm_yn);
				rowMap.put("montrng_testitm_yn", montrng_testitm_yn);
				rowMap.put("unit_cd", unit_cd);
				rowMap.put("choic_fit", choic_fit);
				rowMap.put("piam_kor_nm", piam_kor_nm);
				rowMap.put("emphs_prsec_testitm_yn", emphs_prsec_testitm_yn);
				rowMap.put("jdgmnt_fom_cd", jdgmnt_fom_cd);
				rowMap.put("mimm_val", mimm_val);
				rowMap.put("unit_nm", unit_nm);
				rowMap.put("rvlv_else_testitm_yn", rvlv_else_testitm_yn  );
				rowMap.put("mcrrgnsm_3m", mcrrgnsm_3m);
				rowMap.put("a081_fnprt_cd_nm", a081_fnprt_cd_nm);
				rowMap.put("a079_fnprt_cd_nm", a079_fnprt_cd_nm);
			}else if(category.equals("I2590")){
				String cmmn_spec_cd      = getTagValue("CMMN_SPEC_CD", rowElement);
				String lv                = getTagValue("LV", rowElement);
				String use_yn            = getTagValue("USE_YN", rowElement);
				String last_updt_dtm     = getTagValue("LAST_UPDT_DTM", rowElement);
				String dfn               = getTagValue("DFN", rowElement);
				String hrnk_cmmn_spec_cd = getTagValue("HRNK_CMMN_SPEC_CD", rowElement);
				String spec_nm           = getTagValue("SPEC_NM", rowElement);
				
				rowMap.put("cmmn_spec_cd", cmmn_spec_cd);
				rowMap.put("lv", lv);
				rowMap.put("use_yn", use_yn);
				rowMap.put("last_updt_dtm", last_updt_dtm);
				rowMap.put("dfn", dfn);
				rowMap.put("hrnk_cmmn_spec_cd", hrnk_cmmn_spec_cd);
				rowMap.put("spec_nm", spec_nm);				
			}else if(category.equals("I2600")){
				String cmmn_spec_seq          = getTagValue("CMMN_SPEC_SEQ", rowElement);
				String testitm_cd             = getTagValue("TESTITM_CD", rowElement);
				String prdlst_cd              = getTagValue("PRDLST_CD", rowElement);
				String sorc                   = getTagValue("SORC", rowElement);
				String vald_end_dt            = getTagValue("VALD_END_DT", rowElement);
				String mxmm_val               = getTagValue("MXMM_VAL", rowElement);
				String fnprt_itm_nm           = getTagValue("FNPRT_ITM_NM", rowElement);
				String prdlst_cd_nm           = getTagValue("PRDLST_CD_NM", rowElement);
				String mxmm_val_dvs_cd        = getTagValue("MXMM_VAL_DVS_CD", rowElement);
				String attrb_seq              = getTagValue("ATTRB_SEQ", rowElement);
				String updt_prvns             = getTagValue("UPDT_PRVNS", rowElement);
				String last_updt_dtm          = getTagValue("LAST_UPDT_DTM", rowElement);
				String mcrrgnsm_2n            = getTagValue("MCRRGNSM_2N", rowElement);
				String cmmn_spec_cd           = getTagValue("CMMN_SPEC_CD", rowElement);
				String mcrrgnsm_2m            = getTagValue("MCRRGNSM_2M", rowElement);
				String spec_val               = getTagValue("SPEC_VAL", rowElement);
				String mcrrgnsm_2c            = getTagValue("MCRRGNSM_2C", rowElement);
				String a082_cf_fnprt_cd_nm    = getTagValue("A082_CF_FNPRT_CD_NM", rowElement);
				String vald_manli             = getTagValue("VALD_MANLI", rowElement);
				String testitm_nm             = getTagValue("TESTITM_NM", rowElement);
				String choic_impropt          = getTagValue("CHOIC_IMPROPT", rowElement);
				String a082_ci_fnprt_cd_nm    = getTagValue("A082_CI_FNPRT_CD_NM", rowElement);
				String spec_val_sumup         = getTagValue("SPEC_VAL_SUMUP", rowElement);
				String vald_begn_dt           = getTagValue("VALD_BEGN_DT", rowElement);
				String injry_yn               = getTagValue("INJRY_YN", rowElement);
				String a080_fnprt_cd_nm       = getTagValue("A080_FNPRT_CD_NM", rowElement);
				String fnprt_itm_incls_yn     = getTagValue("FNPRT_ITM_INCLS_YN", rowElement);
				String mimm_val_dvs_cd        = getTagValue("MIMM_VAL_DVS_CD", rowElement);
				String ntr_prsec_itm_yn       = getTagValue("NTR_PRSEC_ITM_YN", rowElement);
				String montrng_testitm_yn     = getTagValue("MONTRNG_TESTITM_YN", rowElement);
				String unit_cd                = getTagValue("UNIT_CD", rowElement);
				String choic_fit              = getTagValue("CHOIC_FIT", rowElement);
				String piam_kor_nm            = getTagValue("PIAM_KOR_NM", rowElement);
				String emphs_prsec_testitm_yn = getTagValue("EMPHS_PRSEC_TESTITM_YN", rowElement);
				String jdgmnt_fom_cd          = getTagValue("JDGMNT_FOM_CD", rowElement);
				String mimm_val               = getTagValue("MIMM_VAL", rowElement);
				String unit_nm                = getTagValue("UNIT_NM", rowElement);
				String rvlv_else_testitm_yn   = getTagValue("RVLV_ELSE_TESTITM_YN", rowElement);
				String mcrrgnsm_3m            = getTagValue("MCRRGNSM_3M", rowElement);
				String a081_fnprt_cd_nm       = getTagValue("A081_FNPRT_CD_NM", rowElement);
				String spec_nm                = getTagValue("SPEC_NM", rowElement);
				String a079_fnprt_cd_nm       = getTagValue("A079_FNPRT_CD_NM", rowElement);
				
				rowMap.put("cmmn_spec_seq", cmmn_spec_seq);
				rowMap.put("testitm_cd", testitm_cd);
				rowMap.put("prdlst_cd", prdlst_cd);
				rowMap.put("sorc", sorc);
				rowMap.put("vald_end_dt", vald_end_dt);
				rowMap.put("mxmm_val", mxmm_val);
				rowMap.put("fnprt_itm_nm", fnprt_itm_nm);
				rowMap.put("prdlst_cd_nm", prdlst_cd_nm);
				rowMap.put("mxmm_val_dvs_cd", mxmm_val_dvs_cd);
				rowMap.put("attrb_seq", attrb_seq);
				rowMap.put("updt_prvns", updt_prvns);
				rowMap.put("last_updt_dtm", last_updt_dtm);
				rowMap.put("mcrrgnsm_2n", mcrrgnsm_2n);
				rowMap.put("cmmn_spec_cd", cmmn_spec_cd);
				rowMap.put("mcrrgnsm_2m", mcrrgnsm_2m);
				rowMap.put("spec_val", spec_val);
				rowMap.put("mcrrgnsm_2c", mcrrgnsm_2c);
				rowMap.put("a082_cf_fnprt_cd_nm", a082_cf_fnprt_cd_nm);
				rowMap.put("vald_manli", vald_manli);
				rowMap.put("testitm_nm", testitm_nm);
				rowMap.put("choic_impropt", choic_impropt);
				rowMap.put("a082_ci_fnprt_cd_nm", a082_ci_fnprt_cd_nm);
				rowMap.put("spec_val_sumup", spec_val_sumup);
				rowMap.put("vald_begn_dt", vald_begn_dt);
				rowMap.put("injry_yn", injry_yn);
				rowMap.put("a080_fnprt_cd_nm", a080_fnprt_cd_nm);
				rowMap.put("fnprt_itm_incls_yn", fnprt_itm_incls_yn);
				rowMap.put("mimm_val_dvs_cd", mimm_val_dvs_cd);
				rowMap.put("ntr_prsec_itm_yn", ntr_prsec_itm_yn);
				rowMap.put("montrng_testitm_yn", montrng_testitm_yn);
				rowMap.put("unit_cd", unit_cd);
				rowMap.put("choic_fit", choic_fit);
				rowMap.put("piam_kor_nm", piam_kor_nm);
				rowMap.put("emphs_prsec_testitm_yn", emphs_prsec_testitm_yn);
				rowMap.put("jdgmnt_fom_cd", jdgmnt_fom_cd);
				rowMap.put("mimm_val", mimm_val);
				rowMap.put("unit_nm", unit_nm);
				rowMap.put("rvlv_else_testitm_yn", rvlv_else_testitm_yn  );
				rowMap.put("mcrrgnsm_3m", mcrrgnsm_3m);
				rowMap.put("a081_fnprt_cd_nm", a081_fnprt_cd_nm);
				rowMap.put("spec_nm", spec_nm);
				rowMap.put("a079_fnprt_cd_nm", a079_fnprt_cd_nm);
			}else if(category.equals("I2610")){
				String testitm_cd    = getTagValue("TESTITM_CD", rowElement);
				String prdlst_cd     = getTagValue("PRDLST_CD", rowElement);
				String last_updt_dtm = getTagValue("LAST_UPDT_DTM", rowElement);
				String kor_nm        = getTagValue("KOR_NM", rowElement);
				String cmmn_spec_cd  = getTagValue("CMMN_SPEC_CD", rowElement);
				String spec_nm       = getTagValue("SPEC_NM", rowElement);
				
				rowMap.put("testitm_cd", testitm_cd);
				rowMap.put("prdlst_cd", prdlst_cd);
				rowMap.put("last_updt_dtm", last_updt_dtm);
				rowMap.put("kor_nm", kor_nm);
				rowMap.put("cmmn_spec_cd", cmmn_spec_cd);
				rowMap.put("spec_nm", spec_nm);
			}
			syncList.add(rowMap);

		}
		return syncList;

	}

	
	private static String getTagValue(String tag, Element rowElement) {
	    NodeList nodeList = rowElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nodeValue = (Node) nodeList.item(0);
	    if(nodeValue == null) 
	        return "";
	    return nodeValue.getNodeValue();
	}	
}