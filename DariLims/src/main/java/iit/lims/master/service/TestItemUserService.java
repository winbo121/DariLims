package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.TestItemVO;

/**
 * TestItemUserService
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
public interface TestItemUserService {

	/**
	 * 테스트 담당시험원 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectTestItemUserList(TestItemVO vo) throws Exception;

	/**
	 * 담당시험원 저장
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int saveTestItemUser(TestItemVO vo) throws Exception;

}
