package iit.lims.analysis.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class ResultModifyDAO extends EgovAbstractMapper {
	public List<ResultInputVO> selectModifyReqList(ResultInputVO vo) {
		return selectList("resultModify.selectModifyReqList", vo);
	}

	public List<ResultInputVO> selectModifyResultList(ResultInputVO vo) {
		return selectList("resultModify.selectModifyResultList", vo);
	}

}