package iit.lims.analysis.controller;

import java.net.InetAddress;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.service.SamplePositionService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import javax.servlet.http.HttpServletRequest;

/**
 * SamplePosition
 * 
 * @author 허태원
 * @since 2020.05.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일			수정자		수정내용
 *  ---------- -------- ---------------------------
 *  2020.05.19	허태원		최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class SamplePositionController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private SamplePositionService samplePositionService;

	/**
	 * 검체위치 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/samplePosition.lims")
	public String samplePosition(HttpServletRequest request, Model model) {
		return "analysis/samplePosition/samplePositionL01";
	}

	/**
	 * 검체위치 검체 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSamplePositionSampleList.lims")
	public ModelAndView selectSamplePositionSampleList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", samplePositionService.selectSamplePositionSampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	
	
	/**
	 * 검체위치 이력 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSamplePositionHistoryList.lims")
	public ModelAndView selectSamplePositionHistoryList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", samplePositionService.selectSamplePositionHistoryList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	

	/**
	 * 검체위치 등록 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertSamplePosition.lims")
	public ModelAndView insertSamplePosition(HttpServletRequest request, @ModelAttribute("vo") ResultInputVO vo, Model model) throws Exception {
		InetAddress local; 
		try { 
			local = InetAddress.getLocalHost();
		    String ip = local.getHostAddress();		
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setIp_address(ip);
			model.addAttribute("resultData", samplePositionService.insertSamplePosition(vo));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 검체위치 수정 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateSamplePosition.lims")
	public ModelAndView updateSamplePosition(HttpServletRequest request, @ModelAttribute("vo") ResultInputVO vo, Model model) throws Exception {
		InetAddress local; 
		try { 
			local = InetAddress.getLocalHost();
		    String ip = local.getHostAddress();		
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setIp_address(ip);
			model.addAttribute("resultData", samplePositionService.updateSamplePosition(vo));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
}
