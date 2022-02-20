package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestMethodVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestItemMethodDAO
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
public class TestItemMethodDAO extends EgovAbstractMapper {

	public List<TestMethodVO> selectTestItemMethodList(TestMethodVO vo) throws Exception {
		return selectList("testItemMethod.selectTestItemMethodList", vo);
	}

	public List<TestMethodVO> selectAllMethodList(TestMethodVO vo) throws Exception {
		return selectList("testItemMethod.selectAllMethodList", vo);
	}

	public int insertTestItemMethod(HashMap<String, String> m) throws Exception {
		insert("testItemMethod.insertTestItemMethod", m);
		return 1;
	}

	public int deleteTestItemMethod(TestMethodVO vo) throws Exception {
		return delete("testItemMethod.deleteTestItemMethod", vo);
	}

}
