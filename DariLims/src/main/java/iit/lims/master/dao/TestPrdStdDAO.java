package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestMethodVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestPrdStdVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestPrdStdDAO
 * 
 * @author 최은향
 * @since 2015.12.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.22  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class TestPrdStdDAO extends EgovAbstractMapper {

	/**	 
	 * 프로토콜 시험항목 목록 조회
	 * @param testPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectStdTestPrdList(HashMap<String,Object> param) throws DataAccessException {
		return selectList("testPrdStd.selectStdTestPrdList", param);
	}

	/**	 
	 * 프로토콜 시험항목 목록 조회
	 * @param testPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectStdTestPrdItemList(HashMap<String,Object> param) throws DataAccessException {
		return selectList("testPrdStd.selectStdTestPrdItemList", param);
	}

	/**	 
	 * 프로토콜 시험항목 저장 처리
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdTestPrdItem(HashMap<String, String> m) throws DataAccessException {
		return insert("testPrdStd.insertStdTestPrdItem", m);
	}
	
	/**	 
	 * 프로토콜 시험항목 복사 처리
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int copyStdTestPrdItem(TestPrdStdVO vo) throws DataAccessException {
		return insert("testPrdStd.copyStdTestPrdItem", vo);
	}
	
	/**	 
	 * 검사기준복사저장
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */	
	public int saveCopySpec(TestPrdStdVO vo) throws Exception {
		return insert("testPrdStd.saveCopySpec", vo);
	}
	
	/**	 
	 * 프로토콜 시험항목 수정 처리
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int updateStdTestPrdItem(HashMap<String, String> m) throws DataAccessException {
		return update("testPrdStd.updateStdTestPrdItem", m);	
	}
	
	/**	 
	 * 프로토콜 시험항목 삭제 처리
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteStdTestItem(HashMap<String, String> m) throws DataAccessException {
		return delete("testPrdStd.deleteStdTestPrdItem", m);
	}

	
	
	/**
	 * 기준등록 > 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectPopAllTestPrdItemList(AcceptVO vo) throws Exception {
		return selectList("accept.selectPopAllTestItemList", vo);
	}
	
	/**
	 * 기준등록 > 품목 리스트 조회 팝업
	 * 
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectPopAllPrdList(TestPrdStdVO vo) throws Exception {
		return selectList("testPrdStd.selectPopAllPrdList", vo);
	}
	
	/**
	 * 기준등록 > 항목 멀티추가
	 * 
	 * @param map
	 * @return List
	 * @exception Exception
	 */
	public int insertTestStdPrdItemPop(HashMap<String, String> m) throws Exception {
		insert("testPrdStd.insertTestStdPrdItemPop", m);
		return 1;
	}

	public int insertFnprtItemPop(HashMap<String, String> m) throws Exception {
		insert("testPrdStd.insertFnprtItemPop", m);
		return 1;
	}
	


	public List<TestPrdStdVO> selectfnprtItemList(TestPrdStdVO vo) throws DataAccessException {
		return selectList("testPrdStd.selectfnprtItemList", vo);
	}

}