package iit.lims.master.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.master.service.TestItemGroupService;
import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestItemGroupController
 * 
 * @author 진영민
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.19  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@RequestMapping(value = "/master/")
@Controller
public class TestItemGroupController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private TestItemGroupService testItemGroupService;
	
	/**
	 * 항목그룹관리 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/testItemGroup.lims")
	public String testItemGroup(HttpServletRequest request, Model model) {
		return "master/testItemGroup/testItemGroupL01";
	}

	/**
	 * 항목그룹 목록 조회
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectItemGroupList.lims")
	public ModelAndView selectItemGroupList(HttpServletRequest request, Model model, TestItemVO vo) {
		try {
			model.addAttribute("resultData", testItemGroupService.selectItemGroupList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 모든 항목 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAllTestItemList.lims")
	public ModelAndView selectAllTestItemList(HttpServletRequest request, Model model, TestItemVO vo) {
		try {
			List<TestItemVO> gridList = testItemGroupService.selectAllTestItemList(vo);
			TestItemVO returnVO = new TestItemVO();
			if(gridList.size() > 0){
				returnVO.setRows(gridList);
				TestItemVO total = (TestItemVO)gridList.get(0);
				returnVO.setTotalCount(total.getTotalCount());
				returnVO.setPageNum(total.getPageNum());
				returnVO.setTotalPage(total.getTotalPage());
				returnVO.setTotal(total.getTotalCount());
			}
			model.addAttribute("resultData", returnVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 시험 항목그룹 목록 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemInGroupList.lims")
	public ModelAndView selectTestItemInGroupList(HttpServletRequest request, Model model, TestItemVO vo) {
		try {
			model.addAttribute("resultData", testItemGroupService.selectTestItemInGroupList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 그룹항목 저장
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveTestItemInGroup.lims")
	public ModelAndView saveTestItemInGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemGroupService.saveTestItemInGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목그룹 등록
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertTestItemGroup.lims")
	public ModelAndView insertTestItemGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemGroupService.insertTestItemGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목그룹 수정
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateTestItemGroup.lims")
	public ModelAndView updateTestItemGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemGroupService.updateTestItemGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목그룹 삭제
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteTestItemGroup.lims")
	public ModelAndView deleteTestItemGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testItemGroupService.deleteTestItemGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	

	/**
	 * 그룹항목 복사
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/copyTestItemGroup.lims")
	public ModelAndView copyTestItemGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", testItemGroupService.copyTestItemGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
}
