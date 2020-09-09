package iit.lims.accept.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptApprovalVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


@Repository
public class AcceptApprovalDAO extends EgovAbstractMapper {

	public List<AcceptApprovalVO> selectReqList(AcceptApprovalVO vo) {
		return selectList("acceptApproval.selectReqList", vo);
	}
	
	public List<AcceptApprovalVO> selectApprList(AcceptApprovalVO vo) {
		return selectList("acceptApproval.selectApprList", vo);
	}

	public int updateApprNowPos(AcceptApprovalVO vo) throws Exception {
		return update("acceptApproval.updateApprNowPos", vo);
	}

	public AcceptApprovalVO selectApprNowPos(AcceptApprovalVO vo) throws Exception {
		return selectOne("acceptApproval.selectApprNowPos", vo);
	}

	public int updateAppr(AcceptApprovalVO vo) throws Exception {
		return update("acceptApproval.updateAppr", vo);
	}

}