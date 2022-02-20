package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.system.service.AuditTrailService;
import iit.lims.system.vo.AuditTrailVO;
import iit.lims.system.vo.LogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * AuditTrailServiceImpl
 * @auditTrailor 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class AuditTrailServiceImpl extends EgovAbstractServiceImpl implements AuditTrailService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;
	
	/**
	 * 감사추적 목록 조회 
	 * @param AuditTrailVO
	 * @throws Exception
	 */
	public List<AuditTrailVO> selectAuditTrailList(AuditTrailVO auditTrailVO) throws Exception {
        return auditTrailDAO.selectAuditTrailList(auditTrailVO);
    }
	
	/**
	 * 감사추적 목록 조회(상세)
	 * @param AuditTrailVO
	 * @throws Exception
	 */
	public List<AuditTrailVO> selectAuditTrailDetail(AuditTrailVO auditTrailVO) throws Exception {
        return auditTrailDAO.selectAuditTrailDetail(auditTrailVO);
    }
	
	
	/**
	 * 감사추적 리스트 COUNT
	 * 
	 * @param AuditTrailVO
	 * @throws Exception
	 */
	@Override
	public int selectAuditTrailPagingListTotCnt(AuditTrailVO auditTrailVO) throws Exception {
		return auditTrailDAO.auditTrailCnt(auditTrailVO);
	}
}
