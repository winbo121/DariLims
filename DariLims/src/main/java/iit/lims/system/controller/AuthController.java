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

import iit.lims.system.service.AuthService;
import iit.lims.system.vo.AuthVO;
import iit.lims.util.JsonView;

/**
 * AuthController
 * @author 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Controller
public class AuthController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private AuthService authService;
	
	/**
	 * 부서관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/auth.lims")
	public String auth(HttpServletRequest request, Model model, AuthVO authVO) {
		return "system/auth/authL01";
	}
	
	/**
	 * 부서관리 목록 조회
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAuthGroupList.lims")
	public ModelAndView selectAuthGroupList(HttpServletRequest request, Model model, AuthVO authVO) throws Exception {
		try {
			List<AuthVO> authList = authService.selectAuthGroupList(authVO);
			model.addAttribute("resultData", authList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 부서관리 저장/수정 처리
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveAuthGroup.lims")
	public ModelAndView saveAuthGroup(HttpServletRequest request, 
			@ModelAttribute("authVO") AuthVO authVO, Model model) throws Exception {
		try{
			int result = authService.saveAuthGroup(authVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(authVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 부서관리 삭제 처리
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/delAuthGroup.lims")
	public ModelAndView delAuthGroup(HttpServletRequest request, 
			@ModelAttribute("authVO") AuthVO authVO, Model model) throws Exception {
		try{
			int result = authService.delAuthGroup(authVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(authVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 부서관리 상세정보 조회
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectCmmnMenuList.lims")
	public ModelAndView selectCmmnMenuList(HttpServletRequest request, Model model, AuthVO authVO) throws Exception {
		try {
			List<AuthVO> authList = authService.selectCmmnMenuList(authVO);
			model.addAttribute("resultData", authList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 부서관리 상세정보 조회
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAuthMenuList.lims")
	public ModelAndView selectAuthMenuList(HttpServletRequest request, Model model, AuthVO authVO) throws Exception {
		try {
			List<AuthVO> authList = authService.selectAuthMenuList(authVO);
			model.addAttribute("resultData", authList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 권한관리 등록 처리
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertAuthMenu.lims")
	public ModelAndView insertAuthMenu(HttpServletRequest request, 
			@ModelAttribute("authVO") AuthVO authVO, Model model) throws Exception {
		try{
			int result = authService.insertAuthMenu(authVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(authVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 권한관리 수정 처리
	 * 세부권한 정보를 수정한다.
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveAuthMenu.lims")
	public ModelAndView saveAuthMenu(HttpServletRequest request, 
			@ModelAttribute("authVO") AuthVO authVO, Model model) throws Exception {
		try{
			int result = authService.saveAuthMenu(authVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(authVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 권한관리 삭제 처리
	 * 
	 * @param AuthVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteAuthMenu.lims")
	public ModelAndView deleteAuthMenu(HttpServletRequest request, 
			@ModelAttribute("authVO") AuthVO authVO, Model model) throws Exception {
		try{
			int result = authService.deleteAuthMenu(authVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(authVO.toString(), e);
			throw e;
		}
	}
	
}
