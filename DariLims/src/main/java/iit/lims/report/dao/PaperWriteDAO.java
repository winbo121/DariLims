package iit.lims.report.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.report.vo.PaperVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * PaperWriteDAO
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class PaperWriteDAO extends EgovAbstractMapper {

	public List<PaperVO> selectPaperList(PaperVO vo) throws Exception {
		return selectList("paperWrite.selectPaperList", vo);
	}

	public PaperVO selectPaperDetail(PaperVO vo) throws Exception {
		return selectOne("paperWrite.selectPaperDetail", vo);
	}

	public int updatePaperDetail(PaperVO vo) throws Exception {
		return update("paperWrite.updatePaperDetail", vo);
	}

	public String selectPaperNo() throws Exception {
		return selectOne("paperWrite.selectPaperNo");
	}

	public void insertPaperDetail(PaperVO vo) throws Exception {
		insert("paperWrite.insertPaperDetail", vo);
	}

	public void deletePaperDetail(PaperVO vo) throws Exception {
		insert("paperWrite.deletePaperDetail", vo);
	}

}
