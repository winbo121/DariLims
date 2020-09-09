package iit.lims.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import iit.lims.system.service.LogService;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.LogVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;

/**
 * LogController
 * @logor 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Controller
public class LogController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private LogService logService;
	
	/**
	 * 부서관리 페이지 전환 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/log.lims")
	public String log(HttpServletRequest request, Model model, LogVO logVO) {
		return "system/log/logL01";
	}
	
	/**
	 * 부서관리 목록 조회
	 * 
	 * @param LogVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectLogList.lims")
	public ModelAndView selectLogList(HttpServletRequest request, Model model, LogVO logVO) throws Exception {
		
		try {
			int currPage = logVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = logVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(25);
			paginationInfo.setPageSize(10);

			logVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			logVO.setLastIndex(paginationInfo.getLastRecordIndex());
			logVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = logService.selectPagingListTotCnt(logVO);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("resultData", logService.selectLogList(logVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
//		try {
//			List<LogVO> logList = logService.selectLogList(logVO);
//			model.addAttribute("resultData", logList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 로그 페이징 처리
	 * 
	 * @param BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/logPaging.lims")
	public String logPaging(HttpServletRequest request, Model model, LogVO logVO) throws Exception {
		try {
			int currPage = logVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = logVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(25);
			paginationInfo.setPageSize(10);

			logVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			logVO.setLastIndex(paginationInfo.getLastRecordIndex());
			logVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = logService.selectPagingListTotCnt(logVO);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging"; // 공지사항 폴더에 페이징 HTML(공통으로 사용)
	}
	
}
