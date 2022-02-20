package iit.lims.accept.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.popbill.api.IssueResponse;
import com.popbill.api.PopbillException;
import com.popbill.api.TaxinvoiceService;
import com.popbill.api.taxinvoice.Taxinvoice;
import com.popbill.api.taxinvoice.TaxinvoiceAddContact;
import com.popbill.api.taxinvoice.TaxinvoiceDetail;

import iit.lims.accept.service.CommissionCheckService;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.accept.vo.CommissionTaxInvoiceVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import iit.lims.util.tax.service.CommissionTaxinvoiceService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * CommissionCheckController
 * 
 * @author 허태원
 * @since 2015.10.02
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
public class CommissionCheckController {
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private CommissionCheckService commissionCheckService;
	
	@Resource
	CommissionTaxinvoiceService commissionTaxinvoiceService;
	
	/**
	 * 수수료입금확인 > 수수료입금확인 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commissionCheck.lims")
	public String sampleChoice() {
		return "accept/commissionCheck/commissionCheckL01";
	}
	
	/**
	 * 수수료입금확인 > 업체 목록 조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectCommissionCheckList.lims")
	public ModelAndView selectCommissionCheckList(Model model, CommissionCheckVO vo) throws Exception {
		System.out.println(vo.getPageNum());
		try {
			List<CommissionCheckVO> gridList = commissionCheckService.selectCommissionCheckList(vo);
			CommissionCheckVO returnVO = new CommissionCheckVO();
			if(gridList.size() > 0){
				returnVO.setRows(gridList);
				ReqOrgVO total = (CommissionCheckVO)gridList.get(0);
				returnVO.setTotalCount(total.getTotalCount());
				returnVO.setPageNum(total.getPageNum());
				returnVO.setTotalPage(total.getTotalPage());
				returnVO.setTotal(total.getTotalCount());
			}
			model.addAttribute("resultData", returnVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 수수료입금확인 > 업체 상세 목록 조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectCommissionDetailList.lims")
	public ModelAndView selectCommissionDetailList(Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionCheckService.selectCommissionDetailList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 수수료입금확인 > 입금 처리
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveCommissionDeposit.lims")
	public ModelAndView saveCommissionDeposit(HttpServletRequest request, 
			@ModelAttribute("vo") CommissionCheckVO vo, Model model) throws Exception{
		try {
			int result = commissionCheckService.saveCommissionDeposit(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 세금계산서 발행내역 조회
	 * 
	 * @param
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/commissionTaxInvoice.lims")
	public String taxInvoice() {
		return "accept/commissionCheck/commissionCheckL02";
	}

	/**
	 * 세금계산서 발행내역 조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTaxInvoiceList.lims")
	public ModelAndView selectTaxInvoiceList(Model model, CommissionCheckVO vo) throws Exception {
		System.out.println(vo);
		try {
			model.addAttribute("resultData", commissionCheckService.selectTaxInvoiceList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 전자세금계산서 발행
	 * 
	 * @param HashMap
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commissionTaxInvoiceRegistIssue.lims")
	public ModelAndView commissionTaxInvoiceRegistIssue(HttpServletRequest request, Model model, CommissionTaxInvoiceVO vo) {
		try {
			model.addAttribute("resultData",commissionTaxinvoiceService.registIssue(vo));
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 세금계산서 발행 팝업
	 * 
	 * @param
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/commissionTaxInvoicePop.lims")
	public String commissionTaxInvoicePop() {
		return "common/pop/commissionTaxInvoicePop";
	}
	
	
	/**
	 * 세금계산서 발행이력 조회
	 * 
	 * @param CommissionCheckVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTaxInvoiceHisList.lims")
	public ModelAndView selectTaxInvoiceHisList(Model model, CommissionTaxInvoiceVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commissionCheckService.selectTaxInvoiceHisList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}
