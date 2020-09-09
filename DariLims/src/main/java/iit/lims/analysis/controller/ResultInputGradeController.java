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
 * @author 송성수
 * @since 2019.11.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2019.11.26  송성수   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultInputGradeController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultInputSampleService resultInputSampleService;

	@Resource
	private CommonService commonService;

	/**
	 * 결과입력 (등급별) 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultInputGrade.lims")
	public String resultInputGrade(HttpServletRequest request, Model model, ResultInputVO vo) {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		model.addAttribute("loginUser", userInfoVO.getUser_nm());
		model.addAttribute("pageType", "item");
		return "analysis/resultInputGrade/resultInputGradeL01";
	}
	
	/**
	 * 결과입력 (등급별) 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectResultSampleGradeList.lims")
	public ModelAndView selectResultSampleGradeList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			//결과확인과 함꼐 사용하여 화면에서 세션처리 
			/*UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());*/
			vo.setResult_type_gbn("G");
			model.addAttribute("resultData", resultInputSampleService.selectResultSampleList(vo));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}
