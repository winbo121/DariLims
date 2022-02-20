package iit.lims.analysis.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.ResultInputMultipleService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * ResultInputMultipleController
 * 
 * @author 김상하
 * @since 2016.04.12
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.04.12  김상하   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultInputMultipleController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultInputMultipleService resultInputMultipleService;

	/**
	 * 결과입력 (항목) 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultInputMultiple.lims")
	public String resultInputMultiple(HttpServletRequest request, Model model) {
		model.addAttribute("pageType", "item");
		return "analysis/resultInputMultiple/resultInputMultipleL01";
	}


	/**
	 * 결과입력 > 결과 저장
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateMultipleItemResult.lims")
	public ModelAndView updateMultipleItemResult(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultInputMultipleService.updateMultipleItemResult(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
}
