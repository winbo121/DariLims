package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.common.vo.MakeGridVO;
import iit.lims.resultStatistical.dao.SampleStatisticsDAO;
import iit.lims.resultStatistical.service.SampleStatisticsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SampleStatisticsServiceImpl
 * 
 * @author 최은향
 * @since 2015.06.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.17           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class SampleStatisticsServiceImpl extends EgovAbstractServiceImpl implements SampleStatisticsService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "sampleStatisticsDAO")
	private SampleStatisticsDAO sampleStatisticsDAO;

	public MakeGridVO selectSampleStatistics(MakeGridVO vo) throws Exception {
		try {
			// 단위업무
			String unit_work_cd_split = vo.getUnit_work_cd();
			String[] result = unit_work_cd_split.split("\\,");
			String unit_work_cd = "";
			for (int i = 0; i < result.length; i++) {
				// set vo _ 1,2,3,4
				unit_work_cd += "'" + result[i] + "',";
			}
			unit_work_cd = unit_work_cd.substring(0, unit_work_cd.length() - 1);
			vo.setUnit_work_cd(unit_work_cd);
			
			System.out.println(vo.getTest_item_cd());
			
			// 항목
			if( vo.getTest_item_cd() != "" && vo.getTest_item_cd() != null ){
				String test_item_cd_split = vo.getTest_item_cd();
				String[] itemResult = test_item_cd_split.split("\\,");
				String test_item_cd = "";
				for (int i = 0; i < itemResult.length; i++) {
					// set vo _ 1,2,3,4
					test_item_cd += "'" + itemResult[i] + "',";
				}
				test_item_cd = test_item_cd.substring(0, test_item_cd.length() - 1);
				vo.setTest_item_cd(test_item_cd);
			}
			
			List<String> lst = sampleStatisticsDAO.selectSampleStatisticsColumn(vo);
			// 헤드 data가 있을때
			if (lst.toString().length() > 3) {
				vo.setHead(lst);
				vo.setBody(sampleStatisticsDAO.selectSampleStatistics(vo));
			}
			return vo;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
}