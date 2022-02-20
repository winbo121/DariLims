package iit.lims.master.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestItemVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestItemDAO
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
@Repository
public class TestItemDAO extends EgovAbstractMapper {

	public List<TestItemVO> selectTestItemList(TestItemVO vo) throws Exception {
		return selectList("testItem.selectTestItemList", vo);
	}

	public int insertTestItem(TestItemVO vo) throws Exception {
		insert("testItem.insertTestItem", vo);
		return 1;
	}

	public int updateTestItem(TestItemVO vo) throws Exception {
		return update("testItem.updateTestItem", vo);
	}

	public int deleteTestItem(TestItemVO vo) throws Exception {
		return delete("testItem.deleteTestItem", vo);
	}

	public TestItemVO selectTestItemDetail(TestItemVO vo) throws Exception {
		return (TestItemVO) selectOne("testItem.selectTestItemDetail", vo);
	}

	public List<TestItemVO> selectFeeGroupList(TestItemVO vo) throws Exception {
		return selectList("testItem.selectFeeGroupList", vo);
	}

	public int insertFeeGroup(TestItemVO vo) throws Exception {
		insert("testItem.insertFeeGroup", vo);
		return 1;
	}

	public int updateFeeGroup(TestItemVO vo) throws Exception {
		return update("testItem.updateFeeGroup", vo);
	}
	
	public List<TestItemVO> selectTestItemAllList(TestItemVO vo) throws Exception {
		return selectList("testItem.selectTestItemAllList", vo);
	}
}