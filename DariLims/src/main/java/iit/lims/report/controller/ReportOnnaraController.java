package iit.lims.report.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.report.service.ReportOnnaraService;
import iit.lims.report.vo.ReportVO;
import iit.lims.util.JsonView;

/**
 * ReportOnnaraController
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
public class ReportOnnaraController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ReportOnnaraService reportOnnaraService;

	/**
	 * 온나라 연계 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportOnnara.lims")
	public String reportPublish(HttpServletRequest request, Model model) {
		return "report/reportOnnara/reportOnnaraL01";
	}

	/**
	 * 온나라 연계 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportOnnaraList.lims")
	public ModelAndView selectReportWriteList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportOnnaraService.selectReportOnnaraList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 온나라 연계 기안 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReportOnnara.lims")
	public ModelAndView updateReportOnnara(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportOnnaraService.updateReportOnnara(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

}
