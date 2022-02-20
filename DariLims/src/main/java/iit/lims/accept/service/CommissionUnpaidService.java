package iit.lims.accept.service;

import java.util.List;

import iit.lims.accept.vo.CommissionCheckVO;

/**
 * CommissionUnpaidService
 * 
 * @author 김상하
 * @since 2016.05.12
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
public interface CommissionUnpaidService {
	
	/**
	 * 수수료미납업체 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectUnpaidSalesList(CommissionCheckVO vo) throws Exception;

	public List<CommissionCheckVO> selectUnpaidTestList(CommissionCheckVO vo) throws Exception;
	
	/**
	 * 수수료미납업체 상세조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectUnpaidSalesDetailList(CommissionCheckVO vo) throws Exception;

	public List<CommissionCheckVO> selectUnpaidTestDetailList(CommissionCheckVO vo) throws Exception;
}
