package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.UserVO;

/**
 * AuthService
 * @author 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface UserAuthService {

	/**
	 * 권한관리 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UserVO> selectCmmnUserList(UserVO userVO) throws Exception;
	
	/**
	 * 권한관리 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UserVO> selectAuthUserList(UserVO userVO) throws Exception;
	
	/**
	 * 권한관리 저장/수정 처리
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public int insertAuthUser(UserVO userVO) throws Exception;
	
	/**
	 * 권한관리 삭제 처리
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public int deleteAuthUser(UserVO userVO) throws Exception;

}
