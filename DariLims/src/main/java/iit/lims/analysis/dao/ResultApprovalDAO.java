package iit.lims.analysis.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultApprovalVO;
import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * MenuService
 * 
 * @author 정우용
 * @since 2015.01.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.17  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ResultApprovalDAO extends EgovAbstractMapper {

	public List<ResultApprovalVO> selectApprList(ResultApprovalVO vo) {
		return selectList("resultApproval.selectApprList", vo);
	}

	public List<ResultApprovalVO> selectSampleList(ResultApprovalVO vo) {
		return selectList("resultApproval.selectSampleList", vo);
	}

	public List<ResultApprovalVO> selectSampleItemList(ResultInputVO vo) {
		return selectList("resultApproval.selectSampleItemList", vo);
	}

	public int updateApprNowPos(ResultApprovalVO vo) throws Exception {
		return update("resultApproval.updateApprNowPos", vo);
	}

	public ResultApprovalVO selectApprNowPos(ResultApprovalVO vo) throws Exception {
		return selectOne("resultApproval.selectApprNowPos", vo);
	}

	public int updateAppr(ResultApprovalVO vo) throws Exception {
		return update("resultApproval.updateAppr", vo);
	}

	public Integer selectApprCnt(ResultApprovalVO vo) {
		return selectOne("resultApproval.selectApprCnt", vo);
	}

	public Integer apprItemCnt(ResultApprovalVO vo) {
		return selectOne("resultApproval.apprItemCnt", vo);
	}

	public List<ResultApprovalVO> selectApprLineList(ResultApprovalVO vo) {
		return selectList("resultApproval.selectApprLineList", vo);
	}

	public int updateSampleApprReturn(ResultApprovalVO vo) throws Exception {
		return update("resultApproval.updateSampleApprReturn", vo);
	}

	public List<AcceptVO> selectApprovalList(AcceptVO vo) {
		return selectList("resultApproval.selectApprovalList", vo);
	}
}