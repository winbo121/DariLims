package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import iit.lims.master.dao.AccountDAO;
import iit.lims.master.dao.FormulaDAO;
import iit.lims.master.service.AccountService;
import iit.lims.master.service.FormulaService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.FormulaVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.util.JsonView;

/**
 * FormulaServiceImpl
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

@Service
public class FormulaServiceImpl extends EgovAbstractServiceImpl implements FormulaService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "formulaDAO")
	private FormulaDAO formulaDAO;

	/**
	 * 계산식관리 목록 조회
	 * 
	 * @param FormulaVO
	 * @throws Exception
	 */
	@Override
	public List<FormulaVO> selectFormulaList(FormulaVO vo) throws Exception {
		return formulaDAO.selectFormulaList(vo);
	}
	/**
	 * 계산식관리 상세 조회
	 * 
	 * @param FormulaVO
	 * @throws Exception
	 */
	@Override
	public FormulaVO selectFormulaDetail(FormulaVO vo) throws Exception {
		return formulaDAO.selectFormulaDetail(vo);
	}
	/**
	 * 계산식관리 상세 목록 조회
	 * 
	 * @param FormulaVO
	 * @throws Exception
	 */
	@Override
	public List<FormulaVO> selectFormulaDetailList(FormulaVO vo) throws Exception {
		return formulaDAO.selectFormulaDetailList(vo);
	}
	/**
	 * 계산식관리 저장 처리
	 * 
	 * @param FormulaVO
	 * @throws Exception
	 */
	@Override
	public int insertFormula(FormulaVO vo) throws Exception {
		int result = -1;
		try {
			vo.setFormula_no(formulaDAO.selectFormulaNo());
			result = formulaDAO.insertFormula(vo);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	/**
	 * 계산식관리 저장 처리
	 * 
	 * @param FormulaVO
	 * @throws Exception
	 */
	@Override
	public int updateFormula(FormulaVO vo) throws Exception {
		int result = -1;
		try {
			result = formulaDAO.updateFormula(vo);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	/*
	public int saveFormulaDetail(String gridData, FormulaVO vo, int result) throws Exception {
		String[] rowArr = gridData.split("◆★◆");
		if (rowArr != null && rowArr.length > 0) {
			for (String row : rowArr) {
				String[] columnArr = row.split("■★■");					
				if (columnArr != null && columnArr.length > 0) {
					HashMap<String, String> map = new HashMap<String, String>();
					for (String column : columnArr) {
						String[] valueArr = column.split("●★●");							
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
						}
					}
					String crud = map.get("crud");
					if (crud != "" && crud != null) {
						map.put("user_id", vo.getCreater_id());
						map.put("formula_no", vo.getFormula_no());
						if ("c".equals(crud)) {
							result = formulaDAO.insertFormulaDetail(map);
						}else if("u".equals(crud)) {
							result = formulaDAO.updateFormulaDetail(map);
						}else if("d".equals(crud)) {
							result = formulaDAO.deleteFormulaDetail(map);
						}
					}
				}
			}
		}
		return result;
	}*/
	@Override
	public int updateFormulaDetail(FormulaVO vo) throws Exception {
		int result = -1;
				
		try {
			result = formulaDAO.updateFormulaDetail(vo);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	@Override
	public int insertFormulaDetail(FormulaVO vo) throws Exception {
		int result = -1;
		
		try {
			result = formulaDAO.insertFormulaDetail(vo);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
}