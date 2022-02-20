package iit.lims.analysis.dao;


import iit.lims.analysis.vo.TestReportVO;
import iit.lims.accept.vo.AcceptVO;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * SampleDisuse
 * 
 * @author 정우용
 * @since 2015.03.05
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.05  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class TestReportDAO extends EgovAbstractMapper {

	//시료 목록 조회
	public List<TestReportVO> selectTestReportSampleList(TestReportVO vo) {
		return selectList("testReport.selectTestReportSampleList", vo);
	}
	
	//항목 목록 조회
	public List<TestReportVO> selectTestReportItemList(TestReportVO vo) {
		return selectList("testReport.selectTestReportItemList", vo);
	}
	
	//시료 상세 데이터 조회
	public TestReportVO selectTestReportSampleDetail(TestReportVO vo) {
		return selectOne("testReport.selectTestReportSampleDetail", vo);
	}
	
	//시험일지 중복확인
	public int selectTestReportCount(AcceptVO vo) {
		return selectOne("testReport.selectTestReportCount", vo);
	}
	
	//시험일지 작성
	public int insertTestReport(TestReportVO vo){
		return insert("testReport.insertTestReport", vo);
	}
	
	//시험일지 수정
	public int updateTestReport(TestReportVO vo) throws Exception {
		return update("testReport.updateTestReport", vo);
	}
	
	//시험일지 불러오기
	public TestReportVO selectTestReport(TestReportVO vo) {
		return selectOne("testReport.selectTestReport", vo);
	}
	
	//시험일지 없을시 초기값
	public TestReportVO selectTestReportInit(TestReportVO vo) {
		return selectOne("testReport.selectTestReportInit", vo);
	}
	
	
}
