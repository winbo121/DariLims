package iit.lims.kolas.contoller;

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
import iit.lims.kolas.service.EduAttendService;
import iit.lims.kolas.vo.EduAttendVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;

/**
 * EduAttendController
 * @author 석은주
 * @since 2015.01.28
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.28  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/kolas/")
@Controller
public class EduAttendController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private EduAttendService eduAttendService;
	@Resource
	private CommonService commonService;
	
	
	/**
	 * 교육결과 등록 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("eduAttendManage.lims")
	public String eduAttendManage(HttpServletRequest request, Model model) {
		return "kolas/eduAttend/eduAttendL01";
	}
	
	/**
	 * 교육결과 등록 교육참석자 목록 페이지 열기
	 * 
	 * @param StdTestItemVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("eduAttendList.lims")
	public String eduAttendList(HttpServletRequest request, Model model, EduAttendVO vo) {
		try {
			model.addAttribute("detail", vo);
		} catch (Exception e) {
		}
		return "kolas/eduAttend/eduAttendL02";
	}
	
	/**
	 * 교육참석자 목록 조회
	 * 
	 * @param EduAttendVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectEduAttendList.lims")
	public ModelAndView selectEduAttendList(HttpServletRequest request, Model model, EduAttendVO vo) throws Exception {
		try {
			model.addAttribute("resultData", eduAttendService.selectEduAttendList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}   
	
	/**
	 * 교육참석자 목록 저장
	 * 
	 * @param EduAttendVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertEduAttend.lims")
	public ModelAndView insertEduAttend(HttpServletRequest request, 
			@ModelAttribute("vo") EduAttendVO vo, Model model) throws Exception {
		try {
			model.addAttribute("resultData", eduAttendService.insertEduAttend(vo));
			return new ModelAndView(new JsonView());
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}
	
	/**
	 * 교육결과 첨부파일 등록 팝업 보기
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popEduAttendFileUpload.lims")
	public String popEduAttendFileUpload(HttpServletRequest request, Model model, EduAttendVO vo) throws Exception {
		try {
			EduAttendVO s = eduAttendService.selectEduAttendDetail(vo);
			model.addAttribute("detail", s);
			//System.out.println(s.getDept_nm() + "확인용");
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return "common/pop/eduAttendPop";
	}
	
	/**
	 * 교육결과 팝업 첨부파일 업데이트
	 * 
	 * @param EduAttendVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateEduAttend.lims")
	public ModelAndView updateEduAttend(HttpServletRequest request, 
			@ModelAttribute("vo") EduAttendVO vo, Model model) throws Exception {
		try {
			model.addAttribute("resultData", eduAttendService.updateEduAttend(vo));
			return new ModelAndView(new JsonView());
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}  
	
	/**
	 * 교육결과 팝업 첨부파일 다운로드
	 * 
	 * @param EduAttendVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("eduAttendFileDown.lims")
	public ModelAndView eduAttendFileDown(HttpServletRequest request, EduAttendVO vo, Model model) throws Exception {
		try {
			EduAttendVO edu = eduAttendService.eduAttendFileDown(vo);	
			if(edu != null) {
			model.addAttribute("data", edu.getAtt_file());
			model.addAttribute("fileName", edu.getFile_nm());
			}			
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
}
