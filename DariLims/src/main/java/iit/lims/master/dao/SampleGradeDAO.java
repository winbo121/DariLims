package iit.lims.master.dao;

import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.SampleGradeVO;
import iit.lims.master.vo.TestPrdStdVO;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SampleGradeDAO extends EgovAbstractMapper {

	/**	 
	 * 시험기준별 시험항목 목록 조회 //
	 * @param testPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectSampleGradeList(HashMap<String, Object> param) throws DataAccessException {
		return selectList("sampleGrade.selectSampleGradeList", param);
	}
	
	public List<SampleGradeVO> selectSampleGradePList(SampleGradeVO vo) throws DataAccessException {
		return selectList("sampleGrade.selectSampleGradePList", vo);
	}
	
	/*
	 * 항목 등급 등록
	 */
	public int insertGrade(SampleGradeVO vo) throws Exception {
		insert("sampleGrade.insertGrade", vo);
		return 1;
	}
	
	/*
	 * 항목 등급 수정
	 */
	public int updateGrade(SampleGradeVO vo) throws Exception {
		return update("sampleGrade.updateGrade", vo);
	}
	
	/*
	 * 항목 리스트
	 */
	public List<TestPrdStdVO> selectSampGdList(TestPrdStdVO vo) throws DataAccessException {
		return selectList("sampleGrade.selectSampGdList", vo);
	}
	
	/*
	 * 항목 등급 삭제
	 */
	public int deleteGrade(SampleGradeVO vo) throws Exception {
		return update("sampleGrade.deleteGrade", vo);
	}

	public int deleteSampleGradeTestItem(SampleGradeVO vo) throws Exception {
		return update("sampleGrade.deleteSampleGradeTestItem", vo);
	}

	public int insertGradeItem(HashMap<String, String> param) {
		return update("sampleGrade.insertGradeItem", param);
	}

	public int updateGradeItem(HashMap<String, String> param) throws Exception {
		return update("sampleGrade.updateGradeItem", param);
	}

	public void deleteGradeItem(HashMap<String, String> map) {
	}

	public int updateSampleMaxGrde(PrdLstVO vo) {
		return update("sampleGrade.updateSampleMaxGrde", vo);
	}
	
	public int copyGradeItem(SampleGradeVO vo) {
		return insert("sampleGrade.copyGradeItem", vo);
	}
	
	public List<SampleGradeVO> selectSampleGradeListPop(SampleGradeVO vo) throws DataAccessException {
		return selectList("sampleGrade.selectSampleGradeListPop", vo);
	}
}
