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

import iit.lims.accept.service.CommissionService;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.accept.vo.CounselVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonTextView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * CommissionController
 * 
 * @author 최은향
 * @since 2015.04.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.04.16  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/accept/")
public class CommissionController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private CommissionService commissionService;
	
	/**
	 * 수수료관리 페이지
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commission.lims")
	public String commission(Model model, TestPrdStdVO vo) {
		return "accept/commission/commissionL01";
	}
	
	/**
	 * 수수료 관리
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/commissionList.lims")
	public ModelAndView commissionList(HttpServletRequest request, Model model, TestPrdStdVO vo) {
		try {
			model.addAttribute("resultData", commissionService.stdItemCommissionList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	
	
	
	/**
	 * 시험기준분류별 시험항목(및 수수료) 저장
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("insertStdItemCommission.lims")
	public ModelAndView insertStdTestItem(HttpServletRequest request, 
			@ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = commissionService.insertStdItemCommission(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/*새로운 삭제 컨트롤러 추가*/
	
	@RequestMapping("deleteStdItemCommission.lims")
	public ModelAndView deleteStdTestItem(HttpServletRequest request, 
			@ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = commissionService.deleteStdItemCommission(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 수수료 프로세스 사용 여부 조회
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("commissionFlag.lims")
	public ModelAndView commissionFlag(HttpServletRequest request, Model model) throws Exception {
		try {
			String result = commissionService.commissionFlag();
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	
	/**
	 * 수수료 프로세스 사용 여부 수정
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	
	@RequestMapping("updateCommissionFlag.lims")
	public ModelAndView updateCommissionFlag(HttpServletRequest request, @ModelAttribute("counselVO") TestPrdStdVO vo, Model model) throws Exception {
		try {
			int result = commissionService.updateCommissionFlag(vo);			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}	
//	updateCommissionFlag
}