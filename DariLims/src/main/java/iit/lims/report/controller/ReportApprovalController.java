package iit.lims.report.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.report.service.ReportApprovalService;
import iit.lims.report.vo.ReportVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * ReportApprovalController
 * 
 * @author 허태원
 * @since 2020.02.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.02.26  허태원   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/report/")
public class ReportApprovalController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ReportApprovalService reportApprovalService;

	/**
	 * 성적서 승인 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportApproval.lims")
	public String reportApproval(HttpServletRequest request, Model model) {
		return "report/reportApproval/reportApprovalL01";
	}

	/**
	 * 성적서 승인 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportApprovalList.lims")
	public ModelAndView selectReportApprovalList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportApprovalService.selectReportApprovalList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 승인 시료 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportApprovalSampleList.lims")
	public ModelAndView selectReportApprovalSampleList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportApprovalService.selectReportApprovalSampleList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 승인 항목 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportApprovalItemList.lims")
	public ModelAndView selectReportApprovalItemList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportApprovalService.selectReportApprovalItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 승인
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReportApproval.lims")
	public ModelAndView updateReportApproval(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			model.addAttribute("resultData", reportApprovalService.updateReportApproval(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 반려
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteReportReturn.lims")
	public ModelAndView deleteReportReturn(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			model.addAttribute("resultData", reportApprovalService.deleteReportReturn(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
}
