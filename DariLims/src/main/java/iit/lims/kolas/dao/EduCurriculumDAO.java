package iit.lims.kolas.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.kolas.vo.EduAttendVO;
import iit.lims.kolas.vo.EduResultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * EduCurriculumDAO
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

@Repository
public class EduCurriculumDAO extends EgovAbstractMapper {

	/**
	 * 메뉴관리 목록 조회 
	 * @param EduResultVO
	 * @return List
	 * @throws Exception
	 */
	public List<EduResultVO> selectEduCurrList(EduResultVO vo) throws Exception {
		return selectList("eduCurr.selectEduCurrList", vo);
	}

	/**
	 * 교육과정 등록 상세정보 조회 
	 * @param EduResultVO
	 * @return EduResultVO
	 * @throws Exception
	 */
	public EduResultVO selectEduCurriculumDetail(EduResultVO vo) throws Exception {
		return selectOne("eduCurr.selectEduCurriculumDetail", vo);
	}
	
	/**
	 * 교육과정 등록을 위한 새로운 No 받기 
	 * @param EduResultVO
	 * @return Integer
	 * @throws Exception
	 */
	public String getNewEduResultNo() throws Exception {
		return selectOne("eduCurr.getNewEduResultNo");
	}

	/**
	 * 교육과정 등록 저장 
	 * @param EduResultVO
	 * @return int
	 * @throws Exception
	 */
	public int insertEduCurriculum(EduResultVO vo) throws Exception {
		return insert("eduCurr.insertEduCurriculum", vo);
	}
	
	/**
	 * 교육과정 등록 첨부파일 신규등록 
	 * @param EduResultVO
	 * @return int
	 * @throws Exception
	 */
	public int insertEduCurrDocFile(EduResultVO vo) throws Exception {
		return insert("eduCurr.insertEduCurrDocFile", vo);
	}

	/**
	 * 교육과정 등록 수정 
	 * @param EduResultVO
	 * @return int
	 * @throws Exception
	 */
	public int updateEduCurriculum(EduResultVO vo) throws Exception {
		return update("eduCurr.updateEduCurriculum", vo);
	}
	
	/**
	 * 교육과정 등록 첨부파일 수정 
	 * @param EduResultVO
	 * @return int
	 * @throws Exception
	 */
	public int updateEduCurrDocFile(EduResultVO vo) throws Exception {
		return update("eduCurr.updateEduCurrDocFile", vo);	
	}
	
	public int deleteEduCurriculum(EduResultVO vo) throws Exception {
		return delete("eduCurr.deleteEduCurriculum", vo);
	}
	
	/**
	 * 교육과정 등록 첨부파일 수정 전 저장된 첨부파일 여부 확인
	 * @param EduResultVO
	 * @return int
	 * @throws Exception
	 */
	public Integer selectEduCurrDocFile(EduResultVO vo) throws Exception {
		return selectOne("eduCurr.selectEduCurrDocFile", vo);
	}
	
	/**
	 * 교육과정 참석자 여부
	 * @param EduResultVO
	 * @return int
	 * @throws Exception
	 */
	public Integer selectEduAttendCnt(EduResultVO vo) throws Exception {
		return selectOne("eduCurr.selectEduAttendCnt", vo);
	}
	
	/**
	 * 교육과정 교육일자 확인
	 * @param EduResultVO
	 * @return string
	 * @throws Exception
	 */
	public String selectEduEndDt(EduResultVO vo) throws Exception {
		return selectOne("eduCurr.selectEduEndDt", vo);
	}

	/**
	 * 교육참석자 팝업 참석자 목록 조회
	 *
	 * @param EduAttendVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<EduAttendVO> selectEduAttendInfoList(EduAttendVO vo) throws Exception {
		return selectList("eduCurr.selectEduAttendInfoList", vo);
	}

	/**
	 * 교육과정 등록 첨부파일 다운로드
	 *
	 * @param EduResultVO
	 * @return EduResultVO
	 * @exception Exception	 
	 */
	public EduResultVO eduCurriculumDown(EduResultVO vo) throws Exception {
		return (EduResultVO) selectOne("eduCurr.eduCurriculumDown", vo);
	}

	/**
	 * 교육과정 등록 첨부파일 삭제
	 *
	 * @param EduResultVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteEduCurrDocFile(EduResultVO vo) throws Exception {
		return delete("eduCurr.deleteEduCurrDocFile", vo);
		
	}				
	
}
