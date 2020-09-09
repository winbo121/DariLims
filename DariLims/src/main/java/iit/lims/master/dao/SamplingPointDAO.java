package iit.lims.master.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.SamplingPointVO;
import iit.lims.system.vo.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SamplingPointDAO extends EgovAbstractMapper {

	public List<SamplingPointVO> samplingPoint(SamplingPointVO samplingPointVO) throws DataAccessException {
		return selectList("samplingPoint.samplingPoint", samplingPointVO);
	}

	public SamplingPointVO samplingPointDetail(SamplingPointVO samplingPointVO) {
		return (SamplingPointVO) selectOne("samplingPoint.samplingPointDetail", samplingPointVO);
	}

	public int insertSamplingPoint(SamplingPointVO samplingPointVO) throws DataAccessException {
		insert("samplingPoint.insertSamplingPoint", samplingPointVO);
		return 1;
	}

	public int updateSamplingPoint(SamplingPointVO samplingPointVO) throws DataAccessException {
		return update("samplingPoint.updateSamplingPoint", samplingPointVO);
	}

	public int deleteSamplingPoint(SamplingPointVO samplingPointVO) throws DataAccessException {
		return delete("samplingPoint.deleteSamplingPoint", samplingPointVO);
	}

	public List<SamplingPointVO> selectReqOrgList(SamplingPointVO samplingPointVO) throws Exception {
		return selectList("samplingPoint.selectOfficeList", samplingPointVO);
	}

	public int samplingPointCnt(SamplingPointVO samplingPointVO) {
		return (Integer) selectOne("samplingPoint.samplingPointCnt", samplingPointVO);
	}
}