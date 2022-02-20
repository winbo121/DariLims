package iit.lims.resultStatistical.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.resultStatistical.vo.InstrumentUseStatisticalVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * InstrumentUseStatisticalDAO
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

@Repository
public class InstrumentUseStatisticalDAO extends EgovAbstractMapper {

	/**
	 * 장비활용조회 (월별)
	 * 
	 * @param InstrumentUseStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<InstrumentUseStatisticalVO> selectInstrumentUseMList(InstrumentUseStatisticalVO vo) throws Exception {
		return selectList("InstrumentUseStatistical.selectInstrumentUseMList", vo);
	}
	
	/**
	 * 장비활용조회 (분기별)
	 * 
	 * @param InstrumentUseStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<InstrumentUseStatisticalVO> selectInstrumentUseQList(InstrumentUseStatisticalVO vo) throws Exception {
		return selectList("InstrumentUseStatistical.selectInstrumentUseQList", vo);
	}
}
