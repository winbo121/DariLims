package iit.lims.resultStatistical.service;

import iit.lims.common.vo.MakeGridVO;

/**
 * itemStatisticsDAO
 * 
 * @author 진영민
 * @since 2015.03.31
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

/**
 * 항목별 통계 목록 조회
 * 
 * @param HttpServletRequest
 *            , Model, MakeGridVO
 * @return ModelAndView
 * @throws Exception
 */
public interface ItemStatisticsService {
	public MakeGridVO selectItemStatistics(MakeGridVO vo) throws Exception;
}