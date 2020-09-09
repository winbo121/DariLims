package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.OxideMarkVO;


/**
 * OxideMarkService
 * @author 한지연
 * @since 2020.01.14
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.01.14  한지연   최초 생성
 * </pre>
 *
 * Copyright (C) 2020 by interfaceIT., All right reserved.
 */


public interface OxideMarkService {

	/**
	 * 산화물표기 목록 조회
	 *
	 * @param OxideMarkVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<OxideMarkVO> selectOxideMarkList(OxideMarkVO vo) throws Exception;

	/**
	 * 산화물표기 상세정보 조회 / 신규페이지 열기
	 *
	 * @param OxideMarkVO
	 * @return OxideMarkVO
	 * @exception Exception	 
	 */
	public OxideMarkVO selectOxideMarkListDetail(OxideMarkVO vo) throws Exception;
	
	/**
	 * 산화물표기 신규 등록
	 *
	 * @param OxideMarkVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertOxideMark(OxideMarkVO vo) throws Exception;
	
	/**
	 * 산화물표기 수정
	 *
	 * @param OxideMarkVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateOxideMark(OxideMarkVO vo) throws Exception;

}
