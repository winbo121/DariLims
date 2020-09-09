package iit.lims.master.controller;

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
import iit.lims.master.service.SampleService;
import iit.lims.master.vo.SampleVO;
import iit.lims.util.JsonView;
import iit.lims.system.vo.UserInfoVO;

/**
 * SampleController
 * @author 최은향
 * @since 2015.01.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
public class SampleController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private SampleService sampleService;
	@Resource
	private CommonService commonService;
	
	/**
	 * 시료유형 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/sampleInsertManage.lims")
	public String sampleInsertManage(HttpServletRequest request, Model model) {
		return "master/sample/sampleInsertL01";
	}

	/**
	 * 시료유형 목록 조회
	 * 
	 * @param HttpServletRequest, Model, SampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/sampleInsert.lims")
	public ModelAndView sampleInsert(HttpServletRequest request, Model model, SampleVO sampleVO) {
		try {
			model.addAttribute("resultData", sampleService.sampleInsert(sampleVO));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시료유형 상세정보 조회
	 * 
	 * @param HttpServletRequest, Model, SampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/sampleInsertD01.lims")
	public String sampleInsertDetail(HttpServletRequest request, Model model, SampleVO sampleVO) {
		if(request.getParameter("pageType").equals("insert")){
			model.addAttribute("detail", new SampleVO());
		}else{
			try {
				model.addAttribute("detail", sampleService.sampleInsertDetail(sampleVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "master/sample/sampleInsertD01";
	}
	
	/**
	 * 시료유형 저장 처리
	 * 
	 * @param HttpServletRequest, Model, SampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/master/insertSample.lims")
	public ModelAndView insertSampleInsert(HttpServletRequest request, 
			@ModelAttribute("sampleVO") SampleVO sampleVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			sampleVO.setUser_id(userInfoVO.getUser_id());
			
			int result = sampleService.insertSampleInsert(sampleVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(sampleVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 시료유형 수정 처리
	 * 
	 * @param HttpServletRequest, Model, SampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/updateSample.lims")
	public ModelAndView updateSampleInsert(HttpServletRequest request, 
			@ModelAttribute("sampleVO") SampleVO sampleVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			sampleVO.setUser_id(userInfoVO.getUser_id());
			int result = sampleService.updateSampleInsert(sampleVO);			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(sampleVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 시료유형 삭제 처리
	 * 
	 * @param HttpServletRequest, Model, SampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/deleteSample.lims")
	public ModelAndView deleteSampleInsert(HttpServletRequest request, 
			@ModelAttribute("sampleVO") SampleVO sampleVO, Model model) throws Exception {
		try{
			int result = sampleService.deleteSampleInsert(sampleVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(sampleVO.toString(), e);
			throw e;
		}
	}
}