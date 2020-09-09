package iit.lims.master.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.master.service.PrdLstService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * PrdLstController
 * 
 * @author 윤상준
 * @since 2015.12.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.17  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/master/")
@Controller
public class PrdLstController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private PrdLstService prdLstService;
	@Resource
	private CommonService commonService;

	/**
	 * 품목 관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("prdLstManage.lims")
	public String prdLstManage(HttpServletRequest request, Model model, PrdLstVO vo) {
		return "master/prdLst/prdLstL01";
	}

	/**
	 * 품목 리스트 조회 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectPrdLstList.lims")
	public ModelAndView selectPrdLstList(HttpServletRequest request, Model model, PrdLstVO prdLstVO) {
		try {
			List<PrdLstVO> gridList = prdLstService.selectPrdLstList(prdLstVO);
//			PrdLstVO returnVO = new PrdLstVO();
			
//			if(gridList.size() > 0){
//				returnVO.setRows(gridList);
//				PrdLstVO total = (HashMap<String,Object>)gridList.get(0);
//				returnVO.setTotalCount(total.getTotalCount());
//				returnVO.setPageNum(total.getPageNum());
//				returnVO.setTotalPage(total.getTotalPage());
//				returnVO.setTotal(total.getTotalCount());
//			}
			model.addAttribute("resultData", gridList);
			
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 품목 관리 세부페이지 전환 처리
	 * 
	 * @param PrdLstVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectPrdLstDetail.lims")
	public String selectPrdLstDetail(HttpServletRequest request, Model model, PrdLstVO prdLstVO) {
		try {
			if (prdLstVO.getPageType() != null && "detail".equals(prdLstVO.getPageType())) {
				model.addAttribute("detail", prdLstService.selectPrdLstListDetail(prdLstVO));
				model.addAttribute("pageType", prdLstVO.getPageType());
			}else{
				model.addAttribute("pageType", prdLstVO.getPageType());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/prdLst/prdLstD01";
	}
	
	
	/**
	 * 품목관리 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("prdLstPop.lims")
	public String prdLstPop() throws Exception {
		return "common/pop/prdLstPop";
	}
	
	/**
	 * 식약처품목관리 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("kfdaPrdLstPop.lims")
	public String kfdaPrdLstPop() throws Exception {
		return "common/pop/kfdaPrdLstPop";
	}
	
	/**
	 * 식약처품목관리 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("prdlstGubunPop.lims")
	public String prdlstGubunPop() throws Exception {
		return "common/pop/prdlstGubunPop";
	}

	
	/**
	 * 품목관리 저장 처리
	 * 
	 * @param PrdLstVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertPrdlst.lims")
	public ModelAndView insertPrdlst(HttpServletRequest request, @ModelAttribute("prdLstVO") PrdLstVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = prdLstService.insertPrdlst(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());

		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 품목관리 수정 처리
	 * 
	 * @param PrdLstVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updatePrdlst.lims")
	public ModelAndView updatePrdlst(HttpServletRequest request, @ModelAttribute("prdLstVO") PrdLstVO vo, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			int result = prdLstService.updatePrdlst(vo);

			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}	
	
}
