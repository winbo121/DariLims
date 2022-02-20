package iit.lims.accept.service;

import java.util.List;

import iit.lims.accept.vo.CommissionCheckVO;

/**
 * CommissionBonusService
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
public interface CommissionBonusService {
	
	/**
	 * 수수료성과급 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectBonusSalesList(CommissionCheckVO vo) throws Exception;

	
}
