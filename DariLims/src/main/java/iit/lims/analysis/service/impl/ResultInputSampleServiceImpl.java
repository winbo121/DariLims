package iit.lims.analysis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.analysis.dao.ResultInputSampleDAO;
import iit.lims.analysis.dao.TestReportDAO;
import iit.lims.analysis.service.ResultInputSampleService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.analysis.vo.TestReportVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.vo.TestMethodVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.ConverObjectToMap;
import iit.lims.util.SessionCheck;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MenuService
 * 
 * @author 조재환
 * @since 2015.01.14
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.14  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ResultInputSampleServiceImpl extends EgovAbstractServiceImpl implements ResultInputSampleService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultInputSampleDAO")
	private ResultInputSampleDAO resultInputSampleDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;

	@Resource(name = "testReportDAO")
	private TestReportDAO testReportDAO;
	
	@Resource
	private CommonDAO commonDAO;

	/**
	 * 결과입력 (시료유형) 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultReqList(ResultInputVO vo) throws Exception {
		return resultInputSampleDAO.selectResultReqList(vo);
	}

	/**
	 * 결과입력 (시료유형) 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultSampleList(ResultInputVO vo) throws Exception {
		return resultInputSampleDAO.selectResultSampleList(vo);
	}

	/**
	 * 결과입력 > 결과 저장
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String updateItemResult(ResultInputVO vo) throws Exception {
		try {
			String test_item_nm = "";
			TestReportVO tvo = new TestReportVO();
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					//System.out.println(row);
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							//System.out.println(column);
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
						System.out.println(audit);
						map.put("at_cont", audit); // 로우데이터 셋팅
						map.put("crud", "u"); // 로우데이터 셋팅
						map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
						map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
						map.put("test_req_seq", vo.getTest_req_seq()); // 접수번호 셋팅
						map.put("test_item_cd", vo.getTest_item_cd()); // 항목코드 셋팅
						map.put("test_sample_seq", vo.getTest_sample_seq()); // 시료번호 셋팅
						map.put("at_proc", "항목(결과저장)");
						map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
						
						System.out.println("*************" + vo.getTest_req_seq());
						auditTrailDAO.insertAuditTrail(map);
						/* AUDIT_TRAIL END*/
						
						if (vo.getPageType() == null || "item".equals(vo.getPageType())) {
							List<ResultInputVO> l = resultInputSampleDAO.checkReqInput(map);
							if (l != null) {
								for (ResultInputVO r : l) {
									resultInputSampleDAO.updateSampleJudgment(r); // 시료 판정값 수정
								}
							}
						}
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
			
			if (vo.getPageType() == null || !"item".equals(vo.getPageType())) {
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
			}
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 결과입력 > 결과 입력 완료
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String completeResultInput(ResultInputVO vo) throws Exception {
		//System.out.println(vo.getPageType());
		String ret = null;
		try {
			List<ResultInputVO> lst = resultInputSampleDAO.selectCheckResultList(vo);
			if (lst != null && lst.size() > 0) {
				String msg = "";
				for (ResultInputVO s : lst) {
					msg += s.getSample_reg_nm() + "의 " + s.getTest_item_nm() + "\n";
				}
				return msg + "의 결과값을 입력해주세요.";
			}
			lst = resultInputSampleDAO.selectCheckJdgList(vo);
			if (lst != null && lst.size() > 0) {
				String msg = "";
				for (ResultInputVO s : lst) {
					msg += s.getSample_reg_nm() + "의 " + s.getTest_item_nm() + "\n";
				}
				return msg + "의 결과판정을 해주세요.";
			}
			List<ResultInputVO> reqList = resultInputSampleDAO.selectResultList(vo);
			List<String> itemList = new ArrayList<String>();
			String row_test_sample_seq = null;
			String row_dept_cd = null;
			for (ResultInputVO row : reqList) {
				if (row_test_sample_seq == null) {
					row_test_sample_seq = row.getTest_sample_seq();
					row_dept_cd = row.getDept_cd();
				}
				if (!row_test_sample_seq.equals(row.getTest_sample_seq())) {
					HistoryVO historyVO = new HistoryVO();
					historyVO.setTest_req_seq(vo.getTest_req_seq());
					historyVO.setTest_sample_seq(row_test_sample_seq);
					historyVO.setSample_state(vo.getState());
					historyVO.setDept_cd(row_dept_cd);
					historyVO.setUser_id(vo.getUser_id());
					historyVO.setTest_dept_cd(vo.getDept_cd());
					if (vo.getDept_cd().equals(row_dept_cd)) {
						historyVO.setColla_flag("N");
					} else {
						historyVO.setColla_flag("Y");
					}
					historyVO.setEtc(itemList.toString());
					commonDAO.insertSampleHistory(historyVO);

					row_test_sample_seq = row.getTest_sample_seq();
					row_dept_cd = row.getDept_cd();
					itemList = new ArrayList<String>();
				}

				//if (!itemList.contains(row.getTest_item_nm())) {
					itemList.add(row.getTest_item_nm());
				//}
				//진행상태업데이트
				row.setState(vo.getState());
				row.setResult_input_type(vo.getResult_input_type());
				commonDAO.updateTestState(row);
				
				// 성적서 페이지만 다름
				row.setPageType(vo.getPageType());
				row.setUser_id(vo.getUser_id());
				//resultInputSampleDAO.updateReturnFlag(row);		
				if(vo.getPageType().equals("report")){
					resultInputSampleDAO.updateSampleJudgment(row); // 성적서 일때 시료 판정값 수정
				}
				
				/* AUDIT_TRAIL START*/
				String audit = ConverObjectToMap.conver(row).toString();
				HashMap<String, String> map = new HashMap<String, String>();
				//log.debug("Log[Lims AUDIT TRAIL] :" + audit);
				map.put("at_cont", audit); // 로우데이터 셋팅f
				map.put("crud", "u"); // 로우데이터 셋팅
				map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
				map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
				map.put("test_req_seq", vo.getTest_req_seq()); // 접수SEQ 셋팅
				map.put("test_sample_seq", row.getTest_sample_seq()); // 시료번호 셋팅
				map.put("test_item_seq", row.getTest_item_seq()); // 항목번호 셋팅
				map.put("test_item_cd", row.getTest_item_cd()); // 항목코드 셋팅
				map.put("at_proc", "결과입력완료");
				map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
				auditTrailDAO.insertAuditTrail(map);
				/* AUDIT_TRAIL END*/
			}
			HistoryVO historyVO = new HistoryVO();
			historyVO.setTest_req_seq(vo.getTest_req_seq());
			historyVO.setTest_sample_seq(row_test_sample_seq);
			historyVO.setSample_state(vo.getState());
			historyVO.setDept_cd(row_dept_cd);
			historyVO.setUser_id(vo.getUser_id());
			historyVO.setTest_dept_cd(vo.getDept_cd());
			if (vo.getDept_cd().equals(row_dept_cd)) {
				historyVO.setColla_flag("N");
			} else {
				historyVO.setColla_flag("Y");
			}
			if (itemList.size() > 0) {
				historyVO.setEtc(itemList.toString());
			}
			commonDAO.insertSampleHistory(historyVO);

			ret = resultInputSampleDAO.checkReqInputComplete(vo);
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 결과입력 > 시험방법 팝업 > 목록조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<TestMethodVO> selectTestMethodList(ResultInputVO vo) throws Exception {
		return resultInputSampleDAO.selectTestMethodList(vo);
	}

	/**
	 * 결과입력 > 시험기기 팝업 > 목록조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<MachineVO> selectTestMachineList(ResultInputVO vo) throws Exception {
		return resultInputSampleDAO.selectTestMachineList(vo);
	}

	/**
	 * 결과입력 > 특기사항 조회
	 * 
	 * @param ResultInputVO
	 * @return String
	 * @throws Exception
	 */
	public String showReqmessage(ResultInputVO vo) throws Exception {
		String s = resultInputSampleDAO.showReqmessage(vo);
		if (s == null) {
			s = "no_data";
		}
		return s;
	}

	public ResultInputVO selectOriginalSTD(ResultInputVO vo) throws Exception {
		return resultInputSampleDAO.selectOriginalSTD(vo);
	}

	public List<ResultInputVO> selectSampleList(ResultInputVO vo) throws Exception {
		return resultInputSampleDAO.selectSampleList(vo);
	}
	
	/**
	 * 결과입력 > 첨부파일 조회
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public ResultInputVO reportFilePop(ResultInputVO vo) {
		try {
			return resultInputSampleDAO.reportFilePop(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 결과입력 > 첨부파일 저장 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	@Override
	public int insertReportFile(ResultInputVO vo) throws Exception {
		try {
			if (vo.getTest_item_cd() != "" && vo.getTest_item_cd() != null){
				resultInputSampleDAO.updateReportFlag(vo); // 항목 flag 수정
			} else {
				resultInputSampleDAO.updateSampleReportFlag(vo); // 시료 flag 수정
			}
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
				result = resultInputSampleDAO.insertReportFile(vo);
			} else {
				if(vo.getFile_nm() != null && !vo.getFile_nm().equals("")) 
					result = resultInputSampleDAO.insertReportFile(vo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 결과입력 > 첨부파일 수정 처리
	 * @param ResultInputVO
	 * @throws Exception
	 */
	@Override
	public int updateReportFile(ResultInputVO vo) throws Exception {
		try {
			if (vo.getTest_item_cd() != "" && vo.getTest_item_cd() != null){
				resultInputSampleDAO.updateReportFlag(vo); // 항목 flag 수정
			} else {
				resultInputSampleDAO.updateSampleReportFlag(vo); // 시료 flag 수정
			}
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {				
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
					result = resultInputSampleDAO.updateReportFile(vo);
			} else {				
				result = resultInputSampleDAO.updateReportFile(vo);			
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 결과입력 > 첨부파일 삭제 처리
	 * @param ResultInputVO
	 * @throws Exception
	 */
	@Override
	public int deleteReportFile(ResultInputVO vo) throws Exception {
		try {
			resultInputSampleDAO.deleteReportFile(vo);
			resultInputSampleDAO.deleteReportUpdate(vo);
			resultInputSampleDAO.updateSampleJudgment(vo); // 시료 판정값 수정
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 결과입력 > 첨부파일 다운로드 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	@Override
	public ResultInputVO reportDown(ResultInputVO vo) throws Exception {
		try {
			return resultInputSampleDAO.reportDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
}
