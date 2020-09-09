package iit.lims.report.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.report.vo.ReportVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ReportPublishDAO
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

@Repository
public class ReportPublishDAO extends EgovAbstractMapper {

	public List<ReportVO> selectReportWriteList(ReportVO vo) throws Exception {
		return selectList("reportPublish.selectReportWriteList", vo);
	}
	
	public List<ReportVO> selectReportPublishHistoryList(ReportVO vo) throws Exception {
		return selectList("reportPublish.selectReportPublishHistoryList", vo);
	}
	//메일전송
	public List<ReportVO> selectReportMailList(ReportVO vo) throws Exception {
		return selectList("reportPublish.selectReportMailList", vo);
	}

	public List<ReportVO> selectReportWriteSampleList(ReportVO vo) throws Exception {
		return selectList("reportPublish.selectReportWriteSampleList", vo);
	}

	public List<ReportVO> selectReportWriteSampleItemList(ReportVO vo) throws Exception {
		return selectList("reportPublish.selectReportWriteSampleItemList", vo);
	}
	
	public int updateReportPublish(ReportVO vo) throws Exception {
		return update("reportPublish.updateReportPublish", vo);
	}

	public String checkReportPublish(ReportVO vo) throws Exception {
		return selectOne("reportPublish.checkReportPublish", vo);
	}

	public int deleteReport(ReportVO vo) throws Exception {
		return delete("reportPublish.deleteReport", vo);
	}
	
	public String selectLogNo(ReportVO vo) throws Exception {
		return selectOne("reportPublish.selectLogNo", vo);
	}
	
	public String selectReportPublishNo(ReportVO vo) throws Exception {
		return selectOne("reportPublish.selectReportPublishNo", vo);
	}

	public int updateReportNo(ReportVO vo) throws Exception {
		return update("reportPublish.updateReportNo", vo);
	}
	
	public int insertReportPublishLog(ReportVO vo) throws Exception {
		return insert("reportPublish.insertReportPublishLog", vo);
	}
	
	public int insertReportPublishLog2(ReportVO vo) throws Exception {
		return insert("reportPublish.insertReportPublishLog2", vo);
	}

	public int insertReportSampleItem(HashMap<String, String> map) throws Exception {
		return insert("reportPublish.insertReportSampleItem", map);
	}
	
	public int deleteAllSampleItem(ReportVO vo) throws Exception {
		return delete("reportPublish.deleteAllSampleItem", vo);
	}
	
	public ReportVO selectReportFormInfo(ReportVO vo) throws Exception {
		return selectOne("reportPublish.selectReportFormInfo", vo);
	}
	
	//메일전송
	public List<ReportVO> selectSurfaceMailList(ReportVO vo) throws Exception {
		return selectList("reportPublish.selectSurfaceMailList", vo);
	}

	public int deleteReportPublishLog(ReportVO vo) {
		
		return delete("reportPublish.deleteReportPublishLog", vo);
	}
}
