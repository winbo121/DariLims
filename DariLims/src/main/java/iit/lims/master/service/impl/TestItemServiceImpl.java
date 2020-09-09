package iit.lims.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.TestItemDAO;
import iit.lims.master.service.TestItemService;
import iit.lims.master.vo.TestItemVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestItemServiceImpl
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
@Service
public class TestItemServiceImpl extends EgovAbstractServiceImpl implements TestItemService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testItemDAO")
	private TestItemDAO testItemDAO;

	public List<TestItemVO> selectTestItemList(TestItemVO vo) throws Exception {
		return testItemDAO.selectTestItemList(vo);
	}

	public int insertTestItem(TestItemVO vo) throws Exception {
		try {
			return testItemDAO.insertTestItem(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int updateTestItem(TestItemVO vo) throws Exception {
		try {
			return testItemDAO.updateTestItem(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int deleteTestItem(TestItemVO vo) throws Exception {
		try {
			return testItemDAO.deleteTestItem(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public TestItemVO selectTestItemDetail(TestItemVO vo) throws Exception {
		return testItemDAO.selectTestItemDetail(vo);
	}

	public List<TestItemVO> selectFeeGroupList(TestItemVO vo) throws Exception {
		return testItemDAO.selectFeeGroupList(vo);
	}

	public int insertFeeGroup(TestItemVO vo) throws Exception {
		try {
			return testItemDAO.insertFeeGroup(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int updateFeeGroup(TestItemVO vo) throws Exception {
		try {
			return testItemDAO.updateFeeGroup(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public List<TestItemVO> selectTestItemAllList(TestItemVO vo) throws Exception {
		return testItemDAO.selectTestItemAllList(vo);
	}


}
