package iit.lims.accept.service;

import java.util.List;

import iit.lims.accept.vo.CounselVO;

/**
 * MachineService
 * 
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface CounselService {
	
	/**
	 * 통합상담 목록 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public List<CounselVO> selectCounselTotalList(CounselVO counselVO) throws Exception;
	
	/**
	 * 개별상담 목록 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public List<CounselVO> selectCounselPersonalList(CounselVO counselVO) throws Exception;
	
	/**
	 * 통합상담 등록 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int insertCounselTotal(CounselVO counselVO) throws Exception;
	
	/**
	 * 개별상담 등록 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int insertCounselPersonal(CounselVO counselVO) throws Exception;

	/**
	 * 통합상담 상세 데이터
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */	
	public CounselVO selectCounselTotalDetail(CounselVO counselVO) throws Exception;
	
	/**
	 * 개별상담 상세 데이터
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */	
	public CounselVO selectCounselPersonalDetail(CounselVO counselVO) throws Exception;
	
	/**
	 * 통합상담 수정 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int updateCounselTotal(CounselVO counselVO) throws Exception;

	/**
	 * 개별상담 수정 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int updateCounselPersonal(CounselVO counselVO) throws Exception;
	
	/**
	 * 통합상담 삭제 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int deleteCounselTotal(CounselVO counselVO) throws Exception;

	/**
	 * 개별상담 삭제 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int deleteCounselPersonal(CounselVO counselVO) throws Exception;
}
