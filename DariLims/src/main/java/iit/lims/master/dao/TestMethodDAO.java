package iit.lims.master.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestMethodVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestMethodDAO
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

@Repository
public class TestMethodDAO extends EgovAbstractMapper {

	/**
	 * 시험방법 목록 조회
	 *
	 * @param TestMethodVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<TestMethodVO> selectTestMethodList(TestMethodVO vo) throws Exception {
		return selectList("testMethod.selectTestMethodList", vo);
	}

	/**
	 * 시험방법 상세정보 조회
	 *
	 * @param TestMethodVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public TestMethodVO selectTestMethodDetail(TestMethodVO vo) throws Exception {
		return (TestMethodVO) selectOne("testMethod.selectTestMethodDetail", vo);
	}
	
	/**
	 * 시험방법 신규 등록
	 *
	 * @param TestMethodVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertTestMethod(TestMethodVO vo) throws Exception {
		return insert("testMethod.insertTestMethod", vo);
	}
	
	/**
	 * 시험방법 수정
	 *
	 * @param TestMethodVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateTestMethod(TestMethodVO vo) throws Exception  {
		return update("testMethod.updateTestMethod", vo);
	}

	/**
	 * 시험방법 첨부파일 다운로드
	 *
	 * @param TestMethodVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public TestMethodVO testMethodDown(TestMethodVO vo) throws Exception {
		return (TestMethodVO) selectOne("testMethod.testMethodDown", vo);
	}	
}