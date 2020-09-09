package iit.lims.master.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.SampleVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SampleDAO extends EgovAbstractMapper {
	
	public List<SampleVO> sampleInsert(SampleVO sampleVO) {
		return selectList("sample.sampleInsert", sampleVO);
	}

	public SampleVO sampleInsertDetail(SampleVO sampleVO) {
		return (SampleVO) selectOne("sample.sampleInsertDetail", sampleVO);
	}

	public int insertSampleInsert(SampleVO sampleVO) {
		insert("sample.insertSampleInsert", sampleVO);
		return 1;
	}

	public int updateSampleInsert(SampleVO sampleVO) throws DataAccessException {
		return update("sample.updateSampleInsert", sampleVO);
	}

	public int deleteSampleInsert(SampleVO sampleVO) {
		return delete("sample.deleteSampleInsert", sampleVO);
	}
}