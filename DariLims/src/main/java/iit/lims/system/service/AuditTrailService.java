package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.AuditTrailVO;
import iit.lims.system.vo.LogVO;

/**
 * AuditTrailService
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


public interface AuditTrailService {

	
	/**
	 * 감사추적 목록 조회
	 *
	 * @param AuditTrailVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AuditTrailVO> selectAuditTrailList(AuditTrailVO auditTrailVO) throws Exception;
	
	/**
	 * 감사추적 목록 조회(상세)
	 *
	 * @param AuditTrailVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AuditTrailVO> selectAuditTrailDetail(AuditTrailVO auditTrailVO) throws Exception;
	
	/**
	 * 감사추적 페이징
	 *
	 * @param AuditTrailVO
	 * @return AuditTrailVO
	 * @exception Exception	 
	 */
	public int selectAuditTrailPagingListTotCnt(AuditTrailVO auditTrailVO) throws Exception;
	
}
