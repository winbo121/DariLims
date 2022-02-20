package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.common.vo.MakeGridVO;
import iit.lims.resultStatistical.dao.ItemStatisticsDAO;
import iit.lims.resultStatistical.service.ItemStatisticsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ItemStatisticsServiceImpl
 * 
 * @author 진영민
 * @since 2015.03.31
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.31           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ItemStatisticsServiceImpl extends EgovAbstractServiceImpl implements ItemStatisticsService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "itemStatisticsDAO")
	private ItemStatisticsDAO itemStatisticsDAO;

	public MakeGridVO selectItemStatistics(MakeGridVO vo) throws Exception {
		try {
			List<String> lst = itemStatisticsDAO.selectItemStatisticsColumn(vo);
			vo.setHead(lst);
			vo.setBody(itemStatisticsDAO.selectItemStatistics(vo));
			return vo;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}

	}
}