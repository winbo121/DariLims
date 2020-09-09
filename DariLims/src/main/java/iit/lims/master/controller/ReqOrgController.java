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
import iit.lims.master.service.ReqOrgService;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * ReqOrgController
 * 
 * @author 석은주
 * @since 2015.01.23
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.23  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class ReqOrgController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private ReqOrgService reqOrgService;
	@Resource
	private CommonService commonService;

	/**
	 * 의뢰처 관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("reqOrgManage.lims")
	public String menu(HttpServletRequest request, Model model, CommonCodeVO vo) {
		return "master/reqOrg/reqOrgL01";
	}

	/**
	 * 의뢰처 관리 목록 조회
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReqOrgList.lims")
	public ModelAndView selectReqOrgList(HttpServletRequest request, Model model, ReqOrgVO vo) throws Exception {
		try {
			List<ReqOrgVO> gridList = reqOrgService.selectReqOrgList(vo);
			ReqOrgVO returnVO = new ReqOrgVO();
			if(gridList.size() > 0){
				returnVO.setRows(gridList);
				ReqOrgVO total = (ReqOrgVO)gridList.get(0);
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
	 * 의뢰처관리 상세정보 조회 / 신규등록 페이지 열기
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectReqOrgD01.lims")
	public String selectMenuDetail(HttpServletRequest request, Model model, ReqOrgVO vo) {
		try {
			model.addAttribute("detail", reqOrgService.selectReqOrgDetail(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/reqOrg/reqOrgD01";
	}

	/**
	 * 의뢰처관리 저장 처리
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertReqOrg.lims")
	public ModelAndView insertReqOrg(HttpServletRequest request, @ModelAttribute("vo") ReqOrgVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = reqOrgService.insertReqOrg(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 의뢰처관리 수정 처리
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateReqOrg.lims")
	public ModelAndView updateReqOrg(HttpServletRequest request, @ModelAttribute("vo") ReqOrgVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = reqOrgService.updateReqOrg(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 의뢰처관리 삭제 처리
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteReqOrg.lims")
	public ModelAndView deleteReqOrg(HttpServletRequest request, @ModelAttribute("vo") ReqOrgVO vo, Model model) throws Exception {
		try {
			int result = reqOrgService.deleteReqOrg(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 의뢰처관리 복사 
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("copyReqOrg.lims")
	public ModelAndView copyReqOrg(HttpServletRequest request, @ModelAttribute("vo") ReqOrgVO vo, Model model) throws Exception {
		try {
			int result = reqOrgService.copyReqOrg(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
}
