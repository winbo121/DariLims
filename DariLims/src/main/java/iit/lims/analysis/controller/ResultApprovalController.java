package iit.lims.analysis.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.ResultApprovalService;
import iit.lims.analysis.vo.ResultApprovalVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * MenuController
 * 
 * @resultApprovalor 정우용
 * @since 2015.02.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.16  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
public class ResultApprovalController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultApprovalService resultApprovalService;

	@RequestMapping("analysis/resultApproval.lims")
	public String resultApproval(HttpServletRequest request, ResultApprovalVO resultApprovalVO, Model model) {
		model.addAttribute("pageType", "item");
		model.addAttribute("type", "sect");
		return "analysis/resultApproval/resultApprovalL01";
	}

	@RequestMapping("analysis/resultApprDept.lims")
	public String resultApprDept(HttpServletRequest request, ResultApprovalVO resultApprovalVO, Model model) {
		model.addAttribute("pageType", "item");
		model.addAttribute("type", "dept");
		return "analysis/resultApproval/resultApprovalL01";
	}

	/**
	 * 결재라인 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("resultApproval/selectApprList.lims")
	public String selectApprList(HttpServletRequest request, ResultApprovalVO vo, Model model) {
		try {
			model.addAttribute("apprList", resultApprovalService.selectApprList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "analysis/resultApproval/resultApprovalD01";
	}

	/**
	 * 시료목록 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("resultApproval/selectSampleList.lims")
	public ModelAndView selectSampleList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultApprovalService.selectSampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목목록 조회
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("resultApproval/selectSampleItemList.lims")
	public ModelAndView selectSampleItemList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setDept_cd(userInfoVO.getDept_cd());

			List<ResultApprovalVO> itemResult = resultApprovalService.selectSampleItemList(vo);
			model.addAttribute("resultData", itemResult);
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결재승인 처리
	 * 
	 * @param AcceptApprovalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("resultApproval/updateAppr.lims")
	public ModelAndView updateAppr(HttpServletRequest request, Model model, ResultApprovalVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			vo.setAppr_id(userInfoVO.getUser_id());

			model.addAttribute("resultData", resultApprovalService.updateAppr(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

}
