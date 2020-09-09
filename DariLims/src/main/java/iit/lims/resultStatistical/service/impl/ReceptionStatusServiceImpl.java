package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.resultStatistical.dao.ReceptionStatusDAO;
import iit.lims.resultStatistical.service.ReceptionStatusService;
import iit.lims.resultStatistical.vo.ReceptionStatusVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ReceptionStatusServiceImpl
 * 
 * @author 석은주
 * @since 2015.04.07
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.31           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ReceptionStatusServiceImpl extends EgovAbstractServiceImpl implements ReceptionStatusService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "receptionStatusDAO")
	private ReceptionStatusDAO receptionStatusDAO;

	/**
	 * 수질검사접수현황 조회
	 * 
	 * @param ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ReceptionStatusVO> selectReceptionStatusList(ReceptionStatusVO vo) throws Exception {
		try {
			if(vo.getPageType().equals("sample"))
				return receptionStatusDAO.selectReceptionStatusList(vo);
			else
				return receptionStatusDAO.selectReceptionStatusUnitList(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}