package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ResultInputVO;

public interface ResultModifyService {
	/**
	 * 결과수정 의뢰 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectModifyReqList(ResultInputVO vo) throws Exception;

	/**
	 * 결과수정 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectModifyResultList(ResultInputVO vo) throws Exception;

}
