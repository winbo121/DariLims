package iit.lims.analysis.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * MenuService
 * 
 * @author 조재환
 * @since 2015.01.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.17  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ResultInputItemDAO extends EgovAbstractMapper {

	public List<ResultInputVO> selectReqTestItemList(ResultInputVO vo) throws Exception {
		return selectList("resultInputItem.selectReqTestItemList", vo);
	}

	public List<ResultInputVO> selectResultItemList(ResultInputVO vo) throws Exception {
		return selectList("resultInputItem.selectResultItemList", vo);
	}

}