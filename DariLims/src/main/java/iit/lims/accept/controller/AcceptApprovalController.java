package iit.lims.accept.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.service.AcceptApprovalService;
import iit.lims.accept.vo.AcceptApprovalVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

@Controller
@RequestMapping(value = "/accept/")
public class AcceptApprovalController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private AcceptApprovalService acceptApprovalService;

	@RequestMapping("/acceptApproval.lims")
	public String acceptApproval(HttpServletRequest request, AcceptApprovalVO acceptApprovalVO, Model model) {
		return "accept/acceptApproval/acceptApprovalL01";
	}

	@RequestMapping("/selectReqList.lims")
	public ModelAndView selectReqList(HttpServletRequest request, Model model, AcceptApprovalVO vo) {
		try {
			model.addAttribute("resultData", acceptApprovalService.selectReqList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 결재라인 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectApprList.lims")
	public String selectApprList(HttpServletRequest request, AcceptApprovalVO vo, Model model) {
		try {
			model.addAttribute("apprList", acceptApprovalService.selectApprList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "accept/acceptApproval/acceptApprovalD01";
	}


	/**
	 * 결재승인 처리
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateAppr.lims")
	public ModelAndView updateAppr(HttpServletRequest request, Model model, AcceptApprovalVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			vo.setAppr_id(userInfoVO.getUser_id());

			model.addAttribute("resultData", acceptApprovalService.updateAppr(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

}
