package iit.lims.analysis.controller;

import iit.lims.analysis.service.TestReportService;
import iit.lims.analysis.vo.TestReportVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * ResultCheckController
 * 
 * @author 윤상준
 * @since 2015.02.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.17  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class TestReportController {

	static final Logger log = LogManager.getLogger();
	
	@Resource
	private TestReportService testReportService;
	
	/**
	 * 사용일지 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testReport.lims")
	public String testReport(HttpServletRequest request, Model model) {
		model.addAttribute("pageType", "item");
		return "analysis/testReport/testReportL01";
	}
	
	/**
	 * 시료 목록 조회
	 * 
	 * @param TestReportVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReportSampleList.lims")
	public ModelAndView selectTestReportSampleList(HttpServletRequest request, Model model, TestReportVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			
			model.addAttribute("resultData", testReportService.selectTestReportSampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목 목록 조회
	 * 
	 * @param TestReportVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReportItemList.lims")
	public ModelAndView selectTestReportItemList(HttpServletRequest request, Model model, TestReportVO vo) {
		try {
			model.addAttribute("resultData", testReportService.selectTestReportItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시료 상세 데이터 조회
	 * 
	 * @param TestReportVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReportSampleDetail.lims")
	public ModelAndView selectTestReportSampleDetail(HttpServletRequest request, Model model, TestReportVO vo) {
		try {
			model.addAttribute("resultData", testReportService.selectTestReportSampleDetail(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험일지 작성
	 * 
	 * @param TestReportVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveTestReport.lims")
	public ModelAndView saveTestReport(HttpServletRequest request, Model model, TestReportVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testReportService.saveTestReport(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험일지 불러오기
	 * 
	 * @param TestReportVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReport.lims")
	public ModelAndView selectTestReport(HttpServletRequest request, Model model, TestReportVO vo) {
		try {
			model.addAttribute("resultData", testReportService.selectTestReport(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
}
