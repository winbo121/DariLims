package iit.lims.master.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.master.service.TestItemMethodService;
import iit.lims.master.vo.TestMethodVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestItemMethodController
 * 
 * @author 진영민
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.19  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@RequestMapping(value = "/master/")
@Controller
public class TestItemMethodController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private TestItemMethodService testItemMethodService;

	/**
	 * 항목별 시험방법 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/testItemMethod.lims")
	public String testItemMethod(HttpServletRequest request, Model model) {
		return "master/testItemMethod/testItemMethodL01";
	}

	/**
	 * 항목별 시험방법 목록 조회
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemMethodList.lims")
	public ModelAndView selectTestItemMethodList(HttpServletRequest request, Model model, TestMethodVO vo) {
		try {
			if (vo.getPageType() != null && "all".equals(vo.getPageType())) {
				model.addAttribute("resultData", testItemMethodService.selectAllMethodList(vo));
			} else if (vo.getPageType() == null || "".equals(vo.getPageType())) {
				//System.out.println(vo.getTest_std_no());
				//vo.setTest_std_no(request.getParameter("test_std_no"));
				model.addAttribute("resultData", testItemMethodService.selectTestItemMethodList(vo));
			}
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목별 시험방법 저장
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveTestItemMethod.lims")
	public ModelAndView saveTestItemMethod(HttpServletRequest request, Model model, TestMethodVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setTest_std_no(request.getParameter("test_std_no"));
			model.addAttribute("resultData", testItemMethodService.saveTestItemMethod(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
}
