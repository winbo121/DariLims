package iit.lims.kolas.service;

import java.util.List;

import iit.lims.kolas.vo.EduAttendVO;

/**
 * EduAttendService
 * @author 석은주
 * @since 2015.01.28
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.28  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface EduAttendService {

	/**
	 * 교육참석자 목록 조회
	 *
	 * @param EduAttendVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<EduAttendVO> selectEduAttendList(EduAttendVO vo) throws Exception;

	/**
	 * 교육참석자 상세보기/추가 화면 보기
	 *
	 * @param EduAttendVO
	 * @return EduAttendVO
	 * @exception Exception	 
	 */
	public EduAttendVO selectEduAttendDetail(EduAttendVO vo) throws Exception;

	/**
	 * 교육참석자 목록 저장
	 *
	 * @param EduAttendVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertEduAttend(EduAttendVO vo) throws Exception;

	/**
	 * 교육결과 팝업 첨부파일 업데이트
	 *
	 * @param EduAttendVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateEduAttend(EduAttendVO vo) throws Exception;

	/**
	 * 교육결과 팝업 첨부파일 다운로드
	 *
	 * @param EduAttendVO
	 * @return EduAttendVO
	 * @exception Exception	 
	 */
	public EduAttendVO eduAttendFileDown(EduAttendVO vo) throws Exception;
	
}
