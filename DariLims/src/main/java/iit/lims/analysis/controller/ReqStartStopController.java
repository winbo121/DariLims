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
import iit.lims.analysis.service.ReqStartStopService;
import iit.lims.analysis.vo.ReqStartStopVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

@Controller
@RequestMapping(value = "/analysis/")
public class ReqStartStopController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ReqStartStopService reqStartStopService;

	@Resource
	private ResultInputSampleService resultInputSampleService;

	/**
	 * 요청에 의한 시험 중지/시작
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/reqStartStop.lims")
	public String reqStartStop(HttpServletRequest request, Model model, ReqStartStopVO vo) {
		return "analysis/reqStartStop/reqStartStopL01";
	}
	
	/**
	 * 요청에 의한 시험 중지/시작
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/updateStopStart.lims")
	public ModelAndView updateStopStart(HttpServletRequest request, Model model, ReqStartStopVO vo) throws Exception {
		try {
			vo.setStop_flag(request.getParameter("stop_flag"));
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", reqStartStopService.updateStopStart(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

}
