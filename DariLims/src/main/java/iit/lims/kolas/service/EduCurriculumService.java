package iit.lims.kolas.service;

import java.util.List;

import iit.lims.kolas.vo.EduAttendVO;
import iit.lims.kolas.vo.EduResultVO;


/**
 * EduCurriculumService
 * @author 석은주
 * @since 2015.01.26
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.26  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface EduCurriculumService {

	/**
	 * 교육과정 목록 조회
	 *
	 * @param EduResultVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<EduResultVO> selectEduCurrList(EduResultVO vo) throws Exception;

	/**
	 * 교육과정 등록 상세정보 조회
	 *
	 * @param EduResultVO
	 * @return EduResultVO
	 * @exception Exception	 
	 */
	public EduResultVO selectEduCurriculumDetail(EduResultVO vo) throws Exception;

	/**
	 * 교육과정 등록 저장
	 *
	 * @param EduResultVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertEduCurriculum(EduResultVO vo) throws Exception;

	/**
	 * 교육과정 등록 수정
	 *
	 * @param EduResultVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateEduCurriculum(EduResultVO vo) throws Exception;
	
	/**
	 * 교육과정 등록 삭제
	 *
	 * @param EduResultVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteEduCurriculum(EduResultVO vo) throws Exception;

	/**
	 * 교육참석자 팝업 참석자 목록 조회
	 *
	 * @param EduAttendVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<EduAttendVO> selectEduAttendInfoList(EduAttendVO vo) throws Exception;

	/**
	 * 교육과정 등록 첨부파일 다운로드
	 *
	 * @param EduResultVO
	 * @return EduResultVO
	 * @exception Exception	 
	 */
	public EduResultVO eduCurriculumDown(EduResultVO vo) throws Exception;
	
	
}
