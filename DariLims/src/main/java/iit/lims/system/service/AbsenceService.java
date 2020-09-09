package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.UserVO;

/**
 * @author 진영민
 * @since 2015.06.11
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.11  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface AbsenceService {

	/**
	 * 부재자 목록 조회
	 * 
	 * @param UserVO
	 * @return List
	 * @exception Exception
	 */
	public List<UserVO> selectAbsenceList(UserVO userVO) throws Exception;

	/**
	 * 부재자 상세 조회
	 * 
	 * @param UserVO
	 * @return List
	 * @exception Exception
	 */
	public UserVO selectAbsenceDetail(UserVO userVO) throws Exception;

	/**
	 * 부재자 삽입
	 * 
	 * @param UserVO
	 * @return List
	 * @exception Exception
	 */
	public int saveAbsence(UserVO userVO) throws Exception;

	/**
	 * 부재자 삭제
	 * 
	 * @param UserVO
	 * @return List
	 * @exception Exception
	 */
	public int deleteAbsence(UserVO userVO) throws Exception;

	/**
	 * 대리자 목록 조회
	 * 
	 * @param UserVO
	 * @return List
	 * @exception Exception
	 */
	public List<UserVO> selectAbsenceUserList(UserVO userVO) throws Exception;
}
