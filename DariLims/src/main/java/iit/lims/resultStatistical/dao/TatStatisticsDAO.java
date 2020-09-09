package iit.lims.resultStatistical.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.report.vo.ReportVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TatStatisticsDAO
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

@Repository
public class TatStatisticsDAO extends EgovAbstractMapper {

	public List<String> selectTatStatisticsColumn(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectTatStatisticsColumn", vo);
	}

	public List<HashMap<String, String>> selectTatStatistics(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectTatStatistics", vo);
	}
	
	public List<HashMap<String, String>> selectTatReportStatistics(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectTatReportStatistics", vo);
	}
	
	public List<AcceptVO> selectTatDetailList(AcceptVO vo) throws Exception {
		return selectList("resultStatistical.selectTatDetailList", vo);
	}
	
	public List<ResultInputVO> selectTatReason(ResultInputVO vo) throws Exception {
		return selectList("resultStatistical.selectTatReason", vo);
	}
	
	public List<AcceptVO> selectTatReportDetailList(AcceptVO vo) throws Exception {
		return selectList("resultStatistical.selectTatReportDetailList", vo);
	}
	
	public List<ReportVO> selectTatReportReason(ReportVO vo) throws Exception {
		return selectList("resultStatistical.selectTatReportReason", vo);
	}
	
}
