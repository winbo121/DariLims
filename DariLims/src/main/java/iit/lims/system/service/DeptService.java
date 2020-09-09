package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.DeptVO;

/**
 * DeptService
 * @author 윤상준
 * @since 2015.08.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.08.24  윤상준   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface DeptService {

	
	/**
	 * 공통부서 목록 조회
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<DeptVO> selectDeptCmmnList(DeptVO deptVO) throws Exception;
	
	/**
	 * LIMS사용부서 목록 조회
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<DeptVO> selectDeptLimsList(DeptVO deptVO) throws Exception;
	
	/**
	 * 부서관리 확인 처리
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int saveDeptLims(DeptVO deptVO) throws Exception;
	
	/**
	 * 부서관리 수정 처리
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int updateDeptLims(DeptVO deptVO) throws Exception;

	/**
	 * 부서 등록
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int insertDeptInfo(DeptVO deptVO)throws Exception;

	/**
	 * 부서관리 수정 처리
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int updateDeptInfo(DeptVO deptVO)throws Exception;

	/**
	 * 부서정보 수정
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public DeptVO selectDeptLimsDetail(DeptVO deptVO)throws Exception;

	/**
	 * 부서 팀 목록 조회
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<DeptVO> selectDeptTeamList(DeptVO deptVO) throws Exception;

	/**
	 * 부서 팀 사용자 목록 조회
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<DeptVO> selectDeptTeamUserList(DeptVO deptVO) throws Exception;

	/**
	 * 팀정보 수정
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int updateDeptTeam(DeptVO deptVO)throws Exception;

	/**
	 * 팀 사용자 등록
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int insertDeptTeam(DeptVO deptVO)throws Exception;

	/**
	 * 팀 등록 팝업
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public Object selectDeptTeamDetail(DeptVO deptVO)throws Exception;

	/**
	 * 팀정보 삭제
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int deleteDeptTeam(DeptVO deptVO)throws Exception;

	/**
	 * 팀 사용자 등록
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int insertDeptTeamUser(DeptVO deptVO)throws Exception;
	
	/**
	 * 팀 사용자 삭제
	 *
	 * @param DeptVO
	 * @return List
	 * @exception Exception	 
	 */
	public int deleteDeptTeamUser(DeptVO deptVO)throws Exception;
}

