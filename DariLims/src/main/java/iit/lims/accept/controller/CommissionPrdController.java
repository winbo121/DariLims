package iit.lims.accept.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.service.CommissionPrdService;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * CommissionPrdController
 * 
 * @author 최은향
 * @since 2016.01.25
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.01.25  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/accept/")
public class CommissionPrdController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private CommissionPrdService commissionPrdService;
	
	/**
	 * 품목별 수수료관리 페이지
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commissionPrd.lims")
	public String commissionPrd(Model model, TestPrdStdVO vo) {
		return "accept/commissionPrd/commissionPrdL01";
	}
	
	/**
	 * 품목별 수수료 목록
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/commissionPrdList.lims")
	public ModelAndView commissionPrdList(HttpServletRequest request, Model model, TestPrdStdVO vo) {
		try {
			model.addAttribute("resultData", commissionPrdService.stdPrdItemCommissionList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	
	
	
	/**
	 * 시험기준 & 품목별 항목(및 수수료) 저장
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("insertStdPrdItemCommission.lims")
	public ModelAndView insertStdPrdItemCommission(HttpServletRequest request, @ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = commissionPrdService.insertStdPrdItemCommission(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
}