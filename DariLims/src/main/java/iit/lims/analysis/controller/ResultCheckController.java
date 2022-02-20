package iit.lims.analysis.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.service.ResultCheckService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * ResultCheckController
 * 
 * @author 윤상준
 * @since 2015.02.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.17  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultCheckController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultCheckService resultCheckService;

	/**
	 * 결과확인 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultCheck.lims")
	public String resultCheck(HttpServletRequest request, ResultInputVO vo, Model model) {
		try {
			model.addAttribute("pageType", "item");
			model.addAttribute("type", "sect");
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setDept_cd(userInfoVO.getDept_cd());

			ResultInputVO apprLineDefaultList = resultCheckService.selectApprLineDefaultList(vo);

			if (apprLineDefaultList != null) {
				model.addAttribute("detail", apprLineDefaultList);
			} else {
				model.addAttribute("detail", new ResultInputVO());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "analysis/resultCheck/resultCheckL01";
	}

	/**
	 * 결과확인 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultCheckDept")
	public String resultCheckDept(HttpServletRequest request, ResultInputVO vo, Model model) {
		try {
			model.addAttribute("pageType", "item");
			model.addAttribute("type", "dept");
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setDept_cd(userInfoVO.getDept_cd());

			ResultInputVO apprLineDefaultList = resultCheckService.selectApprLineDefaultList(vo);

			if (apprLineDefaultList != null) {
				model.addAttribute("detail", apprLineDefaultList);
			} else {
				model.addAttribute("detail", new ResultInputVO());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "analysis/resultCheck/resultCheckL01";
	}

	/**
	 * 결과확인 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectCheckReqList.lims")
	public ModelAndView selectCheckReqList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultCheckService.selectCheckReqList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과확인 결과 확인 완료 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/completeResultCheck.lims")
	public ModelAndView completeResultCheck(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultCheckService.completeResultCheck(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결과확인 상신 회수
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/cancelResultCheck.lims")
	public ModelAndView cancelResultCheck(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultCheckService.cancelResultCheck(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 결재선관리 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/approvalLine.lims")
	public String approvalLine(HttpServletRequest request, Model model) {
		return "common/pop/approvalLinePop";
	}

	/**
	 * 결재선관리 전체 사용자 조회 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectCmmnUserList.lims")
	public ModelAndView selectCmmnUserList(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			List<ResultInputVO> cmmnUserList = resultCheckService.selectCmmnUserList(vo);
			model.addAttribute("resultData", cmmnUserList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결재선관리 결재선 조회 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectApprLineList.lims")
	public ModelAndView selectApprLineList(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setDept_cd(userInfoVO.getDept_cd());

			List<ResultInputVO> apprLineList = resultCheckService.selectApprLineList(vo);
			model.addAttribute("resultData", apprLineList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결재선 등록
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertApprLine.lims")
	public ModelAndView insertApprLine(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultCheckService.insertApprLine(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결재선 수정
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateApprLine.lims")
	public ModelAndView updateApprLine(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			if(vo.getAppr_mst_seq() != null){
				UserInfoVO userInfoVO = SessionCheck.getSession(request);
				vo.setUser_id(userInfoVO.getUser_id());
				vo.setDept_cd(userInfoVO.getDept_cd());
				model.addAttribute("resultData", resultCheckService.updateApprLine(vo));
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/updateApprDefault.lims")
	public ModelAndView updateApprDefault(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			if(vo.getAppr_mst_seq() != null){
				UserInfoVO userInfoVO = SessionCheck.getSession(request);
				vo.setUser_id(userInfoVO.getUser_id());
				vo.setDept_cd(userInfoVO.getDept_cd());
				model.addAttribute("resultData", resultCheckService.updateApprDefault(vo));
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/deleteApprLine.lims")
	public ModelAndView deleteApprLine(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			if(vo.getAppr_mst_seq() != null){
				UserInfoVO userInfoVO = SessionCheck.getSession(request);
				vo.setUser_id(userInfoVO.getUser_id());
				vo.setDept_cd(userInfoVO.getDept_cd());
				model.addAttribute("resultData", resultCheckService.deleteApprLine(vo));
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	

	/**
	 * 결재선관리 결재선 사용자 조회 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectApprLineUserList.lims")
	public ModelAndView selectApprLineUserList(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			List<ResultInputVO> apprLineUserList = resultCheckService.selectApprLineUserList(vo);
			model.addAttribute("resultData", apprLineUserList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 결재선관리 결재선 사용자 추가 처리
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveApprovalUser.lims")
	public ModelAndView saveApprovalUser(HttpServletRequest request, @ModelAttribute("vo") ResultInputVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", resultCheckService.saveApprovalUser(vo));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 시험 확인 > 시료판정 값 수정
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateSampleJdg.lims")
	public ModelAndView updateSampleJdg(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
//			UserInfoVO userInfoVO = SessionCheck.getSession(request);
//			vo.setUser_id(userInfoVO.getUser_id());
//			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultCheckService.updateSampleJdg(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 항목별 결과 기록 조회 팝업 화면 전환
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/itemResultHistoryPop.lims")
	public String itemResultHistoryPop(HttpServletRequest request) {
		return "common/pop/itemResultHistoryPop";
	}
	
	/**
	 * 항목별 결과 히스토리 조회
	 * 
	 * @param HttpServletRequest, Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectItemResultHistory.lims")
	public ModelAndView selectItemResultHistory(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			//test_req_no
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", resultCheckService.selectItemResultHistory(vo));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}
