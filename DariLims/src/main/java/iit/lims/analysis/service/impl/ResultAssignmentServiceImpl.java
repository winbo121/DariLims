package iit.lims.analysis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.dao.ResultAssignmentDAO;
import iit.lims.analysis.dao.TestReportDAO;
import iit.lims.analysis.service.ResultAssignmentService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.SessionCheck;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ResultAssignmentService
 * 
 * @author 최은향
 * @since 2016.01.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.01.26  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Service
public class ResultAssignmentServiceImpl extends EgovAbstractServiceImpl implements ResultAssignmentService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultAssignmentDAO")
	private ResultAssignmentDAO resultAssignmentDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;

	@Resource(name = "testReportDAO")
	private TestReportDAO testReportDAO;
	
	@Resource
	private CommonDAO commonDAO;

	/**
	 * 접수완료 목록 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectAcceptCompleteList(AcceptVO vo) throws Exception {
		return resultAssignmentDAO.selectAcceptCompleteList(vo);
	}
	
	/*배정 시료 목록*/
	public List<ResultInputVO> selectSampleAssignmentList(ResultInputVO vo) throws Exception {
		return resultAssignmentDAO.selectSampleAssignmentList(vo);
	}
	
	/**
	 * 배정 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultAssignmentList(ResultInputVO vo) throws Exception {
		return resultAssignmentDAO.selectResultAssignmentList(vo);
	}

	/**
	 * 배정자 저장 및 배정완료
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String updateResultTester(ResultInputVO vo) throws Exception {
		try {
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
								
							}
						}
						
						map.put("assignment_flag", vo.getAssignment_flag());
						resultAssignmentDAO.updateResultTester(map); // 배정자 수정
					}
				}
			}
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	/**
	 * 배정완료 validation
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public String updateAssignmentComplete(String reqList) throws Exception{
		String returnMsg = "";
		String[] reqList_arr = reqList.split(",", -1);
		ResultInputVO vo = new ResultInputVO();

		if (reqList_arr.length > 0) {
			for(int i=0; i < reqList_arr.length ; i++){
				vo.setTest_req_seq(reqList_arr[i]);
				ResultInputVO result = resultAssignmentDAO.selectAssignmentValidation(vo);
				if(result.getSample_cnt() > 0){
					//미배정된 시료존재
					returnMsg += result.getTest_req_no() + ", ";
				}else{
					// 배정자 수정
					resultAssignmentDAO.updateAssignmentComplete(vo);
				}
			}
		}
		return returnMsg;
	}
	
//	/**
//	 * 결과입력 > 결과 입력 완료
//	 * 
//	 * @param ResultInputVO
//	 * @return int
//	 * @throws Exception
//	 */
//	public String completeResultInput(ResultInputVO vo) throws Exception {
//		//System.out.println(vo.getPageType());
//		String ret = null;
//		try {
//			List<ResultInputVO> lst = resultAssignmentDAO.selectCheckResultList(vo);
//			if (lst != null && lst.size() > 0) {
//				String msg = "";
//				for (ResultInputVO s : lst) {
//					msg += s.getSample_reg_nm() + "의 " + s.getTest_item_nm() + "\n";
//				}
//				return msg + "의 결과값을 입력해주세요.";
//			}
//			lst = resultAssignmentDAO.selectCheckJdgList(vo);
//			if (lst != null && lst.size() > 0) {
//				String msg = "";
//				for (ResultInputVO s : lst) {
//					msg += s.getSample_reg_nm() + "의 " + s.getTest_item_nm() + "\n";
//				}
//				return msg + "의 결과판정을 해주세요.";
//			}
//			List<ResultInputVO> reqList = resultAssignmentDAO.selectResultList(vo);
//			List<String> itemList = new ArrayList<String>();
//			String row_test_sample_seq = null;
//			String row_dept_cd = null;
//			for (ResultInputVO row : reqList) {
//				if (row_test_sample_seq == null) {
//					row_test_sample_seq = row.getTest_sample_seq();
//					row_dept_cd = row.getDept_cd();
//				}
//				if (!row_test_sample_seq.equals(row.getTest_sample_seq())) {
//					HistoryVO historyVO = new HistoryVO();
//					historyVO.setTest_sample_seq(row_test_sample_seq);
//					historyVO.setSample_state(vo.getState());
//					historyVO.setDept_cd(row_dept_cd);
//					historyVO.setUser_id(vo.getUser_id());
//					historyVO.setTest_dept_cd(vo.getDept_cd());
//					if (vo.getDept_cd().equals(row_dept_cd)) {
//						historyVO.setColla_flag("N");
//					} else {
//						historyVO.setColla_flag("Y");
//					}
//					historyVO.setEtc(itemList.toString());
//					commonDAO.insertSampleHistory(historyVO);
//
//					row_test_sample_seq = row.getTest_sample_seq();
//					row_dept_cd = row.getDept_cd();
//					itemList = new ArrayList<String>();
//				}
//
//				if (!itemList.contains(row.getTest_item_nm())) {
//					itemList.add(row.getTest_item_nm());
//				}
//				row.setState(vo.getState());
//				commonDAO.updateTestState(row);
//				
//				// 성적서 페이지만 다름
//				row.setPageType(vo.getPageType());
//				row.setUser_id(vo.getUser_id());
//				resultAssignmentDAO.updateReturnFlag(row);		
//				if(vo.getPageType().equals("report")){
//					resultAssignmentDAO.updateSampleJudgment(row); // 성적서 일때 시료 판정값 수정
//				}
//				
//				/* AUDIT_TRAIL START*/
//				String audit = ConverObjectToMap.conver(row).toString();
//				HashMap<String, String> map = new HashMap<String, String>();
//				//log.debug("Log[Lims AUDIT TRAIL] :" + audit);
//				map.put("at_cont", audit); // 로우데이터 셋팅f
//				map.put("crud", "u"); // 로우데이터 셋팅
//				map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
//				map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
//				map.put("test_req_no", vo.getTest_req_no()); // 접수번호 셋팅
//				map.put("test_sample_seq", row.getTest_sample_seq()); // 시료번호 셋팅
//				map.put("test_item_seq", row.getTest_item_seq()); // 항목번호 셋팅
//				map.put("test_item_cd", row.getTest_item_cd()); // 항목코드 셋팅
//				map.put("at_proc", "결과입력완료");
//				map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
//				auditTrailDAO.insertAuditTrail(map);
//				/* AUDIT_TRAIL END*/
//			}
//			HistoryVO historyVO = new HistoryVO();
//			historyVO.setTest_sample_seq(row_test_sample_seq);
//			historyVO.setSample_state(vo.getState());
//			historyVO.setDept_cd(row_dept_cd);
//			historyVO.setUser_id(vo.getUser_id());
//			historyVO.setTest_dept_cd(vo.getDept_cd());
//			if (vo.getDept_cd().equals(row_dept_cd)) {
//				historyVO.setColla_flag("N");
//			} else {
//				historyVO.setColla_flag("Y");
//			}
//			if (itemList.size() > 0) {
//				historyVO.setEtc(itemList.toString());
//			}
//			commonDAO.insertSampleHistory(historyVO);
//
//			ret = resultAssignmentDAO.checkReqInputComplete(vo);
//			return ret;
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw e;
//		}
//	}
}
