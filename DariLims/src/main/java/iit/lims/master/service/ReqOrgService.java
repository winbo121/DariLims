package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.ReqOrgVO;


/**
 * ReqOrgService
 * @author 석은주
 * @since 2015.01.23
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.23  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface ReqOrgService {

	/**
	 * 의뢰처관리 목록 조회
	 *
	 * @param ReqOrgVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ReqOrgVO> selectReqOrgList(ReqOrgVO vo) throws Exception;

	/**
	 * 의뢰처관리 상세정보 조회
	 *
	 * @param ReqOrgVO
	 * @return ReqOrgVO
	 * @exception Exception	 
	 */
	public ReqOrgVO selectReqOrgDetail(ReqOrgVO vo) throws Exception;

	/**
	 * 의뢰처관리 저장 처리
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertReqOrg(ReqOrgVO vo) throws Exception;

	/**
	 * 의뢰처관리 수정 처리
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateReqOrg(ReqOrgVO vo) throws Exception;
	
	/**
	 * 의뢰처관리 삭제 처리
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteReqOrg(ReqOrgVO vo) throws Exception;	
	
	public int copyReqOrg(ReqOrgVO vo) throws Exception;
	

}
