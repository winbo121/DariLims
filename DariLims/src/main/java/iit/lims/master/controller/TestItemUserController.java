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

import iit.lims.master.service.TestItemUserService;
import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestItemUserController
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
public class TestItemUserController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private TestItemUserService testItemUserService;

	/**
	 * 시험항목별담당자 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/testItemUser.lims")
	public String testItemUser(HttpServletRequest request, Model model) {
		return "master/testItemUser/testItemUserL01";
	}

	/**
	 * 시험원 목록 조회
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemUserList.lims")
	public ModelAndView selectTestItemUserList(HttpServletRequest request, Model model, TestItemVO vo) {
		try {
			List<TestItemVO> gridList = testItemUserService.selectTestItemUserList(vo);
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
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 담당시험원 저장
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveTestItemUser.lims")
	public ModelAndView saveTestItemUser(HttpServletRequest request, Model model, TestItemVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemUserService.saveTestItemUser(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
}
