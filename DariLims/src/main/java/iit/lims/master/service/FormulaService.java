package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.FormulaVO;


/**
 * FormulaService
 * @author 허태원
 * @since 2020.02.17
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.02.17  허태원   최초 생성
 * </pre>
 *
 * Copyright (C) 2020 by interfaceIT., All right reserved.
 */

public interface FormulaService {

	/**
	 * 계산식관리 목록 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<FormulaVO> selectFormulaList(FormulaVO vo) throws Exception;
	
	/**
	 * 계산식관리 상세 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public FormulaVO selectFormulaDetail(FormulaVO vo) throws Exception;

	/**
	 * 계산식관리 상세 목록 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<FormulaVO> selectFormulaDetailList(FormulaVO vo) throws Exception;
	
	/**
	 * 계산식관리 등록 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertFormula(FormulaVO vo) throws Exception;
	
	/**
	 * 계산식관리 수정 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateFormula(FormulaVO vo) throws Exception;

	
	public int updateFormulaDetail(FormulaVO vo) throws Exception;

	public int insertFormulaDetail(FormulaVO vo) throws Exception;
	
	
}
