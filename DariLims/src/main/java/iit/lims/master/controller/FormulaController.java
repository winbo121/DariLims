package iit.lims.master.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.master.service.FormulaService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.FormulaVO;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * FormulaController
 * 
 * @author 허태원
 * @since 2020.02.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.02.17  허태원   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2020 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class FormulaController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private FormulaService formulaService;

	/**
	 * 계산식 관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("formulaManage.lims")
	public String menu(HttpServletRequest request, Model model, CommonCodeVO vo) {
		return "master/formula/formulaL01";
	}

	/**
	 * 계산식 관리 목록 조회
	 * 
	 * @param FormulaVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectFormulaList.lims")
	public ModelAndView selectFormulaList(HttpServletRequest request, Model model, FormulaVO vo) throws Exception {	
		try {
			model.addAttribute("resultData", formulaService.selectFormulaList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 계산식관리 상세 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectFormulaDetail.lims")
	public String selectFormulaDetail(HttpServletRequest request, Model model, FormulaVO vo) throws Exception {
		try {
			if (vo.getPageType() != null && "detail".equals(vo.getPageType())) {
				model.addAttribute("detail", formulaService.selectFormulaDetail(vo));
			} else {
				model.addAttribute("detail", new FormulaVO());
			}
			model.addAttribute("pageType", request.getParameter("pageType"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/formula/formulaD01";
	}
	
	/**
	 * 계산식관리 상세 목록 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectFormulaDetailList.lims")
	public ModelAndView selectFormulaDetailList(HttpServletRequest request, Model model, FormulaVO vo) throws Exception {
		try {
			model.addAttribute("resultData", formulaService.selectFormulaDetailList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 계산식관리 등록 처리
	 * 
	 * @param FormulaVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertFormula.lims")
	public ModelAndView saveFormula(HttpServletRequest request, @ModelAttribute("vo") FormulaVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = formulaService.insertFormula(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 계산식관리 수정 처리
	 * 
	 * @param FormulaVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateFormula.lims")
	public ModelAndView updateFormula(HttpServletRequest request, @ModelAttribute("vo") FormulaVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = formulaService.updateFormula(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	@RequestMapping("updateFormulaDetail.lims")
	public ModelAndView updateFormulaDetail(HttpServletRequest request, Model model, FormulaVO vo) throws Exception {
		try {
			if(vo.getInput_val()==null || vo.getInput_val().equals("")) {
			vo.setInput_val("0");	
			}
				int result = formulaService.updateFormulaDetail(vo);
				model.addAttribute("resultData", result);
				return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("insertFormulaDetail.lims")
	public ModelAndView insertFormulaDetail(HttpServletRequest request, Model model, FormulaVO vo) throws Exception {
		try {
			if(vo.getInput_val()==null || vo.getInput_val().equals("")) {
			vo.setInput_val("0");	
			}
				int result = formulaService.insertFormulaDetail(vo);
				model.addAttribute("resultData", result);
				return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
}
