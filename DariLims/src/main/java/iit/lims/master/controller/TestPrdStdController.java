package iit.lims.master.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.common.service.CommonService;
import iit.lims.master.service.TestPrdStdService;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestPrdStdController
 * @author 최은향
 * @since 2015.12.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.22  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class TestPrdStdController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private TestPrdStdService testPrdStdService;
	@Resource
	private CommonService commonService;

	/**
	 * 프로토콜 페이지 전환 처리
	 * 
	 * @param TestPrdStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("testPrdStdRevManage.lims")
	public String testPrdStdRevManage(HttpServletRequest request, Model model) {
		return "master/testPrdStd/testStdRevL01";
	}

	/**
	 * 프로토콜 품목 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStdTestPrdList.lims")
	public ModelAndView selectStdTestPrdList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) {
		try {
			model.addAttribute("resultData", testPrdStdService.selectStdTestPrdList(param));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	
	
	/**
	 * 프로토콜 시험항목 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStdTestPrdItemList.lims")
	public ModelAndView selectStdTestPrdItemList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) {
		try {
			model.addAttribute("resultData", testPrdStdService.selectStdTestPrdItemList(param));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	

	/**
	 * 프로토콜 시험항목 저장
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("insertStdPrdTestItem.lims")
	public ModelAndView insertStdPrdTestItem(HttpServletRequest request, 
			@ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			int result = testPrdStdService.insertStdTestPrdItem(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 프로토콜 시험항목 복사
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("copyStdTestPrdItem.lims")
	public ModelAndView copyStdTestPrdItem(HttpServletRequest request, @ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			int result = testPrdStdService.copyStdTestPrdItem(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 검사기준복사저장
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("saveCopySpec.lims")
	public ModelAndView saveCopySpec(HttpServletRequest request, 
			@ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			int result = testPrdStdService.saveCopySpec(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 불러오기 팝업 처리
	 * 
	 * @param TestPrdStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testPrdlstChoice.lims")
	public String testPrdlstChoice(HttpServletRequest request, Model model, StdTestItemVO vo) {
		return "master/testPrdStd/prdlstP01";
	}
	
	/**
	 * 시험항목선택 팝업 처리
	 * 
	 * @param TestPrdStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testPrdStdItemChoice.lims")
	public String popStdTestPrdItemManage(HttpServletRequest request, Model model, StdTestItemVO vo) {
		return "master/testPrdStd/testStdRevP01";
	}
	
	/**
	 * 기준등록 > 항목 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/prdItemChoice.lims")
	public String prdItemChoice() {
		return "common/pop/prdItemChoicePop";
	}
	
	/**
	 * 기준등록 > 품목 리스트 조회 팝업
	 * 
	 * @param TestPrdStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopAllPrdList.lims")
	public ModelAndView selectPopAllPrdList(HttpServletRequest request, Model model, TestPrdStdVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testPrdStdService.selectPopAllPrdList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 기준등록 > 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopAllTestPrdItemList.lims")
	public ModelAndView selectPopAllTestPrdItemList(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", testPrdStdService.selectPopAllTestPrdItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 접수 > 항목 리스트 멀티 추가(항목 선택 팝업)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertTestStdPrdItem.lims")
	public ModelAndView insertTestStdPrdItem(HttpServletRequest request, Model model, TestPrdStdVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());

			model.addAttribute("resultData", testPrdStdService.insertTestStdPrdItemPop(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	

	@RequestMapping("selectfnprtItemList.lims")
	public ModelAndView selectfnprtItemList(HttpServletRequest request, Model model, TestPrdStdVO vo, StdTestItemVO svo) {
		try {
			model.addAttribute("resultData", testPrdStdService.selectfnprtItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
}
