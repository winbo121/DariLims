package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.TestStdDAO;
import iit.lims.master.service.TestStdService;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestStdVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestStdServiceImpl
 * 
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class TestStdServiceImpl extends EgovAbstractServiceImpl implements TestStdService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testStdDAO")
	private TestStdDAO testStdDAO;

	/**
	 * 시험기준분류 목록 조회
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestStdVO> selectTestStdList(TestStdVO vo) throws Exception {
		return testStdDAO.selectTestStdList(vo);
	}

	/**
	 * 시험기준분류 저장 처리
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	@Override
	public int insertTestStd(TestStdVO vo) throws Exception {
		try {
			return testStdDAO.insertTestStd(vo);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	/**
	 * 시험기준분류 수정 처리
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	@Override
	public int updateTestStd(TestStdVO vo) throws Exception {
		try {
			return testStdDAO.updateTestStd(vo);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	/**
	 * 시험기준분류 삭제 처리
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	@Override
	public int deleteTestStd(TestStdVO vo) throws Exception {
		try {
			// STD_TEST_ITEM 삭제
			testStdDAO.deleteStdTestItemAll(vo);
			return testStdDAO.deleteTestStd(vo);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	/**
	 * 시험기준분류 개정이력 목록 조회
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestStdRevVO> selectTestStdRevList(TestStdRevVO vo) throws Exception {
		return testStdDAO.selectTestStdRevList(vo);
	}

	/**
	 * 시험기준분류 개정이력 수정 처리
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	/*	@Override
		public int updateTestStdRev(StdTestItemVO vo) throws Exception {
			try {
				return testStdDAO.updateTestStdRev(vo);
			} catch (Exception e) {
				log.error(e);
				throw e;
			}
		}*/

	/**
	 * 시험기준분류 개정이력 삭제 처리
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	/*	@Override
		public int deleteTestStdRev(StdTestItemVO vo) throws Exception {
			try {
				return testStdDAO.deleteTestStdRev(vo);
			} catch (Exception e) {
				log.error(e);
				throw e;
			}
		}*/

	/**
	 * 시험기준분류 개정이력 저장 처리
	 * 
	 * @param TestStdVO
	 * @throws Exception
	 */
	@Override
	public int insertTestStdRev(StdTestItemVO vo) throws Exception {
		try {
			int check = testStdDAO.insertTestStdRev(vo);
			if (check > 0) {
				vo.setRev_no(testStdDAO.getLastTestStdRevNo(vo));
				check += insertStdTestItem(vo);
			}
			return check;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	/**
	 * 시험항목 목록 전체 조회
	 * 
	 * @param StdTestItemVO
	 * @throws Exception
	 */
	@Override
	public List<StdTestItemVO> selectAllTestItemList(StdTestItemVO vo) throws Exception {
		return testStdDAO.selectAllTestItemList(vo);
	}

	/**
	 * 시험기준별 시험항목 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @throws Exception
	 */
	@Override
	public List<StdTestItemVO> selectStdTestItemList(StdTestItemVO vo) throws Exception {
		return testStdDAO.selectStdTestItemList(vo);
	}

	/**
	 * 시험기준별 시험항목 저장 처리
	 * 
	 * @param StdTestItemVO
	 * @throws Exception
	 */
	@Override
	public int insertStdTestItem(StdTestItemVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1)
									value = valueArr[1];
								map.put(valueArr[0], value);
							}
						}
						map.put("test_std_no", vo.getTest_std_no());
						map.put("rev_no", vo.getRev_no());
						map.put("user_id", vo.getUser_id());
						String crud = map.get("crud");
						if (vo.getPageType().equals("testStdRev")) {
							if (!"d".equals(crud))
								testStdDAO.insertStdTestItem(map);
						} else {
							if ("n".equals(crud))
								testStdDAO.insertStdTestItem(map);
							else if ("d".equals(crud))
								testStdDAO.deleteStdTestItem(map);
							else if ("u".equals(crud))
								testStdDAO.updateStdTestItem(map);
						}
					}
				}
			}
			//개정이력 table update
			testStdDAO.updateTestStdRev(vo);
			return 1;

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	@Override
	public int deleteProtocolItem(TestStdVO vo) throws Exception {
		return testStdDAO.deleteProtocolItem(vo);
	}
}
