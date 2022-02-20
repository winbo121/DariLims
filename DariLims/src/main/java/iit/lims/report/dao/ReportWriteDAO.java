package iit.lims.report.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.report.vo.ReportVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ReportWriteDAO
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
public class ReportWriteDAO extends EgovAbstractMapper {

	public List<ReportVO> selectReportReqList(ReportVO vo) throws Exception {
		return selectList("reportWrite.selectReportReqList", vo);
	}

	public List<ReportVO> selectReportSampleList(ReportVO vo) throws Exception {
		return selectList("reportWrite.selectReportSampleList", vo);
	}

	public List<ReportVO> selectReportSampleItemList(ReportVO vo) throws Exception {
		return selectList("reportWrite.selectReportSampleItemList", vo);
	}
	
	public String selectReportDocSeq(ReportVO vo) throws Exception {
		return selectOne("reportWrite.selectReportDocSeq", null);
	}
	
	public String selectReportNo(ReportVO vo) throws Exception {
		return selectOne("reportWrite.selectReportNo", null);
	}
	
	public void insertReportDocWrite(ReportVO vo) throws Exception {
		insert("reportWrite.insertReportDocWrite", vo);
	}

	public void insertReportSampleWrite(ReportVO vo) throws Exception {
		insert("reportWrite.insertReportSampleWrite", vo);
	}

	public void updateReportDocWrite(ReportVO vo) throws Exception {
		update("reportWrite.updateReportDocWrite", vo);
	}

	public void deleteReportWrite(ReportVO vo) throws Exception {
		delete("reportWrite.deleteReportWrite", vo);
	}

	public ReportVO selectReportDetail(ReportVO vo) throws Exception {
		return selectOne("reportWrite.selectReportDetail", vo);
	}

	public void updateReqState(ReportVO vo) throws Exception {
		update("reportWrite.updateReqState", vo);
	}
	
	/**
	 * 검증ID 중복확인
	 *
	 * @param String
	 * @return int
	 * @exception Exception	 
	 */
	public int selectVerifyCnt(String verify_id) throws Exception{
		return selectOne("reportWrite.selectVerifyCnt", verify_id);
	}
	//성적서 발행 구분  
	public int updateSeparation(ReportVO vo) throws Exception {
		return update("reportWrite.updateSeparation", vo);
	}
	//성적서 발행 구분  
	public int updateReqEtc(ReportVO vo) throws Exception {
		return update("reportWrite.updateReqEtc", vo);
	}

	public ReportVO selectReportMake(ReportVO vo) {
		
		return selectOne("reportWrite.selectReportMake",vo);
	}
}
