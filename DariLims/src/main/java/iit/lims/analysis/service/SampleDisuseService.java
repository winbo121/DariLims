package iit.lims.analysis.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import iit.lims.analysis.vo.ResultInputVO;

/**
 * SampleDisuse
 * 
 * @author 정우용
 * @since 2015.03.05
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.05  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface SampleDisuseService {
	/**
	 * 결과입력 (시료유형) 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSampleDisuseList(ResultInputVO vo) throws Exception;
	
	/**
	 * 시료관리 상세정보 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public ResultInputVO sampleDisuseDetail(HttpServletRequest request, ResultInputVO vo);
	
	/**
	 * 시료관리 수정 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateSampleDisuse(ResultInputVO vo) throws Exception;

	/**
	 * 시료관리 삭제 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int deleteSampleDisuse(ResultInputVO vo) throws Exception;

}
