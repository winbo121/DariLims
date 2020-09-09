package iit.lims.master.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.master.service.TestMethodService;
import iit.lims.master.vo.TestMethodVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestMethodController
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
public class TestMethodController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private TestMethodService testMethodService;
	@Resource
	private CommonService commonService;
	
	/**
	 * 시험방법 등록 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testMethodManage.lims")
	public String testMethodManage(HttpServletRequest request, Model model) {
		return "master/testMethod/testMethodL01";
	}

	/**
	 * 시험방법 목록 조회
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestMethodList.lims")
	public ModelAndView selectTestMethodList(HttpServletRequest request, Model model, TestMethodVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testMethodService.selectTestMethodList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시험방법 상세정보 조회 / 신규 페이지 열기
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestMethodDetail.lims")
	public String selectTestMethodDetail(HttpServletRequest request, Model model, TestMethodVO vo) {
		try {
			model.addAttribute("detail", testMethodService.selectTestMethodDetail(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return "master/testMethod/testMethodD01";  
	}
	
	/**
	 * 시험방법 신규등록
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertTestMethod.lims")
	public ModelAndView insertTestMethod(HttpServletRequest request, Model model, TestMethodVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testMethodService.insertTestMethod(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView()); 
	} 
	
	/**
	 * 시험방법 수정
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateTestMethod.lims")
	public ModelAndView updateTestMethod(HttpServletRequest request, Model model, TestMethodVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testMethodService.updateTestMethod(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView()); 
	}

	/**
	 * 시험방법 첨부파일 다운로드
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testMethodDown.lims")
	public ModelAndView testMethodDown(HttpServletResponse response, Model model, TestMethodVO vo) throws Exception {
		try {
			TestMethodVO t = testMethodService.testMethodDown(vo);
		
			if (t != null) {
				model.addAttribute("data", t.getAtt_file());
				model.addAttribute("fileName", t.getFile_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}	

}
