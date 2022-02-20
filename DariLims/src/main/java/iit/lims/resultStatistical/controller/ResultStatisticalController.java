package iit.lims.resultStatistical.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.resultStatistical.service.ResultStatisticalService;
import iit.lims.resultStatistical.vo.ResultStatisticalVO;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.CommonCodeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
/**
 * ResultStatisticalController
 * @author 
 * @since 2015.03.13
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.13  		 최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/resultStatistical/")
@Controller
public class ResultStatisticalController {
	
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private ResultStatisticalService resultStatisticalService;
	@Resource
	private CommonService commonService;
	
	/**
	 * 시험결과검색 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testResultManage.lims")
	public String testResultManage(HttpServletRequest request, Model model) {
		return "resultStatistical/testResult/testResultL01";
	}
	
	/**
	 * 시험결과검색 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReultList.lims")
	public ModelAndView selectTestReultList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(20);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = resultStatisticalService.selectTestReultListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);

			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());

			model.addAttribute("resultData", resultStatisticalService.selectTestReultList(vo));
		} catch (Exception e) {			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 단위업무 공통코드 조회
	 * 
	 * @param HttpServletRequest, Model, CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectCommonCodeUnitWork.lims")
	public ModelAndView selectCommonCodeUnitWork(HttpServletRequest request, Model model, CommonCodeVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectCommonCodeUnitWork(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 통계보고서 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 *//*
	@RequestMapping("statisticalReportsManage.lims")
	public String statisticalReportsManage(HttpServletRequest request, Model model) {
		return "resultStatistical/statistical/statisticalReportsL01";
	}

	
	*//**
	 * 통계보고서 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 *//*
	@RequestMapping("statisticalReports.lims")
	public ModelAndView sampleInsert(HttpServletRequest request, Model model, ResultStatisticalVO resultStatisticalVO) {
		try {
			model.addAttribute("resultData", resultStatisticalService.statisticalReports(resultStatisticalVO));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}*/
	
	/**
	 * 시료정보조회 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testSampleStateManage.lims")
	public String testSampleStateManage(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("rsVO", vo);
		} catch (Exception e) {
			
		}
		return "resultStatistical/testSampleState/testSampleStateL01";
	}

	@RequestMapping("testSampleStateManageSales.lims")
	public String testSampleStateManageSales(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("rsVO", vo);
		} catch (Exception e) {
			
		}
		return "resultStatistical/testSampleState/testSampleStateL02";
	}
	
	/**
	 * 시료정보조회 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestSampleStateList.lims")
	public ModelAndView selectTestSampleStateList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectTestSampleStateList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험결과검색(이전) 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("testResultBManage.lims")
	public String testResultBManage(HttpServletRequest request, Model model) throws Exception {
		try{
		} catch(Exception e){
			throw e;
		}
		return "resultStatistical/testResultB/testResultBL01";
	}
	
	/**
	 * 시험결과검색(이전) 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReultBList.lims")
	public ModelAndView selectTestReultBList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectTestReultBList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험결과검색(이전) 단위업무 팝업 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popUnitWork.lims")
	public String popUnitWork(HttpServletRequest request, Model model) {
		return "resultStatistical/testResultB/testResultBP01";
	}
	
	/**
	 * 시험결과검색(이전) 단위업무 팝업 페이지 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectUnitWorkList.lims")
	public ModelAndView selectUnitWorkList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectUnitWorkList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험결과검색(이전) 단위업무 팝업 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popSampleChoice.lims")
	public String popSampleChoice(HttpServletRequest request, Model model) {
		return "resultStatistical/testResultB/testResultBP02";
	}
	
	/**
	 * 시험결과검색(이전) 검체 팝업 페이지 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectSampleChoiceList.lims")
	public ModelAndView selectSampleChoiceList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectSampleChoiceList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험결과검색(이전) 시험항목 팝업 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("popTestItemSearch.lims")
	public String popTestItemSearch(HttpServletRequest request, Model model) {
		return "resultStatistical/testResultB/testResultBP03";
	}
	
	/**
	 * 시험결과검색(이전) 시험항목 팝업 페이지 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestItemSearchList.lims")
	public ModelAndView selectTestItemSearchList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectTestItemSearchList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 과별단위업무실적 페이지 전환 처리
	 * 
	 * @param HttpServletRequest, Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deptUnitWorkPerfManage.lims")
	public String deptUnitWorkPerfManage(HttpServletRequest request, Model model) {
		return "resultStatistical/deptUnitWorkPerf/deptUnitWorkPerfL01";
	}
	
	/**
	 * 과별단위업무실적 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectDeptUnitWorkPerfList.lims")
	public ModelAndView selectDeptUnitWorkPerfList(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectDeptUnitWorkPerfList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	} 
	
	/**
	 * 과별단위업무실적 시료구분콤보 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectSampleCombo.lims")
	public ModelAndView selectSampleCombo(HttpServletRequest request, Model model, ResultStatisticalVO vo) {
		try {
			model.addAttribute("resultData", resultStatisticalService.selectSampleCombo(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 시험결과검색 페이징 처리
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectTestReultListPaging.lims")
	public String selectTestReultListPaging(HttpServletRequest request, Model model, ResultStatisticalVO vo) throws Exception {
		try {
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(20);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = resultStatisticalService.selectTestReultListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging"; // 공지사항 폴더에 페이징 HTML(공통으로 사용)
	}	
	
}
