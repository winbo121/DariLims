package iit.lims.analysis.controller;

import javax.annotation.Resource;
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
import iit.lims.analysis.service.ResultInputSampleService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.service.CommonService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * MenuController
 * 
 * @author 조재환
 * @since 2015.01.14
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.14  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultInputSampleController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultInputSampleService resultInputSampleService;

	@Resource
	private CommonService commonService;

	/**
	 * 결과입력 (시료유형) 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultInputSample.lims")
	public String sampleInput(HttpServletRequest request, Model model, ResultInputVO vo) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		model.addAttribute("loginUser", userInfoVO.getUser_nm());
		model.addAttribute("pageType", "item");
		return "analysis/resultInputSample/resultInputSampleL01";
	}

	/**
	 * 결과입력 (시료유형) 의뢰 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectResultReqList.lims")
	public ModelAndView selectResultReqList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setCommission_flag(request.getParameter("commission_flag"));
			model.addAttribute("resultData", resultInputSampleService.selectResultReqList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과입력 (시료유형) 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectResultSampleList.lims")
	public ModelAndView selectResultSampleList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			//결과확인과 함꼐 사용하여 화면에서 세션처리 
			/*UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());*/
			vo.setResult_type_gbn("S");
			model.addAttribute("resultData", resultInputSampleService.selectResultSampleList(vo));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과입력 > 결과 저장
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateItemResult.lims")
	public ModelAndView updateItemResult(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultInputSampleService.updateItemResult(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과입력 > 결과 입력 완료 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/completeResultInput.lims")
	public ModelAndView completeResultInput(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			vo.setPageType(request.getParameter("pageType"));
			model.addAttribute("resultData", resultInputSampleService.completeResultInput(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과입력 > 시험방법 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testMethodChoice.lims")
	public String testMethodChoice() {
		return "common/pop/resultInputMethodPop";
	}

	/**
	 * 결과입력 > 시험방법 팝업 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestMethodList.lims")
	public ModelAndView selectTestMethodList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultInputSampleService.selectTestMethodList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과입력 > 시험기기 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testMachineChoice.lims")
	public String testMachineChoice() {
		return "common/pop/resultInputMachinePop";
	}

	/**
	 * 결과입력 > 시험기기 팝업 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestMachineList.lims")
	public ModelAndView selectTestMachineList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultInputSampleService.selectTestMachineList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과 특기사항 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/showReqmessage.lims")
	public ModelAndView showReqmessage(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultInputSampleService.showReqmessage(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/itemResultInput")
	public String itemInput(HttpServletRequest request, Model model) {
		return "analysis/itemResult/itemResultD01";
	}

	/**
	 * 자동기준일때 기준 가져오기
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectOriginalSTD.lims")
	public ModelAndView selectOriginalSTD(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			model.addAttribute("resultData", resultInputSampleService.selectOriginalSTD(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/selectSampleList.lims")
	public ModelAndView selectSampleDetail(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultInputSampleService.selectSampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 결과입력 > 성적서 첨부파일 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/reportFilePop.lims")
	public String reportFilePop(HttpServletRequest request, ResultInputVO vo, Model model) {
		try {
			if( request.getParameter("rowId") != "" && request.getParameter("rowId") != null ) {		
				vo.setTest_sample_seq(request.getParameter("test_sample_seq")); // 시료번호
				vo.setTest_item_seq(request.getParameter("test_item_cd")); // 항목번호
				vo.setAtt_seq(request.getParameter("rowId")); // seq
				model.addAttribute("detail", resultInputSampleService.reportFilePop(vo));
			} else {
				model.addAttribute("detail", new ResultInputVO());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/filePop";
	}
	
	/**
	 * 결과입력 >  성적서 첨부파일 저장
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertReportFile.lims")
	public ModelAndView insertDocument(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultInputSampleService.insertReportFile(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 결과입력 >  성적서 첨부파일 수정 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReportFile.lims")
	public ModelAndView updateDocument(HttpServletRequest request, @ModelAttribute("vo") ResultInputVO vo, Model model) throws Exception {
		try {
			int result = resultInputSampleService.updateReportFile(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 결과입력 >  성적서 첨부파일 삭제 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteReportFile.lims")
	public ModelAndView deleteReportFile(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
//			vo.setAtt_seq(request.getParameter("att_seq"));
//			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
//			vo.setTest_item_cd(request.getParameter("test_item_cd"));
			model.addAttribute("resultData", resultInputSampleService.deleteReportFile(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과입력 >  성적서 첨부파일 다운로드
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportDown.lims")
	public ModelAndView reportDown(HttpServletResponse response, Model model, ResultInputVO vo) throws Exception {
		try {
			ResultInputVO D = resultInputSampleService.reportDown(vo);
			if (D != null) {
				model.addAttribute("data", D.getFile_att());
				model.addAttribute("fileName", D.getFile_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
}
