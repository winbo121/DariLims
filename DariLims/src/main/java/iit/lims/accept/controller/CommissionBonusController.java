package iit.lims.accept.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.service.CommissionBonusService;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * CommissionBonusController
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
public class CommissionBonusController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private CommissionBonusService commissionBonusService;
	
	/**
	 * 수수료성과급 조회
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commissionBonus.lims")
	public String unpaidSales(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		return "accept/commissionBonus/commissionBonusL01";
	}

	@RequestMapping("/commissionBonusMaster.lims")
	public String unpaidSalesMaster(HttpServletRequest request, Model model) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		return "accept/commissionBonus/commissionBonusL02";
	}

	/**
	 * 수수료성과급 조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectBonusList.lims")
	public ModelAndView selectBonusSalesList(Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionBonusService.selectBonusSalesList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}


}
