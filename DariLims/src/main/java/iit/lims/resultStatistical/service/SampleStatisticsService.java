package iit.lims.resultStatistical.service;

import iit.lims.common.vo.MakeGridVO;

/**
 * SampleStatisticsDAO
 * 
 * @author 최은향
 * @since 2015.06.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.17           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

/**
 * 시료별 통계 목록 조회
 * 
 * @param HttpServletRequest
 *            , Model, ResultStatisticalVO
 * @return ModelAndView
 * @throws Exception
 */
public interface SampleStatisticsService {
	public MakeGridVO selectSampleStatistics(MakeGridVO vo) throws Exception;
}