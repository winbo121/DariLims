package iit.lims.accept.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.CommissionCheckVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * CommissionBonusDAO
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
public class CommissionBonusDAO extends EgovAbstractMapper {

	public List<CommissionCheckVO> selectBonusSalesList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionBonus.selectCommissionBonusList", vo);
	}


}