package iit.lims.accept.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.service.CommissionUnpaidService;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * CommissionUnpaidController
 * 
 * @author 김상하
 * @since 2016.05.12
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/accept/")
public class CommissionUnpaidController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private CommissionUnpaidService commissionUnpaidService;
	
	/**
	 * 수수료미납업체 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commissionUnpaidSales.lims")
	public String unpaidSales(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		return "accept/commissionUnpaid/commissionUnpaidL01";
	}

	@RequestMapping("/commissionUnpaidTest.lims")
	public String unpaidTest(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		return "accept/commissionUnpaid/commissionUnpaidL02";
	}
	
	@RequestMapping("/commissionUnpaidSalesMaster.lims")
	public String unpaidSalesMaster(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		return "accept/commissionUnpaid/commissionUnpaidL03";
	}

	/**
	 * 수수료미납업체 조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectUnpaidSalesList.lims")
	public ModelAndView selectUnpaidSalesList(Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionUnpaidService.selectUnpaidSalesList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/selectUnpaidTestList.lims")
	public ModelAndView selectUnpaidTestList(Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionUnpaidService.selectUnpaidTestList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	/**
	 * 수수료미납업체 상세조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectUnpaidSalesDetailList.lims")
	public ModelAndView selectUnpaidSalesDetailList(Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionUnpaidService.selectUnpaidSalesDetailList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}


	@RequestMapping("/selectUnpaidTestDetailList.lims")
	public ModelAndView selectUnpaidTestDetailList(Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionUnpaidService.selectUnpaidTestDetailList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}
