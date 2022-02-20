package iit.lims.accept.service;

import java.util.List;

import iit.lims.accept.vo.AcceptApprovalVO;

public interface AcceptApprovalService {

	public List<AcceptApprovalVO> selectReqList(AcceptApprovalVO vo) throws Exception;
	
	/**
	 * 결재선 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptApprovalVO> selectApprList(AcceptApprovalVO vo) throws Exception;

	/**
	 * 승인처리
	 * 
	 * @param AcceptApprovalVO
	 * @return List
	 * @exception Exception
	 */
	public int updateAppr(AcceptApprovalVO vo) throws Exception;
}
