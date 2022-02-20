package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestItemVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestItemGroupDAO
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
public class TestItemGroupDAO extends EgovAbstractMapper {

	public List<TestItemVO> selectTestItemInGroupList(TestItemVO vo) throws Exception {
		return selectList("testItemGroup.selectTestItemInGroupList", vo);
	}

	public List<TestItemVO> selectAllTestItemList(TestItemVO vo) throws Exception {
		return selectList("testItemGroup.selectAllTestItemList", vo);
	}

	public int insertTestItemInGroup(HashMap<String, String> m) throws Exception {
		insert("testItemGroup.insertTestItemInGroup", m);
		return 1;
	}

	public int deleteTestItemInGroup(TestItemVO vo) throws Exception {
		return delete("testItemGroup.deleteTestItemInGroup", vo);
	}

	public List<TestItemVO> selectItemGroupList(TestItemVO vo) throws Exception {
		return selectList("testItemGroup.selectItemGroupList", vo);
	}

	public int insertTestItemGroup(TestItemVO vo) throws Exception {
		insert("testItemGroup.insertTestItemGroup", vo);
		return 1;
	}

	public int updateTestItemGroup(TestItemVO vo) throws Exception {
		return update("testItemGroup.updateTestItemGroup", vo);
	}

	public int deleteTestItemGroup(TestItemVO vo) throws Exception {
		return delete("testItemGroup.deleteTestItemGroup", vo);
	}

	public int copyTestItemGroup(TestItemVO vo) throws Exception{
		insert("testItemGroup.copyTestItemGroup", vo);
		return 1;
	}
}
