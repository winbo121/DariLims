package iit.lims.analysis.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ResultInputMultipleDAO
 * 
 * @author 김상하
 * @since 2016.04.12
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.04.12  김상하   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Repository
public class ResultInputMultipleDAO extends EgovAbstractMapper {

	public int updateMultipleItem(ResultInputVO vo) throws Exception {
		return update("resultInputMultiple.updateMultipleItem", vo);
	}

}