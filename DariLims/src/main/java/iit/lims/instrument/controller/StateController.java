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
import iit.lims.instrument.service.StateService;
import iit.lims.instrument.vo.StateVO;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.service.UnitWorkService;
import iit.lims.util.JsonView;

@Controller
public class StateController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private StateService stateService;
	@Resource
	private UnitWorkService unitWorkService;
	@Resource
	private CommonService commonService;

	/**
	 * 장비현황 페이지 전환 처리
	 *
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/stateManage.lims")
	public String stateManage(HttpServletRequest request, Model model) {
		return "instrument/state/stateL01";
	}

	/**
	 * 장비현황 전체 목록 조회
	 *
	 * @param HttpServletRequest, Model, MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineState.lims")
	public ModelAndView machineState(HttpServletRequest request, Model model, MachineVO machineVO) {
		try {
			model.addAttribute("resultData", stateService.machineState(machineVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 장비현황 목록 조회
	 *
	 * @param HttpServletRequest, Model, StateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/state.lims")
	public ModelAndView state(HttpServletRequest request, Model model, StateVO stateVO) {
		try {
			model.addAttribute("resultData", stateService.selectStateList(stateVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 장비현황 상세정보 조회
	 *
	 * @param HttpServletRequest, Model, StateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/stateD01.lims")
	public String stateDetail(HttpServletRequest request, Model model, StateVO stateVO) {
		if(request.getParameter("pageType").equals("insert")){
			model.addAttribute("detail", new StateVO());
		}else{
			try {
				model.addAttribute("detail", stateService.stateDetail(stateVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "instrument/state/stateD01";
	}

	/**
	 * 장비현황 저장 처리
	 *
	 * @param StateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/insertState.lims")
	public ModelAndView insertState(HttpServletRequest request,
			@ModelAttribute("stateVO") StateVO stateVO, Model model) throws Exception {
		try{
			int result = stateService.insertState(stateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch(Exception e) {
			log.error(stateVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 장비현황 수정 처리
	 *
	 * @param StateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/updateState.lims")
	public ModelAndView updateState(HttpServletRequest request,
			@ModelAttribute("stateVO") StateVO stateVO, Model model) throws Exception {
		try{
			int result = stateService.updateState(stateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch(Exception e) {
			log.error(stateVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 장비현황 삭제 처리
	 *
	 * @param StateVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteState.lims")
	public ModelAndView deleteState(HttpServletRequest request,
			@ModelAttribute("stateVO") StateVO stateVO, Model model) throws Exception {
		try{
			int result = stateService.deleteState(stateVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch(Exception e) {
			log.error(stateVO.toString(), e);
			throw e;
		}
	}	
}
