package iit.lims.accept.controller;

import iit.lims.accept.service.EstimateService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.EstimateVO;
import iit.lims.common.service.CommonService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.service.SampleService;
import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import java.net.URLDecoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * AstimateController
 * 
 * @author 윤상준
 * @since 2015.09.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.10  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/accept/")
public class EstimateController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private EstimateService estimateService;
	@Resource
	private SampleService sampleService;
	@Resource
	private CommonService commonService;
	
	
	/**
	 * 접수 > 견적관리 
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estimate.lims")
	public String estimate() {
		return "accept/estimate/estimateL01";
	}
	
	
	/**
	 * 접수 > 견적관리 
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estimateDetail.lims")
	public String estimateDetail(HttpServletRequest request, Model model, EstimateVO estimateVO) {
		model.addAttribute("detail", estimateVO);
		return "accept/estimate/estimateL02";
	}
	
	/**
	 * 접수 > 견적 리스트
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectEstimateList.lims")
	public ModelAndView selectEstimateList(HttpServletRequest request, Model model, EstimateVO estimateVO) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			model.addAttribute("resultData", estimateService.selectEstimateList(estimateVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 견적 항목 리스트
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectEstimateItemList.lims")
	public ModelAndView selectEstimateItemList(HttpServletRequest request, Model model, EstimateVO estimateVO) throws Exception {
		try {
			model.addAttribute("resultData", estimateService.selectEstimateItemList(estimateVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 접수 > 견적 항목 수수료 리스트
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectEstimateItemFeeList.lims")
	public ModelAndView selectEstimateItemFeeList(HttpServletRequest request, Model model, EstimateVO estimateVO) throws Exception {
		try {
			model.addAttribute("resultData", estimateService.selectEstimateItemFeeList(estimateVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 견적 등록 팝업
	 * 
	 * @param EstimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estimatePop.lims")
	public String estimatePop(HttpServletRequest request, Model model, EstimateVO estimateVO) {
		try {
			if (estimateVO.getPageType() != null && "detail".equals(estimateVO.getPageType())) {
				model.addAttribute("detail", estimateService.selectEstimateDetail(estimateVO));
			} else {				
				//estimateVO.setEst_org_nm(URLDecoder.decode(estimateVO.getEst_org_nm(), "UTF-8"));
				model.addAttribute("detail", estimateVO);
			}
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setCreater_id(userInfoVO.getUser_id());
			model.addAttribute("user_id", userInfoVO.getUser_id());
			model.addAttribute("user_nm", userInfoVO.getUser_nm());
			model.addAttribute("dept_nm", userInfoVO.getDept_nm());
			model.addAttribute("pageType",estimateVO.getPageType());
			//model.addAttribute("est_org_no",estimateVO.getEst_org_no());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/estimatePop";
	}
	
	
	/**
	 * 견적 항목등록 팝업
	 * 
	 * @param EstimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estimateItemPop.lims")
	public String estimateItemPop(HttpServletRequest request, Model model, EstimateVO estimateVO) {
		try {
			if (estimateVO.getPageType() != null && "detail".equals(estimateVO.getPageType())) {
				model.addAttribute("detail", estimateService.selectEstimateDetail(estimateVO));
			} else {
				
				estimateVO.setEst_org_nm(URLDecoder.decode(estimateVO.getEst_org_nm(), "UTF-8"));
				model.addAttribute("detail", estimateVO);
			}
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setCreater_id(userInfoVO.getUser_id());
			model.addAttribute("user_id", userInfoVO.getUser_id());
			model.addAttribute("user_nm", userInfoVO.getUser_nm());
			model.addAttribute("dept_nm", userInfoVO.getDept_nm());
			model.addAttribute("pageType",estimateVO.getPageType());
			model.addAttribute("est_org_no",estimateVO.getEst_org_no());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/estimatePop";
	}
	
	/**
	 * 견적 등록
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertEstimate.lims")
	public ModelAndView insertEstimate(HttpServletRequest request, 
			@ModelAttribute("estimateVO") EstimateVO estimateVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setCreater_id(userInfoVO.getUser_id());
			estimateVO.setDept_cd(userInfoVO.getDept_cd());
			int result = estimateService.insertEstimate(estimateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(estimateVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 견적정보 수정
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateEstimate.lims")
	public ModelAndView updateEstimate(HttpServletRequest request, 
			@ModelAttribute("estimateVO") EstimateVO estimateVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setUpdater_id(userInfoVO.getUser_id());
			int result = estimateService.updateEstimate(estimateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(estimateVO.toString(), e);
			throw e;
		}
	}
	
	
	/**
	 * 견적정보 삭제
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteEstimate.lims")
	public ModelAndView deleteEstimate(HttpServletRequest request, 
			@ModelAttribute("estimateVO") EstimateVO estimateVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setUpdater_id(userInfoVO.getUser_id());
			int result = estimateService.deleteEstimate(estimateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(estimateVO.toString(), e);
			throw e;
		}
	}
	
	
	@RequestMapping("/copyEstimate.lims")
	public ModelAndView copyEstimate(HttpServletRequest request, 
			@ModelAttribute("estimateVO") EstimateVO estimateVO, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setUpdater_id(userInfoVO.getUser_id());
			int result = estimateService.copyEstimate(estimateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(estimateVO.toString(), e);
			throw e;
		}
	}
	/**
	 * 견적 > 장비 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instChoice.lims")
	public String instChoice() {
		return "common/pop/instChoicePop";
	}
	
	/**
	 * 접수 > 항목 리스트 멀티 추가
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertInstGrid.lims")
	public ModelAndView insertInstGrid(HttpServletRequest request, Model model, MachineVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			System.out.println("pageType : "+vo.getPageType());
			if(vo.getPageType().equals("EST")){
				model.addAttribute("resultData", estimateService.insertInstGrid(vo));
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 견적항목저장
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveEstimateItem.lims")
	public ModelAndView saveEstimateItem(HttpServletRequest request, 
			@ModelAttribute("estimateVO") EstimateVO estimateVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", estimateService.saveEstimateItem(estimateVO));
		} catch (Throwable e) {
			log.error(estimateVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 견적항목수수료저장
	 * 
	 * @param estimateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveEstimateItemFee.lims")
	public ModelAndView saveEstimateItemFee(HttpServletRequest request, 
			@ModelAttribute("estimateVO") EstimateVO estimateVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			estimateVO.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", estimateService.saveEstimateItemFee(estimateVO));
		} catch (Throwable e) {
			log.error(estimateVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
		
	}
	
	/**
	 * 접수 > 견적관리 팝업
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estChoicePop.lims")
	public String estChoicePop() {
		return "common/pop/estChoicePop";
	}	
	
	/**
	 * 접수 > 견적서 템플릿 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estimateTemplatePop.lims")
	public String estimateTemplate() {
		return "common/pop/estimateTemplatePop";
	}

	/**
	 * 접수 > 견적서 템플릿 > 리스트 조회
	 * 
	 * @param DemoSampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectEstimateTemplateList.lims")
	public ModelAndView selectEstimateTemplateList(Model model, EstimateVO vo) {
		try {
			model.addAttribute("resultData", estimateService.selectEstimateTemplateList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 견적서별 항목 템플릿 > 리스트 조회
	 * 
	 * @param DemoSampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectEstimateItemTemplateList.lims")
	public ModelAndView selectEstimateItemTemplateList(Model model, EstimateVO vo) {
		try {
			model.addAttribute("resultData", estimateService.selectEstimateItemTemplateList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 견적서별 항목 수수료 템플릿 > 리스트 조회
	 * 
	 * @param DemoSampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectEstimateItemFeeTemplateList.lims")
	public ModelAndView selectEstimateItemFeeTemplateList(Model model, EstimateVO vo) {
		try {
			model.addAttribute("resultData", estimateService.selectEstimateItemFeeTemplateList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 견적서별 템플릿 등록
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/estimateTemplateInsert.lims")
	public ModelAndView insertEstimateTemplate(HttpServletRequest request, @ModelAttribute("deptVO") EstimateVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			
			int result = estimateService.insertEstimateTemplate(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 견적서별 템플릿 견적서로 등록
	 * 
	 * @param deptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertSelectEstimateTemplate.lims")
	public ModelAndView insertSelectEstimateTemplate(HttpServletRequest request, @ModelAttribute("deptVO") EstimateVO vo, Model model) throws Exception {
		try{
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			int result = estimateService.insertSelectEstimateTemplate(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 견적 > 항목 리스트 멀티 추가(항목 선택 팝업)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertEstimateItemGrid.lims")
	public ModelAndView insertEstimateItemGrid(HttpServletRequest request, Model model, EstimateVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			model.addAttribute("resultData", estimateService.insertEstimateItemGrid(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
}