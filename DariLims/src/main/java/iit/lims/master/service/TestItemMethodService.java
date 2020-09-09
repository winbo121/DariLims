package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.TestMethodVO;

/**
 * TestItemMethodService
 * 
 * @author 진영민
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.19  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
public interface TestItemMethodService {
	
	/**
	 * 항목별 시험방법 목록 조회
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestMethodVO> selectTestItemMethodList(TestMethodVO vo) throws Exception;

	/**
	 * 전체 시험방법 조회
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestMethodVO> selectAllMethodList(TestMethodVO vo) throws Exception;

	/**
	 * 항목별 시험방법 저장
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int saveTestItemMethod(TestMethodVO vo) throws Exception;
}
