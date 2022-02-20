package iit.lims.analysis.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.ResultInputItemService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * MenuController
 * 
 * @author 조재환
 * @since 2015.01.14
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.14  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultInputItemController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultInputItemService resultInputItemService;

	/**
	 * 결과입력 (항목) 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultInputItem.lims")
	public String sampleInput(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		model.addAttribute("loginUser", userInfoVO.getUser_nm());
		model.addAttribute("pageType", "item");
		return "analysis/resultInputItem/resultInputItemL01";
	}

	/**
	 * 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReqTestItemList.lims")
	public ModelAndView selectReqTestItemList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultInputItemService.selectReqTestItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목별 결과 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectResultItemList.lims")
	public ModelAndView selectResultItemList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultInputItemService.selectResultItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
}
