package iit.lims.analysis.service;


import iit.lims.analysis.vo.TestReportVO;

import java.util.List;

/**
 * ResultApprovalService
 * 
 * @resultApprovalor 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface TestReportService {

	/**
	 * 시료 목록 조회
	 * 
	 * @param TestReportVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestReportVO> selectTestReportSampleList(TestReportVO vo) throws Exception;
	
	/**
	 * 항목 목록 조회
	 * 
	 * @param TestReportVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestReportVO> selectTestReportItemList(TestReportVO vo) throws Exception;
	
	/**
	 * 시료 상세 데이터 조회
	 * 
	 * @param TestReportVO
	 * @return List
	 * @exception Exception
	 */
	public TestReportVO selectTestReportSampleDetail(TestReportVO vo) throws Exception;
	
	/**
	 * 시험일지 작성
	 * 
	 * @param TestReportVO
	 * @return List
	 * @exception Exception
	 */
	public int saveTestReport(TestReportVO vo) throws Exception;
	
	/**
	 * 시험일지 불러오기
	 * 
	 * @param TestReportVO
	 * @return List
	 * @exception Exception
	 */
	public TestReportVO selectTestReport(TestReportVO vo) throws Exception;
	
	
	
}
