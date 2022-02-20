package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.TestItemMethodDAO;
import iit.lims.master.service.TestItemMethodService;
import iit.lims.master.vo.TestMethodVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestItemMethodServiceImpl
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
public class TestItemMethodServiceImpl extends EgovAbstractServiceImpl implements TestItemMethodService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testItemMethodDAO")
	private TestItemMethodDAO testItemMethodDAO;

	public int saveTestItemMethod(TestMethodVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				testItemMethodDAO.deleteTestItemMethod(vo);
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
						map.put("user_id", vo.getUser_id());
						map.put("test_item_cd", vo.getTest_item_cd());
						map.put("test_std_no", vo.getTest_std_no());
						testItemMethodDAO.insertTestItemMethod(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public List<TestMethodVO> selectTestItemMethodList(TestMethodVO vo) throws Exception {
		return testItemMethodDAO.selectTestItemMethodList(vo);
	}

	public List<TestMethodVO> selectAllMethodList(TestMethodVO vo) throws Exception {
		return testItemMethodDAO.selectAllMethodList(vo);
	}
}