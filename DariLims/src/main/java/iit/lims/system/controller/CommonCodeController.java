package iit.lims.system.controller;

import iit.lims.master.vo.OxideMarkVO;
import iit.lims.system.service.CommonCodeService;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CommonCodeController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private CommonCodeService commonCodeService;

	/**
	 * 공통코드 콤보 조회 - 공통
	 * 
	 * @param code_group
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeCombo.lims")
	public ModelAndView selectCommonCodeCombo(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonCodeCombo(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 EX1 조회 - 공통
	 * 
	 * @param code_group
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeDepth.lims")
	public ModelAndView selectCommonCodeDepth(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonCodeDepth(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 부서
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeDept.lims")
	public ModelAndView selectCommonCodeDept(Model model) throws Exception {
		try {
			List<CommonCodeVO> deptList = commonCodeService.selectCommonCodeDept();
			model.addAttribute("resultData", deptList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 부서
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectEstFeeGubun.lims")
	public ModelAndView selectEstFeeGubun(Model model) throws Exception {
		try {
			List<CommonCodeVO> feeList = commonCodeService.selectEstFeeGubun();
			model.addAttribute("resultData", feeList);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 모든부서
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodePreDept.lims")
	public ModelAndView selectCommonCodePreDept(Model model) throws Exception {
		try {
			List<CommonCodeVO> deptList = commonCodeService.selectCommonCodePreDept();
			model.addAttribute("resultData", deptList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 공통코드 콤보 조회 - 시험기준
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeStd.lims")
	public ModelAndView selectCommonCodeStd(Model model) throws Exception {
		try {
			List<CommonCodeVO> deptList = commonCodeService.selectCommonCodeStd();
			model.addAttribute("resultData", deptList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 공통코드 콤보 조회 - 단위업무
	 * 
	 * @param code_group
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeUnitWork.lims")
	public ModelAndView selectCommonCodeUnitWork(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> uniWorkList = commonCodeService.selectCommonCodeUnitWork(vo);
			model.addAttribute("resultData", uniWorkList);
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 공통코드 콤보 조회 - 진행상태
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeState.lims")
	public ModelAndView selectCommonCodeState(Model model) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodeState());
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 진행상태(통계)
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeStatusState.lims")
	public ModelAndView selectCommonCodeStatusState(Model model) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodeStatusState());
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 공통코드 콤보 조회 - 성적서
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeReport.lims")
	public ModelAndView selectCommonCodeReport(Model model) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodeReport());
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 공통코드 콤보 조회 - 보고서
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodePaper.lims")
	public ModelAndView selectCommonCodePaper(Model model, CommonCodeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodePaper(vo));
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 공통코드 콤보 조회 - 시료
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeSample.lims")
	public ModelAndView selectCommonCodeSample(HttpServletRequest request, Model model, CommonCodeVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", commonCodeService.selectCommonCodeSample(vo));
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 상담경로
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeCounselPath.lims")
	public ModelAndView selectCommonCodeCounselPath(HttpServletRequest request, Model model, CommonCodeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodeCounselPath());
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 상담구분
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeCounselDiv.lims")
	public ModelAndView selectCommonCodeCounselDiv(HttpServletRequest request, Model model, CommonCodeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodeCounselDiv());
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 삼당진행상태
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeCounselprogressSts.lims")
	public ModelAndView selectCommonCodeCounselprogressSts(HttpServletRequest request, Model model, CommonCodeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodeCounselprogressSts());
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 품목구분(1레벨)
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodePrdlst_gubun.lims")
	public ModelAndView selectCommonCodePrdlst_gubun(HttpServletRequest request, Model model, CommonCodeVO vo) throws Exception {
		try {
			model.addAttribute("resultData", commonCodeService.selectCommonCodePrdlst_gubun(vo));
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	
	
	/**
	 * 공통코드 콤보 조회 - 양식종류
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonFormType.lims")
	public ModelAndView selectCommonFormType(Model model) throws Exception {
		try {
			List<CommonCodeVO> formType = commonCodeService.selectCommonFormType();
			model.addAttribute("resultData", formType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 양식종류리스트
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonFormTypeDetail.lims")
	public ModelAndView selectCommonFormTypeDetail(Model model,CommonCodeVO vo) throws Exception {
		try {
			List<CommonCodeVO> formType = commonCodeService.selectCommonFormTypeDetail(vo);
			model.addAttribute("resultData", formType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 항목 대분류 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonTestItemL.lims")
	public ModelAndView selectCommonTestItemL(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonTestItemL();
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 항목 중분류 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonTestItemM.lims")
	public ModelAndView selectCommonTestItemM(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonTestItemM(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 공통코드 콤보 조회 - 업체 리스트 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonOrgList.lims")
	public ModelAndView selectCommonOrgList(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonOrgList();
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 여분코드 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeEX1Combo.lims")
	public ModelAndView selectCommonCodeEX1Combo(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonCodeEX1Combo(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 여분코드 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeEX2Combo.lims")
	public ModelAndView selectCommonCodeEX2Combo(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonCodeEX2Combo(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 부서별 사용자 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectCommonCodeUser.lims")
	public ModelAndView selectCommonCodeUser(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectCommonCodeUser(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 공통코드 콤보 조회 - 양식 종류 콤보
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectFormComboList.lims")
	public ModelAndView selectFormComboList(CommonCodeVO vo, Model model) throws Exception {
		try {
			List<CommonCodeVO> codeList = commonCodeService.selectFormComboList(vo);
			model.addAttribute("resultData", codeList);
		} catch (Exception e) {

		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 산화물 표기 조회
	 * 
	 * @param OxideMarkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectItemOxideMarkList.lims")
	public ModelAndView selectItemOxideMarkList(HttpServletRequest request, Model model, OxideMarkVO vo) throws Exception {
		try {
			List<OxideMarkVO> oxideList = commonCodeService.selectItemOxideMarkList(vo);
			model.addAttribute("resultData", oxideList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 프로토콜 조회
	 * 
	 * @param OxideMarkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/commonCode/selectProtocolList.lims")
	public ModelAndView selectProtocolList(HttpServletRequest request, Model model, OxideMarkVO vo) throws Exception {
		try {
			List<OxideMarkVO> oxideList = commonCodeService.selectProtocolList(vo);
			model.addAttribute("resultData", oxideList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
}
