package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestStdVO;

/**
 * MenuService
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface TestStdService {
	
	/**	 
	 * 시험기준분류 목록 조회 
	 * @param TestStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestStdVO> selectTestStdList(TestStdVO vo) throws Exception;
	
	/**	 
	 * 시험기준분류 저장 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int insertTestStd(TestStdVO vo) throws Exception;
	
	/**	 
	 * 시험기준분류 수정 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int updateTestStd(TestStdVO vo) throws Exception;	
	
	/**	 
	 * 시험기준분류 삭제 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteTestStd(TestStdVO vo) throws Exception;

	/**	 
	 * 시험기준분류 개정이력 목록 조회 
	 * @param TestStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestStdRevVO> selectTestStdRevList(TestStdRevVO vo) throws Exception;
	
	/**	 
	 * 시험기준분류 개정이력 저장 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int insertTestStdRev(StdTestItemVO vo) throws Exception;
	
	/**	 
	 * 시험기준분류 개정이력 수정 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
//	public int updateTestStdRev(StdTestItemVO vo) throws Exception;	
	
	/**	 
	 * 시험기준분류 개정이력 삭제 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
//	public int deleteTestStdRev(StdTestItemVO vo) throws Exception;

	/**	 
	 * 시험항목 목록 전체 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<StdTestItemVO> selectAllTestItemList(StdTestItemVO vo) throws Exception;
	
	/**	 
	 * 시험기준별 시험항목 목록 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<StdTestItemVO> selectStdTestItemList(StdTestItemVO vo) throws Exception;	
	
	/**	 
	 * 시험기준별 시험항목 저장 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdTestItem(StdTestItemVO vo) throws Exception;

	public int deleteProtocolItem(TestStdVO vo) throws Exception;		

}
