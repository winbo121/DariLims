package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.TestItemVO;

/**
 * TestItemService
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
public interface TestItemService {
	/**
	 * 항목 리스트 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectTestItemList(TestItemVO vo) throws Exception;

	/**
	 * 항목 등록
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int insertTestItem(TestItemVO vo) throws Exception;

	/**
	 * 항목 수정
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int updateTestItem(TestItemVO vo) throws Exception;

	/**
	 * 항목 삭제
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int deleteTestItem(TestItemVO vo) throws Exception;

	/**
	 * 항목 상세 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public TestItemVO selectTestItemDetail(TestItemVO vo) throws Exception;

	/**
	 * 수수료관리 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectFeeGroupList(TestItemVO vo) throws Exception;

	/**
	 * 수수료 관리 등록
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int insertFeeGroup(TestItemVO vo) throws Exception;

	/**
	 * 수수료 관리 수정
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int updateFeeGroup(TestItemVO vo) throws Exception;
	
	/**
	 * 모든 항목 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectTestItemAllList(TestItemVO vo) throws Exception;

}
