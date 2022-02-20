package iit.lims.report.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.report.service.PaperWriteService;
import iit.lims.report.vo.PaperVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * PaperWriteController
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/report/")
public class PaperWriteController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private PaperWriteService paperWriteService;

	/**
	 * 보고서 작성 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/paperWrite.lims")
	public String paperWrite(HttpServletRequest request, Model model) {
		return "report/paperWrite/paperWriteL01";
	}

	/**
	 * 보고서 작성 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPaperList.lims")
	public ModelAndView selectPaperList(HttpServletRequest request, Model model, PaperVO vo) {
		try {
			model.addAttribute("resultData", paperWriteService.selectPaperList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 보고서 작성 상세 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPaperDetail.lims")
	public String selectPaperDetail(HttpServletRequest request, Model model, PaperVO vo) {
		try {
			if (vo.getPageType() != null && "detail".equals(vo.getPageType())) {
				model.addAttribute("detail", paperWriteService.selectPaperDetail(vo));
			} else {
				model.addAttribute("detail", new PaperVO());
			}
		} catch (Exception e) {
		}
		return "report/paperWrite/paperWriteD01";
	}

	/**
	 * 보고서 작성 상세 저장
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/savePaperDetail.lims")
	public ModelAndView savePaperDetail(HttpServletRequest request, Model model, PaperVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", paperWriteService.savePaperDetail(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 보고서 작성 삭제
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deletePaperDetail.lims")
	public ModelAndView deletePaperDetail(HttpServletRequest request, Model model, PaperVO vo) {
		try {
			model.addAttribute("resultData", paperWriteService.deletePaperDetail(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

}