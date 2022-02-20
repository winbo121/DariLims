package iit.lims.report.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.service.AcceptService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.report.service.ReportPublishService;
import iit.lims.report.service.ReportWriteService;
import iit.lims.report.vo.ReportVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * ReportWriteController
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/report/")
public class ReportWriteController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private ReportWriteService reportWriteService;
	@Resource
	private AcceptService acceptService;
	@Resource
	private ReportPublishService reportPublishService;
	/**
	 * 성적서 작성 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportWrite.lims")
	public String reportMake(HttpServletRequest request, Model model,ReportVO vo) throws Exception {
		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		vo.setUser_id(userInfoVO.getUser_id());
		model.addAttribute("cntType", request.getParameter("cntType"));
		model.addAttribute("resultData",reportWriteService.selectReportMake(vo));
		return "report/reportWrite/reportWriteL01";
	}

	/**
	 * 성적서 작성 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportReqList.lims")
	public ModelAndView selectReportWriteList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setCommission_flag(request.getParameter("commission_flag"));
			model.addAttribute("resultData", reportWriteService.selectReportReqList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 작성 시료 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportSampleList.lims")
	public ModelAndView selectReportSampleList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportWriteService.selectReportSampleList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/selectReportSampleItemList.lims")
	public ModelAndView selectReportSampleItemList(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportWriteService.selectReportSampleItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 성적서 작성 등록
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertReportWrite.lims")
	public ModelAndView insertReportWrite(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			//진위확인id 생성
			String verify_id = "";
			label: do {    		
				verify_id = RandomStringUtils.randomAlphanumeric(20).toUpperCase();
    			int verifyCo = reportWriteService.selectVerifyCnt(verify_id);
				if(verifyCo > 0) continue label;
				break label;    				
			} while(true);

			vo.setVerify_id(verify_id);
			model.addAttribute("resultData", reportWriteService.insertReportWrite(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 작성 삭제
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteReportWrite.lims")
	public ModelAndView deleteReportWrite(HttpServletRequest request, Model model, ReportVO vo) {
		try {
			model.addAttribute("resultData", reportWriteService.deleteReportWrite(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 작성 의뢰 정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportDetail.lims")
	public String selectReportDetail(HttpServletRequest request, Model model, AcceptVO vo) {
		try {
			ReportVO vo2 = new ReportVO();
			vo2.setReport_doc_seq(request.getParameter("report_doc_seq"));
			model.addAttribute("viewGbn", request.getParameter("viewGbn"));
			model.addAttribute("detail", acceptService.selectAcceptDetail(vo));
			model.addAttribute("detail2", reportPublishService.selectReportFormInfo(vo2));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/reportWritePop";
	}
	/**
	 * 접수 > 성적서 발행 구분  
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateSeparation.lims")
	public ModelAndView updateSeparation(HttpServletRequest request, Model model, ReportVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			model.addAttribute("resultData", reportWriteService.updateSeparation(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 성적서 비고 저장
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReqEtc.lims")
	public ModelAndView updateReqEtc(HttpServletRequest request, Model model, ReportVO vo) throws Exception {
		try {
			
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			
			if(vo.getPlusNum().equals("")) {
				
			}
			else {
			StringBuilder realReq_etc = new StringBuilder(vo.getReq_etc());
			String realPlusNum=vo.getPlusNum();
			String[] array_word; // 스트링을 담을 배열
			
			array_word = realPlusNum.split(",");
			
			for(int i=0; i<array_word.length; i++) {
				realReq_etc.setCharAt(Integer.parseInt(array_word[i]), '+');
			}
			
			vo.setReq_etc(realReq_etc.toString());
			}
			model.addAttribute("resultData", reportWriteService.updateReqEtc(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}


}
