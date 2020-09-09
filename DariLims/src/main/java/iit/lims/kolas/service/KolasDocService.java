package iit.lims.kolas.service;

import java.util.List;

import iit.lims.kolas.vo.KolasDocVO;


/**
 * KolasDocService
 * @author 석은주
 * @since 2015.02.02
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.02  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface KolasDocService {

	/**
	 * KOLAS 문서 등록 목록 조회
	 *
	 * @param KolasDocVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<KolasDocVO> selectKolasDocList(KolasDocVO vo) throws Exception;

	/**
	 * KOLAS 문서 등록 상세정보 조회
	 *
	 * @param TestMethodVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public KolasDocVO selectKolasDocDetail(KolasDocVO vo) throws Exception;
	
	/**
	 * 문서등록 신규등록
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertKolasDoc(KolasDocVO vo) throws Exception;
	
	/**
	 * 문서등록 수정
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
	public int updateKolasDoc(KolasDocVO vo) throws Exception;

	/**
	 * 문서등록 삭제
	 *
	 * @param KolasDocVO
	 * @return int
	 * @exception Exception	 
	 */
/*	public int deleteKolasDoc(KolasDocVO vo) throws Exception;*/

	/**
	 * 문서등록 첨부파일 다운로드
	 *
	 * @param KolasDocVO
	 * @return KolasDocVO
	 * @exception Exception	 
	 */
	public KolasDocVO kolasDocDown(KolasDocVO vo) throws Exception;			

}
