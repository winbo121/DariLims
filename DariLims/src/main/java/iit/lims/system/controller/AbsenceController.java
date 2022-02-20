package iit.lims.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.system.service.AbsenceService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.UserVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * AbsenceController
 * 
 * @author 진영민
 * @since 2015.06.11
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.11  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
public class AbsenceController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private AbsenceService absenceService;

	/**
	 * 사용자관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/absenceManage.lims")
	public String absenceManage(HttpServletRequest request, Model model, UserVO userVO) {
		return "system/absence/absenceL01";
	}

	/**
	 * 부재자 목록 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAbsenceList.lims")
	public ModelAndView selectAbsenceList(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			model.addAttribute("resultData", absenceService.selectAbsenceList(userVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 부재자 상세정보 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAbsenceDetail.lims")
	public String selectAbsenceDetail(HttpServletRequest request, Model model, UserVO vo) throws Exception {
		try {
			if (vo != null && "detail".equals(vo.getPageType())) {
				model.addAttribute("detail", absenceService.selectAbsenceDetail(vo));
			} else {
				UserInfoVO userInfoVO = SessionCheck.getSession(request);
				UserVO userVO = new UserVO();
				userVO.setUser_id(userInfoVO.getUser_id());
				userVO.setDept_nm(userInfoVO.getDept_nm());
				userVO.setUser_nm(userInfoVO.getUser_nm());
				model.addAttribute("detail", userVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/absence/absenceD01";
	}

	/**
	 * 부재자 저장
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveAbsence.lims")
	public ModelAndView saveAbsence(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
		try {
			model.addAttribute("resultData", absenceService.saveAbsence(userVO));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(userVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 부재자 삭제
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteAbsence.lims")
	public ModelAndView deleteAbsence(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
		try {
			model.addAttribute("resultData", absenceService.deleteAbsence(userVO));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(userVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 부재자 상세정보 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAbsenceUserList.lims")
	public ModelAndView selectAbsenceUserList(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			model.addAttribute("resultData", absenceService.selectAbsenceUserList(userVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}