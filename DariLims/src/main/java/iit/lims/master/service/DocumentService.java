package iit.lims.master.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import iit.lims.master.vo.DocumentVO;

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

public interface DocumentService {
	
	/**
	 * 양식 관리 목록 조회
	 * 
	 * @param DocumentVO
	 * @return List
	 * @throws Exception
	 */
	public List<DocumentVO> selectFormList(DocumentVO vo) throws Exception;
	
	/**
	 * 양식 관리 저장 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int insertForm(DocumentVO vo) throws Exception;

	/**
	 * 양식 관리 수정 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int updateForm(DocumentVO vo) throws Exception;

	/**
	 * 양식 관리 삭제 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int deleteForm(DocumentVO vo) throws Exception;
	
	/**
	 * 문서 관리 목록 조회
	 * 
	 * @param DocumentVO
	 * @return List
	 * @throws Exception
	 */
	public List<DocumentVO> selectDocumentList(DocumentVO vo) throws Exception;
	
	/**
	 * 문서 관리 상세정보 조회
	 * 
	 * @param DocumentVO
	 * @return List
	 * @exception Exception
	 */
	public DocumentVO documentDetail(HttpServletRequest request, DocumentVO vo);
	
	/**
	 * 문서 관리 저장 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int insertDocument(DocumentVO vo) throws Exception;

	/**
	 * 문서 관리 수정 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int updateDocument(DocumentVO vo) throws Exception;

	/**
	 * 문서 관리 삭제 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int deleteDocument(DocumentVO vo) throws Exception;
	
	/**
	 * 다음 양식번호 조회
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public DocumentVO selectFormNo(DocumentVO vo);
	
	/**
	 * 문서등록 첨부파일 다운로드
	 *
	 * @param DocumentVO
	 * @return DocumentVO
	 * @exception Exception	 
	 */
	public DocumentVO formDocDown(DocumentVO vo) throws Exception;	
}
