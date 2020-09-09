package iit.lims.master.controller;

import java.util.HashMap;
import java.util.List;

import iit.lims.master.service.SampleGradeService;
import iit.lims.master.service.TestItemService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.SampleGradeVO;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.util.JsonView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@RequestMapping(value = "/master/")
@Controller
public class SampleGradeController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private SampleGradeService sampleGradeService;
	@Resource
	private TestItemService testItemService;
	
	/**
	 * 등급설정 페이지 전환 처리
	 * 
	 * @param SampleGradeVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("sampleGradeManage.lims")
	public String sampleGradeManage(HttpServletRequest request, Model model) {
		return "master/sampleGrade/sampleGradeL01";
	}
	
	/**
	 * 품목별 항목등급 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectSampleGradeList.lims")
	public ModelAndView selectSampleGradeList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) {
		System.out.println(param);
		try {
			model.addAttribute("resultData", sampleGradeService.selectSampleGradeList(param));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 항목추가 팝업 처리
	 * 
	 * @param TestPrdStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testSampleGradeChoice.lims")
	public String popSampleGradeManage(HttpServletRequest request, Model model, StdTestItemVO vo) {
		return "master/sampleGrade/sampleGradeP01";
	}
	
	/*
	 * 팝업 항목리스트
	 */
	@RequestMapping("/selectSampleGradePList.lims")
	public ModelAndView selectSampleGradePList(HttpServletRequest request, Model model, TestPrdStdVO vo, StdTestItemVO svo,
												SampleGradeVO sgvo) {
		try {
			List<SampleGradeVO> gridList = sampleGradeService.selectSampleGradePList(sgvo);
			//vo.setDept_cd(userInfoVO.getDept_cd());
			
			//SampleGradeVO returnVO = new SampleGradeVO();

			model.addAttribute("resultData", gridList);
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목 등급 등록
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertGrade.lims")
	public ModelAndView insertGrade(HttpServletRequest request, Model model, SampleGradeVO vo) throws Exception {
		try {
			/*UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemService.insertTestItem(vo));*/
			model.addAttribute("resultData", sampleGradeService.insertGrade(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/* 
	 * 항목 등급 삭제 deleteGrade
	*/
	@RequestMapping("/deleteSampleGradeTestItem.lims")
	public ModelAndView deleteSampleGradeTestItem(HttpServletRequest request, Model model, SampleGradeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", sampleGradeService.deleteSampleGradeTestItem(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 항목 등급 추가
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertGradeItem.lims")
	public ModelAndView insertGradeItem(HttpServletRequest request, Model model, SampleGradeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", sampleGradeService.insertGradeItem(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목 등급 저장
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateSampleMaxGrde.lims")
	public ModelAndView updateSampleMaxGrde(HttpServletRequest request, Model model, PrdLstVO vo) throws Exception {
		try {
			model.addAttribute("resultData", sampleGradeService.updateSampleMaxGrde(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목 등급 저장
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateGradeItem.lims")
	public ModelAndView updateGradeItem(HttpServletRequest request, Model model, SampleGradeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", sampleGradeService.updateGradeItem(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목 등급 저장
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/copyGradeItem.lims")
	public ModelAndView copyGradeItem(HttpServletRequest request, Model model, SampleGradeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", sampleGradeService.copyGradeItem(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 품목별 항목등급 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectSampleGradeListPop.lims")
	public ModelAndView selectSampleGradeListPop(HttpServletRequest request, Model model, SampleGradeVO vo) {
		try {
			model.addAttribute("resultData", sampleGradeService.selectSampleGradeListPop(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
}
