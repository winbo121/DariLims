package iit.lims.master.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.TestItemUserDAO;
import iit.lims.master.service.TestItemUserService;
import iit.lims.master.vo.TestItemVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestItemUserServiceImpl
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
public class TestItemUserServiceImpl extends EgovAbstractServiceImpl implements TestItemUserService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testItemUserDAO")
	private TestItemUserDAO testItemUserDAO;

	public List<TestItemVO> selectTestItemUserList(TestItemVO vo) throws Exception {
		return testItemUserDAO.selectTestItemUserList(vo);
	}
	
	public int saveTestItemUser(TestItemVO vo) throws Exception {
		int result = -1;
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			String[] strArr = new String[vo.getTest_item_cnt()];
			if(vo.getTest_item_cnt() == 1){
				strArr[0] = vo.getArr_test_item();
			}else{
				strArr = vo.getArr_test_item().split(",");
			}
			
			for(int i=0; i<strArr.length; i++){
				map.put("tester_dept_cd", vo.getTester_dept_cd());
				map.put("tester_user_id", vo.getTester_user_id());
				map.put("test_item_cd", strArr[i].toString());
				if(vo.getPageType().equals("INSERT")){
					result = testItemUserDAO.insertTestItemUser(map);
				}else if(vo.getPageType().equals("UPDATE")){
					result = testItemUserDAO.deleteTestItemUser(map);
				}else{
					result = testItemUserDAO.deleteTestItemUser(map);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
}
