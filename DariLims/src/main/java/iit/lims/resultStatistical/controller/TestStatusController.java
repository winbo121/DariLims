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
import iit.lims.resultStatistical.vo.ResultStatisticalVO;
import iit.lims.resultStatistical.service.TestStatusService;
import iit.lims.util.JsonView;

/**
 * TestStatusController
 * 
 * @author 최은향
 * @since 2015.10.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.22           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/resultStatistical/")
@Controller
public class TestStatusController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private TestStatusService testStatusService;
	@Resource
	private CommonService commonService;

	/**
	 * 항목별 통계 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/testStatusManage.lims")
	public String testStatus(HttpServletRequest request, Model model) {
		return "resultStatistical/testStatus/testStatusL01";
	}

	/**
	 * 항목별 통계 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestStatus.lims")
	public ModelAndView selectTestStatus(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", testStatusService.selectTestStatus(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}