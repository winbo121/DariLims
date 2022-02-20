package iit.lims.instrument.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.instrument.vo.CorrectionVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CorrectionDAO extends EgovAbstractMapper {

	public List<CorrectionVO> selectCorrectionList(CorrectionVO correctionVO) throws DataAccessException {
		return selectList("correction.correction", correctionVO);
	}

	public CorrectionVO correctionDetail(CorrectionVO correctionVO) {
		return (CorrectionVO) selectOne("correction.correctionDetail", correctionVO);
	}
	
	public CorrectionVO correctionMng(CorrectionVO correctionVO) {
		return (CorrectionVO) selectOne("correction.correctionMng", correctionVO);
	}

	public int insertCorrection(CorrectionVO correctionVO) throws Exception {
		return insert("correction.insertCorrection", correctionVO);
	}

	public int updateCorrection(CorrectionVO correctionVO) throws DataAccessException {
		return update("correction.updateCorrection", correctionVO);
	}

	public int deleteCorrection(CorrectionVO correctionVO) throws DataAccessException {
		return delete("correction.deleteCorrection", correctionVO);
	}
	
	public List<CorrectionVO> selectCorrectionList2(CorrectionVO correctionVO) throws DataAccessException {
		return selectList("correction.correction2", correctionVO);
	}

	public CorrectionVO correctionDetail2(CorrectionVO correctionVO) {
		return (CorrectionVO) selectOne("correction.correctionDetail2", correctionVO);
	}

	public int insertCorrection2(CorrectionVO correctionVO) throws Exception {
		return insert("correction.insertCorrection2", correctionVO);
	}

	public int updateCorrection2(CorrectionVO correctionVO) throws DataAccessException {
		return update("correction.updateCorrection2", correctionVO);
	}

	public int deleteCorrection2(CorrectionVO correctionVO) throws DataAccessException {
		return delete("correction.deleteCorrection2", correctionVO);
	}
}
