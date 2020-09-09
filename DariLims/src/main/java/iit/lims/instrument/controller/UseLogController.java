package iit.lims.instrument.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.instrument.service.UseLogService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.instrument.vo.UseLogVO;
import iit.lims.util.JsonView;

@Controller
public class UseLogController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private UseLogService useLogService;
	@Resource
	private CommonService commonService;

	/**
	 * 장비사용일지 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/useLogManage.lims")
	public String useLogManage(HttpServletRequest request, Model model) {
		return "instrument/useLog/useLogL01";
	}

	/**
	 * 장비사용일지 전체 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineUseLog.lims")
	public ModelAndView machineUseLog(HttpServletRequest request, Model model, MachineVO machineVO) {
		try {
			model.addAttribute("resultData", useLogService.machineUseLog(machineVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 장비사용일지 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UseLogVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/useLog.lims")
	public ModelAndView useLog(HttpServletRequest request, Model model, UseLogVO useLogVO) {
		try {
			model.addAttribute("resultData", useLogService.selectUseLogList(useLogVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 장비사용일지 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UseLogVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/useLogD01.lims")
	public String useLogDetail(HttpServletRequest request, Model model, UseLogVO useLogVO) {
		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new UseLogVO());
		} else {
			try {
				model.addAttribute("detail", useLogService.useLogDetail(useLogVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "instrument/useLog/useLogD01";
	}

	/**
	 * 장비사용일지 저장 처리
	 * 
	 * @param UseLogVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/insertUseLog.lims")
	public ModelAndView insertUseLog(HttpServletRequest request, @ModelAttribute("useLogVO") UseLogVO useLogVO, Model model) throws Exception {
		try {
			//System.out.println("사용자:" + request.getParameter("his_user"));
			int result = useLogService.insertUseLog(useLogVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(useLogVO.toString(), e);
			throw e;
		}
	}

	//	/**
	//	 * 장비사용일지 수정 처리
	//	 *
	//	 * @param UseLogVO
	//	 * @return ModelAndView
	//	 * @throws Exception
	//	 */
	//	@RequestMapping("/instrument/updateUseLog.lims")
	//	public ModelAndView updateUseLog(HttpServletRequest request,
	//			@ModelAttribute("useLogVO") UseLogVO useLogVO, Model model) throws Exception {
	//		try{
	//			int result = useLogService.updateUseLog(useLogVO);
	//			model.addAttribute("resultData", result);
	//			return new ModelAndView(new JsonView());
	//		} catch(Exception e) {
	//			log.error(useLogVO.toString(), e);
	//			throw e;
	//		}
	//	}

	/**
	 * 장비사용일지 삭제 처리
	 * 
	 * @param UseLogVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteUseLog.lims")
	public ModelAndView deleteUseLog(HttpServletRequest request, @ModelAttribute("useLogVO") UseLogVO useLogVO, Model model) throws Exception {
		try {
			int result = useLogService.deleteUseLog(useLogVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(useLogVO.toString(), e);
			throw e;
		}
	}
}
