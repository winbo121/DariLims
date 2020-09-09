package iit.lims.system.controller;

import java.net.URLDecoder;
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

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import iit.lims.common.service.CommonService;
import iit.lims.system.service.AccessIpService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.AccessIpVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * AccessIpController
 * @author 최은향
 * @since 2015.12.08
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.08  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Controller
public class AccessIpController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private AccessIpService accessIpService;
	
	@Resource
	private CommonService commonService;
	
	/**
	 * 접근IP정보 페이지 전환 처리
	 * 
	 * @param AccessIpVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/accessIpManage.lims")
	public String accessIpManage(HttpServletRequest request, Model model, AccessIpVO vo) {
		return "system/accessIp/accessIpL01";
	}	
	
	/**
	 * 접근IP정보 목록 조회
	 * 
	 * @param AccessIpVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAccessIp.lims")
	public ModelAndView selectAccessIp(HttpServletRequest request, Model model, AccessIpVO vo) throws Exception {
		try {
			List<AccessIpVO> accessIpList = accessIpService.selectAccessIp(vo);
			model.addAttribute("resultData", accessIpList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	
	/**
	 * 접근IP정보 상세 조회
	 * 
	 * @param AccessIpVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("system/selectAccessIpDetail.lims")
	public String selectAccessIpDetail(HttpServletRequest request, Model model, AccessIpVO vo) throws Exception {
		try {
			if (vo.getIp_seq() != null && vo.getIp_seq() != "") {
				vo = accessIpService.selectAccessIpDetail(vo);				
				model.addAttribute("detail", vo);
			} else {
				model.addAttribute("detail", vo);
			}
			model.addAttribute("pageType",vo.getPageType());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/accessIp/accessIpD01";
	}
	
	
	/**
	 * 접근IP정보 등록
	 * 
	 * @param AccessIpVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertAccessIp.lims")
	public ModelAndView insertAccessIp(HttpServletRequest request, @ModelAttribute("vo") AccessIpVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setCreater_id(userInfoVO.getUser_id());
			
			vo.setStart_ip(vo.getStart_ip01()+ "."+vo.getStart_ip02()+ "."+vo.getStart_ip03()+ "."+vo.getStart_ip04());
			vo.setEnd_ip(vo.getEnd_ip01()+ "."+vo.getEnd_ip02()+ "."+vo.getEnd_ip03()+ "."+vo.getEnd_ip04());
			
			int result = accessIpService.insertAccessIp(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 접근IP정보 수정
	 * 
	 * @param AccessIpVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateAccessIp.lims")
	public ModelAndView updateAccessIp(HttpServletRequest request, 
			@ModelAttribute("vo") AccessIpVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUpdater_id(userInfoVO.getUser_id());	
			
			vo.setStart_ip(vo.getStart_ip01()+ "."+vo.getStart_ip02()+ "."+vo.getStart_ip03()+ "."+vo.getStart_ip04());
			vo.setEnd_ip(vo.getEnd_ip01()+ "."+vo.getEnd_ip02()+ "."+vo.getEnd_ip03()+ "."+vo.getEnd_ip04());
			
			int result = accessIpService.updateAccessIp(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 접근IP정보 삭제
	 * 
	 * @param AccessIpVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteAccessIp.lims")
	public ModelAndView deleteAccessIp(HttpServletRequest request, 
			@ModelAttribute("vo") AccessIpVO vo, Model model) throws Exception {
		try{
			int result = accessIpService.deleteAccessIp(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
}
