package iit.lims.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.system.service.MenuService;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.MenuVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * MenuController
 * @author 정우용
 * @since 2015.01.13
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.19  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Controller
public class MenuController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private MenuService menuService;
	
	@Resource
	private CommonService commonService;

	
	/**
	 * 메뉴관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/menu.lims")
	public String menu(HttpServletRequest request, Model model, CommonCodeVO vo) {
		return "system/menu/menuL01";
	}
	
	/**
	 * 메뉴관리 목록 조회
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectMenuGroupList.lims")
	public ModelAndView selectMenuGroupList(HttpServletRequest request, Model model, MenuVO menuVO) throws Exception {
		try {
			List<MenuVO> menuList = menuService.selectMenuGroupList(menuVO);
			model.addAttribute("resultData", menuList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 메뉴관리 저장/수정 처리
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveMenuGroup.lims")
	public ModelAndView saveMenuGroup(HttpServletRequest request, 
			@ModelAttribute("menuVO") MenuVO menuVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			menuVO.setCreater_id(userInfoVO.getUser_id());
			
			menuVO.setPageType(request.getParameter("pageType"));
			int result = menuService.saveMenuGroup(menuVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(menuVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 메뉴관리 삭제 처리
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteMenu.lims")
	public ModelAndView deleteMenu(HttpServletRequest request, 
			@ModelAttribute("menuVO") MenuVO menuVO, Model model) throws Exception {
		try{
			
			
			
			int result = menuService.deleteMenu(menuVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(menuVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 메뉴관리 상세정보 조회
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectMenuDetailList.lims")
	public ModelAndView selectMenuDetailList(HttpServletRequest request, Model model, MenuVO menuVO) throws Exception {
		try {
			List<MenuVO> menuList = menuService.selectMenuDetailList(menuVO);
			model.addAttribute("resultData", menuList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 메뉴관리 저장/수정 처리
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveMenuDetail.lims")
	public ModelAndView saveMenuDetail(HttpServletRequest request, 
			@ModelAttribute("menuVO") MenuVO menuVO, Model model) throws Exception {
		try{
			int result = menuService.saveMenuDetail(menuVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(menuVO.toString(), e);
			throw e;
		}
	}
	
	
	
	/**
	 * 메뉴관리 상세정보 조회
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectMenuDetailExcel.lims")
	public ModelAndView selectMenuDetailExcel(HttpServletRequest request, Model model, MenuVO menuVO) throws Exception {
		try {
			List<MenuVO> menuList = menuService.selectMenuDetailList(menuVO);
			
			for(int i = 0; i < menuList.size(); i++){
				
				
				
			}
			
			model.addAttribute("resultData", menuList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
}
