package iit.lims.analysis.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ResultCheckDAO
 * 
 * @author 윤상준
 * @since 2015.02.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.17  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ResultCheckDAO extends EgovAbstractMapper {

	public ResultInputVO selectApprLineDefaultList(ResultInputVO vo) {
		return (ResultInputVO) selectOne("resultCheck.selectApprLineDefaultList", vo);
	}

	public List<ResultInputVO> selectCheckReqList(ResultInputVO vo) {
		return selectList("resultCheck.selectCheckReqList", vo);
	}

	public List<ResultInputVO> updateSampleResult(ResultInputVO vo) {
		return selectList("resultCheck.updateSampleResult", vo);
	}

	public List<ResultInputVO> selectApprLineList(ResultInputVO vo) {
		return selectList("resultCheck.selectApprLineList", vo);
	}

	public List<ResultInputVO> selectCmmnUserList(ResultInputVO vo) {
		return selectList("resultCheck.selectUserList", vo);
	}

	public List<ResultInputVO> selectApprLineUserList(ResultInputVO vo) {
		return selectList("resultCheck.selectApprLineUserList", vo);
	}

	public int insertApprLine(ResultInputVO vo) throws Exception {
		insert("resultCheck.insertApprLine", vo);
		return 1;
	}

	public int updateApprLine(ResultInputVO vo) throws Exception {
		return update("resultCheck.updateApprLine", vo);
	}

	public int updateApprDefault(ResultInputVO vo) throws Exception {
		return update("resultCheck.updateApprDefault", vo);
	}

	public int deleteApprLine(ResultInputVO vo) throws Exception {
		return delete("resultCheck.deleteApprLine", vo);
	}
	
	
	public int insertApprovalUser(HashMap<String, String> map) throws Exception {
		insert("resultCheck.insertApprovalUser", map);
		return 1;
	}

	public int deleteApprovalUser(ResultInputVO vo) throws Exception {
		return delete("resultCheck.deleteApprovalUser", vo);
	}

	public int insertApprRequest(ResultInputVO vo) throws Exception {
		insert("resultCheck.insertApprRequest", vo);
		return 1;
	}

	public int updateApprNowPos(ResultInputVO vo) throws Exception {
		return update("resultCheck.updateApprNowPos", vo);
	}

	public ResultInputVO selectApprNowPos(ResultInputVO vo) throws Exception {
		return selectOne("resultCheck.selectApprNowPos", vo);
	}

	public List<AcceptVO> selectCheckList(AcceptVO vo) {
		return selectList("resultCheck.selectCheckList", vo);
	}

	public List<AcceptVO> selectCancelList(AcceptVO vo) {
		return selectList("resultCheck.selectCancelList", vo);
	}
	
	public int updateSampleJdg(ResultInputVO vo) throws Exception {
		return update("resultCheck.updateSampleJdg", vo);
	}	
	public List<ResultInputVO> selectItemResultHistory(ResultInputVO vo)throws Exception {
		return selectList("resultCheck.selectItemResultHistoryPop", vo);
	}

}
