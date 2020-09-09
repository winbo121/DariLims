package iit.lims.master.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.master.vo.ReqOrgVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ReqOrgDAO
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

@Repository
public class ReqOrgDAO extends EgovAbstractMapper {

	/**
	 * 의뢰처관리 목록 조회
	 *
	 * @param ReqOrgVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ReqOrgVO> selectReqOrgList(ReqOrgVO vo) throws Exception {
		return selectList("reqOrg.selectReqOrgList", vo);
	}

	/**
	 * 의뢰처관리 상세정보 조회
	 *
	 * @param ReqOrgVO
	 * @return ReqOrgVO
	 * @exception Exception	 
	 */
	public ReqOrgVO selectReqOrgDetail(ReqOrgVO vo) throws Exception {
		return (ReqOrgVO) selectOne("reqOrg.selectReqOrgDetail", vo);
	}

	/**
	 * 의뢰처관리 저장 처리
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertReqOrg(ReqOrgVO vo) throws Exception {
		return insert("reqOrg.insertReqOrg", vo);
	}

	/**
	 * 의뢰처관리 수정 처리
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateReqOrg(ReqOrgVO vo) throws Exception {
		return update("reqOrg.updateReqOrg", vo);
	}

	
	/**
	 * 의뢰처관리 삭제 처리
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteReqOrg(ReqOrgVO vo) {
		return delete("reqOrg.deleteReqOrg", vo);
	}
	
	/**
	 * 의뢰처관리 복사
	 *
	 * @param ReqOrgVO
	 * @return int
	 * @exception Exception	 
	 */
	public int copyReqOrg(ReqOrgVO vo) throws Exception{
		return insert("reqOrg.copyReqOrg",vo);
	}

}
