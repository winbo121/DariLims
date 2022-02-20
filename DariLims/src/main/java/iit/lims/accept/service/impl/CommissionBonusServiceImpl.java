package iit.lims.accept.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.CommissionBonusDAO;
import iit.lims.accept.service.CommissionBonusService;
import iit.lims.accept.vo.CommissionCheckVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * CommissionBonustServiceImpl
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
public class CommissionBonusServiceImpl extends EgovAbstractServiceImpl implements CommissionBonusService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "commissionBonusDAO")
	private CommissionBonusDAO commissionBonusDAO;

	/**
	 * 수수료성과급 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectBonusSalesList(CommissionCheckVO vo) throws Exception {
		return commissionBonusDAO.selectBonusSalesList(vo);
	}


}
