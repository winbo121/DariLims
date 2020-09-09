package iit.lims.report.service;

import java.util.List;

import iit.lims.report.vo.ReportVO;

/**
 * ReportOnnaraService
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
public interface ReportOnnaraService {

	public List<ReportVO> selectReportOnnaraList(ReportVO vo) throws Exception;

	public int updateReportOnnara(ReportVO vo) throws Exception;

}