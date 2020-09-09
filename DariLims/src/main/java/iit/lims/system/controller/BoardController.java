package iit.lims.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.system.service.BoardService;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonTextView;
import iit.lims.util.JsonView;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * BoardController
 * 
 * @author 최은향
 * @since 2015.03.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.19  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/system/")
@Controller
public class BoardController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private BoardService boardService;
	@Resource
	private CommonService commonService;

	/**
	 * 자유 게시판 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("freeBoardManage.lims")
	public String freeBoardManage(HttpServletRequest request, Model model) {
		return "system/free/freeBoardL01";
	}

	/**
	 * 질문과답변 게시판 페이지 전환 처리
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("qnaBoardManage.lims")
	public String qnaBoardManage(HttpServletRequest request, Model model) {
		return "system/qna/qnaBoardL01";
	}

	/**
	 * 게시판 목록 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("board.lims")
	public ModelAndView board(HttpServletRequest request, Model model, BoardVO boardVO) {

		try {
			int currPage = boardVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = boardVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
			boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = boardService.selectPagingListTotCnt(boardVO);

			paginationInfo.setTotalRecordCount(totCnt);

			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			boardVO.setUser_id(userInfoVO.getUser_id());

			model.addAttribute("resultData", boardService.board(boardVO));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 자유 게시판 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("freeBoardD01.lims")
	public String freeBoardDetail(HttpServletRequest request, Model model, BoardVO boardVO) {

		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new BoardVO());
		} else {
			try {
				model.addAttribute("detail", boardService.boardDetail(boardVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "system/free/freeBoardD01";
	}

	/**
	 * 질문과답변 게시판 상세정보 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("qnaBoardD01.lims")
	public String qnaBoardDetail(HttpServletRequest request, Model model, BoardVO boardVO) {

		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", new BoardVO());
		} else {
			try {
				model.addAttribute("detail", boardService.boardDetail(boardVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "system/qna/qnaBoardD01";
	}

	/**
	 * 자유 게시판 덧글 쓰기 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("freeBoardD02.lims")
	public String boardDetail02(HttpServletRequest request, Model model, BoardVO boardVO) {

		boardVO.setKey(request.getParameter("key"));
		boardVO.setBoard_no(request.getParameter("board_no"));

		model.addAttribute("PreDetail", boardService.boardDetail(boardVO));

		if (request.getParameter("pageType").equals("insert")) {
			model.addAttribute("detail", boardService.boardDetailInsert(boardVO));

		} else {
			try {
				model.addAttribute("detail", boardService.boardRepleDetail(boardVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "system/free/freeBoardD02";
	}

	/**
	 * 질문과 답변 게시판 덧글 쓰기 조회
	 * 
	 * @param HttpServletRequest
	 *            , Model, BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("qnaBoardD02.lims")
	public String qnaBoardDetail02(HttpServletRequest request, Model model, BoardVO boardVO) {

		boardVO.setKey(request.getParameter("key"));
		boardVO.setBoard_no(request.getParameter("board_no"));

		model.addAttribute("PreDetail", boardService.boardDetail(boardVO));

		if (request.getParameter("pageType").equals("insert")) {
			//System.out.println(request.getParameter("board_type"));
			model.addAttribute("detail", boardService.boardDetailInsert(boardVO));

		} else {
			try {
				model.addAttribute("detail", boardService.boardRepleDetail(boardVO));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "system/qna/qnaBoardD02";
	}

	/**
	 * 게시판 (저장/수정) 처리
	 * 
	 * @param MachineVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertBoard.lims")
	public ModelAndView insertBoard(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, Model model) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			boardVO.setUser_id(userInfoVO.getUser_id());

			int result = boardService.insertBoard(boardVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonTextView());
		} catch (Exception e) {
			log.error(boardVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 게시판 삭제 처리
	 * 
	 * @param BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("deleteBoard.lims")
	public ModelAndView deleteBoard(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, Model model) throws Exception {
		try {
			int result = boardService.deleteBoard(boardVO);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(boardVO.toString(), e);
			throw e;
		}
	}

	/**
	 * 게시판 첨부파일 다운로드
	 * 
	 * @param BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("boardDown.lims")
	public ModelAndView boardDown(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		try {			
			boardVO.setPath(request.getParameter("path"));			
			BoardVO f = boardService.boardDown(boardVO);
			if (f != null) {
				model.addAttribute("data", f.getAdd_file());
				model.addAttribute("fileName", f.getFile_nm());
			}
		} catch (Exception e) {
			log.error(boardVO.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}

	/**
	 * 게시판 페이징 처리
	 * 
	 * @param BoardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("boardPaging.lims")
	public String boardPaging(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		try {
			int currPage = boardVO.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = boardVO.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
			boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = boardService.selectPagingListTotCnt(boardVO);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging"; // 공지사항 폴더에 페이징 HTML(공통으로 사용)
	}
}