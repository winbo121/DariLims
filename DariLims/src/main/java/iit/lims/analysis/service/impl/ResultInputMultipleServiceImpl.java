package iit.lims.analysis.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.analysis.dao.ResultInputMultipleDAO;
import iit.lims.analysis.dao.ResultInputSampleDAO;
import iit.lims.analysis.dao.TestReportDAO;
import iit.lims.analysis.service.ResultInputMultipleService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.analysis.vo.TestReportVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.SessionCheck;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ResultInputMultipleServiceImpl
 * 
 * @author 김상하
 * @since 2016.04.12
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.04.12  김상하   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Service
public class ResultInputMultipleServiceImpl extends EgovAbstractServiceImpl implements ResultInputMultipleService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultInputMultipleDAO")
	private ResultInputMultipleDAO resultInputMultipleDAO;

	@Resource(name = "resultInputSampleDAO")
	private ResultInputSampleDAO resultInputSampleDAO;

	@Resource(name = "testReportDAO")
	private TestReportDAO testReportDAO;
	
	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;

	@Resource
	private CommonDAO commonDAO;

	/**
	 * 결과입력 > 결과 저장
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String updateMultipleItemResult(ResultInputVO vo) throws Exception {
		try {
			//다중 결과입력시 시료에 해당하는 모든결과 우선 적합판정
			resultInputMultipleDAO.updateMultipleItem(vo);
			
			String test_item_nm = "";
			TestReportVO tvo = new TestReportVO();
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
								
								if(valueArr[0].equals("test_item_cd")){
									if(value != null && value != ""){
										vo.setTest_item_cd(value);
										tvo.setTest_item_cd(value);
									}
								}
								if(valueArr[0].equals("test_item_seq")){
									if(value != null && value != ""){
										vo.setTest_item_seq(value);
									}
								}
								if(valueArr[0].equals("std_val")){
									if(value != null && value != ""){
										vo.setStd_val(value);
									}
								}
								if(valueArr[0].equals("unit")){
									if(value != null && value != ""){
										vo.setUnit(value);
									}
								}
								if(valueArr[0].equals("std_type")){
									if(value != null && value != ""){
										vo.setStd_type(value);
									}
								}
								if(valueArr[0].equals("result_type")){
									if(value != null && value != ""){
										vo.setResult_type(value);
									}
								}
								if(valueArr[0].equals("result_val")){
									if(value != null && value != ""){
										vo.setResult_val(value);
									}
								}
								if(valueArr[0].equals("result_cd")){
									if(value != null && value != ""){
										vo.setResult_cd(value);
									}
								}
								if(valueArr[0].equals("jdg_type")){
									if(value != null && value != ""){
										vo.setJdg_type(value);
									}
								}
								if(valueArr[0].equals("test_method_no")){
									if(value != null && value != ""){
										vo.setTest_method_no(value);
									} else {
										vo.setTest_method_no("");
									}
								}
								if(valueArr[0].equals("inst_no")){
									if(value != null && value != ""){
										vo.setInst_no(value);
									}else{
										vo.setInst_no("");										
									}
								}
								if(valueArr[0].equals("state")){
									if(value != null && value != ""){
										vo.setState(value);
									}
								}
								if(valueArr[0].equals("account_no")){
									if(value != null && value != ""){
										vo.setAccount_no(value);
									}else{
										vo.setAccount_no("");										
									}
								}
								if(vo.getTest_sample_seq() == "" || vo.getTest_sample_seq() == null){
									if(valueArr[0].equals("test_sample_seq")){
										if(value != null && value != ""){
											vo.setTest_sample_seq(value);
											tvo.setTest_sample_seq(value);
										}
									}
								} else {
									tvo.setTest_sample_seq(vo.getTest_sample_seq());
								}
								if(valueArr[0].equals("test_item_nm")){
									if(value != null && value != ""){
										test_item_nm += value + ", ";
									}
								}
							}
						}								
						map.put("user_id", vo.getUser_id());
						
						resultInputSampleDAO.updateItemResult(map); // 항목별 결과값 수정
						
						tvo.setTest_method_no(vo.getTest_method_no());
						tvo.setTest_inst_no(vo.getInst_no());
						tvo.setAccount_no(vo.getAccount_no());						
						tvo.setUser_id(vo.getUser_id());						
						testReportDAO.updateTestReport(tvo); // 시험일지에도 수정
						resultInputSampleDAO.insertItemResultHistory(map); // 항목별 결과값 수정시 히스토리에 등록
						
						/* AUDIT_TRAIL START*/
						//String audit = ConverObjectToMap.conver(vo).toString();						
						String audit = "{test_item_seq=" + vo.getTest_item_seq() + ", std_val=" + vo.getStd_val() +
										", unit=" + vo.getUnit() + ", std_type=" + vo.getStd_type() +
										", result_type=" + vo.getResult_type() + ", result_val=" + vo.getResult_val() + ", result_cd=" + vo.getResult_cd() +
										", jdg_type=" + vo.getJdg_type() + ", test_method_no=" + vo.getTest_method_no() +
										", inst_no=" + vo.getInst_no() +
										"}";
						map.put("at_cont", audit); // 로우데이터 셋팅
						map.put("crud", "u"); // 로우데이터 셋팅
						map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
						map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
						map.put("test_req_seq", vo.getTest_req_seq()); // 접수번호 셋팅
						map.put("test_item_cd", vo.getTest_item_cd()); // 항목코드 셋팅
						map.put("test_sample_seq", vo.getTest_sample_seq()); // 시료번호 셋팅
						map.put("at_proc", "항목(결과저장)");
						map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
						auditTrailDAO.insertAuditTrail(map);
						/* AUDIT_TRAIL END*/
					}
				}
			}
			
			HistoryVO historyVO = new HistoryVO();
			historyVO.setTest_req_seq(vo.getTest_req_seq());
			historyVO.setTest_sample_seq(vo.getTest_sample_seq());
			historyVO.setSample_state("C"); // 결과입력
			historyVO.setDept_cd(vo.getDept_cd());
			historyVO.setUser_id(vo.getUser_id());
			historyVO.setTest_dept_cd(vo.getDept_cd());
			if (vo.getDept_cd().equals(vo.getDept_cd())) {
				historyVO.setColla_flag("N");
			} else {
				historyVO.setColla_flag("Y");
			}
			
			// 시료별 히스토리에 등록
			historyVO.setEtc("["+test_item_nm.substring(0, test_item_nm.length()-2)+"]");
			commonDAO.insertSampleHistory(historyVO);
			
			//분석의견, 온도, 습도
			if (vo.getTest_cmt() != null) {
				resultInputSampleDAO.saveTestComment(vo);
				resultInputSampleDAO.saveTestEnvironment(vo);
			}
		
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("test_sample_seq", vo.getTest_sample_seq());
			List<ResultInputVO> l = resultInputSampleDAO.checkReqInput(map);
			if (l != null) {
				for (ResultInputVO r : l) {
					resultInputSampleDAO.updateSampleJudgment(r); // 시료 판정값 수정
				}
			}
			String ret = resultInputSampleDAO.selectSampleJudgment(vo.getTest_sample_seq());
			if (ret == null) {
				return "";
			} else {
				return ret;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
