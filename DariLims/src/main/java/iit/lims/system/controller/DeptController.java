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

import iit.lims.system.service.DeptService;
import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.UserVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * DeptController
 * @author 윤상준
 * @since 2015.08.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.08.24  윤상준   최초생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Controller
public class DeptController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private DeptService deptService;
	
	/**
	 * (연동)부서관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/dept.lims")
	public String dept(HttpServletRequest request, Model model, DeptVO deptVO) {
		return "system/dept/deptL01";
	}
	
	/**
	 * 부서관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deptManage.lims")
	public String deptManage(HttpServletRequest request, Model model, DeptVO deptVO) {
		return "system/dept/deptL02";
	}
	
	/**
	 *(연동) 공통부서 목록 조회
	 * 
	 * @param DeptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectDeptCmmnList.lims")
	public ModelAndView selectDeptCmmnList(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			List<DeptVO> deptList = deptService.selectDeptCmmnList(deptVO);
			model.addAttribute("resultData", deptList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * LIMS사용부서 목록 조회
	 * 
	 * @param DeptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectDeptLimsList.lims")
	public ModelAndView selectDeptLimsList(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			List<DeptVO> deptList = deptService.selectDeptLimsList(deptVO);
			model.addAttribute("resultData", deptList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * (연동)부서관리 확인 처리
	 * 
	 * @param DeptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveDeptLims.lims")
	public ModelAndView saveDeptLims(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			deptVO.setUser_id(userInfoVO.getUser_id());
			
			int result = deptService.saveDeptLims(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * (연동)부서관리 수정 처리
	 * 
	 * @param DeptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateDeptLims.lims")
	public ModelAndView updateDeptLims(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			deptVO.setUser_id(userInfoVO.getUser_id());
			
			int result = deptService.updateDeptLims(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 부서관리 상세 조회
	 * 
	 * @param MenuVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("system/selectDeptLimsDetail.lims")
	public String selectDeptLimsDetail(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			if (deptVO.getPageType() != null && "detail".equals(deptVO.getPageType())) {
				model.addAttribute("detail", deptService.selectDeptLimsDetail(deptVO));
			} else {
				model.addAttribute("detail", deptVO);
			}
			model.addAttribute("pageType",deptVO.getPageType());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/dept/deptD01";
	}
	
	/**
	 * 부서 등록
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertDeptInfo.lims")
	public ModelAndView insertDeptInfo(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			deptVO.setCreater_id(userInfoVO.getUser_id());
			
			int result = deptService.insertDeptInfo(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 부서정보 수정
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateDeptInfo.lims")
	public ModelAndView updateDeptInfo(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			deptVO.setUpdater_id(userInfoVO.getUser_id());
			
			int result = deptService.updateDeptInfo(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 부서 팀 목록 조회
	 * 
	 * @param DeptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectDeptTeamList.lims")
	public ModelAndView selectDeptTeamList(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			List<DeptVO> deptTeamList = deptService.selectDeptTeamList(deptVO);
			model.addAttribute("resultData", deptTeamList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 부서 팀 사용자 목록 조회
	 * 
	 * @param DeptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectDeptTeamUserList.lims")
	public ModelAndView selectDeptTeamUserList(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			List<DeptVO> deptTeamUserList = deptService.selectDeptTeamUserList(deptVO);
			model.addAttribute("resultData", deptTeamUserList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 팀 등록 팝업
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deptTeamPop.lims")
	public String deptTeamPop(HttpServletRequest request, Model model, DeptVO deptVO) {
		try {
			if (deptVO.getPageType() != null && "detail".equals(deptVO.getPageType())) {
				model.addAttribute("detail", deptService.selectDeptTeamDetail(deptVO));
				model.addAttribute("team_cd",deptVO.getTeam_cd());
			} else {
				model.addAttribute("detail", deptVO);
			}
			model.addAttribute("pageType",deptVO.getPageType());
			model.addAttribute("dept_cd",deptVO.getDept_cd());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/deptTeamPop";
	}
	
	
	/**
	 * 부서 팀 등록
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertDeptTeam.lims")
	public ModelAndView insertDeptTeam(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			
			System.out.println("@@@@"+deptVO.getDept_cd());
			int result = deptService.insertDeptTeam(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 팀정보 수정
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/updateDeptTeam.lims")
	public ModelAndView updateDeptTeam(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			deptVO.setUpdater_id(userInfoVO.getUser_id());
			
			int result = deptService.updateDeptTeam(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 팀정보 삭제
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteDeptTeam.lims")
	public ModelAndView deleteDeptTeam(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			int result = deptService.deleteDeptTeam(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 팀 사용자 등록
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/insertDeptTeamUser.lims")
	public ModelAndView insertDeptTeamUser(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			int result = deptService.insertDeptTeamUser(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 팀 사용자 삭제
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/deleteDeptTeamUser.lims")
	public ModelAndView deleteDeptTeamUser(HttpServletRequest request, 
			@ModelAttribute("deptVO") DeptVO deptVO, Model model) throws Exception {
		try{
			int result = deptService.deleteDeptTeamUser(deptVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(deptVO.toString(), e);
			throw e;
		}
	}
}
