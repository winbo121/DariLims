package iit.lims.master.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.EstimateVO;
import iit.lims.common.service.CommonService;
import iit.lims.master.service.AccountService;
import iit.lims.master.service.MailGroupService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * MailgroupController
 * 
 * @author zestysong
 * @since 2020.01.06
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.01.06  zestysong   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2020 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class MailGroupController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private MailGroupService mailGroupService;

	/**
	 * 메일그룹관리 관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("mailGroupManage.lims")
	public String menu(HttpServletRequest request, Model model, CommonCodeVO vo) {
		return "master/mailGroup/mailGroupL01";
	}

	/**
	 * 메일그룹 목록조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectListMailGroup.lims")
	public ModelAndView selectListMailGroup(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			model.addAttribute("resultData", mailGroupService.selectListMailGroup(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 메일그룹별 메일목록 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectListMailAddress.lims")
	public ModelAndView selectListMailAddress(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			model.addAttribute("resultData", mailGroupService.selectListMailAddress(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 메일그룹 저장 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("saveMailGroup.lims")
	public ModelAndView saveMailGroup(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			int result = mailGroupService.saveMailGroup(param);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 메일 저장 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("saveMailAddress.lims")
	public ModelAndView saveMailAddress(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			int result = mailGroupService.saveMailAddress(param);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	
	/**
	 * 메일그룹 삭제 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteMailGroup.lims")
	public ModelAndView deleteMailGroup(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			int result = mailGroupService.deleteMailGroup(param);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 메일 삭제 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteMailAddress.lims")
	public ModelAndView deleteMailAddress(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			int result = mailGroupService.deleteMailAddress(param);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
}
