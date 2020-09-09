package iit.lims.reagentsGlass.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.reagentsGlass.service.PurchaseConfirmService;
import iit.lims.reagentsGlass.service.ReagentsGlassService;
import iit.lims.reagentsGlass.vo.ReagentsGlassVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;

/**
 * PurchaseConfirmController
 * 
 * @author 진영민
 * @since 2015.06.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.16  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/reagents/")
@Controller
public class PurchaseConfirmController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private PurchaseConfirmService purchaseConfirmService;
	@Resource
	private ReagentsGlassService buyingRequestService;

	/**
	 * 구매 확정 승인 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("purchaseConfirmManage.lims")
	public String purchaseConfirm(HttpServletRequest request, Model model) {
		return "reagentsGlass/purchaseConfirm/purchaseConfirmL01";
	}

	/**
	 * 구매 확정 승인 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("purchaseInfoList.lims")
	public ModelAndView purchaseInfoList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("resultData", purchaseConfirmService.purchaseInfoList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매 확정 승인 구매요청 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("purchaseReqList.lims")
	public ModelAndView purchaseReqList(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("resultData", purchaseConfirmService.purchaseReqList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매 확정 승인 구매확정 목록 저장
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("savePurchaseConfirm.lims")
	public ModelAndView savePurchaseConfirm(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id()); // 로그인 ID
			vo.setCreate_dept(userInfoVO.getDept_cd()); // 로그인 부서

			vo.setMtlr_mst_no(request.getParameter("mtlr_mst_no"));
			model.addAttribute("resultData", purchaseConfirmService.savePurchaseConfirm(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매 확정
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("purchaseConfirm.lims")
	public ModelAndView purchaseConfirm(HttpServletRequest request, Model model, ReagentsGlassVO vo) throws Exception {
		try {
			model.addAttribute("resultData", purchaseConfirmService.purchaseConfirm(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 구매확정 - 시약/실험기구정보 수정(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("popUpdatePurchaseConfirm.lims")
	public String popUpdatePurchaseConfirm(HttpServletRequest request, Model model, ReagentsGlassVO vo) {
		try {
			model.addAttribute("detail", buyingRequestService.reagentsGlassInfoDetail(request, vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/purchaseConfirmPop";
	}

	/**
	 * 구매확정 - 엑셀다운
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return String
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("excelDownloadPurchaseConfirm.lims")
	public void excelDownloadPurchaseConfirm(HttpServletRequest request, HttpServletResponse response, Model model, ReagentsGlassVO vo) {
		ServletOutputStream servletOutputStream = null;
		try {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=excel.xls");

			Workbook wb = purchaseConfirmService.excelDownloadPurchaseConfirm(vo);
			servletOutputStream = response.getOutputStream();
			wb.write(servletOutputStream);
			servletOutputStream.flush();
			//servletOutputStream.close();
		} catch (Exception e) {
		} finally {
			try {
				servletOutputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 구매확정 - 시약/실험기구정보 수정(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return String
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("excelUploadPurchaseConfirm.lims")
	public ModelAndView excelUploadPurchaseConfirm(HttpServletRequest request, HttpServletResponse response, Model model, ReagentsGlassVO vo) {
		try {
			model.addAttribute("resultData", purchaseConfirmService.excelUploadPurchaseConfirm(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
}
