package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import iit.lims.master.vo.FormulaVO;

/**
 * FormulaDAO
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

@Repository
public class FormulaDAO extends EgovAbstractMapper {

	/**
	 * 계산식관리 목록 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<FormulaVO> selectFormulaList(FormulaVO vo) throws Exception {
		return selectList("formula.selectFormulaList", vo);
	}
	/**
	 * 계산식관리 상세 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public FormulaVO selectFormulaDetail(FormulaVO vo) throws Exception {
		return selectOne("formula.selectFormulaDetail", vo);
	}
	/**
	 * 계산식관리 상세 목록 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<FormulaVO> selectFormulaDetailList(FormulaVO vo) throws Exception {
		return selectList("formula.selectFormulaDetailList", vo);
	}
	/**
	 * 계산식관리 상세 조회
	 *
	 * @param FormulaVO
	 * @return List
	 * @exception Exception	 
	 */
	public String selectFormulaNo() throws Exception {
		return selectOne("formula.selectFormulaNo", null);
	}
	/**
	 * 계산식관리 등록 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertFormula(FormulaVO vo) throws Exception {
		return insert("formula.insertFormula", vo);
	}
	/**
	 * 계산식관리 수정 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateFormula(FormulaVO vo) throws Exception {
		return update("formula.updateFormula", vo);
	}
	/**
	 * 계산식관리 상세 등록 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertFormulaDetail(HashMap<String, String> map) throws Exception {
		return insert("formula.insertFormulaDetail", map);
	}
	/**
	 * 계산식관리 상세 수정 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateFormulaDetail(HashMap<String, String> map) throws Exception {
		return update("formula.updateFormulaDetail", map);
	}
	/**
	 * 계산식관리 상세 삭제 처리
	 *
	 * @param FormulaVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteFormulaDetail(HashMap<String, String> map) throws Exception {
		return insert("formula.deleteFormulaDetail", map);
	}
	
	public int updateFormulaDetail(FormulaVO vo) {
		
		return update("formula.updateFormulaDetail", vo);
	}
	public int insertFormulaDetail(FormulaVO vo) {
		
		return insert("formula.insertFormulaDetail",vo);
	}
}
