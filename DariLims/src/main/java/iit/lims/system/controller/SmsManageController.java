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
import iit.lims.system.service.SmsManageService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import iit.lims.util.sms.vo.SmsVO;

/**
 * SmsManageController
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
public class SmsManageController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private SmsManageService smsManageService;
	
	/**
	 * SMS관리 페이지 전환 처리
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/smsManage.lims")
	public String smsManage(HttpServletRequest request, Model model, SmsVO vo) {
		return "system/smsManage/smsManageL01";
	}	
	
	/**
	 * SMS관리 목록 조회
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectSmsManage.lims")
	public ModelAndView selectSmsManage(HttpServletRequest request, Model model, SmsVO vo) throws Exception {
		try {
			List<SmsVO> accessIpList = smsManageService.selectSmsManage(vo);
			model.addAttribute("resultData", accessIpList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	
	/**
	 * SMS관리 상세 조회
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("system/selectSmsManageDetail.lims")
	public String selectSmsManageDetail(HttpServletRequest request, Model model, SmsVO vo) throws Exception {
		try {
			if (vo.getPageType() == null){
				model.addAttribute("detail", null);
			}else{
				vo = smsManageService.selectSmsManageDetail(vo);				
				model.addAttribute("detail", vo);
				model.addAttribute("pageType",vo.getPageType());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/smsManage/smsManageD01";
	}
	
	
	/**
	 * SMS관리 등록
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertSmsManage.lims")
	public ModelAndView insertSmsManage(HttpServletRequest request, @ModelAttribute("vo") SmsVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setCreater_id(userInfoVO.getUser_id());
			
			int result = smsManageService.insertSmsManage(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * SMS관리 수정
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateSmsManage.lims")
	public ModelAndView updateSmsManage(HttpServletRequest request, 
			@ModelAttribute("vo") SmsVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUpdater_id(userInfoVO.getUser_id());	

			int result = smsManageService.updateSmsManage(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * SMS관리 삭제
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteSmsManage.lims")
	public ModelAndView deleteSmsManage(HttpServletRequest request, 
			@ModelAttribute("vo") SmsVO vo, Model model) throws Exception {
		try{
			int result = smsManageService.deleteSmsManage(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * SMS관리 키 중복 체크
	 * 
	 * @param SmsVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectSmsKeyCheck.lims")
	public ModelAndView selectSmsKeyCheck(HttpServletRequest request, 
			@ModelAttribute("vo") SmsVO vo, Model model) throws Exception {
		try{
			String result = smsManageService.selectSmsKeyCheck(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
}
