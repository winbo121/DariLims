package iit.lims.kolas.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.kolas.vo.EduAttendVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * EduAttendDAO
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

@Repository
public class EduAttendDAO extends EgovAbstractMapper {

	/**
	 * 교육참석자 목록 조회
	 *
	 * @param EduAttendVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<EduAttendVO> selectEduAttendList(EduAttendVO vo) throws Exception {
		return selectList("eduAttend.selectEduAttendList", vo);
	}

	/**
	 * 교육참석자 목록 조회
	 *
	 * @param EduAttendVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<EduAttendVO> selectAllUserList(EduAttendVO vo) throws Exception {
		return selectList("eduAttend.selectAllUserList", vo);
	}

	/**
	 * 교육참석자 목록 삭제
	 *
	 * @param EduAttendVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteEduAttend(EduAttendVO vo) throws Exception {
		return delete("eduAttend.deleteEduAttend", vo);		
	}

	/**
	 * 교육참석자 등록
	 *
	 * @param EduAttendVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertEduAttend(HashMap<String, String> map) throws Exception {
		return insert("eduAttend.insertEduAttend", map);		
	}
	
	/**
	 * 교육참석자 수정
	 *
	 * @param EduAttendVO
	 * @return int
	 * @exception Exception	 
	 */
	/*public int updateEduAttend(HashMap<String, String> map) throws Exception {
		return update("eduAttend.updateEduAttend", map);		
	}*/

	/**
	 * 교육참석자 첨부파일 등록
	 *
	 * @param EduAttendVO
	 * @return EduAttendVO
	 * @exception Exception	 
	 */
	public EduAttendVO selectEduAttendDetail(EduAttendVO vo) throws Exception {
		return selectOne("eduAttend.selectEduAttendDetail", vo);
	}

	/**
	 * 교육결과 팝업 첨부파일 업데이트
	 *
	 * @param EduAttendVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateEduAttend(EduAttendVO vo) throws Exception {
		return update("eduAttend.updateEduAttend", vo);
	}

	/**
	 * 교육결과 팝업 첨부파일 다운로드
	 *
	 * @param EduAttendVO
	 * @return EduAttendVO
	 * @exception Exception	 
	 */
	public EduAttendVO eduAttendFileDown(EduAttendVO vo) throws Exception {
		return (EduAttendVO) selectOne("eduAttend.eduAttendFileDown", vo);
	}
	
}
