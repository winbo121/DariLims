package iit.lims.kolas.contoller;

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

import iit.lims.common.service.CommonService;
import iit.lims.kolas.service.EduCurriculumService;
import iit.lims.kolas.vo.EduAttendVO;
import iit.lims.kolas.vo.EduResultVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * EduCurriculumController
 * @author 석은주
 * @since 2015.01.26
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.26  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/kolas/")
@Controller
public class EduCurriculumController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private EduCurriculumService eduCurriculumService;
	@Resource
	private CommonService commonService;
	
	/**
	 * 교육과정 등록 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("eduCurrManage.lims")
	public String eduCurrManage(HttpServletRequest request, Model model) {
		return "kolas/eduCurriculum/eduCurriculumL01";
	}

	/**
	 * 교육과정 목록 조회
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectEduCurrList.lims")
	public ModelAndView selectEduCurrList(HttpServletRequest request, Model model, EduResultVO vo) throws Exception {
		try {
			model.addAttribute("resultData", eduCurriculumService.selectEduCurrList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 교육과정 등록 상세정보 조회
	 * 
	 * @param EduResultVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectEduCurriculumDetail.lims")
	public String selectEduCurriculumDetail(HttpServletRequest request, Model model, EduResultVO vo) throws Exception {
		if(request.getParameter("pageType").equals("detail")){
			try {
				model.addAttribute("detail", eduCurriculumService.selectEduCurriculumDetail(vo));
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				model.addAttribute("detail", new EduResultVO());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "kolas/eduCurriculum/eduCurriculumD01";
	}
	
	/**
	 * 교육과정 등록 저장 처리
	 * 
	 * @param EduResultVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertEduCurriculum.lims")
	public ModelAndView insertEduCurriculum(HttpServletRequest request, 
			@ModelAttribute("vo") EduResultVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = eduCurriculumService.insertEduCurriculum(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
			
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 교육과정 등록 수정 처리
	 * 
	 * @param EduResultVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateEduCurriculum.lims")
	public ModelAndView updateEduCurriculum(HttpServletRequest request, 
			@ModelAttribute("vo") EduResultVO vo, Model model) throws Exception {
		try{
			int result = eduCurriculumService.updateEduCurriculum(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
			
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 교육과정 등록 삭제 처리
	 * 
	 * @param EduResultVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteEduCurriculum.lims")
	public ModelAndView deleteEduCurriculum(HttpServletRequest request, 
			@ModelAttribute("vo") EduResultVO vo, Model model) throws Exception {
		try{
			int result = eduCurriculumService.deleteEduCurriculum(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
			
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 교육참석자 목록 팝업 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popEduAttendInfo.lims")
	public String popEduAttendInfo(HttpServletRequest request, Model model, EduResultVO vo) throws Exception {
		model.addAttribute("key", vo.getKey());
		return "common/pop/eduAttendInfoPop";
	}
	
	/**
	 * 교육참석자 팝업 참석자 목록 조회
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectEduAttendInfoList.lims")
	public ModelAndView selectEduAttendInfoList(HttpServletRequest request, Model model, EduAttendVO vo) throws Exception {
		try {
			model.addAttribute("resultData", eduCurriculumService.selectEduAttendInfoList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}	
	/**
	 * 교육과정 등록 첨부파일 다운로드
	 * 
	 * @param EduAttendVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("eduCurriculumDown.lims")
	public ModelAndView eduCurriculumDown(HttpServletResponse response, Model model, EduResultVO vo) throws Exception {
		try {
			EduResultVO t = eduCurriculumService.eduCurriculumDown(vo);
		
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
