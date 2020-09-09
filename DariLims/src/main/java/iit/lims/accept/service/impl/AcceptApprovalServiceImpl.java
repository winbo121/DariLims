package iit.lims.accept.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.AcceptApprovalDAO;
import iit.lims.accept.dao.AcceptDAO;
import iit.lims.accept.service.AcceptApprovalService;
import iit.lims.accept.vo.AcceptApprovalVO;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.ConverObjectToMap;
import iit.lims.util.SessionCheck;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class AcceptApprovalServiceImpl extends EgovAbstractServiceImpl implements AcceptApprovalService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "acceptApprovalDAO")
	private AcceptApprovalDAO acceptApprovalDAO;

	@Resource(name = "acceptDAO")
	private AcceptDAO acceptDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;
	
	@Resource
	private CommonDAO commonDAO;

	public List<AcceptApprovalVO> selectReqList(AcceptApprovalVO vo) throws Exception {
		return acceptApprovalDAO.selectReqList(vo);
	}
	
	/**
	 * 결재라인 조회
	 * 
	 * @param AcceptApprovalVO
	 * @throws Exception
	 */
	public List<AcceptApprovalVO> selectApprList(AcceptApprovalVO vo) throws Exception {
		return acceptApprovalDAO.selectApprList(vo);
	}

	/**
	 * 승인 처리
	 * 
	 * @param AcceptApprovalVO
	 * @throws Exception
	 */
	public int updateAppr(AcceptApprovalVO vo) throws Exception {
		try {

			String test_req_seq_list = vo.getTest_req_seq();
			String[] columnArr = test_req_seq_list.split("■★■");
			
			if (columnArr != null && columnArr.length > 0) {
				for (String column : columnArr) {
					
					/********************** 승인처리 시작 ***********************/
					vo.setTest_req_seq(column);

					//승인처리
					acceptApprovalDAO.updateAppr(vo);
					
					//승인대기자 조회
					AcceptApprovalVO ap = acceptApprovalDAO.selectApprNowPos(vo);
					if (ap != null) {
						vo.setAppr_no(ap.getAppr_no());
						//승인대기자 다음 승인자로 수정
						acceptApprovalDAO.updateApprNowPos(vo);
					}else{
						//접수대기
						vo.setState("Z");

						acceptDAO.updateAcceptState(vo);
						List<String> seqList = commonDAO.selectSampleSeqList(vo.getTest_req_seq());
						if (seqList != null && seqList.size() > 0) {
							for (String seq : seqList) {
								HistoryVO historyVO = new HistoryVO();
								historyVO.setTest_sample_seq(seq);
								if(vo.getSample_state() != null && vo.getSample_state() != "" &&  !vo.getSample_state().trim().equals("") ){
									historyVO.setSample_state(vo.getSample_state());
								} else {
									historyVO.setSample_state(vo.getState());
								}
								historyVO.setDept_cd(vo.getDept_cd());
								historyVO.setTest_dept_cd(vo.getDept_cd());
								historyVO.setUser_id(vo.getUser_id());
								historyVO.setTest_req_seq(vo.getTest_req_seq());
								commonDAO.insertSampleHistory(historyVO);
							}
						}
						
						/* AUDIT_TRAIL START*/
						HashMap<String, String> map = new HashMap<String, String>();
						String data = ConverObjectToMap.conver(vo).toString();
						log.debug("Log[Lims AUDIT TRAIL] :" + data);
						map.put("crud", "u");
						map.put("at_cont", data); // 로우데이터 셋팅
						map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
						map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
						map.put("test_req_no", vo.getTest_req_no()); // 접수번호 셋팅(위에있음)
						map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
						map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
						map.put("test_req_seq", vo.getTest_req_seq()); // 의뢰일련번호
						
						// 의뢰 -> 접수
						map.put("at_proc", "접수대기");
						
						auditTrailDAO.insertAuditTrail(map);
						/* AUDIT_TRAIL END*/
						
						
						// 의뢰 -> 접수대기로
						acceptDAO.updateAcceptSeq(vo); // 의뢰상태 수정
						acceptDAO.updateSampleSeq(vo); // 시료상태 수정
						acceptDAO.updateItemSeq(vo); // 항목상태 수정
					}

					/********************** 승인처리 종료 ***********************/
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
