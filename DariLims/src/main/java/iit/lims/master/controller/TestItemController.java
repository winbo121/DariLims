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

import iit.lims.master.service.TestItemService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestItemController
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
public class TestItemController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private TestItemService testItemService;

	/**
	 * 항목등록 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/testItem.lims")
	public String testItem(HttpServletRequest request, Model model) {
		return "master/testItem/testItemL01";
	}

	/**
	 * 수수료관리 팝업 페이지
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/feeGroup.lims")
	public String feeGroup(HttpServletRequest request, Model model) {
		return "common/pop/testItemPop";
	}

	/**
	 * 수수료관리 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectFeeGroupList.lims")
	public ModelAndView selectGridTestStdList(HttpServletRequest request, Model model, TestItemVO vo) {
		try {
			model.addAttribute("resultData", testItemService.selectFeeGroupList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 수수료 관리 등록
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertFeeGroup.lims")
	public ModelAndView insertFeeGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemService.insertFeeGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 수수료 관리 수정
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateFeeGroup.lims")
	public ModelAndView updateFeeGroup(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemService.updateFeeGroup(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목 리스트 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemList.lims")
	public ModelAndView selectTestItemList(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testItemService.selectTestItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목 등록
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertTestItem.lims")
	public ModelAndView insertTestItem(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemService.insertTestItem(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목 수정
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateTestItem.lims")
	public ModelAndView updateTestItem(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemService.updateTestItem(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목 삭제
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteTestItem.lims")
	public ModelAndView deleteTestItem(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testItemService.deleteTestItem(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 항목 상세 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemDetail.lims")
	public String selectTestItemDetail(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			if (vo.getPageType() != null && "detail".equals(vo.getPageType())) {
				model.addAttribute("detail", testItemService.selectTestItemDetail(vo));
			} else {
				model.addAttribute("detail", new TestItemVO());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/testItem/testItemD01";
	}
	
	/**
	 * 모든 항목 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemAllList.lims")
	public ModelAndView selectTestItemAllList(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			List<TestItemVO> gridList = testItemService.selectTestItemAllList(vo);
			model.addAttribute("resultData", gridList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

}
