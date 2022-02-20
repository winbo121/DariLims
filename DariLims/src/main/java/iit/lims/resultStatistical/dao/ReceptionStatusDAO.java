package iit.lims.resultStatistical.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.resultStatistical.vo.ReceptionStatusVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ReceptionStatusDAO
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

@Repository
public class ReceptionStatusDAO extends EgovAbstractMapper {

	/**
	 * 수질검사접수현황 조회(시료유형별)
	 * 
	 * @param ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReceptionStatusVO> selectReceptionStatusList(ReceptionStatusVO vo) throws Exception {
		return selectList("resultStatistical.selectReceptionStatusList", vo);
	}

	/**
	 * 수질검사접수현황 조회(단위업무별)
	 * 
	 * @param ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReceptionStatusVO> selectReceptionStatusUnitList(ReceptionStatusVO vo) {
		return selectList("resultStatistical.selectReceptionStatusUnitList", vo);
	}
	
}
