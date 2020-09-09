package iit.lims.report.service;

import java.util.HashMap;
import java.util.List;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.report.vo.ReportVO;

/**
 * ReportPublishService
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
public interface ReportPublishService {

	/**
	 * 성적서 발행 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportWriteList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 발행 이력 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportPublishHistoryList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서메일전송 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportMailList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 발행 시료 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectReportWriteSampleList(ReportVO vo) throws Exception;
	public List<ReportVO> selectReportWriteSampleItemList(ReportVO vo) throws Exception;
	
	/**
	 * 성적서 발행 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int updateReportPublish(ReportVO vo) throws Exception;

	/**
	 * 성적서 발행 상태값 변경
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public String checkReportPublish(ReportVO vo) throws Exception;

	/**
	 * 성적서 삭제
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int deleteReport(ReportVO vo) throws Exception;

	/**
	 * 성적서 발행 로그 기록
	 * 
	 * @param ReportVO
	 * @return 
	 * @exception Exception
	 */
	public int insertReportPublishLog(ReportVO vo) throws Exception;

	public int saveExceptItem(ReportVO vo) throws Exception;

	public ReportVO selectReportFormInfo(ReportVO vo) throws Exception;
	
	public String selectLogNo(ReportVO vo) throws Exception;
	
	public String selectReportPublishNo(ReportVO vo) throws Exception;
	
	/**
	 * 성적서메일전송 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReportVO> selectSurfaceMailList(ReportVO vo) throws Exception;

	public  int deleteReportPublishLog(ReportVO vo) throws Exception;
}
