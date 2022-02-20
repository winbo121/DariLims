package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.BoardVO;

/**
 * BoardService
 * @author 최은향
 * @since 2015.03.19
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.19  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface BoardService {

	/**
	 * 게시판 목록 조회
	 *
	 * @param BoardVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<BoardVO> board(BoardVO boardVO) throws Exception;
	
	
	/**
	 * 게시판 상세정보 조회
	 *
	 * @param BoardVO
	 * @return List
	 * @exception Exception	 
	 */
	public BoardVO boardDetail(BoardVO boardVO);
	
	/**
	 * 게시판 (덧글) 상세정보 조회
	 *
	 * @param BoardVO
	 * @return List
	 * @exception Exception	 
	 */
	public BoardVO boardRepleDetail(BoardVO boardVO);
	
	/**
	 * 게시판 상세정보 조회(신규등록용)
	 *
	 * @param BoardVO
	 * @return List
	 * @exception Exception	 
	 */
	public BoardVO boardDetailInsert(BoardVO boardVO);
	
	/**
	 * 게시판 저장(등록/수정) 처리
	 * @param BoardVO
	 * @throws Exception
	 */
	public int insertBoard(BoardVO boardVO) throws Exception;
	
	
	/**
	 * 게시판 삭제 처리 
	 * @param BoardVO
	 * @throws Exception
	 */
	public int deleteBoard(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 첨부파일 다운로드
	 *
	 * @param BoardVO
	 * @return BoardVO
	 * @exception Exception	 
	 */
	public BoardVO boardDown(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 페이징
	 *
	 * @param BoardVO
	 * @return BoardVO
	 * @exception Exception	 
	 */
	public int selectPagingListTotCnt(BoardVO boardVO) throws Exception;
}
