package iit.lims.master.service;

import iit.lims.master.vo.PrdLstVO;

import java.util.HashMap;
import java.util.List;


/**
 * PrdLstService
 * @author 윤상준
 * @since 2015.12.17
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.18  윤상준   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface PrdLstService {

	/**
	 * 품목 조회
	 *
	 * @param PrdLstVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<PrdLstVO> selectPrdLstList(PrdLstVO prdLstVO) throws Exception;

	public int insertPrdlst(PrdLstVO vo) throws Exception;

	public int updatePrdlst(PrdLstVO vo) throws Exception;

	public PrdLstVO selectPrdLstListDetail(PrdLstVO prdLstVO)throws Exception;


	
}
