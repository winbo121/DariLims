package iit.lims.master.controller;

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
import iit.lims.master.service.UnitWorkService;
import iit.lims.master.vo.UnitWorkVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;

/**
 * UnitWorkController
 * 
 * @author 최은향
 * @since 2015.01.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
public class UnitWorkController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private UnitWorkService unitWorkService;
	@Resource
	private CommonService commonService;

	/**
	 * 단위업무 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/unitWorkManage.lims")
	public String unitWorkManage(HttpServletRequest request, Model model) {
		return "master/unitWork/unitWorkL01";
	}

	/**
	 * 단위업무 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/unitWork.lims")
	public ModelAndView unitWork(HttpServletRequest request, Model model, UnitWorkVO unitWorkVO) {
		try {
			model.addAttribute("resultData", unitWorkService.unitWork(unitWorkVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 단위업무 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/unitWorkD01.lims")
	public String unitWorkDetail(HttpServletRequest request, Model model, UnitWorkVO unitWorkVO) {

		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new UnitWorkVO());
		} else {
			try {
				model.addAttribute("detail", unitWorkService.unitWorkDetail(unitWorkVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "master/unitWork/unitWorkD01";
	}

	/**
	 * 단위업무 저장 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/insertUnitWork.lims")
	public ModelAndView insertUnitWork(HttpServletRequest request, @ModelAttribute("unitWorkVO") UnitWorkVO unitWorkVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			unitWorkVO.setUser_id(userInfoVO.getUser_id());

			int result = unitWorkService.insertUnitWork(unitWorkVO);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(unitWorkVO.toString(), e);
			throw e;
		}
	}

	//	/**
	//	 * 단위업무 수정 처리
	//	 * 
	//	 * @param UnitWorkVO
	//	 * @return ModelAndView
	//	 * @throws Exception
	//	 */
	//	@RequestMapping("/master/updateUnitWork.lims")
	//	public ModelAndView updateUnitWork(HttpServletRequest request, @ModelAttribute("unitWorkVO") UnitWorkVO unitWorkVO, Model model) throws Exception {
	//		try {
	//			int result = unitWorkService.updateUnitWork(unitWorkVO);
	//			model.addAttribute("resultData", result);
	//			return new ModelAndView(new JsonView());
	//		} catch (Exception e) {
	//			log.error(unitWorkVO.toString(), e);
	//			throw e;
	//		}
	//	}

	/**
	 * 단위업무 삭제 처리
	 * 
	 * @param UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/deleteUnitWork.lims")
	public ModelAndView deleteUnitWork(HttpServletRequest request, @ModelAttribute("unitWorkVO") UnitWorkVO unitWorkVO, Model model) throws Exception {
		try {
			int result = unitWorkService.deleteUnitWork(unitWorkVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(unitWorkVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 부서별 단위업무 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/deptUnitWorkManage.lims")
	public String deptUnitWorkManage(HttpServletRequest request, Model model) {
		return "master/unitWork/deptUnitWorkL01";
	}

	/**
	 * 부서 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/deptUnitWork.lims")
	public ModelAndView deptList(HttpServletRequest request, Model model, UnitWorkVO unitWorkVO) {
		try {
			model.addAttribute("resultData", unitWorkService.deptList(unitWorkVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 부서별 단위업무 조회(ALL)
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/allDeptUnitWork.lims")
	public ModelAndView deptUnitWork(HttpServletRequest request, Model model, UnitWorkVO unitWorkVO) {
		try {
			model.addAttribute("resultData", unitWorkService.deptUnitWork(unitWorkVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 부서별 단위업무 조회(ALL)
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/selectDeptUnitWork.lims")
	public ModelAndView selectDeptUnitWork(HttpServletRequest request, Model model, UnitWorkVO unitWorkVO) {
		try {
			model.addAttribute("resultData", unitWorkService.selectDeptUnitWork(unitWorkVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 부서별 단위업무 저장 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/saveDeptUnitWork.lims")
	public ModelAndView saveDeptUnitWork(HttpServletRequest request, Model model, UnitWorkVO unitWorkVO) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			unitWorkVO.setUser_id(userInfoVO.getUser_id());

			model.addAttribute("resultData", unitWorkService.saveDeptUnitWork(unitWorkVO));
		} catch (Exception e) {
			log.error(unitWorkVO.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 단위업무 삭제여부 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, UnitWorkVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/deptUnitWorkDeleteFlag.lims")
	public ModelAndView deptUnitWorkDeleteFlag(HttpServletRequest request, @ModelAttribute("unitWorkVO") UnitWorkVO unitWorkVO, Model model) throws Exception {
		try {
			UnitWorkVO vo = unitWorkService.deptUnitWorkDeleteFlag(unitWorkVO);
			int result = vo.getDel_count();
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(unitWorkVO.toString(), e);
			throw e;
		}
	}
}