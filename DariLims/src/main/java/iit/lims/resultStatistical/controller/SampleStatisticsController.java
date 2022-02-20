package iit.lims.resultStatistical.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.resultStatistical.service.SampleStatisticsService;
import iit.lims.util.JsonView;

/**
 * SampleStatisticsController
 * 
 * @author 최은향
 * @since 2015.06.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.17           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/resultStatistical/")
@Controller
public class SampleStatisticsController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private SampleStatisticsService sampleStatisticsService;
	@Resource
	private CommonService commonService;

	/**
	 * 시료별 통계 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sampleStatistics.lims")
	public String sampleStatistics(HttpServletRequest request, Model model) {
		return "resultStatistical/sampleStatistics/sampleStatisticsL01";
	}

	/**
	 * 시료별 통계 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSampleStatistics.lims")
	public ModelAndView selectSampleStatistics(HttpServletRequest request, Model model, MakeGridVO vo) {
		try {
			model.addAttribute("resultData", sampleStatisticsService.selectSampleStatistics(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
}