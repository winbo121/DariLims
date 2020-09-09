package iit.lims.accept.controller;

import iit.lims.accept.service.CounselService;
import iit.lims.accept.vo.CounselVO;
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
public class CounselController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private CounselService counselService;
	
	/**
	 * 상담관리 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/counsel.lims")
	public String counsel(HttpServletRequest request, Model model) {
		return "accept/counsel/counselL01";
	}
	
	/**
	 * 통합상담리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectCounselTotalList.lims")
	public ModelAndView selectCounselTotalList(HttpServletRequest request, Model model, CounselVO counselVO) {
		try {
			model.addAttribute("resultData", counselService.selectCounselTotalList(counselVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 개별상담리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectCounselPersonalList.lims")
	public ModelAndView counselPersonalList(HttpServletRequest request, Model model, CounselVO counselVO) {
		try {
			model.addAttribute("resultData", counselService.selectCounselPersonalList(counselVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 통합상담리스트 팝업
	 * 
	 * @param HttpServletRequest
	 *            , Model, CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectCounselTotalDetail.lims")
	public String selectCounselTotalPop(HttpServletRequest request, CounselVO counselVO, Model model) {	

		request.setAttribute("pageType", request.getParameter("pageType"));
		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new CounselVO());			
		} else {
			try {				
				counselVO.setTotal_no(request.getParameter("totalNo"));
				model.addAttribute("detail", counselService.selectCounselTotalDetail(counselVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		
		return "common/pop/counselTotalPop";
	}
	
	/**
	 * 개별상담리스트 팝업
	 * 
	 * @param HttpServletRequest
	 *            , Model, CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectCounselPersonalDetail.lims")
	public String selectCounselPersonalDetail(HttpServletRequest request, CounselVO counselVO, Model model) {
		
		request.setAttribute("pageType", request.getParameter("pageType"));
		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new CounselVO());
			request.setAttribute("totalNo", request.getParameter("totalNo"));
		} else {
			try {				
				counselVO.setTotal_no(request.getParameter("totalNo"));
				counselVO.setPersonal_no(request.getParameter("personalNo"));
				model.addAttribute("detail", counselService.selectCounselPersonalDetail(counselVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		return "common/pop/counselPersonalPop";
	}
	
	/**
	 * 통합상담 등록 처리
	 * 
	 * @param CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/insertCounselTotal.lims")
	public ModelAndView insertCounselTotal(HttpServletRequest request, @ModelAttribute("counselVO") CounselVO counselVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			counselVO.setUser_id(userInfoVO.getUser_id());
			counselVO.setDept_cd(userInfoVO.getDept_cd());
			
			int result = counselService.insertCounselTotal(counselVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(counselVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 개별상담 등록 처리
	 * 
	 * @param CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/insertCounselPersonal.lims")
	public ModelAndView insertCounselPersonal(HttpServletRequest request, @ModelAttribute("counselVO") CounselVO counselVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			counselVO.setUser_id(userInfoVO.getUser_id());
			
			int result = counselService.insertCounselPersonal(counselVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(counselVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 통합상담 수정 처리
	 * 
	 * @param CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/updateCounselTotal.lims")
	public ModelAndView updateCounselTotal(HttpServletRequest request, @ModelAttribute("counselVO") CounselVO counselVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			counselVO.setUser_id(userInfoVO.getUser_id());
			
			int result = counselService.updateCounselTotal(counselVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(counselVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 개별상담 수정 처리
	 * 
	 * @param CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/updateCounselPersonal.lims")
	public ModelAndView updateCounselPersonal(HttpServletRequest request, @ModelAttribute("counselVO") CounselVO counselVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			counselVO.setUser_id(userInfoVO.getUser_id());
			
			int result = counselService.updateCounselPersonal(counselVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(counselVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 통합상담 삭제 처리
	 * 
	 * @param CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/deleteCounselTotal.lims")
	public ModelAndView deleteCounselTotal(HttpServletRequest request, @ModelAttribute("counselVO") CounselVO counselVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			counselVO.setUser_id(userInfoVO.getUser_id());
			
			int result = counselService.deleteCounselTotal(counselVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(counselVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 개별상담 삭제 처리
	 * 
	 * @param CounselVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/deleteCounselPersonal.lims")
	public ModelAndView deleteCounselPersonal(HttpServletRequest request, @ModelAttribute("counselVO") CounselVO counselVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			counselVO.setUser_id(userInfoVO.getUser_id());
			
			int result = counselService.deleteCounselPersonal(counselVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(counselVO.toString(), e);
			throw e;
		}
	}
	
}
