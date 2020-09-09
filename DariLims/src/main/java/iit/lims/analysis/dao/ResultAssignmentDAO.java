package iit.lims.analysis.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ResultAssignmentDAO
 * 
 * @author 최은향
 * @since 2016.01.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.01.26  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Repository
public class ResultAssignmentDAO extends EgovAbstractMapper {

	public List<ResultInputVO> selectAcceptCompleteList(AcceptVO vo) {
		return selectList("resultAssignment.selectAcceptCompleteList", vo);
	}
	
	public List<ResultInputVO> selectSampleAssignmentList(ResultInputVO vo) {
		return selectList("resultAssignment.selectSampleAssignmentList", vo);
	}
	
	public List<ResultInputVO> selectResultAssignmentList(ResultInputVO vo) {
		return selectList("resultAssignment.selectResultAssignmentList", vo);
	}
	
	public int updateResultTester(HashMap<String, String> m) throws Exception {
		return update("resultAssignment.updateResultTester", m);
	}

	public ResultInputVO selectAssignmentValidation(ResultInputVO vo) throws Exception {
		return selectOne("resultAssignment.selectAssignmentValidation", vo);
	}

	public int updateAssignmentComplete(ResultInputVO vo) throws Exception {
		return update("resultAssignment.updateAssignmentComplete", vo);
	}
	
}