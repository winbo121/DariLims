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
import iit.lims.system.service.AuditTrailService;
import iit.lims.system.vo.AuditTrailVO;
import iit.lims.system.vo.LogVO;
import iit.lims.util.JsonView;

/**
 * AuditTrailController
 * 
 * @auditTrailor 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
public class AuditTrailController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private AuditTrailService auditTrailService;
	/**
	 * 감사추적 페이지 전환 처리
	 * 
	 * @param AuditTrailVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/auditTrailManage.lims")
	public String auditTrail(HttpServletRequest request, Model model, AuditTrailVO auditTrailVO) {
		return "system/auditTrail/auditTrailL01";
	}

	/**
	 * 감사추적 목록 조회
	 * 
	 * @param AuditTrailVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAuditTrailList.lims")
	public ModelAndView selectAuditTrailList(HttpServletRequest request, Model model, AuditTrailVO auditTrailVO) throws Exception {
		try {
			
			int currPage = auditTrailVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = auditTrailVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(25);
			paginationInfo.setPageSize(10);

			auditTrailVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			auditTrailVO.setLastIndex(paginationInfo.getLastRecordIndex());
			auditTrailVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			//int totCnt = auditTrailService.selectAuditTrailPagingListTotCnt(auditTrailVO);
			//paginationInfo.setTotalRecordCount(totCnt);			
			
			List<AuditTrailVO> auditTrailList = auditTrailService.selectAuditTrailList(auditTrailVO);
			model.addAttribute("resultData", auditTrailList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 감사추적 페이징 처리
	 * 
	 * @param BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/auditTrailPaging.lims")
	public String auditTrailPaging(HttpServletRequest request, Model model, AuditTrailVO auditTrailVO) throws Exception {
		try {
			int currPage = auditTrailVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = auditTrailVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(25);
			paginationInfo.setPageSize(10);

			auditTrailVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			auditTrailVO.setLastIndex(paginationInfo.getLastRecordIndex());
			auditTrailVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = auditTrailService.selectAuditTrailPagingListTotCnt(auditTrailVO);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging"; // 공지사항 폴더에 페이징 HTML(공통으로 사용)
	}
	
	
	/**
	 * 감사추적 상세정보 조회
	 * 
	 * @param AuditTrailVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectAuditTrailDetail.lims")
	public ModelAndView selectAuditTrailDetail(HttpServletRequest request, Model model, AuditTrailVO auditTrailVO) throws Exception {
		try {
			List<AuditTrailVO> auditTrailList = auditTrailService.selectAuditTrailDetail(auditTrailVO);
			model.addAttribute("resultData", auditTrailList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

}
