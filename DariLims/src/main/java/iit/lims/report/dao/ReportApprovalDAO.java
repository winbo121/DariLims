package iit.lims.report.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.report.vo.ReportVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ReportApprovalDAO
 * 
 * @author 허태원
 * @since 2020.02.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.02.26  허태원   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ReportApprovalDAO extends EgovAbstractMapper {

	public List<ReportVO> selectReportApprovalList(ReportVO vo) throws Exception {
		return selectList("reportApproval.selectReportApprovalList", vo);
	}

	public List<ReportVO> selectReportApprovalSampleList(ReportVO vo) throws Exception {
		return selectList("reportApproval.selectReportApprovalSampleList", vo);
	}

	public List<ReportVO> selectReportApprovalItemList(ReportVO vo) throws Exception {
		return selectList("reportApproval.selectReportApprovalItemList", vo);
	}
	
	public int updateReportApproval(ReportVO vo) throws Exception {
		return update("reportApproval.updateReportApproval", vo);
	}
	
	public int deleteReportReturn(ReportVO vo) throws Exception {
		return delete("reportApproval.deleteReportReturn", vo);
	}
}
