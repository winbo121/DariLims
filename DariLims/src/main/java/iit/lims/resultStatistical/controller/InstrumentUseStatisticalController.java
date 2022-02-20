package iit.lims.resultStatistical.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.resultStatistical.service.InstrumentUseStatisticalService;
import iit.lims.resultStatistical.vo.InstrumentUseStatisticalVO;
import iit.lims.util.JsonView;
/**
 * EquipUseStatisticalController
 * @author 
 * @since 2015.12.10
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.10  		 최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/resultStatistical/")
@Controller
public class InstrumentUseStatisticalController {
	
	@Resource
	private InstrumentUseStatisticalService instrumentUseStatisticalService;
	
	static final Logger log = LogManager.getLogger();
	
	/**
	 * 장비활용조회 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("instrumentUseManage.lims")
	public String instrumentUseManage(HttpServletRequest request, Model model) {
		return "resultStatistical/instrumentUse/instrumentUseL01";
	}	
	
	/**
	 * 장비활용조회
	 * 
	 * @param HttpServletRequest, Model, InstrumentUseStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectInstrumentUseList.lims")
	public ModelAndView selectInstrumentUseList(HttpServletRequest request, Model model, InstrumentUseStatisticalVO vo) {
		try {
			model.addAttribute("resultData", instrumentUseStatisticalService.selectInstrumentUseList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
}
