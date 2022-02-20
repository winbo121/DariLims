package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ResultInputVO;

public interface ResultInputMultipleService {

	/**
	 * 결과입력 > 결과 저장
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String updateMultipleItemResult(ResultInputVO vo) throws Exception;


}
