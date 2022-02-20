package iit.lims.resultStatistical.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.resultStatistical.service.ReceptionStatusService;
import iit.lims.resultStatistical.vo.ReceptionStatusVO;
import iit.lims.util.JsonView;
/**
 * ReceptionStatusController
 * @author 석은주
 * @since 2015.04.07
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.04.07  		 최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/resultStatistical/")
@Controller
public class ReceptionStatusController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private ReceptionStatusService receptionStatusService;
	
	/**
	 * 수질검사접수현황 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView`````
	 * @throws Exception
	 */
	@RequestMapping("receptionStatusManage.lims")
	public String testResultManage(HttpServletRequest request, Model model) {
		return "resultStatistical/receptionStatus/receptionStatusL01";
	}
	
	/**
	 * 수질검사접수현황 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReceptionStatusList.lims")
	public ModelAndView selectReceptionStatusList(HttpServletRequest request, Model model, ReceptionStatusVO vo) {
		try {
			model.addAttribute("resultData", receptionStatusService.selectReceptionStatusList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}	
}
