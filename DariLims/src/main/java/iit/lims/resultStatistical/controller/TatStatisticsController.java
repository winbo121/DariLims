package iit.lims.resultStatistical.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.service.CommonService;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.report.vo.ReportVO;
import iit.lims.resultStatistical.service.TatStatisticsService;
import iit.lims.util.JsonView;

/**
 * TatStatisticsController
 * 
 * @author 한지연	
 * @since 2020.06.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.31           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/resultStatistical/")
@Controller
public class TatStatisticsController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private TatStatisticsService tatStatisticsService;
	@Resource
	private CommonService commonService;

	/**
	 * TAT 통계 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/tatStatistics.lims")
	public String tatStatistics(HttpServletRequest request, Model model) {
		return "resultStatistical/tatStatistics/tatStatisticsL01";
	}

	/**
	 * tat 통계 목록 조회 - 시험완료
	 * 
	 * @param HttpServletRequest
	 *            , Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTatStatistics.lims")
	public ModelAndView selectTatStatistics(HttpServletRequest request, Model model, MakeGridVO vo) {
		try {
			model.addAttribute("resultData", tatStatisticsService.selectTatStatistics(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * tat 통계 목록 조회 - 성적서
	 * 
	 * @param HttpServletRequest
	 *            , Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTatReportStatistics.lims")
	public ModelAndView selectTatReportStatistics(HttpServletRequest request, Model model, MakeGridVO vo) {
		try {
			model.addAttribute("resultData", tatStatisticsService.selectTatReportStatistics(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * tat 그리드 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/tatPop.lims")
	public String pretreatmentPop() {
		return "common/pop/tatPop";
	}
	
	/**
	 * tat 관리 상세내역  조회 - 시험완료예정일
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTatDetailList.lims")
	public ModelAndView selectTatDetailList(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", tatStatisticsService.selectTatDetailList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * tat 미완료사유  조회 - 시험완료예정일
	 * 
	 * @param HttpServletRequest
	 *            , Model, ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTatReason.lims")
	public ModelAndView selectTatReason(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", tatStatisticsService.selectTatReason(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * tat 관리 상세내역  조회 - 성적발행예정일
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTatReportDetailList.lims")
	public ModelAndView selectTatReportDetailList(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", tatStatisticsService.selectTatReportDetailList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * tat 미완료사유  조회 - 성적서발행예정일
	 * 
	 * @param HttpServletRequest
	 *            , Model, ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTatReportReason.lims")
	public ModelAndView selectTatReportReason(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", tatStatisticsService.selectTatReportReason(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}