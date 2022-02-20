package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.master.dao.TestItemGroupDAO;
import iit.lims.master.service.TestItemGroupService;
import iit.lims.master.vo.TestItemVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestItemGroupServiceImpl
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
public class TestItemGroupServiceImpl extends EgovAbstractServiceImpl implements TestItemGroupService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testItemGroupDAO")
	private TestItemGroupDAO testItemGroupDAO;

	public int saveTestItemInGroup(TestItemVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				testItemGroupDAO.deleteTestItemInGroup(vo);
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					//System.out.println(row);
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							//System.out.println(column);
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						//System.out.println(vo.getTest_item_group_no());
						map.put("test_item_group_no", vo.getTest_item_group_no());
						map.put("user_id", vo.getUser_id());
						testItemGroupDAO.insertTestItemInGroup(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public List<TestItemVO> selectTestItemInGroupList(TestItemVO vo) throws Exception {
		return testItemGroupDAO.selectTestItemInGroupList(vo);
	}

	public List<TestItemVO> selectAllTestItemList(TestItemVO vo) throws Exception {
		return testItemGroupDAO.selectAllTestItemList(vo);
	}

	public List<TestItemVO> selectItemGroupList(TestItemVO vo) throws Exception {
		return testItemGroupDAO.selectItemGroupList(vo);
	}

	public int insertTestItemGroup(TestItemVO vo) throws Exception {
		try {
			return testItemGroupDAO.insertTestItemGroup(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int updateTestItemGroup(TestItemVO vo) throws Exception {
		try {
			return testItemGroupDAO.updateTestItemGroup(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int deleteTestItemGroup(TestItemVO vo) throws Exception {
		try {
			return testItemGroupDAO.deleteTestItemGroup(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int copyTestItemGroup(TestItemVO vo) throws Exception{
		try {
			return testItemGroupDAO.copyTestItemGroup(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}