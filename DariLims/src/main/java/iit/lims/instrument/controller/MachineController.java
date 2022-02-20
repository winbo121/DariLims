package iit.lims.instrument.controller;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.instrument.service.MachineService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.service.UnitWorkService;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;

@Controller
public class MachineController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private MachineService machineService;
	@Resource
	private UnitWorkService unitWorkService;
	@Resource
	private CommonService commonService;

	/**
	 * 장비관리 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineManage.lims")
	public String machineManage(HttpServletRequest request, Model model, MachineVO machineVO) {
		try {
			model.addAttribute("dept", machineService.selectMachineDeptList(machineVO));// 관리부서
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "instrument/machine/machineL01";
	}

	/**
	 * 장비관리 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machine.lims")
	public ModelAndView machine(HttpServletRequest request, Model model, MachineVO machineVO) {
		try {			
			model.addAttribute("resultData", machineService.selectMachineList(machineVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 장비관리 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineD01.lims")
	public String machineDetail(HttpServletRequest request, Model model, MachineVO machineVO) {
		// 추가용
		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new MachineVO());
			model.addAttribute("pageType", request.getParameter("pageType"));
		} else {
			try {
				model.addAttribute("detail", machineService.machineDetail(machineVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "instrument/machine/machineD01";
	}

	/**
	 * 장비관리 저장 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/insertMachine.lims")
	public ModelAndView insertMachine(HttpServletRequest request, @ModelAttribute("machineVO") MachineVO machineVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			machineVO.setUser_id(userInfoVO.getUser_id());

			int result = machineService.insertMachine(machineVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(machineVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 장비관리 수정 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/updateMachine.lims")
	public ModelAndView updateMachine(HttpServletRequest request, @ModelAttribute("machineVO") MachineVO machineVO, Model model) throws Exception {
		try {

			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			machineVO.setUser_id(userInfoVO.getUser_id());

			int result = machineService.updateMachine(machineVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(machineVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 장비관리 삭제 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteMachine.lims")
	public ModelAndView deleteMachine(HttpServletRequest request, @ModelAttribute("machineVO") MachineVO machineVO, Model model) throws Exception {
		try {
			int result = machineService.deleteMachine(machineVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(machineVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 장비관리 파일저장 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineDown.lims")
	public ModelAndView machineDown(HttpServletResponse response, Model model, MachineVO machineVO) {

		MachineVO m = machineService.machineDown(machineVO);
		if (m != null) {
			model.addAttribute("data", m.getAdd_file());
			model.addAttribute("fileName", m.getImg_file_nm());
		}
		return new ModelAndView(new ByteDownloadView());
	}

	/**
	 * 장비 삭제여부 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineDeleteFlag.lims")
	public ModelAndView machineDeleteFlag(HttpServletRequest request, @ModelAttribute("unitWorkVO") MachineVO machineVO, Model model) throws Exception {
		try {
			MachineVO vo = machineService.machineDeleteFlag(machineVO);
			int result = vo.getDel_count();
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(machineVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 장비 등록이미지 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/machineImage.lims")
	public void machineImage(HttpServletRequest request, HttpServletResponse response, MachineVO machineVO, Model model) throws Exception {
		ServletOutputStream out = null;
		try {
			response.setContentType("/image/jpg");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Cache-Control", "no-cache");

			byte[] fileBin = (byte[]) machineService.machineImage(machineVO);

			if (fileBin != null && fileBin.length > 0) {
				out = response.getOutputStream();
				out.write(fileBin);
				out.flush();

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}

	/**
	 * 관리자 이력 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/selectMachineManager.lims")
	public ModelAndView selectMachineManager(HttpServletResponse response, Model model, MachineVO machineVO) {
		try {
			model.addAttribute("resultData", machineService.selectMachineManager(machineVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 관리자 저장 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/saveManager.lims")
	public ModelAndView saveManager(HttpServletResponse response, Model model, MachineVO machineVO) {
		try {
			model.addAttribute("resultData", machineService.saveManager(machineVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 관리자 삭제 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/instrument/deleteManager.lims")
	public ModelAndView deleteManager(HttpServletResponse response, Model model, MachineVO machineVO) {
		try {
			model.addAttribute("resultData", machineService.deleteManager(machineVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

}
