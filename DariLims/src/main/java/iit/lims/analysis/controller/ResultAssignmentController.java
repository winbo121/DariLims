package iit.lims.analysis.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.service.ResultAssignmentService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.common.service.CommonService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import twitter4j.internal.org.json.JSONObject;

/**
 * ResultAssignmentController
 * 
 * @author 최은향
 * @since 2016.01.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.01.26  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/analysis/")
public class ResultAssignmentController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ResultAssignmentService resultAssignmentService;

	@Resource
	private CommonService commonService;

	/**
	 * 배정자 지정 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/resultAssignment.lims")
	public String resultAssignment(HttpServletRequest request, Model model, ResultInputVO vo) {
		model.addAttribute("move", vo);
		return "analysis/resultAssignment/resultAssignmentL01";
	}
	
	/**
	 * 접수완료 목록 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAcceptCompleteList.lims")
	public ModelAndView selectAcceptList(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", resultAssignmentService.selectAcceptCompleteList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 배정 시료 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSampleAssignmentList.lims")
	public ModelAndView selectSampleAssignmentList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
				model.addAttribute("resultData", resultAssignmentService.selectSampleAssignmentList(vo));			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 배정 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectResultAssignmentList.lims")
	public ModelAndView selectResultAssignmentList(HttpServletRequest request, Model model, ResultInputVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			//vo.setCommission_flag(request.getParameter("commission_flag"));

			if(!vo.getTest_req_seq().isEmpty() && !vo.getTest_req_seq().equals("")){
				model.addAttribute("resultData", resultAssignmentService.selectResultAssignmentList(vo));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 배정자 저장 및 배정완료
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateResultTester.lims")
	public ModelAndView updateResultTester(HttpServletRequest request, Model model, ResultInputVO vo) throws Exception {
		try {
			//UserInfoVO userInfoVO = SessionCheck.getSession(request);
			//vo.setUser_id(userInfoVO.getUser_id());
			//vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", resultAssignmentService.updateResultTester(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 검사의뢰 전체 배정완료
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateAssignmentComplete.lims")
	public ModelAndView updateAssignmentComplete(HttpServletRequest request, Model model) throws Exception {

    	JSONObject obj = new JSONObject();

		String reqList = request.getParameter("reqList");
		String[] reqList_arr = reqList.split(",", -1);
		if (reqList_arr.length > 0){
			String result = resultAssignmentService.updateAssignmentComplete(reqList);
			if(result.length() > 0){
		    	obj.put("result", "N");
		    	result = result.substring(0, result.length() - 2);
		    	obj.put("msg", result);
			}else{
		    	obj.put("result", "Y");
			}
		}else{
			//0건
	    	obj.put("result", "F");
		}
		
		model.addAttribute("resultData", obj.toString());		
		return new ModelAndView(new JsonView());
	}

}
