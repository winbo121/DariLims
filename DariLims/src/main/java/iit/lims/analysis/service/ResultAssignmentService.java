package iit.lims.analysis.service;

import java.util.List;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;

public interface ResultAssignmentService {
	/**
	 * 접수완료 목록 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectAcceptCompleteList(AcceptVO vo) throws Exception;

	/*배정대기 시료목록 */
	public List<ResultInputVO> selectSampleAssignmentList(ResultInputVO vo) throws Exception;
	
	/**
	 * 배정 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultAssignmentList(ResultInputVO vo) throws Exception;

	/**
	 * 배정자 저장 및 배정완료
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String updateResultTester(ResultInputVO vo) throws Exception;

	/**
	 * 배정완료 validation
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public String updateAssignmentComplete(String reqList) throws Exception;
	
}
