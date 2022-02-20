package iit.lims.master.service;

import iit.lims.master.vo.PretreatmentVO;
import iit.lims.master.vo.SampleGradeVO;
import iit.lims.master.vo.TestPrdStdVO;

import java.util.List;

public interface PretreatmentService {
	
	//품목별 전처리 리스트
	public List<TestPrdStdVO> selectPretMList(PretreatmentVO vo) throws Exception;
	
	/*
	 * 전처리 등록
	 */
	public int insertPretreatment(PretreatmentVO vo) throws Exception;
	
	/*
	 * 항목 등급 삭제
	 */
	public int deletePretreatment(PretreatmentVO vo) throws Exception;

}
