package iit.lims.analysis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.dao.ResultApprovalDAO;
import iit.lims.analysis.dao.ResultCheckDAO;
import iit.lims.analysis.dao.ResultInputSampleDAO;
import iit.lims.analysis.service.ResultApprovalService;
import iit.lims.analysis.vo.ResultApprovalVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.service.CommonService;
import iit.lims.common.vo.HistoryVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.ConverObjectToMap;
import iit.lims.util.SessionCheck;
import iit.lims.util.Sms;
import iit.lims.util.sms.service.SmsService;
import iit.lims.util.sms.vo.SmsVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ResultApprovalServiceImpl
 * 
 * @resultApprovalor 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class ResultApprovalServiceImpl extends EgovAbstractServiceImpl implements ResultApprovalService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultApprovalDAO")
	private ResultApprovalDAO resultApprovalDAO;
	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;
	@Resource
	private CommonDAO commonDAO;
	@Resource
	private CommonService commonService;
	@Resource(name = "resultInputSampleDAO")
	private ResultInputSampleDAO resultInputSampleDAO;
	@Resource(name = "resultCheckDAO")
	private ResultCheckDAO resultCheckDAO;

	@Resource
	private SmsService smsService;
	/**
	 * 결재라인 조회
	 * 
	 * @param AcceptApprovalVO
	 * @throws Exception
	 */
	public List<ResultApprovalVO> selectApprList(ResultApprovalVO vo) throws Exception {
		return resultApprovalDAO.selectApprList(vo);
	}

	/**
	 * 시료목록 조회
	 * 
	 * @param AcceptApprovalVO
	 * @throws Exception
	 */
	public List<ResultApprovalVO> selectSampleList(ResultInputVO vo) throws Exception {

		return resultApprovalDAO.selectSampleList(vo);
	}

	/**
	 * 항목목록 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultApprovalVO> selectSampleItemList(ResultInputVO vo) throws Exception {
		return resultApprovalDAO.selectSampleItemList(vo);
	}

	/**
	 * 승인 처리
	 * 
	 * @param AcceptApprovalVO
	 * @throws Exception
	 */
	public int updateAppr(ResultApprovalVO vo) throws Exception {
		try {
			//결과승인완료
			vo.setState("F");
			
			if (vo.getTest_req_seq() != null && !"".equals(vo.getTest_req_seq())) {
				String[] test_req_seq_arr = (vo.getTest_req_seq()).split(",", -1);
				if (test_req_seq_arr.length > 0) {
					for (String test_req_seq : test_req_seq_arr) {
						vo.setTest_req_seq(test_req_seq);
						List<AcceptVO> approvalList = resultApprovalDAO.selectApprovalList(vo);
						List<String[]> sampleList = new ArrayList<String[]>();
						String row_test_sample_seq = null;
						String row_dept_cd = null;
						for (AcceptVO row : approvalList) {
							if (row_test_sample_seq == null) {
								row_test_sample_seq = row.getTest_sample_seq();
								row_dept_cd = row.getDept_cd();
								String[] arr = new String[3];
								arr[0] = row_test_sample_seq;
								arr[1] = row_dept_cd;
								arr[2] = row.getUser_id();
								sampleList.add(arr);
							}
							if (!row_test_sample_seq.equals(row.getTest_sample_seq())) {
								row_test_sample_seq = row.getTest_sample_seq();
								row_dept_cd = row.getDept_cd();
								String[] arr = new String[3];
								arr[0] = row_test_sample_seq;
								arr[1] = row_dept_cd;
								arr[2] = row.getUser_id();
								sampleList.add(arr);
							}
						}

						//승인처리
						resultApprovalDAO.updateAppr(vo);

						for (String[] sample : sampleList) {
							HistoryVO historyVO = new HistoryVO();
							
							System.out.println(sample[0]);
							
							historyVO.setTest_sample_seq(sample[0]);
							historyVO.setSample_state("G");
							if (sample[2] != null && !sample[2].equals(vo.getAppr_id())) {
								historyVO.setSample_state("K");
							}
							historyVO.setDept_cd(vo.getDept_cd());
							historyVO.setUser_id(vo.getUser_id());
							historyVO.setTest_dept_cd(vo.getDept_cd());
							historyVO.setEtc(null);
							historyVO.setTest_req_seq(vo.getTest_req_seq());
							commonDAO.insertSampleHistory(historyVO);
						}

						//승인대기자 조회
						ResultApprovalVO ap = resultApprovalDAO.selectApprNowPos(vo);
						if (ap != null) {
							vo.setAppr_no(ap.getAppr_no());
							//승인대기자 다음 승인자로 수정
							resultApprovalDAO.updateApprNowPos(vo);
							for (String[] sample : sampleList) {
								HistoryVO historyVO = new HistoryVO();
								historyVO.setTest_sample_seq(sample[0]);
								if ("F".equals(vo.getState())) {
									vo.setState("E");
								} else {
									vo.setState("P");
								}
								historyVO.setSample_state(vo.getState());
								historyVO.setDept_cd(sample[1]);
								historyVO.setUser_id(ap.getAppr_id());
								historyVO.setTest_dept_cd(vo.getDept_cd());
								if (vo.getDept_cd().equals(sample[1])) {
									historyVO.setColla_flag("N");
								} else {
									historyVO.setColla_flag("Y");
								}
								historyVO.setEtc(null);
								historyVO.setTest_req_seq(vo.getTest_req_seq());
								commonDAO.insertSampleHistory(historyVO);
							}
						}

						//남은 미승인자 수 조회
						Integer apprCnt = resultApprovalDAO.selectApprCnt(vo);
						if (apprCnt == 0) {
							row_test_sample_seq = null;
							row_dept_cd = null;
							List<String> itemList = new ArrayList<String>();
							for (AcceptVO row : approvalList) {

								if (row_test_sample_seq == null) {
									row_test_sample_seq = row.getTest_sample_seq();
									row_dept_cd = row.getDept_cd();
								}
								if (!row_test_sample_seq.equals(row.getTest_sample_seq())) {
									HistoryVO historyVO = new HistoryVO();
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
									historyVO.setTest_req_seq(vo.getTest_req_seq());
									commonDAO.insertSampleHistory(historyVO);

									row_test_sample_seq = row.getTest_sample_seq();
									row_dept_cd = row.getDept_cd();
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
								log.debug("Log[Lims AUDIT TRAIL] :" + audit);
								map.put("at_cont", audit); // 로우데이터 셋팅f
								map.put("crud", "u"); // 로우데이터 셋팅
								map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
								map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
								map.put("test_req_seq", vo.getTest_req_seq()); // 접수번호 셋팅
								map.put("test_sample_seq", row.getTest_sample_seq()); // 시료번호 셋팅
								map.put("at_proc", "승인완료");
								map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
								auditTrailDAO.insertAuditTrail(map);
								/* AUDIT_TRAIL END*/
							}
							HistoryVO historyVO = new HistoryVO();
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
							historyVO.setTest_req_seq(vo.getTest_req_seq());
							commonDAO.insertSampleHistory(historyVO);
							//commonDAO.deleteApprLine(vo);
							

/*							//SMS 발송
				        	SmsVO searchVO = new SmsVO();
				        	searchVO.setTest_req_seq(vo.getTest_req_seq());
				        	SmsVO tagetVO = smsService.selectSmsTarget(searchVO);
				        	//발송여부
				            if(tagetVO.getSms_flag().equals("Y")){
				            	Sms sms = new Sms();
								tagetVO.setProcess("B");				
								String custom_message = smsService.selectSmsCont(tagetVO);
								tagetVO.setCustom_msg(custom_message);			
								
								SmsVO returnVO = sms.SmsSend(tagetVO);
					        	smsService.insertSmsLog(returnVO);
				            }*/
						}
						if (ap != null) {
							// 알리미
							//commonService.sendAlert(ap.getAppr_id());
						}
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
