package iit.lims.report.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.report.dao.ReportOnnaraDAO;
import iit.lims.report.service.ReportOnnaraService;
import iit.lims.report.vo.ReportVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ReportOnnaraServiceImpl
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ReportOnnaraServiceImpl extends EgovAbstractServiceImpl implements ReportOnnaraService {
	static final Logger log = LogManager.getLogger();
	@Resource(name = "reportOnnaraDAO")
	private ReportOnnaraDAO reportOnnaraDAO;

	public List<ReportVO> selectReportOnnaraList(ReportVO vo) throws Exception {
		return reportOnnaraDAO.selectReportOnnaraList(vo);
	}

	public int updateReportOnnara(ReportVO vo) throws Exception {
		try {
			return reportOnnaraDAO.updateReportOnnara(vo);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
}