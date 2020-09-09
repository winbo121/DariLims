package iit.lims.analysis.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.ResultInputReportService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.service.CommonService;
import iit.lims.master.vo.SampleVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * ResultInputReportController
 * 
 * @author 최은향
 * @since 2015.10.07
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.07  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultInputReportController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultInputReportService resultInputReportService;

	@Resource
	private CommonService commonService;

	/**
	 * 결과입력 (성적서) 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultReport.lims")
	public String resultReport(HttpServletRequest request, Model model, ResultInputVO vo) {
		model.addAttribute("move", vo);
		return "analysis/resultInputReport/resultInputReportL01";
	}
	
	/**
	 * 결과입력 (성적서) 시료 리스트 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sampleList.lims")
	public ModelAndView sampleList(Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultInputReportService.sampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 결과입력 (성적서) 시료별 성적서 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectsampleReportList.lims")
	public ModelAndView sampleReport(Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultInputReportService.selectsampleReportList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}
