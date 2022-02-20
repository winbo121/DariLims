package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.util.JsonView;

/**
 * AccountDAO
 * @author 최은향
 * @since 2015.09.18
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.18  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class AccountDAO extends EgovAbstractMapper {

	/**
	 * 계산식관리 목록 조회
	 *
	 * @param AccountVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AccountVO> selectAccountList(AccountVO vo) throws Exception {
		return selectList("account.selectAccountList", vo);
	}

	/**
	 * 계산식관리 상세정보
	 *
	 * @param AccountVO
	 * @return AccountVO
	 * @exception Exception	 
	 */
	public AccountVO selectAccountDetail(AccountVO vo) throws DataAccessException {
		return selectOne("account.selectAccountDetail", vo);
	}

	/**
	 * 계산식관리 상세정보 조회
	 *
	 * @param AccountVO
	 * @return AccountVO
	 * @exception Exception	 
	 */
	public List<AccountVO> selectAccountDetailList(AccountVO vo) throws DataAccessException {
		return selectList("account.selectAccountDetailList", vo);
	}

	/**
	 * 계산식적용리스트
	 *
	 * @param AccountVO
	 * @return AccountVO
	 * @exception Exception	 
	 */
	public List<AccountVO> selectAccountApplyList(AccountVO vo) throws DataAccessException {
		return selectList("account.selectAccountApplyList", vo);
	}
	
	/**
	 * 계산식적용리스트
	 *
	 * @param AccountVO
	 * @return AccountVO
	 * @exception Exception	 
	 */
	public String checkAccount(AccountVO vo) throws DataAccessException {
		return selectOne("account.checkAccount", vo);
	}
	
	/**
	 * 계산식관리 저장 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertAccount(AccountVO vo) throws Exception {
		return insert("account.insertAccount", vo);
	}

	/**
	 * 계산식관리 수정 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateAccount(AccountVO vo) throws Exception {
		return update("account.updateAccount", vo);
	}

	/**
	 * 계산식관리 삭제 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteAccount(AccountVO vo) {
		return delete("account.deleteAccount", vo);
	}
	

	/**
	 * 계산식관리 삭제 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteAccountDetail(AccountVO vo) {
		return delete("account.deleteAccountDetail", vo);
	}
	
	public int insertAccountDetail(HashMap<String, String> m) throws Exception {
		insert("account.insertAccountDetail", m);
		return 1;
	}

	public int updateAccountDetail(HashMap<String, String> m) throws Exception {
		insert("account.updateAccountDetail", m);
		return 1;
	}
	
	public int deleteAccountDetail(HashMap<String, String> m) throws Exception {
		insert("account.deleteAccountDetail", m);
		return 1;
	}
	
	
	public int insertAccountApply(HashMap<String, String> m) throws Exception {
		insert("account.insertAccountApply", m);
		return 1;
	}

	public int updateAccountApply(HashMap<String, String> m) throws Exception {
		insert("account.updateAccountApply", m);
		return 1;
	}
	
	public int deleteAccountApply(HashMap<String, String> m) throws Exception {
		insert("account.deleteAccountApply", m);
		return 1;
	}
	
	public List<TestItemVO> selectMasterList(TestItemVO param) throws Exception {
		return selectList("account.selectMasterList", param);
	}
}
