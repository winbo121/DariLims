package iit.lims.system.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.system.vo.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class BoardDAO extends EgovAbstractMapper {

	public List<BoardVO> board(BoardVO boardVO) throws DataAccessException {
		return selectList("Board.board", boardVO);
	}

	public BoardVO boardDetail(BoardVO boardVO) {
		return (BoardVO) selectOne("Board.boardDetail", boardVO);
	}
	
	public BoardVO boardRepleDetail(BoardVO boardVO) {
		return (BoardVO) selectOne("Board.boardRepleDetail", boardVO);
	}
	
	public BoardVO boardDetailInsert(BoardVO boardVO) {
		return (BoardVO) selectOne("Board.boardDetailInsert", boardVO);
	}

	public int insertBoard(BoardVO boardVO) throws DataAccessException {
		insert("Board.insertBoard", boardVO);
		return 1;
	}

	public int updateBoard(BoardVO boardVO) throws DataAccessException {
		return update("Board.updateBoard", boardVO);
	}

	public int deleteBoard(BoardVO boardVO) throws DataAccessException {
		return update("Board.deleteBoard", boardVO);
	}
	
	public BoardVO boardDown(BoardVO boardVO) throws Exception {
		return (BoardVO) selectOne("Board.boardDown", boardVO);
	}
	
	public int boardCnt(BoardVO boardVO) {
		return (Integer) selectOne("Board.boardCnt", boardVO);
	}
}
