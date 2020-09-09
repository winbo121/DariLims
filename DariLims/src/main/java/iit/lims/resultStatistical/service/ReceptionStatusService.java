package iit.lims.resultStatistical.service;

import java.util.List;

import iit.lims.resultStatistical.vo.ReceptionStatusVO;


/**
 * ReceptionStatusService
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
 *  2015.04.07           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface ReceptionStatusService {

	/**
	 * 시험결과 목록 조회
	 * 
	 * @param ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReceptionStatusVO> selectReceptionStatusList(ReceptionStatusVO vo) throws Exception;
}