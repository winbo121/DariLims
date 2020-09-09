package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ResultInputVO;

public interface ResultInputReportService {
	
	/**
	 * 시료 목록 조회
	 *
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ResultInputVO> sampleList(ResultInputVO vo) throws Exception;
	
	/**
	 * 시료별 성적서 목록 조회
	 *
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ResultInputVO> selectsampleReportList(ResultInputVO vo) throws Exception;
}
