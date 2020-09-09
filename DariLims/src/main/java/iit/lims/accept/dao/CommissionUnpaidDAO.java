package iit.lims.accept.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.CommissionCheckVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * CommissionUnpaidDAO
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
@Repository
public class CommissionUnpaidDAO extends EgovAbstractMapper {

	public List<CommissionCheckVO> selectUnpaidSalesList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionUnpaid.selectCommissionUnpaidList", vo);
	}

	public List<CommissionCheckVO> selectUnpaidSalesDetailList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionUnpaid.selectUnpaidSalesDetailList", vo);
	}	

	public List<CommissionCheckVO> selectUnpaidTestList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionUnpaid.selectUnpaidTestList", vo);
	}

	public List<CommissionCheckVO> selectUnpaidTestDetailList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionUnpaid.selectUnpaidTestDetailList", vo);
	}	
}