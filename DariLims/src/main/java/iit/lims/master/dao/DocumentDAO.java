package iit.lims.master.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.DocumentVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * Document
 * 
 * @author 최은향
 * @since 2015.10.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.01  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class DocumentDAO extends EgovAbstractMapper {
	
	public List<DocumentVO> selectFormList(DocumentVO vo) {
		return selectList("document.selectFormList", vo);
	}
	
	public List<DocumentVO> selectDocumentList(DocumentVO vo) {
		return selectList("document.selectDocumentList", vo);
	}

	public DocumentVO documentDetail(DocumentVO vo) {
		return (DocumentVO) selectOne("document.documentDetail", vo);
	}
	
	public String selectFormNo() throws Exception {
		return selectOne("document.selectFormNo", null);
	}
	
	public int insertForm(DocumentVO vo) throws DataAccessException {
		insert("document.insertForm", vo);
		return 1;
	}

	public int updateForm(DocumentVO vo) throws DataAccessException {
		return update("document.updateForm", vo);
	}
	
	public int insertDocument(DocumentVO vo) throws DataAccessException {
		insert("document.insertDocument", vo);
		return 1;
	}

	public int updateDocument(DocumentVO vo) throws DataAccessException {
		return update("document.updateDocument", vo);
	}

	public String selectDocumentNo(DocumentVO vo) throws Exception {
		return selectOne("document.selectDocumentNo", vo);
	}
	
	public int deleteForm(DocumentVO vo) throws DataAccessException {
		return update("document.deleteForm", vo);
	}
	
	public Integer countDeleteDoc(DocumentVO vo) throws Exception {
		return selectOne("document.countDeleteDoc", vo);
	}
	
	public int deleteDocument(DocumentVO vo) throws DataAccessException {
		return update("document.deleteDocument", vo);
	}
	
	public DocumentVO selectFormNo(DocumentVO vo) throws Exception {
		return (DocumentVO) selectOne("document.selectFormNo", vo);
	}

	public Integer countFormDocFile(DocumentVO vo) throws Exception {
		return selectOne("document.countFormDocFile", vo);
	}
	
	public int insertFormDocFile(DocumentVO vo) throws Exception {
		return insert("document.insertFormDocFile", vo);
	}

	public int updateFormDocFile(DocumentVO vo) throws Exception {
		return update("document.updateFormDocFile", vo);
	}

	public int deleteFormDocFile(DocumentVO vo) throws Exception {
		return delete("document.deleteFormDocFile", vo);
	}

	public DocumentVO formDocDown(DocumentVO vo) throws Exception {
		return (DocumentVO) selectOne("document.formDocDown", vo);
	}
}