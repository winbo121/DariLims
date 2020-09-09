package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestItemVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestItemUserDAO
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
public class TestItemUserDAO extends EgovAbstractMapper {

	public List<TestItemVO> selectTestItemUserList(TestItemVO vo) throws Exception {
		return selectList("testItemUser.selectTestItemUserList", vo);
	}
	
	public int insertTestItemUser(HashMap<String, String> m) throws Exception {
		return insert("testItemUser.insertTestItemUser", m);
	}
	
	public int updateTestItemUser(HashMap<String, String> m) throws Exception {
		return update("testItemUser.updateTestItemUser", m);
	}

	public int deleteTestItemUser(HashMap<String, String> m) throws Exception {
		return delete("testItemUser.deleteTestItemUser", m);
	}

}
