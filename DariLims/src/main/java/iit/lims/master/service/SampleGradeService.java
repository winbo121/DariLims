package iit.lims.master.service;

import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.SampleGradeVO;

import java.util.HashMap;
import java.util.List;

public interface SampleGradeService {
	/**	 
	 * 시험기준별 시험항목 목록 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectSampleGradeList(HashMap<String, Object> param) throws Exception;	
	
	public List<SampleGradeVO> selectSampleGradePList(SampleGradeVO vo) throws Exception;	
	
	/*
	 * 항목 등급 등록
	 */
	public int insertGrade(SampleGradeVO vo) throws Exception;
	
	/*
	 * 항목 등급 삭제
	 */
	public int deleteGrade(SampleGradeVO vo) throws Exception;

	public int deleteSampleGradeTestItem(SampleGradeVO vo) throws Exception;

	public int updateGradeItem(SampleGradeVO vo) throws Exception;

	public int insertGradeItem(SampleGradeVO vo) throws Exception;

	public int updateSampleMaxGrde(PrdLstVO vo) throws Exception;
	
	public int copyGradeItem(SampleGradeVO vo) throws Exception;

	public List<SampleGradeVO> selectSampleGradeListPop(SampleGradeVO vo) throws Exception;
}
