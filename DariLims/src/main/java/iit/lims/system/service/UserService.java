package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.UserVO;

/**
 * UserService
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


public interface UserService {

	
	/**
	 * 사용자관리 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UserVO> selectUserCmmnList(UserVO userVO) throws Exception;
	
	/**
	 * 사용자관리 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UserVO> selectUserLimsList(UserVO userVO) throws Exception;
	
	/**
	 * 사용자관리 저장/수정 처리
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public int saveUserLims(UserVO userVO) throws Exception;
	
	/**
	 * 결재라인 멀티 저장
	 * 
	 * @param UserVO
	 * @return int
	 * @exception Exception
	 */
	public int updateUserFlag(UserVO vo) throws Exception;
	
	/**
	 * 사용자 상세 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public UserVO selectUserLimsDetail(UserVO userVO) throws Exception;
	
	/**
	 * 사용자 등록
	 * @param UserVO
	 * @throws Exception
	 */
	public int insertUserInfo(UserVO userVO) throws Exception;
	
	/**
	 * 사용자정보 수정
	 * @param UserVO
	 * @throws Exception
	 */
	public int updateUserInfo(UserVO userVO) throws Exception;
	
	/**
	 * 사인 저장
	 */
	public int putSignFile(UserVO userVO) throws Exception;
	
	/**
	 * 사인 삭제
	 */
	public int deleteSignFile(UserVO userVO) throws Exception;
	
}
