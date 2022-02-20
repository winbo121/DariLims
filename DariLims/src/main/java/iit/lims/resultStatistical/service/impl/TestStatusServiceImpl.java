package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.common.vo.MakeGridVO;
import iit.lims.resultStatistical.dao.TestStatusDAO;
import iit.lims.resultStatistical.service.TestStatusService;
import iit.lims.resultStatistical.vo.ResultStatisticalVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestStatusServiceImpl
 * 
 * @author 최은향
 * @since 2015.10.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   	수정내용
 *  ---------- -------- 	---------------------------
 *  2015.10.19  최은향      최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class TestStatusServiceImpl extends EgovAbstractServiceImpl implements TestStatusService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testStatusDAO")
	private TestStatusDAO testStatusDAO;

	/**
	 * 업무별 통계
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectTestStatus(ResultStatisticalVO vo) throws Exception {
		return testStatusDAO.selectTestStatus(vo);
	}
}