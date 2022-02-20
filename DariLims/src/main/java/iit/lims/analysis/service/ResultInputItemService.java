package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ResultInputVO;

public interface ResultInputItemService {
	/**
	 * 시험항목 목록 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultInputVO> selectReqTestItemList(ResultInputVO vo) throws Exception;

	/**
	 * 항목별 결과 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultItemList(ResultInputVO vo) throws Exception;

}
