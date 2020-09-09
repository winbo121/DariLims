package iit.lims.resultStatistical.service;

import java.util.List;

import iit.lims.resultStatistical.vo.InstrumentUseStatisticalVO;

/**
 * InstrumentUseStatisticalService
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

/**
 * 장비활용조회
 * 
 * @param HttpServletRequest
 *            , Model, InstrumentUseStatisticalVO
 * @return ModelAndView
 * @throws Exception
 */
public interface InstrumentUseStatisticalService {
	
	public List<InstrumentUseStatisticalVO> selectInstrumentUseList(InstrumentUseStatisticalVO vo) throws Exception;
}