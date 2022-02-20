package iit.lims.report.service;

import java.util.List;

import iit.lims.report.vo.ReportVO;

/**
 * ReportWriteService
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
public interface ReportWriteService {

	/**
	 * 성적서 작성 목록 조회
	 *
	 * @param ReportVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ReportVO> selectReportReqList(ReportVO vo) throws Exception;

	/**
	 * 성적서 작성 시료 목록 조회
	 *
	 * @param ReportVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ReportVO> selectReportSampleList(ReportVO vo) throws Exception;
	public List<ReportVO> selectReportSampleItemList(ReportVO vo) throws Exception;

	/**
	 * 성적서 작성 등록
	 *
	 * @param ReportVO
	 * @return List
	 * @exception Exception	 
	 */
	public String insertReportWrite(ReportVO vo) throws Exception;

	/**
	 * 성적서 작성 의뢰 정보 조회
	 *
	 * @param ReportVO
	 * @return List
	 * @exception Exception	 
	 */
	public ReportVO selectReportDetail(ReportVO vo) throws Exception;

	/**
	 * 성적서 작성 삭제
	 *
	 * @param ReportVO
	 * @return List
	 * @exception Exception	 
	 */
	public int deleteReportWrite(ReportVO vo) throws Exception;
	

	/**
	 * 검증ID 중복확인
	 *
	 * @param String
	 * @return int
	 * @exception Exception	 
	 */
	public int selectVerifyCnt(String verify_id) throws Exception;

	/**
	 * 접수 > 성적서 발행 구분  
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateSeparation(ReportVO vo)throws Exception;
	
	/**
	 * 접수 > 성적서 비고 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateReqEtc(ReportVO vo)throws Exception;

	
	public ReportVO selectReportMake(ReportVO vo)throws Exception;
	
	
}