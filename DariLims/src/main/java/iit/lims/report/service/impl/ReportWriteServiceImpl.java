package iit.lims.report.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.report.dao.ReportWriteDAO;
import iit.lims.report.service.ReportWriteService;
import iit.lims.report.vo.ReportVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ReportWriteServiceImpl
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

@Service
public class ReportWriteServiceImpl extends EgovAbstractServiceImpl implements ReportWriteService {
	static final Logger log = LogManager.getLogger();
	@Resource(name = "reportWriteDAO")
	private ReportWriteDAO reportWriteDAO;

	@Resource
	private CommonDAO commonDAO;

	public List<ReportVO> selectReportReqList(ReportVO vo) throws Exception {
		return reportWriteDAO.selectReportReqList(vo);
	}

	public List<ReportVO> selectReportSampleList(ReportVO vo) throws Exception {
		return reportWriteDAO.selectReportSampleList(vo);
	}

	public List<ReportVO> selectReportSampleItemList(ReportVO vo) throws Exception {
		return reportWriteDAO.selectReportSampleItemList(vo);
	}
	
	// 성적서 작성
	public String insertReportWrite(ReportVO vo) throws Exception {
		String report_doc_seq, report_no;
		
		if (vo.getReport_doc_seq() != null && !"".equals(vo.getReport_doc_seq())){
			//안씀
			reportWriteDAO.updateReportDocWrite(vo);
			report_doc_seq = "1";
			
		} else{
			report_doc_seq = reportWriteDAO.selectReportDocSeq(vo);
			
			vo.setReport_doc_seq(report_doc_seq);
			
			report_no = reportWriteDAO.selectReportNo(vo); 
			
			vo.setReport_no(report_no);
			
			reportWriteDAO.insertReportDocWrite(vo);
			String[] arr = vo.getTest_sample_seq().split(",");
			vo.setTest_sample_arr(arr);
			reportWriteDAO.insertReportSampleWrite(vo);

			// 진행상황(HISTORY) 기록
			List<String> seqList = commonDAO.selectSampleSeqList(vo.getTest_req_seq());
			if (seqList != null && seqList.size() > 0) {
				for (String seq : seqList) {
					HistoryVO historyVO = new HistoryVO();
					historyVO.setTest_sample_seq(seq);
					historyVO.setSample_state("G");
					historyVO.setDept_cd(vo.getDept_cd());
					historyVO.setTest_dept_cd(vo.getDept_cd());
					historyVO.setUser_id(vo.getUser_id());
					historyVO.setTest_req_seq(vo.getTest_req_seq());
					historyVO.setEtc(" 성적서 번호 : " + report_no );
					commonDAO.insertSampleHistory(historyVO);
				}
			}
		} 
		
		//의뢰 state 업데이트
		reportWriteDAO.updateReqState(vo);

		return report_doc_seq;
	}

	public int deleteReportWrite(ReportVO vo) throws Exception {
		reportWriteDAO.deleteReportWrite(vo);
		return 1;
	}

	public ReportVO selectReportDetail(ReportVO vo) throws Exception {
		return reportWriteDAO.selectReportDetail(vo);
	}

	/**
	 * 검증ID 중복확인
	 *
	 * @param String
	 * @return int
	 * @exception Exception	 
	 */
	public int selectVerifyCnt(String verify_id) throws Exception{
		return reportWriteDAO.selectVerifyCnt(verify_id);
	}
	/**
	 * 접수 > 성적서 발행 구분  
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateSeparation(ReportVO vo) throws Exception {
		try {
			return reportWriteDAO.updateSeparation(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 접수 > 성적서 비고 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateReqEtc(ReportVO vo) throws Exception {
		try {
			return reportWriteDAO.updateReqEtc(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public ReportVO selectReportMake(ReportVO vo) throws Exception {
		
		return reportWriteDAO.selectReportMake(vo);
	}
}