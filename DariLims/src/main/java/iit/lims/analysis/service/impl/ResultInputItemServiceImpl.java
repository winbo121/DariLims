package iit.lims.analysis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.analysis.dao.ResultInputItemDAO;
import iit.lims.analysis.dao.ResultInputSampleDAO;
import iit.lims.analysis.service.ResultInputItemService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.system.dao.AuditTrailDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MenuService
 * 
 * @author 조재환
 * @since 2015.01.14
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.14  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ResultInputItemServiceImpl extends EgovAbstractServiceImpl implements ResultInputItemService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultInputItemDAO")
	private ResultInputItemDAO resultInputItemDAO;

	@Resource(name = "resultInputSampleDAO")
	private ResultInputSampleDAO resultInputSampleDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;

	@Resource
	private CommonDAO commonDAO;

	/**
	 * 항목별 결과 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<ResultInputVO> selectReqTestItemList(ResultInputVO vo) throws Exception {
		return resultInputItemDAO.selectReqTestItemList(vo);
	}

	/**
	 * 항목별 결과 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<ResultInputVO> selectResultItemList(ResultInputVO vo) throws Exception {
		return resultInputItemDAO.selectResultItemList(vo);
	}
}
