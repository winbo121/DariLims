package iit.lims.master.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.dao.TestItemInstrumentDAO;
import iit.lims.master.service.TestItemInstrumentService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestItemInstrumentServiceImpl
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
public class TestItemInstrumentServiceImpl extends EgovAbstractServiceImpl implements TestItemInstrumentService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testItemInstrumentDAO")
	private TestItemInstrumentDAO testItemInstrumentDAO;

	/**
	 * 항목별 시험기기 목록 조회
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	@Override
	public List<MachineVO> selectTestItemInstList(MachineVO vo) throws Exception {
		try {
			List<MachineVO> list = new ArrayList<MachineVO>();
			if (vo.getPageType() != null && vo.getPageType().equals("all")) {
				list = testItemInstrumentDAO.selectAllInstList(vo);
			} else if (vo.getPageType() == null || "".equals(vo.getPageType())) {
				list = testItemInstrumentDAO.selectTestItemInstList(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 항목별 시험기기 기기 목록 등록
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	@Override
	public int insertTestItemInst(MachineVO vo) throws Exception {
		try {
			if (vo.getGridData().equals("☆★☆★")) {
				testItemInstrumentDAO.deleteTestItemInst(vo);
			} else {
				String[] rowArr = vo.getGridData().split("◆★◆");
				if (rowArr != null && rowArr.length > 0) {
					testItemInstrumentDAO.deleteTestItemInst(vo);
					for (String row : rowArr) {
						String[] columnArr = row.split("■★■");
						if (columnArr != null && columnArr.length > 0) {
							HashMap<String, String> map = new HashMap<String, String>();
							for (String column : columnArr) {
								String[] valueArr = column.split("●★●");
								if (valueArr != null) {
									String value = "";
									if (valueArr.length != 1) {
										value = valueArr[1];
									}
									map.put(valueArr[0], value);
								}
							}
							map.put("test_item_cd", vo.getTest_item_cd());
							map.put("dept_cd", vo.getDept_cd());
							map.put("creater_id", vo.getUser_id());
							map.put("test_std_no", vo.getTest_std_no());
							testItemInstrumentDAO.insertTestItemInst(map);
						}
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}