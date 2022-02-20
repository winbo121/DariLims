package iit.lims.common.controller;

import iit.lims.accept.service.CommissionService;
import iit.lims.accept.service.EstimateService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.EstimateVO;
import iit.lims.analysis.service.TestReportService;
import iit.lims.analysis.vo.SampleStateVO;
import iit.lims.analysis.vo.TestReportVO;
import iit.lims.common.service.CommonService;
import iit.lims.common.vo.CommonVO;
import iit.lims.common.vo.DemoSampleVO;
import iit.lims.common.vo.ExcelVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.common.vo.MessageVO;
import iit.lims.common.vo.ZipCodeVO;
import iit.lims.master.service.AccountService;
import iit.lims.master.vo.FormulaVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.report.service.ReportPublishService;
import iit.lims.report.vo.ReportVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonTextView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.jxls.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import sun.misc.BASE64Encoder;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class CommonController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private CommonService commonService;
	
	@Resource
	private EstimateService estimateService;
	
	@Resource
	private CommissionService commissionService;
	
	@Resource
	private TestReportService testReportService;
	
	@Resource
	private AccountService AccountService;

	@Resource
	private ReportPublishService reportPublishService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired private ServletContext servletContext;

	/**
	 * 로그인 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/login.lims")
	public String login() {
		
		String[] args =  new String[1];
		return "common/login";
	}

	
	/**
	 * 로그인 처리
	 * 
	 * @param UserInfoVO
	 *            , MessageVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/loginCheck.lims")
	public ModelAndView loginCheck(HttpServletRequest request, @ModelAttribute("userInfoVO") UserInfoVO userInfoVO, MessageVO messageVO, Model model) throws Exception {
		BASE64Encoder encoder = new BASE64Encoder();
		
		HttpSession session = null;
		
		userInfoVO.setUser_pw(encoder.encode(userInfoVO.getUser_pw().getBytes())); // 비밀번호 Base64로 인코딩
		UserInfoVO vo = commonService.loginCheck(userInfoVO);

		session = request.getSession();
		session.removeAttribute("session"); // 기본 세션 삭제
		session.setAttribute("session", vo);
		//session.setMaxInactiveInterval(60 * 60); //세션시간 1시간
		session.setMaxInactiveInterval(60 * 180); //세션시간 3시간
		messageVO.setMessage(vo.getMessage());

		model.addAttribute("resultData", messageVO);
		return new ModelAndView(new JsonTextView());
	}
	
	/**
	 * 로그아웃 처리
	 * 
	 * @param UserInfoVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/logout.lims")
	public ModelAndView logout(HttpServletRequest request, Model model, UserInfoVO userInfoVO) throws Exception {

		UserInfoVO vo = SessionCheck.getSession(request);

		userInfoVO.setUser_ip(InetAddress.getLocalHost().getHostAddress());
		userInfoVO.setUser_id(vo.getUser_id());

		commonService.logout(vo);

		request.getSession().invalidate();

		model.addAttribute("resultData", "loginout");
		return new ModelAndView(new JsonTextView());
	}
	
	/**
	 * 메인 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/main.lims")
	public String main(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setDept_cd(userInfoVO.getDept_cd());
			vo.setUser_id(userInfoVO.getUser_id());
			
			String commission_flag = commissionService.commissionFlag();
			vo.setCommission_flag(commission_flag);
			//System.out.println(account_flag);			
			
			model.addAttribute("deadline", commonService.selectDeadlineSampleList(vo));
			model.addAttribute("resultInput", commonService.selectResultInputList(vo));
			model.addAttribute("resultMainCnt", commonService.selectResultMainCntList(vo));
			model.addAttribute("machineMainCnt", commonService.selectMachineMainCntList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/mainFrame";
	}
	
	/**
	 * 메인 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mainContents.lims")
	public String mainContents(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			//vo.setUser_id(userInfoVO.getUser_id());
		
		
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/mainContents";
	}
	
	/**
	 * 메뉴목록 조회 처리
	 * 
	 * @param RoleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectMenuList.lims")
	public ModelAndView selectMenuList(HttpServletRequest request, Model model, UserInfoVO vo) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		//vo.setUser_id(userInfoVO.getUser_id());
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_id", userInfoVO.getUser_id());

		model.addAttribute("resultData", commonService.selectMenuList(map));
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * SAMPLE 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sample/gridSample.lims")
	public String sample(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			//vo.setUser_id(userInfoVO.getUser_id());
			String language =	request.getParameter("language");
			System.out.println(language);
			model.addAttribute("locales", language);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "sample/gridSample";
	}
	

	/**
	 * sample목록 조회 처리
	 * 
	 * @param DemoSampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sample/selectSampleList.lims")
	public ModelAndView selectSampleList(HttpServletRequest request, Model model, DemoSampleVO sampleVO) throws Exception{
		
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setUser_id(userInfoVO.getUser_id());
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("user_id", userInfoVO.getUser_id());
			
		/*	String sample_nm = sampleVO.getSample_nm();
			map.put("sample_nm", sample_nm);
			
			*/
			System.out.println("selectSampleList");
			
			List<DemoSampleVO> gridList = commonService.selectSampleList(sampleVO);
			DemoSampleVO returnVO = new DemoSampleVO();
			
			if(gridList.size() > 0){
				returnVO.setRows(gridList);
				DemoSampleVO total = (DemoSampleVO)gridList.get(0);
				returnVO.setTotalCount(total.getTotalCount());
				returnVO.setPageNum(total.getPageNum());
				//returnVO.setPageNum(2);
				//returnVO.setPageSize(20);
				returnVO.setTotalPage(total.getTotalPage());
				returnVO.setTotal(total.getTotalCount());
				//returnVO.setPageNum(sampleVO.getPageNum());
			}
			
			
			model.addAttribute("resultData", returnVO);
			
			
		}catch (Exception e){
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
		
	}
	
	/**
	 * CHART SAMPLE 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sample/chartSample.lims")
	public String chartSample(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			//vo.setUser_id(userInfoVO.getUser_id());
			String language =	request.getParameter("language");
			System.out.println(language);
			model.addAttribute("locales", language);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "sample/chartSample";
	}

	
	/**
	 * REPORT SAMPLE 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sample/reportSample.lims")
	public String  reportSample(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			//vo.setUser_id(userInfoVO.getUser_id());
			String language =	request.getParameter("language");
			System.out.println(language);
			model.addAttribute("locales", language);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

        return "sample/reportSample";

			
	}
	
	/**
	 * REPORT SAMPLE 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sample/excelReportSample.lims")
	public String  excelReportSample(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			//vo.setUser_id(userInfoVO.getUser_id());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

        return "sample/excelReportSample";

			
	}
	
	/**
	 * REPORT SAMPLE 페이지 전환 처리
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportSamplePOP.lims")
	public String  reportSamplePOP(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			//vo.setUser_id(userInfoVO.getUser_id());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

        return "sample/reportSamplePOP";
	}
	
	
	
	@RequestMapping("/estimateView.lims")
	public void estimateView(HttpServletRequest request, HttpServletResponse response, Model model, EstimateVO estimateVO){
		try {
			Context context = new Context();
			int total1 ;
			int total2 ;
			int total3 = 0;
			int vat = 0;
			int total = 0;
			int total_qty = 0;
			String est_date = "";
			
			EstimateVO excelEstList = estimateService.selectEstimateDetail(estimateVO);
			// 견적업체
			String est_org_nm = excelEstList.getEst_org_nm();
			context.putVar("est_org_nm", est_org_nm);
			context.putVar("est_charger_nm", excelEstList.getEst_charger_nm());
			
			List<EstimateVO> excelDataList = estimateService.selectEstimateItemList(estimateVO);
			
			if(excelDataList.size() > 0){
				int temp = 0;
				int temp2 = 0;
				for(int i=0; i< excelDataList.size();i++){
					EstimateVO tempVO = excelDataList.get(i);
					temp += Integer.parseInt(tempVO.getEst_price_total());
					temp2 += Integer.parseInt(tempVO.getEst_qty());
				}
				total1 = temp;
				total_qty = temp2;
				// 시험분석료합계
				context.putVar("total1", total1);
				context.putVar("total_qty", total_qty);
				total3 += total1;
			}
			List<EstimateVO> excelDataFeeList = estimateService.selectEstimateItemFeeList(estimateVO);
			if(excelDataFeeList.size() > 0){
				int temp = 0;
				for(int i=0; i< excelDataFeeList.size();i++){
					EstimateVO tempVO = excelDataFeeList.get(i);
					context.putVar(tempVO.getEst_exp_nm(), Integer.parseInt(tempVO.getEst_fee_price()));
					context.putVar(tempVO.getEst_exp_nm()+"_desc", tempVO.getEst_fee_desc());
					temp += Integer.parseInt(tempVO.getEst_fee_price());
				}
				total2 = temp;
				// 항목수수료합계
				context.putVar("total2", total2);
				total3 += total2;
			}
			// 소수점금액은 계산안함
			vat = (int)(total3 * 0.1);
			total = total3 + vat;
			
		    //소계
			context.putVar("total3", total3);
			//부가세
			context.putVar("vat", vat);
			//합계
			context.putVar("total", total);
			//발급일(발급당일기준)
			//dataMap.put("est_date", est_date);
			//발급일(견적작성일기준)EST_DATE
			if (est_date != null){
				est_date = excelEstList.getEst_date();
				est_date = est_date.substring(0, 4) + " 년 " + est_date.substring(5, 7) + " 월 " + est_date.substring(8, 10) + " 일";
			}
			context.putVar("est_date", est_date);
			//견적서제목
			context.putVar("title", "시험분석 견적서");
			//견적리스트
			context.putVar("itemList", excelDataList);
			//견적번호
			context.putVar("est_no", estimateVO.getEst_no());
			
			// template 파일
			log.debug("doc_seq : "+request.getParameter("doc_seq"));
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			
			File dir = new File(excelReportPath);
			if(!dir.exists()){
				dir.mkdirs();
				log.debug("MKDIR : "+ excelReportPath);
			}
			
			String file_info = commonService.selectDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+doc_seq + "/" + file_info;

			
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));
			String fileName = excelEstList.getEst_no()+"_"+excelEstList.getEst_date()+".xls";
			
			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");

			/* 직인 이미지*/
	        File stampfile = new File(excelReportPath+"/stamp2.png");
	        InputStream stampInputStream = new FileInputStream(stampfile);
            byte[] bstamp = Util.toByteArray(stampInputStream);
            context.putVar("stampImage", bstamp);
            
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);
			int temp = estimateService.updateEstimateState(estimateVO.getEst_no());
			model.addAttribute("result", temp);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("/reportView.lims")
	public void reportView(HttpServletRequest request, HttpServletResponse response, Model model, ReportVO reportVO){
		try {
			
			Context context = new Context();
			ReportVO reportInfo = commonService.selectReportInfo(reportVO);

			context.putVar("report_doc_seq", "발급번호 : "+reportInfo.getReport_doc_seq()+" 호");
			context.putVar("req_date", reportInfo.getReq_date());
			context.putVar("create_date", reportInfo.getCreate_date());
			context.putVar("destination_nm", reportInfo.getDestination_nm());
			context.putVar("req_nm", reportInfo.getReq_nm());
			context.putVar("test_req_no", reportInfo.getTest_req_no());
			context.putVar("req_org_addr", reportInfo.getReq_org_addr());
			context.putVar("test_goal", reportInfo.getTest_goal());
			context.putVar("req_class", reportInfo.getReq_class());
			context.putVar("test_period", reportInfo.getTest_period());
			context.putVar("sample_reg_nm", reportInfo.getSample_reg_nm());
			context.putVar("test_method_nm", reportInfo.getTest_method_nm());
			context.putVar("verify_id", reportInfo.getVerify_id());
			context.putVar("tester_id", reportInfo.getTester_id());
			context.putVar("appr_id", reportInfo.getAppr_id());
			context.putVar("pre_tel_num", reportInfo.getPre_tel_num());
			context.putVar("pre_fax_num", reportInfo.getPre_fax_num());
			context.putVar("biz_no", reportInfo.getBiz_no());
			context.putVar("produce_date", reportInfo.getProduce_date());
			context.putVar("produce_no", reportInfo.getProduce_no());
			context.putVar("producer_nm", reportInfo.getProducer_nm());
			context.putVar("produce_place", reportInfo.getProduce_place());
			context.putVar("sample_etc_nm", reportInfo.getSample_etc_nm());
			context.putVar("expiry_date", reportInfo.getExpiry_date());
			context.putVar("sample_weight", reportInfo.getSample_weight());
			context.putVar("keep_method", reportInfo.getKeep_method());
			context.putVar("orderer_nm", reportInfo.getOrderer_nm());
			context.putVar("builder_nm", reportInfo.getBuilder_nm());
			context.putVar("joiner_nm", reportInfo.getJoiner_nm());
			context.putVar("collector_nm", reportInfo.getCollector_nm());
			context.putVar("collect_date", reportInfo.getCollect_date());
			context.putVar("tot_item_count", reportInfo.getTot_item_count());
			context.putVar("jdg_type", reportInfo.getJdg_type());
			context.putVar("act_user_id", "접수담당 : "+reportInfo.getAct_user_id()+"");
			context.putVar("act_date", reportInfo.getAct_date());
			context.putVar("report_no", reportInfo.getReport_no());
			context.putVar("pre_man", reportInfo.getPre_man());
			context.putVar("nd_prdlst_nm", reportInfo.getPrdlst_nm());
			context.putVar("nd_test_item_nm", "-");
			context.putVar("nd_std_val", "-");
			context.putVar("nd_report_disp_val", reportInfo.getPrdlst_nm() + "\n\r정량한계 미만");
			context.putVar("nd_sample_etc_nm", "불검출");
			context.putVar("test_item_nm", reportInfo.getTest_item_nm());
			context.putVar("detect_jdg_type", reportInfo.getDetect_jdg_type());
			
			//검출
			List<ReportVO> reportInfoItem = commonService.selectReportInfoItem(reportVO);
			//불검출
			List<ReportVO> reportInfoItem2 = commonService.selectReportInfoItem2(reportVO);
			
			if(reportInfoItem.size() == 0){
				ReportVO voTemp = new ReportVO();
				voTemp.setTest_item_nm("-");
				voTemp.setStd_val("-");
				voTemp.setReport_disp_val("-");
				reportInfoItem.add(0, voTemp);
			}
			
			if(reportInfoItem2.size() == 0){
				ReportVO voTemp = new ReportVO();
				voTemp.setTestitm_mlsfc_nm("-");
				voTemp.setTest_item_nm("-");
				reportInfoItem2.add(0, voTemp);
			}
			
//			String prdlst_nm;
//			prdlst_nm = reportInfo.getPrdlst_nm();
//
//			//불검출관련 정보
//			if(reportInfoItem.size() < 1){
//				ReportVO tempVO = new ReportVO();
//				tempVO.setPrdlst_nm(prdlst_nm);
//				tempVO.setTest_item_nm("-");
//				tempVO.setStd_val("-");
//				tempVO.setReport_disp_val(prdlst_nm+"\n\r검출한계 미만");
//				tempVO.setSample_etc_nm("불검출");
//				reportInfoItem.add(tempVO);
//			}
			context.putVar("itemList", reportInfoItem);
			context.putVar("itemList2", reportInfoItem2);
			
			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
			context.putVar("report_date", report_date);
			
			// template 파일
			log.debug("doc_seq : "+reportInfo.getReport_type());
			String doc_seq = reportInfo.getReport_type();
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+doc_seq + "/" + file_info;
			
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));
			String fileName = reportInfo.getReport_doc_seq()+"_"+reportInfo.getReq_date()+".xls";
			
			/* 로고 이미지*/
	        File imgfile = new File(excelReportPath+"/logo.png");
	        InputStream imageInputStream = new FileInputStream(imgfile);
            byte[] imageBytes = Util.toByteArray(imageInputStream);
            context.putVar("logoImage", imageBytes);

			/* 직인 이미지*/
	        File stampfile = new File(excelReportPath+"/stamp.png");
	        InputStream stampInputStream = new FileInputStream(stampfile);
            byte[] bstamp = Util.toByteArray(stampInputStream);
            context.putVar("stampImage", bstamp);

            
			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);			
			
	        is.close();

	        /*
	         * 성적서 발행log
	         */
	        ReportVO logVo = new ReportVO();
	        logVo.setReport_doc_seq(reportInfo.getReport_doc_seq());
	        logVo.setTest_req_seq(reportInfo.getTest_req_seq());
        	logVo.setTest_sample_seq("");
        	logVo.setLog_flag("1");
	        /*reportPublishService.insertReportPublishLog(logVo);*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//return new ModelAndView(new JsonView());
	}

	@RequestMapping("/receiptDetails.lims")
	public void receiptDetails(HttpServletRequest request, HttpServletResponse response, Model model, AcceptVO vo){
		try {
			//접수증
			String[] test_req_seq_arr = vo.getTest_req_seq().split(",", -1);
			List<String> test_req_seq_list = Arrays.asList(test_req_seq_arr);
			
			ReqOrgVO orgVO = new ReqOrgVO();
			orgVO.setReq_org_no(vo.getReq_org_no());
			orgVO.setTest_req_seq_list(test_req_seq_list);
			
			Context context = new Context();
			ReqOrgVO orgInfo = commonService.selectOrgInfo(orgVO);

			context.putVar("destination_nm", orgInfo.getOrg_nm());
			context.putVar("req_nm", orgInfo.getCharger());
			context.putVar("report_date", orgInfo.getTemp_date1());
			context.putVar("fee_tot", orgInfo.getFee_tot());

			vo.setTest_req_seq_list(test_req_seq_list);
			
			List<AcceptVO> orgInfoItem = commonService.selectTransactionDetails(vo);
			context.putVar("itemList", orgInfoItem);
			
			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
			
			// template 파일
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectMaxDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+ file_info;
			String fileName = "receipt_" + vo.getReq_org_no() + "_" + report_date + ".xls";
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));

			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);	
			
	        is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}	

	@RequestMapping("/transactionDetails.lims")
	public void transactionDetails(HttpServletRequest request, HttpServletResponse response, Model model, AcceptVO vo){
		try {
			//거래내역서
			String[] test_req_seq_arr = vo.getTest_req_seq().split(",", -1);
			List<String> test_req_seq_list = Arrays.asList(test_req_seq_arr);

			ReqOrgVO orgVO = new ReqOrgVO();
			orgVO.setReq_org_no(vo.getReq_org_no());
			orgVO.setTest_req_seq_list(test_req_seq_list);
			
			Context context = new Context();
			ReqOrgVO orgInfo = commonService.selectOrgInfo(orgVO);

			context.putVar("destination_nm", orgInfo.getOrg_nm());
			context.putVar("req_nm", orgInfo.getCharger());
			context.putVar("report_date", orgInfo.getTemp_date2());
			context.putVar("fee_tot", orgInfo.getFee_tot());
			
			vo.setTest_req_seq_list(test_req_seq_list);

			List<AcceptVO> orgInfoItem = commonService.selectTransactionDetails(vo);
			context.putVar("itemList", orgInfoItem);
			
			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
			
			// template 파일
			log.debug("doc_seq : "+request.getParameter("doc_seq"));
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectMaxDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+ file_info;
			String fileName = "tranD_" + vo.getReq_org_no() + "_" + report_date + ".xls";
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));

			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);			
			
	        is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}	

	@RequestMapping("/transactionStatement.lims")
	public void transactionStatement(HttpServletRequest request, HttpServletResponse response, Model model, AcceptVO vo){
		try {
			//거래명세서
			String[] test_req_seq_arr = vo.getTest_req_seq().split(",", -1);
			List<String> test_req_seq_list = Arrays.asList(test_req_seq_arr);

			ReqOrgVO orgVO = new ReqOrgVO();
			orgVO.setReq_org_no(vo.getReq_org_no());
			orgVO.setTest_req_seq_list(test_req_seq_list);
			
			Context context = new Context();
			ReqOrgVO orgInfo = commonService.selectOrgInfo(orgVO);

			context.putVar("destination_nm", orgInfo.getOrg_nm());
			context.putVar("fee_tot", orgInfo.getFee_tot());
			
			vo.setTest_req_seq_list(test_req_seq_list);

			List<AcceptVO> orgInfoItem = commonService.selectTransactionStatement(vo);
			context.putVar("itemList", orgInfoItem);
            
			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
			
			// template 파일
			log.debug("doc_seq : "+request.getParameter("doc_seq"));
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectMaxDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+ file_info;
			String fileName = "tranS_" + vo.getReq_org_no() + "_" + report_date + ".xls";
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));

			/* 직인 이미지*/
	        File stampfile = new File(excelReportPath+"/stamp2.png");
	        InputStream stampInputStream = new FileInputStream(stampfile);
            byte[] bstamp = Util.toByteArray(stampInputStream);
            context.putVar("stampImage", bstamp);
            
			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);	

			is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}	

	@RequestMapping("/reqReport01.lims")
	public void reqReport01(HttpServletRequest request, HttpServletResponse response, Model model, ReportVO reportVO){
		try {
			
			Context context = new Context();
			ReportVO reportInfo = commonService.selectRequestInfo(reportVO);

			context.putVar("destination_nm", reportInfo.getDestination_nm());
			context.putVar("req_nm", reportInfo.getReq_nm());
			context.putVar("test_req_no", reportInfo.getTest_req_no());
			context.putVar("req_org_addr", reportInfo.getReq_org_addr());
			context.putVar("test_period", reportInfo.getTest_period());
			context.putVar("test_sdate", reportInfo.getTest_sdate());
			context.putVar("sample_reg_nm", reportInfo.getSample_reg_nm());
			context.putVar("prdlst_nm", reportInfo.getPrdlst_nm());
			context.putVar("tester_id", reportInfo.getTester_id());
			context.putVar("appr_id", reportInfo.getAppr_id());
			context.putVar("pre_tel_num", reportInfo.getPre_tel_num());
			context.putVar("pre_fax_num", reportInfo.getPre_fax_num());
			context.putVar("biz_no", reportInfo.getBiz_no());

			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
			
			// template 파일
			log.debug("doc_seq : "+request.getParameter("doc_seq"));
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectMaxDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+ file_info;
			String fileName = reportInfo.getTest_req_no() + "_" + report_date + ".xls";
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));

			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);			
			
	        is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/reqReport02.lims")
	public void reqReport02(HttpServletRequest request, HttpServletResponse response, Model model, ReportVO reportVO){
		try {
			
			Context context = new Context();
			ReportVO reportInfo = commonService.selectRequestInfo(reportVO);

			context.putVar("destination_nm", reportInfo.getDestination_nm());
			context.putVar("req_nm", reportInfo.getReq_nm());
			context.putVar("test_req_no", reportInfo.getTest_req_no());
			context.putVar("req_org_addr", reportInfo.getReq_org_addr());
			context.putVar("test_period", reportInfo.getTest_period());
			context.putVar("test_sdate", reportInfo.getTest_sdate());
			context.putVar("sample_reg_nm", reportInfo.getSample_reg_nm());
			context.putVar("prdlst_nm", reportInfo.getPrdlst_nm());
			context.putVar("tester_id", reportInfo.getTester_id());
			context.putVar("appr_id", reportInfo.getAppr_id());
			context.putVar("pre_tel_num", reportInfo.getPre_tel_num());
			context.putVar("pre_fax_num", reportInfo.getPre_fax_num());
			context.putVar("biz_no", reportInfo.getBiz_no());
			context.putVar("return_flag", reportInfo.getReturn_flag());

			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
			
			// template 파일
			log.debug("doc_seq : "+request.getParameter("doc_seq"));
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectMaxDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+ file_info;
			String fileName = reportInfo.getTest_req_no() + "_" + report_date + ".xls";
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));

			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);					
			
	        is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/testReportView.lims")
	public void testReportView(HttpServletRequest request, HttpServletResponse response, Model model, TestReportVO testReportVO){
		try {
			
			Context context = new Context();
			
			TestReportVO tempVO = new TestReportVO();
			tempVO = testReportService.selectTestReportSampleDetail(testReportVO);
			// 시료정보
			context.putVar("test_sample_no", tempVO.getTest_sample_no());			
			context.putVar("sample_reg_nm", tempVO.getSample_reg_nm());
			context.putVar("req_date", tempVO.getReq_date());
			context.putVar("dept_appr_date", tempVO.getDept_appr_date());
			context.putVar("appr_nm", tempVO.getAppr_nm());
			context.putVar("item_nm", tempVO.getItem_nm());
			context.putVar("tester_nm", tempVO.getTester_nm());
			
			/*		TestReportVO tempDetailVO = new TestReportVO();
			tempDetailVO = testReportService.selectTestReport(testReportVO);
			// 일지정보
			if(tempDetailVO != null){
				context.putVar("test_method_nm", tempDetailVO.getTest_method_nm() == null ? "" : tempDetailVO.getTest_method_nm());
				context.putVar("test_method_preclean", tempDetailVO.getTest_method_preclean());
				context.putVar("test_method_content", tempDetailVO.getTest_method_content());
				context.putVar("inst_kor_nm", tempDetailVO.getInst_kor_nm());
				context.putVar("inst_eng_nm", tempDetailVO.getInst_eng_nm());
				context.putVar("account_nm", tempDetailVO.getAccount_nm());
				context.putVar("test_report_content", tempDetailVO.getTest_report_content());
				context.putVar("account_tot_cal_disp", tempDetailVO.getAccount_tot_cal_disp());
				context.putVar("account_tot_disp", tempDetailVO.getAccount_tot_disp());
				context.putVar("account_val_desc_tot", tempDetailVO.getAccount_val_desc_tot());
				context.putVar("result_val", tempDetailVO.getResult_val());
				context.putVar("account_val_desc", tempDetailVO.getAccount_val_desc());
				
			}
			
			String account_no = tempVO.getAccount_no();
			System.out.println(account_no);
			if(account_no != "" && account_no != null){
				AccountVO accountTempVO = new AccountVO();
				AccountVO accountDetailVO = new AccountVO();
				
				accountTempVO.setAccount_no(account_no);
				accountTempVO.setTest_sample_seq(testReportVO.getTest_sample_seq());
				accountTempVO.setTest_item_cd(testReportVO.getTest_item_cd());
				
				accountDetailVO = AccountService.selectAccountDetail(accountTempVO);
				context.putVar("account_tot_disp", accountDetailVO.getAccount_tot_disp());
				context.putVar("account_val_desc", accountDetailVO.getAccount_val_desc());
				context.putVar("account_desc", accountDetailVO.getAccount_desc());
				context.putVar("unit_nm", accountDetailVO.getUnit_nm());
			
			}
					
			System.out.println(context.toString());
			//context.putVar("itemList", reportInfoItem);
			
			context.putVar("title", "시 험 일 지");
			context.putVar("report_date", report_date);
			*/
			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String report_date = cal.get(Calendar.YEAR) + "년" + (cal.get(Calendar.MONTH)+1) + "월" + cal.get(Calendar.DAY_OF_MONTH)+"일";
						
			

			// template 파일
			log.debug("doc_seq : "+request.getParameter("doc_seq"));
			String doc_seq = request.getParameter("doc_seq");
			String excelReportPath = propertyService.getString("excelReport.path");
			String file_info = commonService.selectDocFileInfo(doc_seq);
			String templateFile = excelReportPath+"/"+doc_seq + "/" + file_info;
			String fileName = tempVO.getTest_sample_seq()+"_"+report_date+".xls";
			InputStream is = new BufferedInputStream(new FileInputStream(templateFile));
			
			
			/* 로고 이미지
	        File imgfile = new File(excelReportPath+"/logo.png");
	        InputStream imageInputStream = new FileInputStream(imgfile);
            byte[] imageBytes = Util.toByteArray(imageInputStream);
            ImagesVO imageVo = new ImagesVO();
            imageVo.setLogoImage(imageBytes);
            context.putVar("images", imageVo);
			*/
			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
	        response.setContentType("application/vnd.ms-excel");
			JxlsHelper.getInstance().processTemplate(is, response.getOutputStream(), context);			
			
	        is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//return new ModelAndView(new JsonView());
	}
	
	private String encodeFileName(String filename) {
        try {
            return URLEncoder.encode(filename, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
	
	/**
	 * REPORT SAMPLE 
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/report1.lims")
	public ModelAndView  report1(HttpServletRequest request, Model model, DemoSampleVO sampleVO) throws Exception{

		
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setUser_id(userInfoVO.getUser_id());
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("user_id", userInfoVO.getUser_id());

			System.out.println("1111");
			
			List<Map<String, Object>> list = commonService.selectSampleListMAP(sampleVO);

			//List<SampleVO> list = commonService.selectSampleList(sampleVO); 에러남 확인필요
		
			 //JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
	         ModelAndView mv = new ModelAndView();

	         mv.setViewName("report1");      //​ multiformat-view
	         mv.addObject("format", "pdf");        //pdf
	         //mv.addObject("datasource", src);  //​list DataSource -> “datasource”는 jasperreport-views.properties 파일의 multiformat-view.reportDataKey의 이름과 일치해야한다.
			return mv;
	}
	
	
	/**
	 * 팝업메인 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/popMain.lims")
	public String popMain(HttpServletRequest request, Model model) {
		System.out.println("@@@@@@@@@@@"+request.getParameter("popParam"));
		model.addAttribute("popParam", request.getParameter("popParam"));
		model.addAttribute("popUrl", request.getParameter("popUrl"));		
		return "common/popMain";
	}

	
	/**
	 * Address Pop
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popAddrCode.lims")
	public String popAddrCode(HttpServletRequest request, Model model, CommonVO vo) {
		return "common/pop/zipCode";
	}
	
	/**
	 * 의뢰정보 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/showReqInfo.lims")
	public String showReqInfo(Model model, AcceptVO vo) {
		try {
			model.addAttribute("detail", commonService.selectAcceptInfo(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return "common/pop/acceptInfo";
	}

	/**
	 * 결과 분석의견 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestComment.lims")
	public ModelAndView selectTestComment(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", commonService.selectTestComment(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시료 진행 상황 팝업
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("showReqHistory.lims")
	public String showReqHistory(Model model, AcceptVO vo) throws Exception {
		List<SampleStateVO> sampleList = commonService.selectStateInfoList(vo);
		model.addAttribute("sampleList", sampleList);
		model.addAttribute("test_req_seq", vo.getTest_req_seq());
		return "common/pop/acceptHistory";
	}
	
	/**
	 * 의뢰 히스토리 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("showReqHistorySub.lims")
	public String showReqHistorySub(Model model, AcceptVO vo) throws Exception {
		model.addAttribute("historyList", commonService.selectStateInfo(vo));
		model.addAttribute("test_req_seq", vo.getTest_req_seq());
		return "common/pop/acceptHistorySub";
	}
	
	/**
	 * 의뢰 결과 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("showReqResultInfo.lims")
	public String acceptResultInfo() throws Exception {
		return "common/pop/acceptResultInfo";
	}
	
	/**
	 * 의뢰 결과 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAcceptResultInfo.lims")
	public ModelAndView selectAcceptResultInfo(HttpServletRequest request, Model model, MakeGridVO vo) {
		try {
			model.addAttribute("resultData", commonService.selectAcceptResultInfo(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 재접수-접수대기로 상태 변경(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/returnToBegining.lims")
	public ModelAndView returnToBegining(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", commonService.returnToBegining(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 주소정보 조회(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, CommonVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("zipCode.lims")
	public ModelAndView selectAddrList(HttpServletRequest request, Model model, ZipCodeVO vo) {
		try {
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			// 통합검색 일때..
			String addr[] = new String[2];
			if (vo.getAddr() != "" && vo.getAddr() != null){
				addr = vo.getAddr().split(" ");
				if(addr.length == 2){
					vo.setAddr(addr[0]);
					vo.setAddr_bunji(addr[1]);
				}
			}
			
			//int totCnt = commonService.selectAddrPagingListTotCnt(vo);

			//paginationInfo.setTotalRecordCount(totCnt);

			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());
				
			model.addAttribute("resultData", commonService.selectAddrList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 주소정보(팝업) 페이징 처리
	 * 
	 * @param ZipCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("zipPaging.lims")
	public String selectZipListPaging(HttpServletRequest request, Model model, ZipCodeVO vo) throws Exception {
		try {
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			// 통합검색 일때..
			String addr[] = new String[2];
			if (vo.getAddr() != "" && vo.getAddr() != null){
				addr = vo.getAddr().split(" ");
				if(addr.length == 2){
					vo.setAddr(addr[0]);
					vo.setAddr_bunji(addr[1]);
				}
			}
			int totCnt = commonService.selectAddrPagingListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging"; // 공지사항 폴더에 페이징 HTML(공통으로 사용)
	}
	
	/**
	 * 반려 사유 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/showReturnComment.lims")
	public String returnComment() throws Exception {
		return "common/pop/returnComment";
	}
	
	/**
	 * 반려 항목 체크
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReturnFlag.lims")
	public ModelAndView updateReturnFlag(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", commonService.updateReturnFlag(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 반려사유 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReturnCommentList.lims")
	public ModelAndView selectReturnCommentList(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", commonService.selectReturnCommentList(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 반려 항목 취소
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/cancelReturnFlag.lims")
	public ModelAndView cancelReturnFlag(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", commonService.cancelReturnFlag(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 반려 사유 저장 / 반려처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReturnComment.lims")
	public ModelAndView updateReturnComment(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			model.addAttribute("resultData", commonService.updateReturnComment(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 반려 항목 모든 시료에 반영
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/copyReturnFlag.lims")
	public ModelAndView copyReturnFlag(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", commonService.copyReturnFlag(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * RAWDATA
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/rdmsViewer.lims")
	public ModelAndView rdmsViewer(HttpServletRequest request, Model model) throws Exception {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		String userID = userInfoVO.getUser_id();
		String uuid = UUID.randomUUID().toString();

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userID", userID);
		map.put("uuid", uuid);
		map.put("test_req_no", request.getParameter("test_req_no"));
		map.put("test_sample_seq", request.getParameter("test_sample_seq"));
		map.put("test_item_seq", request.getParameter("test_item_seq"));

		int r = commonService.rdmsViewer(map);
		Object[] ret = new Object[2];
		ret[0] = propertyService.getString("rdms.url");

		if (r == 0) {
			ret[1] = r;
		} else {
			ret[1] = uuid;
		}
		model.addAttribute("resultData", ret);
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("/excelDownload.lims")
	public String excelDownload(HttpServletRequest request, HttpServletResponse response, Model model, ExcelVO vo) throws Exception {
		try {
			model.addAttribute("excel", commonService.excelDownload(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return "common/excel";
	}
	
	/**
	 * 계산식 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/accountSelPop.lims")
	public String accountSelPop() throws Exception {
		return "common/pop/accountSelPop";
	}
	
	/**
	 * 계산식 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/accountPop.lims")
	public String accountPop() throws Exception {
		return "common/pop/accountPop";
	}
	
	/**
	 * 메뉴권한검사
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/menuAuthCheck.lims")
	public ModelAndView menuAuthCheck(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			UserInfoVO sessionVO = SessionCheck.getSession(request);
			vo.setUser_id(sessionVO.getUser_id());
			model.addAttribute("resultData", commonService.menuAuthCheck(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 파일관리 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/fileManagePop.lims")
	public String fileManagePop() throws Exception {
		return "common/pop/fileManagePop";
	}
	
	
	
	/**
	 * 파일관리 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/fileUpload.lims")
	public ModelAndView fileUpload(MultipartHttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			Iterator<String> iterator = request.getFileNames();
			
			while (iterator.hasNext()) {
				String fileName = iterator.next();
				MultipartFile multipartFile = request.getFile(fileName);
				byte[] file = multipartFile.getBytes();
				System.out.println(request.getParameter("path"));
//				System.out.println(":::: " +multipartFile.getOriginalFilename());
				System.out.println(":::: " + file);
				// do stuff...
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("name", multipartFile.getOriginalFilename());
				map.put("path", "00000001");
				map.put("size", "1024");
				
				model.addAttribute("name", multipartFile.getOriginalFilename());
				model.addAttribute("path", "00000001");
				model.addAttribute("resultData", map);
			}			
			// do stuff...			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 파일관리 파일리스트조회
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/selectFileList.lims")
	public ModelAndView selectFileList(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			
			//System.out.println("test");
			
			map.put("name", vo.getName());
			map.put("path", vo.getPath());			
			map.put("size", "1024");
//			map.put("size", vo.getSize());
			
			model.addAttribute("resultData", map);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 파일관리 파일삭제
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/deleteFile.lims")
	public ModelAndView deleteFile(HttpServletRequest request, Model model, UserInfoVO vo) {
		try {
			System.out.println(request.getParameterNames().toString());
			System.out.println(request.getParameter("name"));
			System.out.println(request.getParameter("path"));
			HashMap<String, String> map = new HashMap<String, String>();
			
			model.addAttribute("resultData", map);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 진위확인
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/verifyReport.lims")
	public String verifyReport() {
		return "common/verifyReport";
	}

	@RequestMapping("/verifyReportAction.lims")
	public String verifyReportAction(HttpServletRequest request, HttpServletResponse response, Model model){
		try {
			String verify_id1 = request.getParameter("verify_id1");
			String verify_id2 = request.getParameter("verify_id2");
			String verify_id3 = request.getParameter("verify_id3");
			String verify_id4 = request.getParameter("verify_id4");

			if(verify_id1 != null && verify_id2 != null && verify_id3 != null && verify_id4 != null){

				verify_id1 = verify_id1.toUpperCase();
				verify_id2 = verify_id2.toUpperCase();
				verify_id3 = verify_id3.toUpperCase();
				verify_id4 = verify_id4.toUpperCase();
				
		        model.addAttribute("verify_id1", verify_id1);
		        model.addAttribute("verify_id2", verify_id2);
		        model.addAttribute("verify_id3", verify_id3);
		        model.addAttribute("verify_id4", verify_id4);
		        
				String verify_id = verify_id1 + verify_id2 + verify_id3 + verify_id4;
				ReportVO reportVO = new ReportVO();
				
				//report_doc_seq 조회
				reportVO.setVerify_id(verify_id);
				ReportVO verifyInfo = commonService.selectReportVerify(reportVO);
				if(verifyInfo != null){
					reportVO.setReport_doc_seq(verifyInfo.getReport_doc_seq());
					ReportVO reportInfo = commonService.selectReportInfo(reportVO);
					List<ReportVO> reportInfoItem = commonService.selectReportInfoItem(reportVO);
			        model.addAttribute("reportState", "Y");
			        model.addAttribute("reportInfo", reportInfo);
			        model.addAttribute("reportInfoItem", reportInfoItem);
				}else{
			        model.addAttribute("reportState", "N");
				}
			}else{
		        model.addAttribute("reportState", "F");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/verifyReportAction";
	}
	
	/**
	 * HTML5 RD viewer
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/html5Viewer.lims")
	public ModelAndView html5Viewer(HttpServletRequest request, Model model) throws Exception {
		String data_server = propertyService.getString("rdReport.data_server");
		String reporting_server = propertyService.getString("rdReport.reporting_server");
		String mrd_path = propertyService.getString("rdReport.mrd_path");
		String rd_service_nm = propertyService.getString("rdReport.rd_service_nm");
		String report_id = propertyService.getString("rdReport.report_id");
		String report_pw = propertyService.getString("rdReport.report_pw");
		
		Object[] rtn = new Object[5];
		
		rtn[0] = request.getParameter("fileNm");
		rtn[1] = request.getParameter("parameter") + " /rcontype [Data Server] /rf ["+ data_server +"] /rsn ["+ rd_service_nm +"] /rui [" + report_id + "] /rpw [" + report_pw + "]";
		rtn[2] = reporting_server;
		rtn[3] = mrd_path;
		rtn[4] = " /rcontype [Data Server] /rf ["+ data_server +"] /rsn ["+ rd_service_nm +"] /rui [" + report_id + "] /rpw [" + report_pw + "]";
		
		model.addAttribute("resultData", rtn);
		
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 출력물 개정 정보
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/revisionPop.lims")
	public String revisionPop(HttpServletRequest request, Model model, AcceptVO vo) {
		model.addAttribute("printGbn", request.getParameter("printGbn"));
		return "common/pop/revisionPop";
	}
	
	/**
	 * 계산식 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/formulaPop.lims")
	public String formulaPop(FormulaVO VO) throws Exception {
		return "common/pop/formulaPop";
	}
}
