package iit.lims.accept.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.CommissionUnpaidDAO;
import iit.lims.accept.service.CommissionUnpaidService;
import iit.lims.accept.vo.CommissionCheckVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * CommissionUnpaidtServiceImpl
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
@Service
public class CommissionUnpaidServiceImpl extends EgovAbstractServiceImpl implements CommissionUnpaidService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "commissionUnpaidDAO")
	private CommissionUnpaidDAO commissionUnpaidDAO;

	/**
	 * 수수료미납업체 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectUnpaidSalesList(CommissionCheckVO vo) throws Exception {
		return commissionUnpaidDAO.selectUnpaidSalesList(vo);
	}

	public List<CommissionCheckVO> selectUnpaidTestList(CommissionCheckVO vo) throws Exception {
		return commissionUnpaidDAO.selectUnpaidTestList(vo);
	}
	
	
	/**
	 * 수수료미납업체 상세조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectUnpaidSalesDetailList(CommissionCheckVO vo) throws Exception {
		return commissionUnpaidDAO.selectUnpaidSalesDetailList(vo);
	}

	public List<CommissionCheckVO> selectUnpaidTestDetailList(CommissionCheckVO vo) throws Exception {
		return commissionUnpaidDAO.selectUnpaidTestDetailList(vo);
	}

}
