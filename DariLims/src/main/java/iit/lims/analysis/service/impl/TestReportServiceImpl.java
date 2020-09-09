package iit.lims.analysis.service.impl;

import java.util.List;

import iit.lims.analysis.dao.TestReportDAO;
import iit.lims.analysis.service.TestReportService;
import iit.lims.analysis.vo.TestReportVO;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

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

@Service
public class TestReportServiceImpl implements TestReportService {

	static final Logger log = LogManager.getLogger();

	@Resource(name = "testReportDAO")
	private TestReportDAO testReportDAO;
	
	/**
	 * 시료 목록 조회
	 * 
	 * @param TestReportVO
	 * @return List
	 * @throws Exception
	 */
	public List<TestReportVO> selectTestReportSampleList(TestReportVO vo) throws Exception {
		return testReportDAO.selectTestReportSampleList(vo);
	}
	
	/**
	 * 항목 목록 조회
	 * 
	 * @param TestReportVO
	 * @return List
	 * @throws Exception
	 */
	public List<TestReportVO> selectTestReportItemList(TestReportVO vo) throws Exception {
		return testReportDAO.selectTestReportItemList(vo);
	}
	
	/**
	 * 시료 상세 데이터 조회
	 * 
	 * @param TestReportVO
	 * @return List
	 * @throws Exception
	 */
	public TestReportVO selectTestReportSampleDetail(TestReportVO vo) throws Exception {
		return testReportDAO.selectTestReportSampleDetail(vo);
	}
	
	/**
	 * 시험일지 작성
	 * 
	 * @param TestReportVO
	 * @return List
	 * @throws Exception
	 */	
	public int saveTestReport(TestReportVO vo) throws Exception {
		try {
			int cnt = testReportDAO.selectTestReportCount(vo);
			if(cnt == 0){
				testReportDAO.insertTestReport(vo);
			}else{
				testReportDAO.updateTestReport(vo);
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 시험일지 불러오기
	 * 
	 * @param TestReportVO
	 * @return List
	 * @throws Exception
	 */
	public TestReportVO selectTestReport(TestReportVO vo) throws Exception {
		
		return testReportDAO.selectTestReport(vo);
		
		/*int cnt = testReportDAO.selectTestReportCnt(vo);
		
		if(cnt == 0){
			return testReportDAO.selectTestReportInit(vo);			
		}else{
			return testReportDAO.selectTestReport(vo);
		}*/
		
	}
	
	
}
