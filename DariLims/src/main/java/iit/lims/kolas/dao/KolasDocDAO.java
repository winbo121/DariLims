package iit.lims.kolas.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.kolas.vo.KolasDocVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * KolasDocDAO
 * @author 석은주
 * @since 2015.02.02
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.02 석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


@Repository
public class KolasDocDAO extends EgovAbstractMapper {

	/**
	 * KOLAS 문서 등록 목록 조회
	 *
	 * @param KolasDocVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<KolasDocVO> selectKolasDocList(KolasDocVO vo) throws Exception {
		return selectList("kolasDoc.selectKolasDocList", vo);
	}
	
	/**
	 * 문서등록 상세보기
	 *
	 * @param KolasDocVO
	 * @return KolasDocVO
	 * @exception Exception	 
	 */
	public KolasDocVO selectKolasDocDetail(KolasDocVO vo) throws Exception {
		return (KolasDocVO) selectOne("kolasDoc.selectKolasDocDetail", vo);
	} 
	
	/**
	 * 문서등록 신규등록시 KOLAS_DOC_NO 얻음
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public String getNewKolasDocNo() throws Exception {
		return selectOne("kolasDoc.getNewKolasDocNo");
	}
	
	/**
	 * 문서등록 신규등록
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertKolasDoc(KolasDocVO vo) throws Exception {
		return insert("kolasDoc.insertKolasDoc", vo);
	}
	
	/**
	 * 문서등록 수정
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateKolasDoc(KolasDocVO vo) throws Exception {
		return update("kolasDoc.updateKolasDoc", vo);
	}
	
	/**
	 * 문서등록 삭제
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
/*	public int deleteKolasDoc(KolasDocVO vo) throws Exception {
		return update("kolasDoc.deleteKolasDoc", vo);
	}*/
	
	/**
	 * 문서등록 첨부파일 존재여부 조회
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public Integer selectKolasAddFile(KolasDocVO vo) throws Exception {
		return selectOne("kolasDoc.selectKolasAddFile", vo);
	}
	
	/**
	 * 문서등록 첨부파일 신규등록
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertKolasAddFile(KolasDocVO vo) throws Exception {
		return insert("kolasDoc.insertKolasAddFile", vo);
		
	}
	
	/**
	 * 문서등록 첨부파일 수정
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateKolasAddFile(KolasDocVO vo) throws Exception {	
		return update("kolasDoc.updateKolasAddFile", vo);
	}

	/**
	 * 문서등록 첨부파일 삭제
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteKolasAddFile(KolasDocVO vo) throws Exception {
		return delete("kolasDoc.deleteKolasAddFile", vo);		
	}

	/**
	 * 문서등록 첨부파일 다운로드
	 *
	 * @param KolasDocVO
	 * @return KolasDocVO
	 * @exception Exception	 
	 */
	public KolasDocVO kolasDocDown(KolasDocVO vo) throws Exception {
		return (KolasDocVO) selectOne("kolasDoc.kolasDocDown", vo);
	}		
	
}
