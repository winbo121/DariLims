package iit.lims.report.service;

import java.util.List;

import iit.lims.report.vo.ReportVO;

/**
 * ReportApprovalService
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
public interface ReportApprovalService {

	/**
	 * 성적서 승인 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportApprovalList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 승인 시료 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportApprovalSampleList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 승인 항목 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportApprovalItemList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 승인
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int updateReportApproval(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 반려
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int deleteReportReturn(ReportVO vo) throws Exception;
}
