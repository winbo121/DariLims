package iit.lims.accept.controller;

import iit.lims.accept.service.ChargerManageService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.service.ResultInputSampleService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChargerManageController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private ChargerManageService chargerManageService;
	
	/**
	 * 시험담당자변경 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("/accept/chargerManage.lims")
	public String chargerManage(HttpServletRequest request, Model model) {
		return "accept/chargerManage/chargerManageL01";
	}
	
	/**
	 * 시험담당자변경 접수목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectChargerManageReqList.lims")
	public ModelAndView selectChargerManageReqList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setCommission_flag(request.getParameter("commission_flag"));
			model.addAttribute("resultData", chargerManageService.selectChargerManageReqList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험담당자변경 시료 정보 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectChargerManageSampleDetail.lims")
	public ModelAndView selectChargerManageSampleDetail(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", chargerManageService.selectChargerManageSampleDetail(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험담당자변경 항목 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept/selectChargerManageItemList.lims")
	public ModelAndView selectChargerManageItemList(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", chargerManageService.selectChargerManageItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}
