package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ResultApprovalVO;
import iit.lims.analysis.vo.ResultInputVO;

/**
 * ResultApprovalService
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

public interface ResultApprovalService {

	/**
	 * 결재선 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultApprovalVO> selectApprList(ResultApprovalVO vo) throws Exception;

	/**
	 * 시료목록 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultApprovalVO> selectSampleList(ResultInputVO vo) throws Exception;

	/**
	 * 항목목록 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultApprovalVO> selectSampleItemList(ResultInputVO vo) throws Exception;

	/**
	 * 승인처리
	 * 
	 * @param AcceptApprovalVO
	 * @return List
	 * @exception Exception
	 */
	public int updateAppr(ResultApprovalVO vo) throws Exception;
}
