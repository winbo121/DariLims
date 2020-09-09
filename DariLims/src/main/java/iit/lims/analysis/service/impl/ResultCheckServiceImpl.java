package iit.lims.analysis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.dao.ResultCheckDAO;
import iit.lims.analysis.dao.ResultInputSampleDAO;
import iit.lims.analysis.service.ResultCheckService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.service.CommonService;
import iit.lims.common.vo.HistoryVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.ConverObjectToMap;
import iit.lims.util.SessionCheck;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ResultCheckServiceImpl
 * 
 * @author 윤상준
 * @since 2015.02.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.17  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ResultCheckServiceImpl extends EgovAbstractServiceImpl implements ResultCheckService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultCheckDAO")
	private ResultCheckDAO resultCheckDAO;
	@Resource(name = "resultInputSampleDAO")
	private ResultInputSampleDAO resultInputSampleDAO;
	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;
	@Resource
	private CommonService commonService;

	@Resource
	private CommonDAO commonDAO;

	/**
	 * 기본결재라인 목록 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public ResultInputVO selectApprLineDefaultList(ResultInputVO vo) throws Exception {
		return resultCheckDAO.selectApprLineDefaultList(vo);
	}

	/**
	 * 결과확인 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectCheckReqList(ResultInputVO vo) throws Exception {
		return resultCheckDAO.selectCheckReqList(vo);
	}

	/**
	 * 결과확인 시료유형 판정값 수정
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public int updateResultCheck(ResultInputVO vo) throws Exception {
		try {
			resultCheckDAO.updateSampleResult(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 결과확인 결과 확인(& 상신) 완료 처리
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public int completeResultCheck(ResultInputVO vo) throws Exception {
		try {
			if (vo.getTest_req_seq() != null && !"".equals(vo.getTest_req_seq())) {
				String[] test_req_seq_arr = (vo.getTest_req_seq()).split(",", -1);
				if (test_req_seq_arr.length > 0) {
					for (String test_req_seq : test_req_seq_arr) {
						vo.setTest_req_seq(test_req_seq);
						List<AcceptVO> checkList = resultCheckDAO.selectCheckList(vo);
						List<String> itemList = new ArrayList<String>();
						List<String[]> sampleList = new ArrayList<String[]>();
						String row_test_sample_seq = null;
						String row_dept_cd = null;
						for (AcceptVO row : checkList) {
							if (row_test_sample_seq == null) {
								row_test_sample_seq = row.getTest_sample_seq();
								row_dept_cd = row.getDept_cd();
								String[] arr = new String[2];
								arr[0] = row_test_sample_seq;
								arr[1] = row_dept_cd;
								sampleList.add(arr);
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
								String[] arr = new String[2];
								arr[0] = row_test_sample_seq;
								arr[1] = row_dept_cd;
								sampleList.add(arr);
								itemList = new ArrayList<String>();
							}

							//if (!itemList.contains(row.getTest_item_nm())) {
								itemList.add(row.getTest_item_nm());
							//}
							row.setState(vo.getState());
							commonDAO.updateTestState(row);

							/* AUDIT_TRAIL START*/
							String audit = ConverObjectToMap.conver(row).toString();
							HashMap<String, String> map = new HashMap<String, String>();
							//log.debug("Log[Lims AUDIT TRAIL] :" + audit);
							map.put("at_cont", audit); // 로우데이터 셋팅f
							map.put("crud", "u"); // 로우데이터 셋팅
							map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
							map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
							map.put("test_req_seq", vo.getTest_req_seq()); // 접수번호 셋팅
							map.put("test_sample_seq", row.getTest_sample_seq()); // 시료번호 셋팅
							map.put("at_proc", "결과확인");
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

						//결제라인 추가 처리
						/*ArrayList<ResultInputVO> apprLineList = (ArrayList<ResultInputVO>) resultCheckDAO.selectApprLineUserList(vo);
						if (apprLineList != null && apprLineList.size() > 0) {
							for (ResultInputVO a : apprLineList) {
								//a.setTest_sample_seq(vo.getTest_sample_seq());
								//a.setTest_req_no(vo.getTest_req_no());
								a.setTest_req_seq(vo.getTest_req_seq());
								a.setDept_cd(vo.getDept_cd());
								a.setCreater_id(vo.getUser_id());
								a.setState(vo.getState());
								resultCheckDAO.insertApprRequest(a);
							}

							ResultInputVO ap = resultCheckDAO.selectApprNowPos(vo);
							if (ap != null) {
								vo.setAppr_no(ap.getAppr_no());
								resultCheckDAO.updateApprNowPos(vo);
								for (String[] sample : sampleList) {
									historyVO.setTest_sample_seq(sample[0]);
									if ("D".equals(vo.getState())) {
										historyVO.setSample_state("E");
									} else {
										historyVO.setSample_state("P");
									}

									historyVO.setDept_cd(sample[1]);
									historyVO.setUser_id(ap.getAppr_id());
									historyVO.setTest_dept_cd(vo.getDept_cd());
									if (vo.getDept_cd().equals(sample[1])) {
										historyVO.setColla_flag("N");
									} else {
										historyVO.setColla_flag("Y");
									}
									historyVO.setEtc(null);
									commonDAO.insertSampleHistory(historyVO);
								}

								// 알리미
								//commonService.sendAlert(ap.getAppr_id());
							}
						}*/
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 결과확인 상신 회수
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public int cancelResultCheck(ResultInputVO vo) throws Exception {
		try {
			if (vo.getTest_req_seq() != null && !"".equals(vo.getTest_req_seq())) {
				String[] test_req_seq_arr = (vo.getTest_req_seq()).split(",", -1);
				if (test_req_seq_arr.length > 0) {
					for (String test_req_seq : test_req_seq_arr) {
						vo.setTest_req_seq(test_req_seq);
						List<AcceptVO> checkList = resultCheckDAO.selectCheckList(vo);
						List<String> itemList = new ArrayList<String>();
						List<String[]> sampleList = new ArrayList<String[]>();
						String row_test_sample_seq = null;
						String row_dept_cd = null;
						for (AcceptVO row : checkList) {
							if (row_test_sample_seq == null) {
								row_test_sample_seq = row.getTest_sample_seq();
								row_dept_cd = row.getDept_cd();
								String[] arr = new String[2];
								arr[0] = row_test_sample_seq;
								arr[1] = row_dept_cd;
								sampleList.add(arr);
							}
							if (!row_test_sample_seq.equals(row.getTest_sample_seq())) {
								HistoryVO historyVO = new HistoryVO();
								historyVO.setTest_sample_seq(row_test_sample_seq);
								if ("D".equals(vo.getState())) {
									historyVO.setSample_state("I");
								} else {
									historyVO.setSample_state("J");
								}
								historyVO.setDept_cd(row_dept_cd);
								historyVO.setUser_id(vo.getUser_id());
								historyVO.setTest_dept_cd(vo.getDept_cd());
								if (vo.getDept_cd().equals(row_dept_cd)) {
									historyVO.setColla_flag("N");
								} else {
									historyVO.setColla_flag("Y");
								}
								historyVO.setEtc(itemList.toString());
								historyVO.setTest_req_seq(vo.getTest_req_seq());
								commonDAO.insertSampleHistory(historyVO);

								row_test_sample_seq = row.getTest_sample_seq();
								row_dept_cd = row.getDept_cd();
								String[] arr = new String[2];
								arr[0] = row_test_sample_seq;
								arr[1] = row_dept_cd;
								sampleList.add(arr);
								itemList = new ArrayList<String>();
							}

							//if (!itemList.contains(row.getTest_item_nm())) {
								itemList.add(row.getTest_item_nm());
							//}

							if ("D".equals(vo.getState())) {
								row.setState("C");
							} else {
								row.setState("F");
							}

							commonDAO.updateTestState(row);
							/* AUDIT_TRAIL START*/
							String audit = ConverObjectToMap.conver(row).toString();
							HashMap<String, String> map = new HashMap<String, String>();
							//log.debug("Log[Lims AUDIT TRAIL] :" + audit);
							map.put("at_cont", audit); // 로우데이터 셋팅f
							map.put("crud", "u"); // 로우데이터 셋팅
							map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
							map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
							map.put("test_req_seq", vo.getTest_req_seq()); // 접수번호 셋팅
							map.put("test_sample_seq", row.getTest_sample_seq()); // 시료번호 셋팅
							map.put("at_proc", "상신회수");
							map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
							auditTrailDAO.insertAuditTrail(map);
							/* AUDIT_TRAIL END*/
						}
						HistoryVO historyVO = new HistoryVO();
						historyVO.setTest_sample_seq(row_test_sample_seq);
						if ("D".equals(vo.getState())) {
							historyVO.setSample_state("I");
						} else {
							historyVO.setSample_state("J");
						}
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
						historyVO.setTest_req_seq(vo.getTest_req_seq());
						commonDAO.insertSampleHistory(historyVO);
						commonDAO.deleteApprLine(vo);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 결재라인 목록 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public List<ResultInputVO> selectApprLineList(ResultInputVO vo) throws Exception {
		return resultCheckDAO.selectApprLineList(vo);
	}

	public int insertApprLine(ResultInputVO vo) throws Exception {
		try {
			return resultCheckDAO.insertApprLine(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int updateApprLine(ResultInputVO vo) throws Exception {
		try {
			return resultCheckDAO.updateApprLine(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	public int updateApprDefault(ResultInputVO vo) throws Exception {
		try {
			return resultCheckDAO.updateApprDefault(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	

	public int deleteApprLine(ResultInputVO vo) throws Exception {
		try {
			return resultCheckDAO.deleteApprLine(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	
	
	/**
	 * 전체사용자 목록 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public List<ResultInputVO> selectCmmnUserList(ResultInputVO vo) throws Exception {
		return resultCheckDAO.selectCmmnUserList(vo);
	}

	/**
	 * 결재라인 사용자 목록 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public List<ResultInputVO> selectApprLineUserList(ResultInputVO vo) throws Exception {
		return resultCheckDAO.selectApprLineUserList(vo);
	}

	/**
	 * 결재라인 사용자 저장/수정 처리
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public int saveApprovalUser(ResultInputVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				resultCheckDAO.deleteApprovalUser(vo);
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
							}
						}
						map.put("creater_id", vo.getUser_id());
						map.put("appr_mst_seq", vo.getAppr_mst_seq());
						resultCheckDAO.insertApprovalUser(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 시험 확인 > 시료판정 값 수정
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateSampleJdg(ResultInputVO vo) throws Exception {
		try {
			return resultCheckDAO.updateSampleJdg(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	
	
	/**
	 * 항목별 결과 히스토리 항목
	 */
	public List<ResultInputVO> selectItemResultHistory(ResultInputVO vo)throws Exception {
		return resultCheckDAO.selectItemResultHistory(vo);
	}
}
