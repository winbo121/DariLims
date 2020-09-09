package iit.lims.analysis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.analysis.dao.ResultInputSampleDAO;
import iit.lims.analysis.dao.ResultInputReportDAO;
import iit.lims.analysis.service.ResultInputReportService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.ConverObjectToMap;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ResultInputReportServiceImpl
 * 
 * @author 최은향
 * @since 2015.10.07
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.07  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ResultInputReportServiceImpl extends EgovAbstractServiceImpl implements ResultInputReportService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultInputReportDAO")
	private ResultInputReportDAO resultInputReportDAO;

	@Resource(name = "resultInputSampleDAO")
	private ResultInputSampleDAO resultInputSampleDAO;
	
	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;

	@Resource
	private CommonDAO commonDAO;
	
	/**
	 * 시료유형 목록 조회 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public List<ResultInputVO> sampleList(ResultInputVO vo) throws Exception {
		return resultInputReportDAO.sampleList(vo);
	}
	
	/**
	 * 시료별 성적서 목록 조회 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public List<ResultInputVO> selectsampleReportList(ResultInputVO vo) throws Exception {
		return resultInputReportDAO.selectsampleReportList(vo);
	}


}
