package iit.lims.master.dao;

import iit.lims.master.vo.PrdLstVO;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * AccountDAO
 * @author 윤상준
 * @since 2015.12.18
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.18  윤상준   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class PrdLstDAO extends EgovAbstractMapper {

	/**
	 * 품목 조회
	 *
	 * @param PrdLstVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<PrdLstVO> selectPrdLstList(PrdLstVO prdLstVO) throws Exception {
		return selectList("prdLst.selectPrdLstList", prdLstVO);
	}

	public int insertPrdlst(PrdLstVO prdLstVO) {
		return insert("prdLst.insertPrdlst", prdLstVO);
	}

	public int updatePrdlst(PrdLstVO prdLstVO) {
		return update("prdLst.updatePrdlst", prdLstVO);
	}

	public PrdLstVO selectPrdLstListDetail(PrdLstVO prdLstVO) {
		// TODO Auto-generated method stub
		return selectOne("prdLst.selectPrdLstListDetail", prdLstVO);
	}
	
}
