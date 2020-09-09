package iit.lims.master.controller;

import java.util.HashMap;
import java.util.List;

import iit.lims.common.service.CommonService;
import iit.lims.common.vo.PagingVO;
import iit.lims.master.service.TestPrdStdService;
import iit.lims.master.service.TestStandardService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value = "/master/")
@Controller
public class testStandardController {

	static final Logger log = LogManager.getLogger();
	
	@Resource
	private TestPrdStdService testPrdStdService;
	@Resource
	private CommonService commonService;
	
	@Resource
	private TestStandardService testStandardService;
	
	/**
	 * 시험기준분류 페이지 전환 처리
	 * 
	 * @param TestPrdStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("testStandardManage.lims")
	public String testPrdStdManage(HttpServletRequest request, Model model) {
		return "master/testStandard/testStandardL01";
	}
	
	/**
	 * 시험기준분류별 시험항목 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStandardItemList.lims")
	public ModelAndView selectStandardItemList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) {
		try {
			model.addAttribute("resultData", testPrdStdService.selectStdTestPrdItemList(param));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	
	
	
	@RequestMapping("selectfnprtStdItemList.lims")
	public ModelAndView selectfnprtStdItemList(HttpServletRequest request, Model model, TestPrdStdVO vo, StdTestItemVO svo) {
		try {
			model.addAttribute("resultData", testPrdStdService.selectfnprtItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 스탠다드별 시험항목 저장
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("insertTestStandardItem.lims")
	public ModelAndView iinsertTestStandardItem(HttpServletRequest request, 
			@ModelAttribute("vo") TestStandardVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			int result = testStandardService.insertTestStandardItem(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	
	
	/**
	 * 검사기준복사저장
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("saveCopySpec01.lims")
	public ModelAndView saveCopySpec01(HttpServletRequest request, 
			@ModelAttribute("vo") TestPrdStdVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			int result = testPrdStdService.saveCopySpec(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 시험항목선택 팝업 처리
	 * 
	 * @param TestPrdStdVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/testStandardItemChoice.lims")
	public String popStdTestPrdItemManage(HttpServletRequest request, Model model, StdTestItemVO vo) {
		return "master/testStandard/testStandardP01";
	}
	
	/**
	 * 스탠다드 등록
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertStandardItem.lims")
	public ModelAndView insertStandardItem(HttpServletRequest request, Model model, TestStandardVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testStandardService.insertStandardItem(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 스탠다드 수정
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateStandardItem.lims")
	public ModelAndView updateStandardItem(HttpServletRequest request, Model model, TestStandardVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testStandardService.updateStandardItem(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 스탠다드 복사
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/copyStandard.lims")
	public ModelAndView copyStandard(HttpServletRequest request, Model model, TestStandardVO vo) throws Exception {
		try {
			model.addAttribute("resultData", testStandardService.copyStandard(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험기준분류별 시험항목 목록 조회
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStandardList.lims")
	public ModelAndView selectStandardList(HttpServletRequest request, Model model, TestStandardVO vo) {
		try {
			model.addAttribute("resultData", testStandardService.selectStandardList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}	
	
	/**
	 * 스탠다드별 시험항목 목록 조회
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStandardRItemList.lims")
	public ModelAndView selectStandardRItemList(HttpServletRequest request, Model model, TestStandardVO vo, StdTestItemVO svo) {
		try {
			model.addAttribute("resultData", testStandardService.selectStandardRItemList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	/**
	 * 스탠다드별 시험항목 목록 조회 - 팝업
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectStandardRItemListPop.lims")
	public ModelAndView selectStandardRItemListPop(HttpServletRequest request, Model model, TestStandardVO vo, StdTestItemVO svo) {
		try {
			model.addAttribute("resultData", testStandardService.selectStandardRItemListPop(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 스탠다드 팝업 항목 조회
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectStandardPIList.lims")
	public ModelAndView selectStandardPIList(HttpServletRequest request, Model model, TestStandardVO vo) throws Exception {
		try {
			List<TestStandardVO> gridList = testStandardService.selectStandardPIList(vo);
			model.addAttribute("resultData", gridList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 스탠다드 팝업창 항목 저장
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertStandardPLItem.lims")
	public ModelAndView insertStandardPLItem(HttpServletRequest request, Model model, TestStandardVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());

			model.addAttribute("resultData", testStandardService.insertStandardInsItemPop(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("copyTestStandardItem.lims")
	public ModelAndView copyTestStandardItem(HttpServletRequest request, 
			@ModelAttribute("vo") TestStandardVO vo, Model model) throws Exception{
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			int result = testStandardService.copyTestStandardItem(vo);
			
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
}
