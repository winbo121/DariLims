package iit.lims.report.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.report.dao.ReportPublishDAO;
import iit.lims.report.service.ReportPublishService;
import iit.lims.report.vo.ReportVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ReportPublishServiceImpl
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
public class ReportPublishServiceImpl extends EgovAbstractServiceImpl implements ReportPublishService {
	static final Logger log = LogManager.getLogger();
	@Resource(name = "reportPublishDAO")
	private ReportPublishDAO reportPublishDAO;
	
	@Resource
	private CommonDAO commonDAO;

	public List<ReportVO> selectReportWriteList(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportWriteList(vo);
	}
	
	public List<ReportVO> selectReportPublishHistoryList(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportPublishHistoryList(vo);
	}
	//메일전송
	public List<ReportVO> selectReportMailList(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportMailList(vo);
	}

	public List<ReportVO> selectReportWriteSampleList(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportWriteSampleList(vo);
	}

	public List<ReportVO> selectReportWriteSampleItemList(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportWriteSampleItemList(vo);
	}
	
	public int updateReportPublish(ReportVO vo) throws Exception {
		try {
			reportPublishDAO.updateReportPublish(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public String checkReportPublish(ReportVO vo) throws Exception {
		try {
			return reportPublishDAO.checkReportPublish(vo);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public int deleteReport(ReportVO vo) throws Exception {
		try {
			reportPublishDAO.deleteReport(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	

	/**
	 * 성적서 발행 로그 기록
	 * 
	 * @param ReportVO
	 * @return 
	 * @exception Exception
	 */
	public int insertReportPublishLog(ReportVO vo) throws Exception{
		int result = -1;
				
		String logNo = reportPublishDAO.selectLogNo(vo); 
		vo.setLog_no(logNo);	
		
		if(vo.getPublish_gbn().equals("P01003")){
			//로그등록
			result = reportPublishDAO.insertReportPublishLog2(vo);
		}else{
			//로그등록
			result = reportPublishDAO.insertReportPublishLog(vo);
			//성적서 발행완료 상태변경
			vo.setState("Y");
			result = reportPublishDAO.updateReportPublish(vo);
		}
		
		// 진행상황(HISTORY) 기록
		List<String> seqList = commonDAO.selectSampleSeqList(vo.getTest_req_seq());
		String report_publish_no = reportPublishDAO.selectReportPublishNo(vo);
		if (seqList != null && seqList.size() > 0) {
			for (String seq : seqList) {
				HistoryVO historyVO = new HistoryVO();
				historyVO.setTest_sample_seq(seq);
				historyVO.setSample_state("H");
				historyVO.setDept_cd(vo.getDept_cd());
				historyVO.setTest_dept_cd(vo.getDept_cd());
				historyVO.setUser_id(vo.getUser_id());
				historyVO.setTest_req_seq(vo.getTest_req_seq());
				historyVO.setEtc(" 성적서 발행번호 : " + report_publish_no );
				commonDAO.insertSampleHistory(historyVO);
			}
		}
		
		return Integer.parseInt(logNo);
	}
	

	public int saveExceptItem(ReportVO vo) throws Exception{
		try {

			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				//성적서 항목 모두 삭제
				reportPublishDAO.deleteAllSampleItem(vo);
				
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						//insert item 
						reportPublishDAO.insertReportSampleItem(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	public ReportVO selectReportFormInfo(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportFormInfo(vo);
	}

	public String selectLogNo(ReportVO vo) throws Exception {
		return reportPublishDAO.selectLogNo(vo);
	}
	
	public String selectReportPublishNo(ReportVO vo) throws Exception {
		return reportPublishDAO.selectReportPublishNo(vo);
	}
	
	//메일전송
	public List<ReportVO> selectSurfaceMailList(ReportVO vo) throws Exception {
		return reportPublishDAO.selectSurfaceMailList(vo);
	}

	@Override
	public int deleteReportPublishLog(ReportVO vo) throws Exception {
		
		return reportPublishDAO.deleteReportPublishLog(vo);
	}
}