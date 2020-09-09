package iit.lims.resultStatistical.service;

import java.util.List;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.report.vo.ReportVO;

/**
 * tatStatisticsDAO
 * 
 * @author 한지연
 * @since 2020-06-22
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

/**
 * TAT관리 내역 조회
 * 
 * @param HttpServletRequest
 *            , Model, MakeGridVO
 * @return ModelAndView
 * @throws Exception
 */
public interface TatStatisticsService {
	/**
	 * tat관리 > 메인리스트 조회 > 시험완료예정일
	 * 
	 * @param MakeGridVO
	 * @return List
	 * @exception Exception
	 */
	public MakeGridVO selectTatStatistics(MakeGridVO vo) throws Exception;
	
	/**
	 * tat관리 > 메인리스트 조회 > 성적서발행예정일
	 * 
	 * @param MakeGridVO
	 * @return List
	 * @exception Exception
	 */
	public MakeGridVO selectTatReportStatistics(MakeGridVO vo) throws Exception;

	/**
	 * tat관리 > pop > 상세내역 조회 (시험완료예정일)
	 * 
	 * @param MakeGridVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectTatDetailList(AcceptVO vo) throws Exception;	
	
	/**
	 * tat관리 > pop > 미완료사유 조회 (성적서발행예정일)
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultInputVO> selectTatReason(ResultInputVO vo) throws Exception;	
	
	/**
	 * tat관리 > pop > 상세내역 조회 (시험완료 예정일)
	 * 
	 * @param MakeGridVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectTatReportDetailList(AcceptVO vo) throws Exception;	
	
	/**
	 * tat관리 > pop > 미완료사유 조회 (성적서발행 예정일)
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReportVO> selectTatReportReason(ReportVO vo) throws Exception;	
}