package iit.lims.master.controller;

import java.util.List;

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
import iit.lims.master.service.TestStdService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestStdRevVO;
import iit.lims.master.vo.TestStdVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestStdController
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class TestStdController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private TestStdService testStdService;
	@Resource
	private CommonService commonService;

	/**
	 * 시험기준분류 페이지 전환 처리
	 * 
	 * @param TestStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("testStdRevManage.lims")
	public String testStdManage(HttpServletRequest request, Model model, TestStdVO vo) {
		try {
			/*List<TestStdVO> testStdList = testStdService.selectTestStdList(vo);
			model.addAttribute("list", testStdList);*/
		} catch (Exception e) {
		}
		return "master/testStd/testStdRevL01";
	}

	/**
	 * 시험기준분류 목록 조회
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestStdList.lims")
	public ModelAndView selectTestStdList(HttpServletRequest request, Model model, TestStdVO vo) {
		try {
			List<TestStdVO> testStdList = testStdService.selectTestStdList(vo);
			model.addAttribute("resultData", testStdList);
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험기준분류 저장 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertTestStd.lims")
	public ModelAndView insertTestStd(HttpServletRequest request, 
			@ModelAttribute("vo") TestStdVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = testStdService.insertTestStd(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}
	
	/**
	 * 시험기준분류 수정 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateTestStd.lims")
	public ModelAndView updateTestStd(HttpServletRequest request, 
			@ModelAttribute("vo") TestStdVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = testStdService.updateTestStd(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}
	
	/**
	 * 시험기준분류 삭제 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteTestStd.lims")
	public ModelAndView deleteTestStd(HttpServletRequest request, 
			@ModelAttribute("vo") TestStdVO vo, Model model) throws Exception {
		try {
			int result = testStdService.deleteTestStd(vo);			
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}
	
	/**
	 * 시험기준분류 삭제 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteProtocolItem.lims")
	public ModelAndView deleteProtocolItem(HttpServletRequest request, @ModelAttribute("vo") TestStdVO vo, Model model) throws Exception {
		try {
			int result = testStdService.deleteProtocolItem(vo);			
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}
	
	/**
	 * 시험기준분류 개정이력 목록 조회
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestStdRevList.lims")
	public ModelAndView selectTestStdRevList(HttpServletRequest request, Model model, TestStdRevVO vo) {
		try {	
			List<TestStdRevVO> testStdRevList = testStdService.selectTestStdRevList(vo);
			model.addAttribute("resultData", testStdRevList);
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험기준분류 개정이력 저장 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertTestStdRev.lims")
	public ModelAndView insertTestStdRev(HttpServletRequest request, 
			@ModelAttribute("vo") StdTestItemVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = testStdService.insertTestStdRev(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}
	
	/**
	 * 시험기준분류 개정이력 수정 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
/*	@RequestMapping("updateTestStdRev.lims")
	public ModelAndView updateTestStdRev(HttpServletRequest request, 
			@ModelAttribute("vo") StdTestItemVO vo, Model model) throws Exception {
		try {
			int result = testStdService.updateTestStdRev(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}*/
	
	/**
	 * 시험기준분류 개정이력 삭제 처리
	 * 
	 * @param TestStdVO
	 * @return ModelAndView
	 * @throws Exception
	 */
/*	@RequestMapping("deleteTestStdRev.lims")
	public ModelAndView deleteTestStdRev(HttpServletRequest request, 
			@ModelAttribute("vo") StdTestItemVO vo, Model model) throws Exception {
		try {
			int result = testStdService.deleteTestStdRev(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}		
	}*/
	
	/**
	 * 시험기준분류별 시험항목 페이지 전환 처리
	 * 
	 * @param StdTestItemVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("stdTestItemManage.lims")
	public String stdTestItemManage(HttpServletRequest request, Model model, TestStdRevVO vo) {
		try {
			model.addAttribute("detail", vo);
		} catch (Exception e) {
		}
		return "master/testStd/stdTestItemL01";
	}

	/**
	 * 시험기준분류별 시험항목 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStdTestItemList.lims")
	public ModelAndView selectStdTestItemList(HttpServletRequest request, Model model, StdTestItemVO vo) {
		try {
			if (vo.getPageType() != null && "all".equals(vo.getPageType())) {
				List<StdTestItemVO> stdTestItemList = testStdService.selectAllTestItemList(vo);
				model.addAttribute("resultData", stdTestItemList);
			} else if (vo.getPageType() == null || "".equals(vo.getPageType())) {
				List<StdTestItemVO> gridList = testStdService.selectStdTestItemList(vo);
				StdTestItemVO returnVO = new StdTestItemVO();
				
				if(gridList.size() > 0){
					returnVO.setRows(gridList);
					StdTestItemVO total = (StdTestItemVO)gridList.get(0);
					returnVO.setTotalCount(total.getTotalCount());
					returnVO.setPageNum(total.getPageNum());
					returnVO.setTotalPage(total.getTotalPage());
					returnVO.setTotal(total.getTotalCount());
				} 
				model.addAttribute("resultData", returnVO);
				//model.addAttribute("resultData", testStdService.selectStdTestItemList(vo));
			}
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	

	/**
	 * 시험기준분류별 시험항목 저장
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("insertStdTestItem.lims")
	public ModelAndView insertStdTestItem(HttpServletRequest request, 
			@ModelAttribute("vo") StdTestItemVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = testStdService.insertStdTestItem(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 시험기준분류 팝업 처리
	 * 
	 * @param TestStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("popTestStdManage.lims")
	public String popTestStdManage(HttpServletRequest request, Model model, TestStdVO vo) {
		try {
		/*	List<TestStdVO> testStdList = testStdService.selectTestStdList(vo);
			model.addAttribute("list", testStdList);*/
		} catch (Exception e) {
		}
		return "common/pop/testStdPop";
	}
	
	/**
	 * 시험항목선택 팝업 처리
	 * 
	 * @param TestStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("popStdTestItemManage.lims")
	public String popStdTestItemManage(HttpServletRequest request, Model model, StdTestItemVO vo) {
		try {
		/*	List<TestStdVO> testStdList = testStdService.selectTestStdList(vo);
			model.addAttribute("list", testStdList);*/
		} catch (Exception e) {
		}
		return "master/testStd/stdTestItemP01";
	}
}
