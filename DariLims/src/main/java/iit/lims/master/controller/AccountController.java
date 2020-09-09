package iit.lims.master.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.EstimateVO;
import iit.lims.common.service.CommonService;
import iit.lims.master.service.AccountService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * AccountController
 * 
 * @author 최은향
 * @since 2015.09.18
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.18  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class AccountController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private AccountService AccountService;
	@Resource
	private CommonService commonService;

	/**
	 * 계산식 관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("accountManage.lims")
	public String menu(HttpServletRequest request, Model model, CommonCodeVO vo) {
		return "master/account/accountL01";
	}

	/**
	 * 계산식 관리 목록 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAccountList.lims")
	public ModelAndView selectAccountList(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			model.addAttribute("resultData", AccountService.selectAccountList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 계산식관리 상세 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAccountDetail.lims")
	public String selectAccountDetail(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			if (vo.getPageType() != null && "detail".equals(vo.getPageType())) {
				model.addAttribute("detail", AccountService.selectAccountDetail(vo));
			} else {
				model.addAttribute("detail", new AccountVO());
			}
			model.addAttribute("pageType", request.getParameter("pageType"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/account/accountD01";
	}
	
	/**
	 * 계산식관리 적용
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAccountApply.lims")
	public String selectAccountApply(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			model.addAttribute("detail", AccountService.selectAccountDetail(vo));
			model.addAttribute("pageType", request.getParameter("pageType"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/account/accountD02";
	}
	
	/**
	 * 계산식관리 상세 리스트 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAccountDetailList.lims")
	public ModelAndView selectAccountDetailList(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			if (vo.getPageType() != null && "detail".equals(vo.getPageType())) {		
				model.addAttribute("resultData", AccountService.selectAccountDetailList(vo));
			} else {
				model.addAttribute("resultData", new AccountVO());
			}
			model.addAttribute("pageType", request.getParameter("pageType"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 계산식적용 리스트 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAccountApplyList.lims")
	public ModelAndView selectAccountApplyList(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			model.addAttribute("resultData", AccountService.selectAccountApplyList(vo));
			model.addAttribute("pageType", request.getParameter("pageType"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 계산식확인
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("checkAccount.lims")
	public ModelAndView checkAccount(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			String result;
			System.out.println("시험방법번호 : "+vo.getTest_method_no());
			result = AccountService.checkAccount(vo);
			
			System.out.println("조회결과 : "+result);
			model.addAttribute("resultData", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 계산식관리 저장 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertAccount.lims")
	public ModelAndView insertAccount(HttpServletRequest request, @ModelAttribute("vo") AccountVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = AccountService.insertAccount(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 계산식관리 수정 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateAccount.lims")
	public ModelAndView updateAccount(HttpServletRequest request, @ModelAttribute("vo") AccountVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = AccountService.updateAccount(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 계산식관리 삭제 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteAccount.lims")
	public ModelAndView deleteAccount(HttpServletRequest request, @ModelAttribute("vo") AccountVO vo, Model model) throws Exception {
		try {
			int result = AccountService.deleteAccount(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 계산식관리 삭제 처리
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteAccountDetail.lims")
	public ModelAndView deleteAccountDetail(HttpServletRequest request, @ModelAttribute("vo") AccountVO vo, Model model) throws Exception {
		try {
			int result = AccountService.deleteAccountDetail(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 계산식 팝업 목록 조회
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectAccountPopList.lims")
	public ModelAndView selectAccountPopList(HttpServletRequest request, Model model, AccountVO vo) throws Exception {
		try {
			//model.addAttribute("resultData", AccountService.selectAccountPopList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 세부계산식 저장
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveAccountDetail.lims")
	public ModelAndView saveAccountDetail(HttpServletRequest request, 
			@ModelAttribute("accountVO") AccountVO accountVO, Model model) throws Exception {
		try {
			
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			accountVO.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", AccountService.saveAccountDetail(accountVO));
		} catch (Throwable e) {
			log.error(accountVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 세부계산식적용값 저장
	 * 
	 * @param AccountVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveAccountApply.lims")
	public ModelAndView saveAccountApply(HttpServletRequest request, 
			@ModelAttribute("accountVO") AccountVO accountVO, Model model) throws Exception {
		try {
			
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			accountVO.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", AccountService.saveAccountApply(accountVO));
		} catch (Throwable e) {
			log.error(accountVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 견적 항목 리스트
	 */
	@RequestMapping("/selectTestItemPop.lims")
	public String selectTestItemPop(HttpServletRequest request, Model model, EstimateVO estimateVO) {
		return "common/pop/selectTestItemPop";
	}
	
	/**
	 * 계산식 관리 > 항목 선택 팝업 > 조회
	 * 
	 */
	@RequestMapping("/selectMasterList.lims")
	public ModelAndView selectMasterList(Model model, TestItemVO param) {
		try {
			model.addAttribute("resultData", AccountService.selectMasterList(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

}
