package iit.lims.accept.controller;

import iit.lims.accept.service.InstRentService;
import iit.lims.accept.vo.InstRentVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class InstRentController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private InstRentService instRentService;
	
	/**
	 * 장비대여접수 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/instRent.lims")
	public String instRent(HttpServletRequest request, Model model) {
		return "accept/instRent/instRentL01";
	}
	
	/**
	 * 장비대여접수 업체등록 팝업
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/instRentPop.lims")
	public String instRentPop(HttpServletRequest request, Model model, InstRentVO instRentVO) {
		
		request.setAttribute("pageType", request.getParameter("pageType"));
		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new InstRentVO());			
		} else {
			try {				
				model.addAttribute("detail", instRentService.selectInstRentDetail(instRentVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		return "common/pop/instRentPop";
	}
	
	/**
	 * 장비대여 업체 등록
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/insertInstRentOrg.lims")
	public ModelAndView insertInstRentOrg(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			instRentVO.setUser_id(userInfoVO.getUser_id());
			int result = instRentService.insertInstRentOrg(instRentVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 업체 수정
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/updateInstRentOrg.lims")
	public ModelAndView updateInstRentOrg(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			instRentVO.setUser_id(userInfoVO.getUser_id());
			int result = instRentService.updateInstRentOrg(instRentVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 업체 삭제 처리
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/deleteInstRent.lims")
	public ModelAndView deleteInstRent(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			instRentVO.setUser_id(userInfoVO.getUser_id());
			
			int result = instRentService.deleteInstRent(instRentVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여접수 업체 목록 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/selectInstRentList.lims")
	public ModelAndView selectInstRentList(HttpServletRequest request, Model model, InstRentVO instRentVO) {
		try {
			model.addAttribute("resultData", instRentService.selectInstRentList(instRentVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 장비대여접수 업체 상세 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/selectInstRentDetailList.lims")
	public ModelAndView selectInstRentDetailList(HttpServletRequest request, Model model, InstRentVO instRentVO) {
		try {
			model.addAttribute("resultData", instRentService.selectInstRentDetailList(instRentVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
		
	/**
	 * 장비대여 장비 저장
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/saveInstRent_inst.lims")
	public ModelAndView saveInstRent_inst(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			instRentVO.setUser_id(userInfoVO.getUser_id());
			int result = instRentService.saveInstRent_inst(instRentVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여접수 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/instRentChoicePop.lims")
	public String instChoice() {
		return "common/pop/instRentChoicePop";
	}
	
	/**
	 * 장비대여 사용결과 시료 저장
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/saveInstRent_sample.lims")
	public ModelAndView saveInstRent_sample(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			int result = instRentService.saveInstRent_sample(instRentVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 사용결과 시료목록 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/selectInstRent_sampleList.lims")
	public ModelAndView selectInstRent_sampleList(HttpServletRequest request, Model model, InstRentVO instRentVO) {
		try {
			model.addAttribute("resultData", instRentService.selectInstRent_sampleList(instRentVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 장비대여 사용결과 항목 등록
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/insertInstRent_item.lims")
	public ModelAndView insertInstRent_item(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			int result = instRentService.insertInstRent_item(instRentVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 사용결과 항목 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/selectInstRent_itemList.lims")
	public ModelAndView selectInstRent_itemList(HttpServletRequest request, Model model, InstRentVO instRentVO) {
		try {
			model.addAttribute("resultData", instRentService.selectInstRent_itemList(instRentVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 장비대여 시료 삭제 처리
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/deleteInstRent_sample.lims")
	public ModelAndView deleteInstRent_sample(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			int result = instRentService.deleteInstRent_sample(instRentVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 항목 삭제 처리
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/deleteInstRent_item.lims")
	public ModelAndView deleteInstRent_item(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			int result = instRentService.deleteInstRent_item(instRentVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 항목 비고 추가
	 * 
	 * @param InstRentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/saveSampleEtc.lims")
	public ModelAndView saveSampleEtc(HttpServletRequest request, @ModelAttribute("instRentVO") InstRentVO instRentVO, Model model) throws Exception {
		try {
			int result = instRentService.saveSampleEtc(instRentVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(instRentVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비대여 사용결과 항목 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/selectSampleEtc.lims")
	public ModelAndView selectSampleEtc(HttpServletRequest request, InstRentVO instRentVO, Model model) {
		try {
			model.addAttribute("resultData", instRentService.selectSampleEtc(instRentVO));			
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
}
