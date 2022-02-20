package iit.lims.analysis.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.SampleDisuseService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * SampleDisuse
 * 
 * @author 정우용
 * @since 2015.03.05
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.05  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class SampleDisuseController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private SampleDisuseService sampleDisuseService;

	/**
	 * 시료페기 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/sampleDisuse.lims")
	public String sampleInput(HttpServletRequest request, Model model) {
		return "analysis/sampleDisuse/sampleDisuseL01";
	}

	/**
	 * 시료페기 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSampleDisuseList.lims")
	public ModelAndView selectSampleList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", sampleDisuseService.selectSampleDisuseList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	
	
	/**
	 * 시료페기 상세 페이지
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sampleDisuseDetail.lims")
	public String sampleDisuseDetail(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			//vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			//System.out.println(request.getParameter("test_sample_seq"));
			model.addAttribute("detail", sampleDisuseService.sampleDisuseDetail(request, vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "analysis/sampleDisuse/sampleDisuseD01";
	}

	/**
	 * 시료폐기 수정 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateSampleDisuse.lims")
	public ModelAndView updateSampleDisuse(HttpServletRequest request, @ModelAttribute("vo") ResultInputVO vo, Model model) throws Exception {
		try {
			//UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			//vo.setUser_id(userInfoVO.getUser_id());
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			int result = sampleDisuseService.updateSampleDisuse(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 시료폐기 삭제 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteSampleDisuse.lims")
	public ModelAndView deleteSampleDisuse(HttpServletRequest request, @ModelAttribute("vo") ResultInputVO vo, Model model) throws Exception {
		try {
			int result = sampleDisuseService.deleteSampleDisuse(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
}
