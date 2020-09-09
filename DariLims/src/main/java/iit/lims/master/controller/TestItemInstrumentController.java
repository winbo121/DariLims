package iit.lims.master.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.service.TestItemInstrumentService;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestItemInstrumentController
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class TestItemInstrumentController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private TestItemInstrumentService testItemInstrumentService;
	@Resource
	private CommonService commonService;
	
	/**
	 * 항목별 시험기기 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testItemInstrumentManage.lims")
	public String testItemInstrumentManage(HttpServletRequest request, Model model, CommonCodeVO vo) {		
		try {
		} catch (Exception e) {
		}
		return "master/testItemInstrument/testItemInstrumentL01";
	}
	
	/**
	 * 항목별 시험기기 리스트 페이지 열기
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testItemInstrumentList.lims")
	public String testItemInstrumentList(HttpServletRequest request, Model model, MachineVO vo) {
		try {
			vo.setTest_std_no(request.getParameter("test_std_no"));
			model.addAttribute("detail", vo);
		} catch (Exception e) {
		}
		return "master/testItemInstrument/testItemInstrumentL02";
	}
	
	/**
	 * 항목별 시험기기 시험항목 목록 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
/*	@RequestMapping("/selectTestItemInstList.lims")
	public ModelAndView selectTestItemInstList(HttpServletRequest request, Model model, TestItemVO vo) {
		try {
			model.addAttribute("resultData", testItemService.selectTestItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}*/
	
	/**
	 * 항목별 시험기기 장비 목록 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestItemInstList.lims")
	public ModelAndView selectTestItemInstList(HttpServletRequest request, Model model, MachineVO vo) throws Exception {
		try {
			vo.setTest_std_no(request.getParameter("test_std_no"));
			model.addAttribute("resultData", testItemInstrumentService.selectTestItemInstList(vo));			
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목별 시험기기 기기목록 저장 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertTestItemInst.lims")
	public ModelAndView insertTestItemInst(HttpServletRequest request, 
			@ModelAttribute("vo") MachineVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			
			vo.setTest_std_no(request.getParameter("test_std_no"));
			
			model.addAttribute("resultData", testItemInstrumentService.insertTestItemInst(vo));
			return new ModelAndView(new JsonView());
			
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
}
