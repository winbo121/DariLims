package iit.lims.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.system.service.DeptOthersService;
import iit.lims.system.service.DeptService;
import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.UserVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

@Controller
public class DeptOthersController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private DeptService deptService;
	@Resource
	private DeptOthersService deptOthersService;

	@RequestMapping("/system/deptOthersManage.lims")
	public String deptOthersManage(HttpServletRequest request, Model model, DeptVO deptVO) {
		return "system/deptOthers/deptOthersL01";
	}

	@RequestMapping("/system/selectDeptOthersList.lims")
	public ModelAndView selectDeptOthersList(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			model.addAttribute("resultData", deptOthersService.selectDeptOthersList(deptVO));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/system/selectDeptOthersUserList.lims")
	public ModelAndView selectDeptOthersUserList(HttpServletRequest request, Model model, DeptVO deptVO) throws Exception {
		try {
			model.addAttribute("resultData", deptOthersService.selectDeptOthersUserList(deptVO));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/system/saveDeptOthers.lims")
	public ModelAndView saveDeptOthers(HttpServletRequest request, Model model, DeptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", deptOthersService.saveDeptOthers(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/system/saveDeptOthersUser.lims")
	public ModelAndView saveDeptOthersUser(HttpServletRequest request, Model model, UserVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());			
			model.addAttribute("resultData", deptOthersService.saveDeptOthersUser(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

}