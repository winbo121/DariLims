package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import iit.lims.master.dao.TestStandardDAO;
import iit.lims.master.service.TestStandardService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class TestStandardServiceImpl implements TestStandardService {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource(name = "testStandardDAO")
	private TestStandardDAO testStandardDAO;
	
	
	/**
	 * 스탠다드 리스트 조회
	 * 
	 * @param TestStandardVO
	 * @throws Exception
	 */
	@Override
	public List<TestStandardVO> selectStandardList(TestStandardVO vo) throws Exception {
		return testStandardDAO.selectStandardList(vo);
	}
	
	/*
	 * 스탠다드 등록
	 */
	public int insertStandardItem(TestStandardVO vo) throws Exception {
		try {
			return testStandardDAO.insertStandardItem(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/*
	 * 스탠다드 수정
	 */
	public int updateStandardItem(TestStandardVO vo) throws Exception {
		try {
			return testStandardDAO.updateStandardItem(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/*
	 * 스탠다드 복사
	 */
	public int copyStandard(TestStandardVO vo) throws Exception {
		try {
			return testStandardDAO.copyStandard(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 스탠다드별 시험항목 목록 조회
	 * 
	 * @param testPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestStandardVO> selectStandardRItemList(TestStandardVO vo) throws Exception {
		return testStandardDAO.selectStandardRItemList(vo);
	}
	/**
	 * 스탠다드별 시험항목 목록 조회-팝업
	 * 
	 * @param testPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestStandardVO> selectStandardRItemListPop(TestStandardVO vo) throws Exception {
		return testStandardDAO.selectStandardRItemListPop(vo);
	}
	
	//스탠다드 팝업 항목 추가 리스트 조회
	public List<TestStandardVO> selectStandardPIList(TestStandardVO vo) throws Exception {
		return testStandardDAO.selectStandardPIList(vo);
	}
	
	/**
	 * 스탠다드 팝업창 항목 멀티 추가
	 * 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int insertStandardInsItemPop(TestStandardVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			String standard_spec_seq = "";
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
						map.put("prdlst_cd", vo.getPrdlst_cd());
						System.out.println("vo.getPrdlst_cd():"+vo.getPrdlst_cd());
						standard_spec_seq = map.get("standard_spec_seq");
						if(standard_spec_seq.isEmpty()){
							testStandardDAO.insertStandardInsItemPop(map);
						}else{
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
	 * 스탠다드별 시험항목 저장 처리
	 * 
	 * @param TestPrdStdVO
	 * @throws Exception
	 */
	@Override
	public int insertTestStandardItem(TestStandardVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			String kfda_yn = "";
			String crud = "";
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
						kfda_yn = map.get("kfda_yn");
						crud = map.get("crud");
						
						//식약청 기준규격은 수정/삭제 불가
						if(!kfda_yn.equals("Y")){
							if ("d".equals(crud)){
								testStandardDAO.deleteStandardSpItem(map);
							}else if ("u".equals(crud)){
								testStandardDAO.updateStandardSpItem(map);
							}
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
 * 스탠다드별 시험항목 복사 처리
 * 
 * @param TestPrdStdVO
 * @throws Exception
 */
@Override
public int copyTestStandardItem(TestStandardVO vo) throws Exception {
	try {
		String[] rowArr = vo.getGridData().split("◆★◆");
		String kfda_yn = "";
		String crud = "";
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
					
					testStandardDAO.copyTestStandardItem(map);

				}
			}
		}
		return 1;
		
	} catch (Exception e) {
		log.error(e);
		throw e;
	}
}

}
