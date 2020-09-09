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

import iit.lims.system.service.CodeService;
import iit.lims.system.vo.CodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * CodeController
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
public class CodeController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private CodeService codeService;
	
	/**
	 * 코드관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/code.lims")
	public String code(HttpServletRequest request, Model model, CodeVO codeVO) {
		return "system/code/codeL01";
	}
	
	/**
	 * 코드그룹 목록 조회
	 * 
	 * @param CodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectCodeGroupList.lims")
	public ModelAndView selectCodeGroupList(HttpServletRequest request, Model model, CodeVO codeVO) throws Exception {
		try {
			List<CodeVO> codeList = codeService.selectCodeGroupList(codeVO);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 코드그룹 저장/수정 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveCodeGroup.lims")
	public ModelAndView saveCodeLims(HttpServletRequest request, 
			@ModelAttribute("codeVO") CodeVO codeVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			codeVO.setCreater_id(userInfoVO.getUser_id());
			
			int result = codeService.saveCodeGroup(codeVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(codeVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 코드상세 목록 조회
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectCodeDetailList.lims")
	public ModelAndView selectCodeLimsList(HttpServletRequest request, Model model, CodeVO codeVO) throws Exception {
		try {
			List<CodeVO> codeList = codeService.selectCodeDetailList(codeVO);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 코드상세 저장/수정 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveCodeDetail.lims")
	public ModelAndView saveCodeDetail(HttpServletRequest request, 
			@ModelAttribute("codeVO") CodeVO codeVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			codeVO.setCreater_id(userInfoVO.getUser_id());
			
			int result = codeService.saveCodeDetail(codeVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(codeVO.toString(), e);
			throw e;
		}
	}
	
	
}
