package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ResultInputVO;

/**
 * SamplePosition
 * 
 * @author 허태원
 * @since 2020.05.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일			수정자		수정내용
 *  ---------- -------- ---------------------------
 *  2020.05.19	허태원		최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface SamplePositionService {
	/**
	 * 검체위치 검체 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSamplePositionSampleList(ResultInputVO vo) throws Exception;
	
	/**
	 * 검체위치 이력 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSamplePositionHistoryList(ResultInputVO vo) throws Exception;
	
	/**
	 * 검체위치 등록 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int insertSamplePosition(ResultInputVO vo) throws Exception;

	/**
	 * 검체위치 수정 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateSamplePosition(ResultInputVO vo) throws Exception;

}
