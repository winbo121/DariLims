package iit.lims.report.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.report.service.ReportPublishService;
import iit.lims.report.vo.ReportVO;
import iit.lims.util.JsonView;

/**
 * ReportPublishController
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/report/")
public class ReportPublishController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ReportPublishService reportPublishService;

	/**
	 * 성적서 발행 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportPublish.lims")
	public String reportPublish(HttpServletRequest request, Model model) {
		return "report/reportPublish/reportPublishL01";
	}

	/**
	 * 성적서 발행 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportWriteList.lims")
	public ModelAndView selectReportWriteList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			vo.setCommission_flag(request.getParameter("commission_flag"));
			model.addAttribute("resultData", reportPublishService.selectReportWriteList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 발행 이력 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportPublishHistoryList.lims")
	public ModelAndView selectReportPublishHistoryList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			vo.setCommission_flag(request.getParameter("commission_flag"));
			model.addAttribute("resultData", reportPublishService.selectReportPublishHistoryList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	
	/**
	 * 성적서 메일전송 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportMailList.lims")
	public ModelAndView selectReportMailList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.selectReportMailList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 발행 시료 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportWriteSampleList.lims")
	public ModelAndView selectReportWriteSampleList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.selectReportWriteSampleList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/selectReportWriteSampleItemList.lims")
	public ModelAndView selectReportWriteSampleItemList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.selectReportWriteSampleItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 발행 상태값 변경
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReportPublish.lims")
	public ModelAndView updateReportPublish(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.updateReportPublish(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 발행 상태 체크
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/checkReportPublish.lims")
	public ModelAndView checkReportPublish(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.checkReportPublish(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 삭제
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteReport.lims")
	public ModelAndView deleteReport(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.deleteReport(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/saveExceptItem.lims")
	public ModelAndView saveExceptItem(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.saveExceptItem(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("/insertReportPublishLog.lims")
	public ModelAndView insertReportPublishLog(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.insertReportPublishLog(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("/deleteReportPublishLog.lims")
	public ModelAndView deleteReportPublishLog(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.deleteReportPublishLog(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	
	@RequestMapping("/reportMailSendPop.lims")
	public String acceptMailSendPop() throws Exception {
		return "common/pop/reportMailSendPop";
	}
	
	@RequestMapping("/selectLogNo.lims")
	public ModelAndView selectLogNo(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.selectLogNo(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("/selectReportPublishNo.lims")
	public ModelAndView selectReportPublishNo(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.selectReportPublishNo(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 메일전송 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSurfaceMailList.lims")
	public ModelAndView selectSurfaceMailList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportPublishService.selectSurfaceMailList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
}
