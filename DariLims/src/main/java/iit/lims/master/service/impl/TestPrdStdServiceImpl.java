package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.master.dao.TestPrdStdDAO;
import iit.lims.master.service.TestPrdStdService;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestPrdStdVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestPrdStdServiceImpl
 * 
 * @author 최은향
 * @since 2015.12.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.22  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class TestPrdStdServiceImpl extends EgovAbstractServiceImpl implements TestPrdStdService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testPrdStdDAO")
	private TestPrdStdDAO testPrdStdDAO;

	/**
	 * 프로토콜 시험항목 목록 조회
	 * 
	 * @param testPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestPrdStdVO> selectStdTestPrdList(HashMap<String, Object> param) throws Exception {
		return testPrdStdDAO.selectStdTestPrdList(param);
	}

	/**
	 * 프로토콜 시험항목 목록 조회
	 * 
	 * @param testPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestPrdStdVO> selectStdTestPrdItemList(HashMap<String, Object> param) throws Exception {
		return testPrdStdDAO.selectStdTestPrdItemList(param);
	}

	/**
	 * 프로토콜 시험항목 저장 처리
	 * 
	 * @param TestPrdStdVO
	 * @throws Exception
	 */
	@Override
	public int insertStdTestPrdItem(TestPrdStdVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			String crud = "";
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							System.out.println(column);
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1)
									value = valueArr[1];
								map.put(valueArr[0], value);
							}
						}
						
						map.put("user_id", vo.getUser_id());
						crud = map.get("crud");
						
						if ("u".equals(crud)){
							testPrdStdDAO.updateStdTestPrdItem(map);
						}
					}
				}
			}
			return 1;

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 프로토콜 시험항목 복사 처리
	 * 
	 * @param TestPrdStdVO
	 * @throws Exception
	 */
	@Override
	public int copyStdTestPrdItem(TestPrdStdVO vo) throws Exception {
		try {
			vo.setIndv_spec_seq(vo.getIndv_spec_seq());
			return testPrdStdDAO.copyStdTestPrdItem(vo);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 검사기준복사저장
	 * 
	 * @param TestPrdStdVO
	 * @throws Exception
	 */
	@Override
	public int saveCopySpec(TestPrdStdVO vo) throws Exception {
		try {			
			return testPrdStdDAO.saveCopySpec(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 기준등록 > 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public List<AcceptVO> selectPopAllTestPrdItemList(AcceptVO vo) throws Exception {
		return testPrdStdDAO.selectPopAllTestPrdItemList(vo);
	}

	/**
	 * 기준등록 > 품목 리스트 조회 팝업
	 * 
	 * @param TestPrdStdVO
	 * @throws Exception
	 */
	public List<TestPrdStdVO> selectPopAllPrdList(TestPrdStdVO vo) throws Exception {
		return testPrdStdDAO.selectPopAllPrdList(vo);
	}
	
	/**
	 * 기준등록 > 검사기준관리 항목 리스트 멀티 추가
	 * 
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int insertTestStdPrdItemPop(TestPrdStdVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			String indv_spec_seq = "";
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
						map.put("user_id", vo.getUser_id());
						indv_spec_seq = map.get("indv_spec_seq");
						if(indv_spec_seq.isEmpty()){
							testPrdStdDAO.insertTestStdPrdItemPop(map);
						}else{
							testPrdStdDAO.insertFnprtItemPop(map);
						}
					}
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	
	
	

	

	@Override
	public List<TestPrdStdVO> selectfnprtItemList(TestPrdStdVO vo) throws Exception {
		return testPrdStdDAO.selectfnprtItemList(vo);
	}
	
	
}