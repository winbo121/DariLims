package iit.lims.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.system.service.UserAuthService;
import iit.lims.system.vo.UserVO;
import iit.lims.util.JsonView;

/**
 * AuthController
 * 
 * @author 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
public class UseAuthController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private UserAuthService userAuthService;

	/**
	 * 부서관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/userAuth.lims")
	public String auth(HttpServletRequest request, Model model, UserVO userVO) {
		return "system/userAuth/userAuthL01";
	}

	/**
	 * 부서관리 상세정보 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectCmmnUserList.lims")
	public ModelAndView selectCmmnUserList(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			List<UserVO> authList = userAuthService.selectCmmnUserList(userVO);
			model.addAttribute("resultData", authList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 부서관리 상세정보 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAuthUserList.lims")
	public ModelAndView selectAuthUserList(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			List<UserVO> authList = userAuthService.selectAuthUserList(userVO);
			model.addAttribute("resultData", authList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 부서관리 저장/수정 처리
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertAuthUser.lims")
	public ModelAndView insertAuthMenu(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
		try {
			int result = userAuthService.insertAuthUser(userVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(userVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 부서관리 저장/수정 처리
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteAuthUser.lims")
	public ModelAndView deleteAuthMenu(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
		try {
			int result = userAuthService.deleteAuthUser(userVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(userVO.toString(), e);
			throw e;
		}
	}

}
