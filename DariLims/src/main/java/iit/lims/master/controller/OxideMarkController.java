package iit.lims.master.controller;

import iit.lims.common.service.CommonService;
import iit.lims.master.service.OxideMarkService;
import iit.lims.master.vo.OxideMarkVO;
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
 * OxideMarkController
 * @author 한지연
 * @since 2020.01.14
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.01.14  한지연   최초 생성
 * </pre>
 *
 * Copyright (C) 2020 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class OxideMarkController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private OxideMarkService OxideMarkService;
	@Resource
	private CommonService commonService;
	
	/**
	 * 산화물표기 등록 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("oxideMarkManage.lims")
	public String testMethodManage(HttpServletRequest request, Model model) {
		return "master/oxideMark/oxideMarkL01";
	}

	/**
	 * 산화물표기 목록 조회
	 * 
	 * @param OxideMarkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectOxideMarkList.lims")
	public ModelAndView selectOxideMarkList(HttpServletRequest request, Model model, OxideMarkVO vo) throws Exception {
		try {
			model.addAttribute("resultData", OxideMarkService.selectOxideMarkList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 산화물표기 상세정보 조회 / 신규 페이지 열기
	 * 
	 * @param OxideMarkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectOxideMarkListDetail.lims")
	public String selectOxideMarkListDetail(HttpServletRequest request, Model model, OxideMarkVO vo) {
		try {
			model.addAttribute("detail", OxideMarkService.selectOxideMarkListDetail(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return "master/oxideMark/oxideMarkD01";  
	}
	
	/**
	 * 산화물표기 신규등록
	 * 
	 * @param OxideMarkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertOxideMark.lims")
	public ModelAndView insertOxideMark(HttpServletRequest request, Model model, OxideMarkVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", OxideMarkService.insertOxideMark(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView()); 
	} 
	
	/**
	 * 산화물표기 수정
	 * 
	 * @param OxideMarkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateOxideMark.lims")
	public ModelAndView updateOxideMark(HttpServletRequest request, Model model, OxideMarkVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", OxideMarkService.updateOxideMark(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView()); 
	}	

}
