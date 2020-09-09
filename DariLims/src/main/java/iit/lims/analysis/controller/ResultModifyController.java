package iit.lims.analysis.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.ResultInputSampleService;
import iit.lims.analysis.service.ResultModifyService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

@Controller
@RequestMapping(value = "/analysis/")
public class ResultModifyController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultModifyService resultModifyService;

	@Resource
	private ResultInputSampleService resultInputSampleService;

	/**
	 * 결과수정
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultModify.lims")
	public String resultModify(HttpServletRequest request, Model model, ResultInputVO vo) {
		model.addAttribute("pageType", "item");
		return "analysis/resultModify/resultModifyL01";
	}

	/**
	 * 결과수정 의뢰 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectModifyReqList.lims")
	public ModelAndView selectModifyReqList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultModifyService.selectModifyReqList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과수정 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectModifyResultList.lims")
	public ModelAndView selectModifyResultList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			//결과확인과 함꼐 사용하여 화면에서 세션처리 
			/*UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());*/
			model.addAttribute("resultData", resultModifyService.selectModifyResultList(vo));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

}
