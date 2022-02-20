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

import iit.lims.system.service.NoticeService;
import iit.lims.system.vo.NoticeVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonTextView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NoticeController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private NoticeService noticeService;

	/**
	 * 공지사항관리 페이지 전환 처리
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/noticeManage.lims")
	public String noticeManage(HttpServletRequest request, Model model) {
		return "system/notice/noticeL01";
	}

	/**
	 * 공지사항관리 목록 조회
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/selectNoticeList.lims")
	public ModelAndView selectNoticeList(HttpServletRequest request,
			Model model, NoticeVO vo) throws Exception {
		try {
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			
			// 관리자 권한
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			String role = userInfoVO.getTotal_role_no();
			String[] roleRst = role.split("\\|");
			String roleFlag = "001"; // 권한 Number
			
			for(int i = 0; i< roleRst.length; i++ ){
				//System.out.println(i+"권한: " + roleRst[i]);
				if(roleRst[i].equals(roleFlag)){
					vo.setRole_no(roleFlag); 
				}
			}
			
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			int totCnt = noticeService.selectPagingListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);

			List<NoticeVO> noticeList = noticeService.selectNoticeList(vo);

			model.addAttribute("resultData", noticeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 공지사항관리 목록 페이징 처리
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/noticePaging.lims")
	public String noticePaging(HttpServletRequest request,
			Model model, NoticeVO vo) throws Exception {
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
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = noticeService.selectPagingListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging";
	}
	
	/**
	 * 공지사항관리 상세 조회
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/noticeDetail.lims")
	public String noticeDetail(HttpServletRequest request, Model model, NoticeVO vo) {
		model.addAttribute("detail", noticeService.noticeDetail(vo));
		return "system/notice/noticeD01";
	}
	
	/**
	 * 공지사항관리 저장
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/system/saveNotice.lims")
	public ModelAndView saveNotice(HttpServletRequest request, Model model, NoticeVO vo) {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setCreater_id(userInfoVO.getUser_id());
			
			model.addAttribute("resultData", noticeService.saveNotice(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 메인화면 공지사항 목록
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mainNotice.lims")
	public ModelAndView mainNoticeList(HttpServletRequest request, NoticeVO vo, Model model) throws Exception {
		model.addAttribute("resultData", noticeService.mainNoticeList(vo));
		return new ModelAndView(new JsonTextView());
	}
	
	
	@RequestMapping("/system/noticeP01.lims")
	public String noticeP01(HttpServletRequest request, Model model, NoticeVO vo) {
		model.addAttribute("detail", noticeService.noticeDetail(vo));
		return "system/notice/noticeP01";
	}
	
}
