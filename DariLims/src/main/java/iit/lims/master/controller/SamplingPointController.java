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

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import iit.lims.common.service.CommonService;
import iit.lims.master.service.SamplingPointService;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.util.JsonView;

/**
 * SamplingPointController
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
public class SamplingPointController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private SamplingPointService samplingPointService;
	@Resource
	private CommonService commonService;

	/**
	 * 채수장소관리 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/samplingPointManage.lims")
	public String samplingPointManage(HttpServletRequest request, Model model) {
		return "master/requestWork/samplingPointL01";
	}

	/**
	 * 채수장소관리 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/samplingPoint.lims")
	public ModelAndView samplingPoint(HttpServletRequest request, Model model, SamplingPointVO samplingPointVO) {
		try {
			int currPage = samplingPointVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = samplingPointVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			samplingPointVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			samplingPointVO.setLastIndex(paginationInfo.getLastRecordIndex());
			samplingPointVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = samplingPointService.selectPagingListTotCnt(samplingPointVO);

			paginationInfo.setTotalRecordCount(totCnt);
			
			model.addAttribute("resultData", samplingPointService.samplingPoint(samplingPointVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 채수장소관리 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/samplingPointD01.lims")
	public String samplingPointDetail(HttpServletRequest request, Model model, SamplingPointVO samplingPointVO) {

		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new SamplingPointVO());
		} else {
			try {
				model.addAttribute("detail", samplingPointService.samplingPointDetail(samplingPointVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "master/requestWork/samplingPointD01";
	}

	/**
	 * 채수장소관리 저장 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/insertSamplingPoint.lims")
	public ModelAndView insertSamplingPoint(HttpServletRequest request, @ModelAttribute("samplingPointVO") SamplingPointVO samplingPointVO, Model model) throws Exception {
		try {
			int result = samplingPointService.insertSamplingPoint(samplingPointVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(samplingPointVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 채수장소관리 수정 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/updateSamplingPoint.lims")
	public ModelAndView updateSamplingPoint(HttpServletRequest request, @ModelAttribute("samplingPointVO") SamplingPointVO samplingPointVO, Model model) throws Exception {
		try {
			int result = samplingPointService.updateSamplingPoint(samplingPointVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(samplingPointVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 채수장소관리 삭제 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/deleteSamplingPoint.lims")
	public ModelAndView deleteSamplingPoint(HttpServletRequest request, @ModelAttribute("samplingPointVO") SamplingPointVO samplingPointVO, Model model) throws Exception {
		try {
			int result = samplingPointService.deleteSamplingPoint(samplingPointVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(samplingPointVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 채수장소관리 사업소 페이지 전환(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/master/popSamplingPointManage.lims")
	public String popTestStdManage(HttpServletRequest request, Model model, SamplingPointVO samplingPointVO) {
		return "master/requestWork/samplingPointP01";
	}

	/**
	 * 채수장소관리 사업소 조회(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/master/selectOfficeList.lims")
	public ModelAndView selectOfficeList(Model model, SamplingPointVO samplingPointVO) {
		try {
			model.addAttribute("resultData", samplingPointService.selectOfficeList(samplingPointVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
}