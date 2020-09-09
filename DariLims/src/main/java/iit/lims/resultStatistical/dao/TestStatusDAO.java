package iit.lims.resultStatistical.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.common.vo.MakeGridVO;
import iit.lims.resultStatistical.vo.ResultStatisticalVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestStatusDAO
 * 
 * @author 최은향
 * @since 2015.10.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.19           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class TestStatusDAO extends EgovAbstractMapper {
	
	/**
	 * 업무별 통계
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectTestStatus(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectTestStatus", vo);
	}
	
}
