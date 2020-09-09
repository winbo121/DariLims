package iit.lims.master.service;

import java.util.HashMap;
import java.util.List;

import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;


/**
 * AccountService
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

public interface AccountService {

	/**
	 * 계산식관리 목록 조회
	 *
	 * @param AccountVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AccountVO> selectAccountList(AccountVO vo) throws Exception;

	/**
	 * 계산식관리 상세정보 조회
	 *
	 * @param AccountVO
	 * @return AccountVO
	 * @exception Exception	 
	 */
	public List<AccountVO> selectAccountDetailList(AccountVO vo) throws Exception;

	/**
	 * 계산식관리 저장 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertAccount(AccountVO vo) throws Exception;

	/**
	 * 계산식관리 수정 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateAccount(AccountVO vo) throws Exception;

	/**
	 * 계산식관리 삭제 처리
	 *
	 * @param AccountVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteAccount(AccountVO vo) throws Exception;

	/**
	 * 계산식관리 상세 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public AccountVO selectAccountDetail(AccountVO vo) throws Exception;

	/**
	 * 세부계산식 저장
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int saveAccountDetail(AccountVO accountVO) throws Exception;

	/**
	 * 계산식적용 리스트 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<AccountVO> selectAccountApplyList(AccountVO vo) throws Exception;

	/**
	 * 세부계산식적용값 저장
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int saveAccountApply(AccountVO accountVO)throws Exception;

	/**
	 * 계산식관리 삭제 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int deleteAccountDetail(AccountVO vo) throws Exception;

	/**
	 * 계산식확인
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public String checkAccount(AccountVO vo) throws Exception;	
	
	public List<TestItemVO> selectMasterList(TestItemVO param) throws Exception;


}
