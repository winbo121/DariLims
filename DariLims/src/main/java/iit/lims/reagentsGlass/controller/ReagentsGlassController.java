package iit.lims.reagentsGlass.controller;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.common.service.CommonService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.reagentsGlass.service.ReagentsGlassService;
import iit.lims.reagentsGlass.vo.ReagentsGlassVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;

/**
 * BuyingRequestController
 * 
 * @author 석은주
 * @since 2015.02.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.16  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/reagents/")
@Controller
public class ReagentsGlassController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private ReagentsGlassService buyingRequestService;
	@Resource
	private CommonService commonService;

	/**
	 * 시약/실험기구 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassInfoManage.lims")
	public String reagentsGlassInfoManage(HttpServletRequest request, Model model) {
		return "reagentsGlass/reagentsGlassInfo/reagentsGlassInfoL01";
	}

	/**
	 * 시약/실험기구 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassInfo.lims")
	public ModelAndView sampleInsert(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) {
		try {
			model.addAttribute("resultData", buyingRequestService.reagentsGlassInfo(reagentsGlassVO));
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassInfoD01.lims")
	public String reagentsGlassInfoDetail(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) {
		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new ReagentsGlassVO());
		} else {
			try {
				model.addAttribute("detail", buyingRequestService.reagentsGlassInfoDetail(request, reagentsGlassVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "reagentsGlass/reagentsGlassInfo/reagentsGlassInfoD01";
	}

	/**
	 * 시약/실험기구 저장 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertReagentsGlassInfo.lims")
	public ModelAndView insertReagentsGlassInfo(HttpServletRequest request, @ModelAttribute("reagentsGlassVO") ReagentsGlassVO reagentsGlassVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			reagentsGlassVO.setUser_id(userInfoVO.getUser_id()); // 로그인 ID
			reagentsGlassVO.setCreate_dept(userInfoVO.getDept_cd()); // 로그인 부서
			//reagentsGlassVO.setMaster_yn("Y"); // 마스터
			int result = buyingRequestService.insertReagentsGlassInfo(reagentsGlassVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 시약/실험기구 수정 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateReagentsGlassInfo.lims")
	public ModelAndView updateReagentsGlassInfo(HttpServletRequest request, @ModelAttribute("reagentsGlassVO") ReagentsGlassVO reagentsGlassVO, Model model) throws Exception {
		try {
			//reagentsGlassVO.setMaster_yn("Y"); // 마스터
			int result = buyingRequestService.updateReagentsGlassInfo(reagentsGlassVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 구매정보 등록 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingInfoManage.lims")
	public String buyingInfoManage(HttpServletRequest request, Model model) throws Exception {
		return "reagentsGlass/buyingInfo/buyingInfoL01";
	}

	/**
	 * 구매정보 등록 상세정보 조회 / 신규 페이지 열기
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectBuyingInfoDetail.lims")
	public String selectBuyingInfoDetail(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			ReagentsGlassVO r_vo = buyingRequestService.selectBuyingInfoDetail(vo);
			model.addAttribute("detail", r_vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "reagentsGlass/buyingInfo/buyingInfoD01";
	}

	/**
	 * 구매정보 신규 등록 처리
	 * 
	 * @param reagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertBuyingInfo.lims")
	public ModelAndView insertBuyingInfo(HttpServletRequest request, @ModelAttribute("vo") ReagentsGlassVO vo, Model model) throws Exception {
		try {
			int result = buyingRequestService.insertBuyingInfo(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 구매정보 수정 처리
	 * 
	 * @param reagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateBuyingInfo.lims")
	public ModelAndView updateBuyingInfo(HttpServletRequest request, @ModelAttribute("vo") ReagentsGlassVO vo, Model model) throws Exception {
		try {
			int result = buyingRequestService.updateBuyingInfo(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 구매정보 삭제 처리
	 * 
	 * @param reagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteBuyingInfo.lims")
	public ModelAndView deleteBuyingInfo(HttpServletRequest request, @ModelAttribute("vo") ReagentsGlassVO vo, Model model) throws Exception {
		try {
			int result = buyingRequestService.deleteBuyingInfo(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 구매요청 등록 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingRequestManage.lims")
	public String buyingRequestManage(HttpServletRequest request, Model model) {
		return "reagentsGlass/buyingRequest/buyingRequestL01";
	}

	/**
	 * 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectBuyingInfoList.lims")
	public ModelAndView selectBuyingInfoList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("resultData", buyingRequestService.selectBuyingInfoList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매요청 등록 디테일 페이지 열기
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingRequestList.lims")
	public String buyingRequestList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("detail", vo);
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return "reagentsGlass/buyingRequest/buyingRequestD01";
	}

	/**
	 * 구매요청 등록 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectBuyingRequestList.lims")
	public ModelAndView selectBuyingRequestList(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			model.addAttribute("resultData", buyingRequestService.selectBuyingRequestList(reagentsGlassVO));
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매요청 목록 저장 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertBuyingRequestList.lims")
	public ModelAndView insertBuyingRequestList(HttpServletRequest request, @ModelAttribute("vo") ReagentsGlassVO vo, Model model) throws Exception {
		try {
			int result = buyingRequestService.insertBuyingRequestList(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 시약/실험기구정보 팝업 열기
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popReagentsInfo.lims")
	public String popReagentsInfo(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		return "common/pop/buyingRequestPop";
	}

	/**
	 * 시약/실험기구 등록(일반사용자) 팝업 열기
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popReagentsInsert.lims")
	public String popReagentsInsert(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		return "common/pop/buyingNeedTargetPop";
	}

	/**
	 * 시약/실험기구정보 팝업 목록 조회(마스터만)
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popReagentsGlassInfoList.lims")
	public ModelAndView popReagentsGlassInfoList(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			//reagentsGlassVO.setMaster_yn("Y");
			model.addAttribute("resultData", buyingRequestService.popReagentsGlassInfoList(reagentsGlassVO));
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매확정 - 시약/실험기구정보(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("popBuyingConfirmationManage.lims")
	public String popBuyingConfirmationManage(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) {
		return "common/pop/buyingConfirmationPop";
	}

	/**
	 * 시약/실험기구정보 수불 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassInOutManage.lims")
	public String reagentsGlassInOutManage(HttpServletRequest request, Model model) {
		try {
		} catch (Exception e) {
			log.error(e);
		}
		return "reagentsGlass/reagentsGlassInOut/reagentsGlassInOutL01";
	}

	/**
	 * 시약/실험기구정보 수불 리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReagentsGlassInOutList.lims")
	public ModelAndView selectReagentsGlassInOutList(HttpServletRequest request, Model model, ReagentsGlassVO vo) {
		try {
			model.addAttribute("resultData", buyingRequestService.selectReagentsGlassInOutList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구정보 수불 디테일 페이지 열기
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassInOutDetail.lims")
	public String reagentsGlassInOutDetail(HttpServletRequest request, Model model, ReagentsGlassVO vo) {
		try {
			model.addAttribute("detail", vo);
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return "reagentsGlass/reagentsGlassInOut/reagentsGlassInOutD01";
	}

	/**
	 * 시약/실험기구정보 수불 디테일 리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReagentsGlassInOutDetail.lims")
	public ModelAndView selectReagentsGlassInOutDetail(HttpServletRequest request, Model model, ReagentsGlassVO vo) {
		try {
			model.addAttribute("resultData", buyingRequestService.selectReagentsGlassInOutDetail(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시약/실험기구정보 수불 디테일 수정
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateReagentsGlassInOutDetail.lims")
	public ModelAndView updateReagentsGlassInOutDetail(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {			
			model.addAttribute("resultData", buyingRequestService.updateReagentsGlassInOutDetail(vo));				
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 구시약/실험기구정보 수불 (부서별 신규 등록 팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("popNewReagentsGlassInout.lims")
	public String popNewReagentsGlassInout(HttpServletRequest request, Model model, ReagentsGlassVO vo) {
		return "common/pop/reagentsGlassInOutPop";
	}

	/**
	 * 시약/실험기구정보 수불 등록(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertReagentsGlassInOut.lims")
	public ModelAndView insertReagentsGlassInOut(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id()); // 로그인 ID
			model.addAttribute("resultData", buyingRequestService.insertReagentsGlassInOut(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구정보 수불 수정(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateReagentsGlassInOut.lims")
	public ModelAndView updateReagentsGlassInOut(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id()); // 로그인 ID
			model.addAttribute("resultData", buyingRequestService.updateReagentsGlassInOut(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구정보 수불(결재) 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("receivePayPaymentManage.lims")
	public String receivePayPaymentManage(HttpServletRequest request, Model model) {
		return "reagentsGlass/receivePayPayment/receivePayPaymentL01";
	}

	/**
	 * 시약/실험기구정보 수불(결재) 리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("receivePayPaymentList.lims")
	public ModelAndView receivePayPaymentList(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			reagentsGlassVO.setCreate_dept(userInfoVO.getDept_cd()); // 로그인 부서

			model.addAttribute("resultData", buyingRequestService.receivePayPaymentList(reagentsGlassVO));
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매정보 수정 처리(승인 & 미승인)
	 * 
	 * @param reagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateReceivePayPayment.lims")
	public ModelAndView updateReceivePayPayment(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			model.addAttribute("resultData", buyingRequestService.updateReceivePayPayment(reagentsGlassVO));
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구정보 수불현황 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassStateManage.lims")
	public String reagentsGlassStateManage(HttpServletRequest request, Model model) throws Exception {
		try {
		} catch (Exception e) {
		}
		return "reagentsGlass/reagentsGlassState/reagentsGlassStateL01";
	}

	/**
	 * 시약/실험기구정보 수불현황 리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReagentsGlassStateList.lims")
	public ModelAndView selectReagentsGlassStateList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("resultData", buyingRequestService.selectReagentsGlassStateList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구정보 수불현황 상세보기 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassStateDetail.lims")
	public String reagentsGlassStateDetail(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("detail", vo);
		} catch (Exception e) {
		}
		return "reagentsGlass/reagentsGlassState/reagentsGlassStateD01";
	}

	/**
	 * 구매품목현황 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingProductStateManage.lims")
	public String buyingProductStateListManage(HttpServletRequest request, Model model) throws Exception {
		try {
			//UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			//model.addAttribute("userDeptCd", userInfoVO.getDept_cd());
		} catch (Exception e) {
		}
		return "reagentsGlass/buyingProductState/buyingProductStateL01";
	}

	/**
	 * 구매품목현황 리스트 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingProductStateList.lims")
	public ModelAndView buyingProductStateList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("resultData", buyingRequestService.buyingProductStateList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구 팝업 저장 처리(일반사용자)
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertPopReagentsGlassInfo.lims")
	public ModelAndView insertPopReagentsGlassInfo(HttpServletRequest request, @ModelAttribute("vo") ReagentsGlassVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setCreate_dept(userInfoVO.getDept_cd()); // 로그인 부서
			vo.setUser_id(userInfoVO.getUser_id()); // 로그인 ID

			String max_mtlr_no = buyingRequestService.insertPopReagentsGlassInfo(vo);
			model.addAttribute("resultData", max_mtlr_no);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 시약/실험기구 팝업 수정 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updatePopReagentsGlassInfo.lims")
	public ModelAndView updatePopReagentsGlassInfo(HttpServletRequest request, @ModelAttribute("vo") ReagentsGlassVO vo, Model model) throws Exception {
		try {
			vo.setMtlr_no(request.getParameter("mtlr_no"));
			vo.setMtlr_req_no(request.getParameter("mtlr_req_no"));
			vo.setModify_flag(request.getParameter("modify_flag"));
			//int max_mtlr_no = buyingRequestService.updatePopReagentsGlassInfo(vo);
			model.addAttribute("resultData", buyingRequestService.updatePopReagentsGlassInfo(vo));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 구매검수 등록 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingConfirmManage.lims")
	public String buyingConfirmManage(HttpServletRequest request, Model model) {
		return "reagentsGlass/buyingConfirm/buyingConfirmL01";
	}

	/**
	 * 구매검수 등록 디테일 페이지 열기
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("buyingConfirmList.lims")
	public String buyingConfirmList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("detail", vo);
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return "reagentsGlass/buyingConfirm/buyingConfirmD01";
	}

	/**
	 * 구매검수 등록 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectBuyingConfirmList.lims")
	public ModelAndView selectBuyingConfirmList(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			model.addAttribute("resultData", buyingRequestService.selectBuyingConfirmList(reagentsGlassVO));
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매검수 검수확정(= 수불 테이블에 등록)
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("saveConfirm.lims")
	public ModelAndView saveConfirm(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			reagentsGlassVO.setUser_id(userInfoVO.getUser_id()); // 로그인 ID
			model.addAttribute("resultData", buyingRequestService.saveConfirm(reagentsGlassVO));
		} catch (Exception e) {
			log.error(reagentsGlassVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시약/실험기구 등록(일반) -> 마스터로 변경 팝업 열기
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popMasterList.lims")
	public String popMasterList(HttpServletRequest request, Model model, ReagentsGlassVO reagentsGlassVO) throws Exception {
		return "reagentsGlass/buyingConfirmation/buyingConfirmationP03";
	}
	
	/**
	 * MSDS 이미지 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reagentsGlassImage.lims")
	public void reagentsGlassImage(HttpServletRequest request, HttpServletResponse response, ReagentsGlassVO vo, Model model) throws Exception {
		ServletOutputStream out = null;
		try {
			response.setContentType("/image/jpg");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Cache-Control", "no-cache");

			byte[] fileBin = (byte[]) buyingRequestService.reagentsGlassImage(vo);

			if (fileBin != null && fileBin.length > 0) {
				out = response.getOutputStream();
				out.write(fileBin);
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	
	/**
	 * MSDS 이미지 다운로드
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reagentsGlassImageDown.lims")
	public ModelAndView reagentsGlassImageDown(HttpServletResponse response, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			ReagentsGlassVO r = buyingRequestService.reagentsGlassImageDown(vo);
			if (r != null) {
				model.addAttribute("data", r.getAdd_file());
				model.addAttribute("fileName", r.getImg_file_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
}
