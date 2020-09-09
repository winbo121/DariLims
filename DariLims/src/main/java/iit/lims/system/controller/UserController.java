package iit.lims.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.service.CommonService;
import iit.lims.system.service.UserService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.UserVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * UserController
 * @author 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Controller
public class UserController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private UserService userService;
	
	@Resource
	private CommonService commonService;

	
	/**
	 * 사용자관리(연동) 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/user.lims")
	public String user(HttpServletRequest request, Model model, UserVO userVO) {
		return "system/user/userL01";
	}
	
	/**
	 * 사용자관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/userManage.lims")
	public String userManage(HttpServletRequest request, Model model, UserVO userVO) {
		return "system/user/userL02";
	}
	
	/**
	 * 사용자관리 목록 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectUserCmmnList.lims")
	public ModelAndView selectUserCmmnList(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			List<UserVO> userList = userService.selectUserCmmnList(userVO);
			model.addAttribute("resultData", userList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 사용자관리 목록 조회
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectUserLimsList.lims")
	public ModelAndView selectUserLimsList(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			List<UserVO> userList = userService.selectUserLimsList(userVO);
			model.addAttribute("resultData", userList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	
	/**
	 * 사용자관리 상세 조회
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("system/selectUserLimsDetail.lims")
	public String selectUserLimsDetail(HttpServletRequest request, Model model, UserVO userVO) throws Exception {
		try {
			if (userVO.getPageType() != null && "detail".equals(userVO.getPageType())) {
				
				BASE64Decoder decoder = new BASE64Decoder();				
				userVO = userService.selectUserLimsDetail(userVO);				
				userVO.setUser_pw(new String(decoder.decodeBuffer(userVO.getUser_pw()))); // 비밀번호 Base64로 디코딩
				//System.out.println("디코딩후:" + userVO.getUser_pw());
				
				model.addAttribute("detail", userVO);
			} else {
				model.addAttribute("detail", userVO);
			}
			model.addAttribute("pageType",userVO.getPageType());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/user/userD01";
	}
	
	/**
	 * 사용자관리 저장/수정 처리
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveUserLims.lims")
	public ModelAndView saveUserLims(HttpServletRequest request, 
			@ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			userVO.setUser_id(userInfoVO.getUser_id());
			
			int result = userService.saveUserLims(userVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(userVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 사용자 등록
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertUserInfo.lims")
	public ModelAndView insertUserInfo(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
		try{
			userVO.setReport_class_code(userVO.getReport_class_code().replaceAll(",", "|"));
			BASE64Encoder encoder = new BASE64Encoder();			
			
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			userVO.setUser_pw(encoder.encode(userVO.getUser_pw().getBytes())); // 비밀번호 Base64로 인코딩			
			userVO.setCreater_id(userInfoVO.getUser_id());
			
			
			int result = userService.insertUserInfo(userVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(userVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 사용자정보 수정
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateUserInfo.lims")
	public ModelAndView updateUserInfo(HttpServletRequest request, 
			@ModelAttribute("userVO") UserVO userVO, Model model) throws Exception {
			userVO.setReport_class_code(userVO.getReport_class_code().replaceAll(",", "|"));
		try{
			BASE64Encoder encoder = new BASE64Encoder();
			//userVO.setUser_pw(URLDecoder.decode(userVO.getUser_pw(), "UTF-8"));
			//System.out.println("user_pw:"+userVO.getUser_pw());
			//System.out.println("user_nm:"+userVO.getUser_nm());
			
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			userVO.setUser_pw(encoder.encode(userVO.getUser_pw().getBytes())); // 비밀번호 Base64로 인코딩
			userVO.setUpdater_id(userInfoVO.getUser_id());	
			
			int result = userService.updateUserInfo(userVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(userVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * (연동)사용자수정
	 * 
	 * @param UserVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateUserFlag.lims")
	public ModelAndView updateUserFlag(HttpServletRequest request, Model model, UserVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setCreater_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", userService.updateUserFlag(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 사용자 팝업 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/userChoice.lims")
	public String userChoice(HttpServletRequest request) {
		request.setAttribute("team_cd", request.getParameter("team_cd"));
		return "common/pop/userInfo";
	}
	
	/**
	 * 팀 팝업 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/teamChoice.lims")
	public String teamChoice(HttpServletRequest request) {
		return "common/pop/teamChoicePop";
	}
	
	/**
	 * 2019-09-20 정언구
	 * 사용자 사인 등록 팝업
	 */
	@RequestMapping("/system/popUserSign.lims")
	public String popUserSign(HttpServletRequest request, Model model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", request.getParameter("userId"));
		model.addAttribute("detail", map);
		return "common/pop/userSign";
	}
	
	@RequestMapping("/system/putUserSignFile.lims")
	public ModelAndView putUserSignFile(HttpServletRequest request, Model model, UserVO vo) throws Exception {
		userService.putSignFile(vo);
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("/system/deleteUserSignFile.lims")
	public ModelAndView deleteSignFile(HttpServletRequest request, Model model, UserVO vo) throws Exception {
		userService.deleteSignFile(vo);
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 결과입력 >  성적서 첨부파일 다운로드
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/downloadSignFile.lims")
	public ModelAndView	downloadSignFile(HttpServletResponse response, Model model, UserVO param) throws Exception {
		UserVO vo = userService.selectUserLimsDetail(param);
		System.out.println("@@@@@@@@@@@###");
		System.out.println(vo.getByte_file().length);
		System.out.println(vo.getFile_name());
		model.addAttribute("data", vo.getByte_file());
		model.addAttribute("fileName", vo.getFile_name());
		return new ModelAndView(new ByteDownloadView());
	}
	
}
