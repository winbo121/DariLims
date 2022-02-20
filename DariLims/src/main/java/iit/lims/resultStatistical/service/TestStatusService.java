package iit.lims.resultStatistical.service;

import java.util.List;

import iit.lims.common.vo.MakeGridVO;
import iit.lims.resultStatistical.vo.ResultStatisticalVO;

/**
 * testStatusService
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

public interface TestStatusService {
	/**
	 * 업무별통계 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectTestStatus(ResultStatisticalVO vo) throws Exception;
}