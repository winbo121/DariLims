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
import iit.lims.instrument.service.RepairService;
import iit.lims.instrument.vo.RepairVO;
import iit.lims.master.service.UnitWorkService;
import iit.lims.util.JsonView;

@Controller
public class RepairController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private RepairService repairService;
	@Resource
	private UnitWorkService unitWorkService;
	@Resource
	private CommonService commonService;

	/**
	 * 수리등록 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/repairManage.lims")
	public String repairManage(HttpServletRequest request, Model model) {
		return "instrument/repair/repairL01";
	}

	/**
	 * 수리등록 목록 조회
	 * 
	 * @param HttpServletRequest, Model, RepairVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/repair.lims")
	public ModelAndView repair(HttpServletRequest request, Model model, RepairVO repairVO) {
		try {
			model.addAttribute("resultData", repairService.selectRepairList(repairVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 수리등록 상세정보 조회
	 * 
	 * @param HttpServletRequest, Model, RepairVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/repairD01.lims")
	public String repairDetail(HttpServletRequest request, Model model, RepairVO repairVO) {
		if(request.getParameter("pageType").equals("insert")){
			model.addAttribute("detail", new RepairVO());
		}else{
			try {
				model.addAttribute("detail", repairService.repairDetail(repairVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "instrument/repair/repairD01";
	}
	
	/**
	 * 수리등록 저장 처리
	 * 
	 * @param RepairVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/insertRepair.lims")
	public ModelAndView insertRepair(HttpServletRequest request, 
			@ModelAttribute("repairVO") RepairVO repairVO, Model model) throws Exception {
		try{
			System.out.println("등록번호:" + request.getParameter("inst_no"));
			int result = repairService.insertRepair(repairVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(repairVO.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 수리등록 수정 처리
	 * 
	 * @param RepairVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/updateRepair.lims")
	public ModelAndView updateRepair(HttpServletRequest request, 
			@ModelAttribute("repairVO") RepairVO repairVO, Model model) throws Exception {
		try{
			System.out.println("key:" + request.getParameter("key"));
			int result = repairService.updateRepair(repairVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(repairVO.toString(), e);
			throw e;
		}
	}	
	
	/**
	 * 수리등록 삭제 처리
	 * 
	 * @param RepairVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteRepair.lims")
	public ModelAndView deleteRepair(HttpServletRequest request, 
			@ModelAttribute("repairVO") RepairVO repairVO, Model model) throws Exception {
		try{
			int result = repairService.deleteRepair(repairVO);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		}catch(Exception e){
			log.error(repairVO.toString(), e);
			throw e;
		}
	}	
}
