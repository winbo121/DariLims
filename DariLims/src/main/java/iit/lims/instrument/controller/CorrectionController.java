package iit.lims.instrument.controller;

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
import iit.lims.instrument.service.CorrectionService;
import iit.lims.instrument.vo.CorrectionVO;
import iit.lims.master.service.UnitWorkService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

@Controller
public class CorrectionController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private CorrectionService correctionService;
	@Resource
	private UnitWorkService unitWorkService;
	@Resource
	private CommonService commonService;

	/**
	 * 교정 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/correctionManage.lims")
	public String correctionManage(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		model.addAttribute("admin_user", userInfoVO.getUser_nm());
		model.addAttribute("pageType", request.getParameter("pageType"));
		model.addAttribute("cntType", request.getParameter("cntType"));
		return "instrument/correction/correctionL01";
	}

	/**
	 * 교정 목록 조회
	 * 
	 * @param HttpServletRequest, Model, CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/correction.lims")
	public ModelAndView correction(HttpServletRequest request, Model model, CorrectionVO correctionVO) {
		try {
			model.addAttribute("resultData", correctionService.selectCorrectionList(correctionVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 교정 상세정보 조회
	 * 
	 * @param HttpServletRequest, Model, CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/correctionD01.lims")
	public String correctionDetail(HttpServletRequest request, Model model, CorrectionVO correctionVO) {
		if(request.getParameter("pageType").equals("insert")){
			CorrectionVO vo = correctionService.correctionMng(correctionVO);
			model.addAttribute("detail", vo);
		}else{
			try {
				model.addAttribute("detail", correctionService.correctionDetail(correctionVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "instrument/correction/correctionD01";
	}
	
	/**
	 * 교정 저장 처리
	 * 
	 * @param CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/insertCorrection.lims")
	public ModelAndView insertCorrection(HttpServletRequest request, 
			@ModelAttribute("correctionVO") CorrectionVO correctionVO, Model model) throws Exception {
		try{
			int result = correctionService.insertCorrection(correctionVO);
			System.out.println(result);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
			
		}catch(Exception e){
			log.error(correctionVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 교정 수정 처리
	 * 
	 * @param CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/updateCorrection.lims")
	public ModelAndView updateCorrection(HttpServletRequest request, 
			@ModelAttribute("correctionVO") CorrectionVO correctionVO, Model model) throws Exception {
		try{
			int result = correctionService.updateCorrection(correctionVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(correctionVO.toString(), e);
			throw e;
		}
	}	
	
	/**
	 * 교정 삭제 처리
	 * 
	 * @param CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteCorrection.lims")
	public ModelAndView deleteCorrection(HttpServletRequest request, 
			@ModelAttribute("correctionVO") CorrectionVO correctionVO, Model model) throws Exception {
		try{
			int result = correctionService.deleteCorrection(correctionVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(correctionVO.toString(), e);
			throw e;
		}
	}	
	
	/**
	 * 중간점검 목록 조회
	 * 
	 * @param HttpServletRequest, Model, CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/correction2.lims")
	
	public ModelAndView correction2(HttpServletRequest request, Model model, CorrectionVO correctionVO) {
		try {
			model.addAttribute("resultData", correctionService.selectCorrectionList2(correctionVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 교정 상세정보 조회
	 * 
	 * @param HttpServletRequest, Model, CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/correctionD02.lims")
	public String correctionDetail2(HttpServletRequest request, Model model, CorrectionVO correctionVO) {
		if(request.getParameter("pageType").equals("insert")){
			CorrectionVO vo = correctionService.correctionMng(correctionVO);
			model.addAttribute("detail", vo);
		}else{
			try {
				model.addAttribute("detail", correctionService.correctionDetail2(correctionVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "instrument/correction/correctionD02";
	}
	
	/**
	 * 교정 저장 처리
	 * 
	 * @param CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/insertCorrection2.lims")
	public ModelAndView insertCorrection2(HttpServletRequest request, 
			@ModelAttribute("correctionVO") CorrectionVO correctionVO, Model model) throws Exception {
		try{
			int result = correctionService.insertCorrection2(correctionVO);
			System.out.println(result);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
			
		}catch(Exception e){
			log.error(correctionVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 교정 수정 처리
	 * 
	 * @param CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/updateCorrection2.lims")
	public ModelAndView updateCorrection2(HttpServletRequest request, 
			@ModelAttribute("correctionVO") CorrectionVO correctionVO, Model model) throws Exception {
		try{
			int result = correctionService.updateCorrection2(correctionVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(correctionVO.toString(), e);
			throw e;
		}
	}	
	
	/**
	 * 교정 삭제 처리
	 * 
	 * @param CorrectionVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteCorrection2.lims")
	public ModelAndView deleteCorrection2(HttpServletRequest request, 
			@ModelAttribute("correctionVO") CorrectionVO correctionVO, Model model) throws Exception {
		try{
			int result = correctionService.deleteCorrection2(correctionVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(correctionVO.toString(), e);
			throw e;
		}
	}	
}
