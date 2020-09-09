package iit.lims.master.service;

import java.util.HashMap;
import java.util.List;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestPrdStdVO;

/**
 * TestPrdStdService
 * @author 최은향
 * @since 2015.12.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.22  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface TestPrdStdService {

	/**	 
	 * 프로토콜 시험항목 목록 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectStdTestPrdList(HashMap<String, Object> param) throws Exception;
	
	/**	 
	 * 프로토콜 시험항목 목록 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectStdTestPrdItemList(HashMap<String, Object> param) throws Exception;	
	
	/**	 
	 * 프로토콜 시험항목 저장 처리 
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdTestPrdItem(TestPrdStdVO vo) throws Exception;	
	
	/**	 
	 * 프로토콜 시험항목 복사 처리 
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */
	public int copyStdTestPrdItem(TestPrdStdVO vo) throws Exception;	

	/**	 
	 * 검사기준복사저장
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */
	public int saveCopySpec(TestPrdStdVO vo) throws Exception;	
	
	/**
	 * 기준등록 > 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectPopAllTestPrdItemList(AcceptVO vo) throws Exception;
	
	/**
	 * 기준등록 > 품목 리스트 조회 팝업
	 * 
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectPopAllPrdList(TestPrdStdVO vo) throws Exception;
	
	/**
	 * 기준등록 > 검사기준관리 항목 리스트 멀티 추가
	 *
	 * @param TestPrdStdVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public int insertTestStdPrdItemPop(TestPrdStdVO vo) throws Exception;
	
	public List<TestPrdStdVO> selectfnprtItemList(TestPrdStdVO vo) throws Exception;	
}
