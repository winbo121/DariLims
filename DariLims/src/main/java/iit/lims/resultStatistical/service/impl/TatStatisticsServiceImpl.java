package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.report.vo.ReportVO;
import iit.lims.resultStatistical.dao.TatStatisticsDAO;
import iit.lims.resultStatistical.service.TatStatisticsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TatStatisticsServiceImpl
 * 
 * @author 한지연
 * @since 2020.06.22
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
public class TatStatisticsServiceImpl extends EgovAbstractServiceImpl implements TatStatisticsService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "tatStatisticsDAO")
	private TatStatisticsDAO tatStatisticsDAO;

	public MakeGridVO selectTatStatistics(MakeGridVO vo) throws Exception {
		try {
			List<String> lst = tatStatisticsDAO.selectTatStatisticsColumn(vo);
			vo.setHead(lst);
			vo.setBody(tatStatisticsDAO.selectTatStatistics(vo));
			return vo;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}

	}
	
	public MakeGridVO selectTatReportStatistics(MakeGridVO vo) throws Exception {
		try {
			List<String> lst = tatStatisticsDAO.selectTatStatisticsColumn(vo);
			vo.setHead(lst);
			vo.setBody(tatStatisticsDAO.selectTatReportStatistics(vo));
			return vo;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		
	}
	
	public  List<AcceptVO> selectTatDetailList(AcceptVO vo) throws Exception {
		return tatStatisticsDAO.selectTatDetailList(vo);
	}
	
	public  List<ResultInputVO> selectTatReason(ResultInputVO vo) throws Exception {
		return tatStatisticsDAO.selectTatReason(vo);
	}
	
	public  List<AcceptVO> selectTatReportDetailList(AcceptVO vo) throws Exception {
		return tatStatisticsDAO.selectTatReportDetailList(vo);
	}
	
	public  List<ReportVO> selectTatReportReason(ReportVO vo) throws Exception {
		return tatStatisticsDAO.selectTatReportReason(vo);
	}
	
}