package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.BoardDAO;
import iit.lims.system.service.BoardService;
import iit.lims.system.vo.BoardVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * BoardServiceImpl
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

@Service
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	static final Logger log = LogManager.getLogger();

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	/**
	 * 게시판 목록 조회
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	public List<BoardVO> board(BoardVO boardVO) throws Exception {
		return boardDAO.board(boardVO);
	}

	/**
	 * 게시판 상세정보 조회
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	public BoardVO boardDetail(BoardVO boardVO) {
		try {
			return boardDAO.boardDetail(boardVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 게시판 상세정보(덧글) 조회
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	public BoardVO boardRepleDetail(BoardVO boardVO) {
		try {
			return boardDAO.boardRepleDetail(boardVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 게시판 상세정보 조회(신규등록용)
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	public BoardVO boardDetailInsert(BoardVO boardVO) {
		try {
			return boardDAO.boardDetailInsert(boardVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 게시판 저장(등록/수정) 처리
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	public int insertBoard(BoardVO boardVO) throws Exception {
		int result;
		try {
			if (boardVO.getM_file() != null && boardVO.getM_file().getSize() > 0) {
				boardVO.setAdd_file(boardVO.getM_file().getBytes());
				boardVO.setFile_nm(boardVO.getM_file().getOriginalFilename());
			}
			if (boardVO.getPageType().equals("insert")) {
				result = boardDAO.insertBoard(boardVO);
			} else {
				result = boardDAO.updateBoard(boardVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	/**
	 * 게시판 삭제 처리
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	public int deleteBoard(BoardVO boardVO) throws Exception {
		try {
			return boardDAO.deleteBoard(boardVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 게시판 첨부파일 다운로드
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	@Override
	public BoardVO boardDown(BoardVO boardVO) throws Exception {
		try {
			return boardDAO.boardDown(boardVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 게시판 페이징
	 * 
	 * @param BoardVO
	 * @throws Exception
	 */
	@Override
	public int selectPagingListTotCnt(BoardVO boardVO) throws Exception {
		return boardDAO.boardCnt(boardVO);
	}
}
