package iit.lims.accept.controller;

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

import iit.lims.accept.service.SamplingService;
import iit.lims.accept.vo.SamplingVO;
import iit.lims.common.service.CommonService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;

/**
 * SamplingController
 * 
 * @author 허태원
 * @since 2019.11.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2019.11.26  허태   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/accept/")
public class SamplingController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private SamplingService samplingService;

	@Resource
	private CommonService commonService;

	/**
	 * 배정자 지정 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("sampling.lims")
	public String sampling(HttpServletRequest request, Model model, SamplingVO vo) {
		return "accept/sampling/samplingL01";
	}
	
	@RequestMapping("selectSamplingList.lims")
	public ModelAndView selectSamplingList(Model model, SamplingVO vo) throws Exception {
		try {
			model.addAttribute("resultData", samplingService.selectSamplingList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("selectSamplingDetail.lims")
	public String selectSamplingDetail(HttpServletRequest request, Model model, SamplingVO vo) {
		try {
			SamplingVO dtlVO = new SamplingVO();
			
			if(samplingService.selectSamplingDetail(vo) != null){
				dtlVO = samplingService.selectSamplingDetail(vo);
			}else{
				dtlVO.setTest_req_seq(vo.getTest_req_seq());
			}
			dtlVO.setState(request.getParameter("state"));
			
			model.addAttribute("detail", dtlVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "accept/sampling/samplingD01";
	}
	
	@RequestMapping("samplingFileDown.lims")
	public ModelAndView samplingFileDown(HttpServletResponse response, Model model, SamplingVO vo) throws Exception {
		try {
			SamplingVO s = samplingService.samplingFileDown(vo);

			if (s != null) {
				model.addAttribute("data", s.getDown_file_data());
				model.addAttribute("fileName", s.getDown_file_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
	
	@RequestMapping("insertSampling.lims")
	public ModelAndView insertSampling(HttpServletRequest request, SamplingVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());

			String result = samplingService.insertSampling(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	@RequestMapping("updateSampling.lims")
	public ModelAndView updateSampling(HttpServletRequest request, SamplingVO vo, Model model) throws Exception {
		try {

			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());

			int result = samplingService.updateSampling(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	@RequestMapping("selectSamplingLtList.lims")
	public ModelAndView selectSamplingLtList(Model model, SamplingVO vo) throws Exception {
		try {
			model.addAttribute("resultData", samplingService.selectSamplingLtList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("selectSamplingMesureList.lims")
	public ModelAndView selectSamplingMesureList(Model model, SamplingVO vo) throws Exception {
		try {
			model.addAttribute("resultData", samplingService.selectSamplingMesureList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	@RequestMapping("saveSamplingLt.lims")
	public ModelAndView saveSamplingLt(HttpServletRequest request, @ModelAttribute("vo") SamplingVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());

			int result = samplingService.saveSamplingLt(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	@RequestMapping("saveSamplingMesure.lims")
	public ModelAndView saveSamplingMesure(HttpServletRequest request, @ModelAttribute("vo") SamplingVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());

			int result = samplingService.saveSamplingMesure(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	// 채취 정보 저장시 채취로트 생성
	@RequestMapping("saveSplorePick.lims")
	public ModelAndView saveSplorePick(HttpServletRequest request, @ModelAttribute("vo") SamplingVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());

			int result = samplingService.saveSplorePick(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	// 채취 정보 저장시 채취측정 생성
	@RequestMapping("saveMesure.lims")
	public ModelAndView saveMesure(HttpServletRequest request, @ModelAttribute("vo") SamplingVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());
			
			int result = samplingService.saveMesure(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	//로트전체삭제
	@RequestMapping("deleteSamplingLt.lims")
	public ModelAndView deleteSamplingLt(HttpServletRequest request, @ModelAttribute("vo") SamplingVO vo, Model model) throws Exception {
		try {
			model.addAttribute("resultData", samplingService.deleteSamplingLt(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	//측정전체삭제
	@RequestMapping("deleteSamplingMesure.lims")
	public ModelAndView deleteSamplingMesure(HttpServletRequest request, @ModelAttribute("vo") SamplingVO vo, Model model) throws Exception {
		try {
			model.addAttribute("resultData", samplingService.deleteSamplingMesure(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
}
