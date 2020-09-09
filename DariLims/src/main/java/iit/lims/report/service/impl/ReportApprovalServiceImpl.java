package iit.lims.report.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.report.dao.ReportApprovalDAO;
import iit.lims.report.service.ReportApprovalService;
import iit.lims.report.vo.ReportVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ReportApprovalServiceImpl
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

@Service
public class ReportApprovalServiceImpl extends EgovAbstractServiceImpl implements ReportApprovalService {
	static final Logger log = LogManager.getLogger();
	@Resource(name = "reportApprovalDAO")
	private ReportApprovalDAO reportApprovalDAO;
	
	@Resource
	private CommonDAO commonDAO;


	public List<ReportVO> selectReportApprovalList(ReportVO vo) throws Exception {
		return reportApprovalDAO.selectReportApprovalList(vo);
	}

	public List<ReportVO> selectReportApprovalSampleList(ReportVO vo) throws Exception {
		return reportApprovalDAO.selectReportApprovalSampleList(vo);
	}

	public List<ReportVO> selectReportApprovalItemList(ReportVO vo) throws Exception {
		return reportApprovalDAO.selectReportApprovalItemList(vo);
	}
	
	public int updateReportApproval(ReportVO vo) throws Exception {
		int result = -1;
		try {
			String[] arrReport = vo.getArr_report().get(0).split(",");
			String[] arrReq = vo.getArr_req().get(0).split(",");
			for(int i=0; i<arrReport.length; i++){	
				vo.setReport_doc_seq(arrReport[i]);
				vo.setTest_req_seq(arrReq[i]);
				vo.setUser_id(vo.getUser_id());
				result = reportApprovalDAO.updateReportApproval(vo);
			}
			// 진행상황(HISTORY) 기록
			List<String> seqList = commonDAO.selectSampleSeqList(vo.getTest_req_seq());
			if (seqList != null && seqList.size() > 0) {
				for (String seq : seqList) {
					HistoryVO historyVO = new HistoryVO();
					historyVO.setTest_sample_seq(seq);
					historyVO.setSample_state("I");
					historyVO.setDept_cd(vo.getDept_cd());
					historyVO.setTest_dept_cd(vo.getDept_cd());
					historyVO.setUser_id(vo.getUser_id());
					historyVO.setTest_req_seq(vo.getTest_req_seq());
//					historyVO.setEtc(" 성적서 번호 : " + report_no );
					commonDAO.insertSampleHistory(historyVO);
				}
			}
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return result;
	}
	
	public int deleteReportReturn(ReportVO vo) throws Exception {
		int result = -1;
		try {
			String[] arrReport = vo.getArr_report().get(0).split(",");
			String[] arrReq = vo.getArr_req().get(0).split(","); 
			for(int i=0; i<arrReport.length; i++){
				vo.setReport_doc_seq(arrReport[i]);
				vo.setTest_req_seq(arrReq[i]);
				result = reportApprovalDAO.deleteReportReturn(vo);
			}
			
			// 진행상황(HISTORY) 기록
			List<String> seqList = commonDAO.selectSampleSeqList(vo.getTest_req_seq());
			if (seqList != null && seqList.size() > 0) {
				for (String seq : seqList) {
					HistoryVO historyVO = new HistoryVO();
					historyVO.setTest_sample_seq(seq);
					historyVO.setSample_state("F");
					historyVO.setDept_cd(vo.getDept_cd());
					historyVO.setTest_dept_cd(vo.getDept_cd());
					historyVO.setUser_id(vo.getUser_id());
					historyVO.setTest_req_seq(vo.getTest_req_seq());
					historyVO.setEtc("[반려] 성적서번호 : " + vo.getReport_doc_seq() +" - "+ vo.getReturn_comment());
					commonDAO.insertSampleHistory(historyVO);
				}
			}
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return result;
	}
}