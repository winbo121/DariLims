package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.resultStatistical.dao.InstrumentUseStatisticalDAO;
import iit.lims.resultStatistical.service.InstrumentUseStatisticalService;
import iit.lims.resultStatistical.vo.InstrumentUseStatisticalVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * InstrumentUseStatisticalServiceImpl
 * 
 * @author 허태원
 * @since 2015.12.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.10           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class InstrumentUseStatisticalServiceImpl extends EgovAbstractServiceImpl implements InstrumentUseStatisticalService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "instrumentUseStatisticalDAO")
	private InstrumentUseStatisticalDAO instrumentUseStatisticalDAO;

	/**
	 * 장비활용조회
	 * 
	 * @param InstrumentUseStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<InstrumentUseStatisticalVO> selectInstrumentUseList(InstrumentUseStatisticalVO vo) throws Exception {		
		try {
			//월별, 분기별 조회
			if(vo.getType().equals("month"))
				return instrumentUseStatisticalDAO.selectInstrumentUseMList(vo);
			else
				return instrumentUseStatisticalDAO.selectInstrumentUseQList(vo);			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}