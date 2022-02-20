package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestStdVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestStdDAO
 * 
 * @author 석은주
 * @since 2015.01.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.26  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class TestStdDAO extends EgovAbstractMapper {

	/**	 
	 * 시험기준분류 목록 조회 
	 * @param TestStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestStdVO> selectTestStdList(TestStdVO vo) {
		return selectList("testStd.selectTestStdList", vo);
	}	

	/**	 
	 * 시험기준분류 저장 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int insertTestStd(TestStdVO vo) throws DataAccessException {
		return insert("testStd.insertTestStd", vo);
	}
	
	
	/**	 
	 * 시험기준분류 수정 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int updateTestStd(TestStdVO vo) {
		return update("testStd.updateTestStd", vo);
	}
	
	/**	 
	 * 시험기준분류 삭제 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteTestStd(TestStdVO vo) throws DataAccessException {
		return delete("testStd.deleteTestStd", vo);
	}
	
	/**	 
	 * 항목별 시험기준 삭제 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteStdTestItemAll(TestStdVO vo) throws DataAccessException {
		return delete("testStd.deleteStdTestItemAll", vo);
	}
	
	/**	 
	 * 시험기준분류 개정이력 목록 조회 
	 * @param TestStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestStdRevVO> selectTestStdRevList(TestStdRevVO vo) {
		return selectList("testStd.selectTestStdRevList", vo);
	}
	
	/**	 
	 * 시험기준분류 개정이력 저장 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int insertTestStdRev(StdTestItemVO vo) throws DataAccessException {
		return insert("testStd.insertTestStdRev", vo);
	}
	
	/**	 
	 * 시험기준분류 개정이력 수정 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
	public int updateTestStdRev(StdTestItemVO vo) {
		return update("testStd.updateTestStdRev", vo);
	}
	
	/**	 
	 * 시험기준분류 개정이력 삭제 처리 
	 * @param TestStdVO
	 * @return int
	 * @exception Exception
	 */
/*	public int deleteTestStdRev(StdTestItemVO vo) {
		return delete("testStd.deleteTestStdRev", vo);
	}*/
	
	/**	 
	 * 시험항목 목록 전체 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<StdTestItemVO> selectAllTestItemList(StdTestItemVO vo) throws DataAccessException {
		return selectList("testStd.selectAllTestItemList", vo);
	}

	/**	 
	 * 시험기준별 시험항목 목록 조회 
	 * @param StdTestItemVO
	 * @return List
	 * @exception Exception
	 */
	public List<StdTestItemVO> selectStdTestItemList(StdTestItemVO vo) throws DataAccessException {
		return selectList("testStd.selectStdTestItemList", vo);
	}

	/**	 
	 * 시험기준별 시험항목 저장 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdTestItem(HashMap<String, String> m) throws DataAccessException {
		return insert("testStd.insertStdTestItem", m);
	}
	
	/**	 
	 * 시험기준별 시험항목 수정 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int updateStdTestItem(HashMap<String, String> m) throws DataAccessException {
		return update("testStd.updateStdTestItem", m);	
	}
	
	/**	 
	 * 시험기준별 시험항목 삭제 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteStdTestItem(HashMap<String, String> m) throws DataAccessException {
		return delete("testStd.deleteStdTestItem", m);
	}

	/**	 
	 * 시험기준별 개정이력 last No가져오기
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public String getLastTestStdRevNo(StdTestItemVO vo) {
		return selectOne("testStd.getLastTestStdRevNo", vo);
	}

	public int deleteProtocolItem(TestStdVO vo) {
		return delete("testStd.deleteProtocolItem", vo);
	}
				
}