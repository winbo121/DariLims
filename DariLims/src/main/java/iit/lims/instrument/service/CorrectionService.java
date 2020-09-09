package iit.lims.instrument.service;

import java.util.List;
import iit.lims.instrument.vo.CorrectionVO;

/**
 * CorrectionService
 * @author 최은향
 * @since 2015.01.27
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.27  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface CorrectionService {
	
	/**
	 * 교정 목록 조회
	 *
	 * @param CorrectionVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<CorrectionVO> selectCorrectionList(CorrectionVO correctionVO) throws Exception;	
	
	/**
	 * 교정 상세 조회
	 *
	 * @param CorrectionVO
	 * @return CorrectionVO
	 * @exception Exception	 
	 */
	public CorrectionVO correctionDetail(CorrectionVO correctionVO);
	
	/**
	 * 교정 담당자 조회
	 *
	 * @param CorrectionVO
	 * @return CorrectionVO
	 * @exception Exception	 
	 */
	public CorrectionVO correctionMng(CorrectionVO correctionVO);

	/**
	 * 교정 저장 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int insertCorrection(CorrectionVO correctionVO) throws Exception;

	/**
	 * 교정 수정 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int updateCorrection(CorrectionVO correctionVO) throws Exception;
	
	/**
	 * 교정 삭제 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int deleteCorrection(CorrectionVO correctionVO) throws Exception;

	
	/**
	 * 중간점검 목록 조회
	 *
	 * @param CorrectionVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<CorrectionVO> selectCorrectionList2(CorrectionVO correctionVO) throws Exception;	
	
	/**
	 * 중간점검 상세 조회
	 *
	 * @param CorrectionVO
	 * @return CorrectionVO
	 * @exception Exception	 
	 */
	public CorrectionVO correctionDetail2(CorrectionVO correctionVO);	

	/**
	 * 중간점검 저장 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int insertCorrection2(CorrectionVO correctionVO) throws Exception;

	/**
	 * 중간점검 수정 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int updateCorrection2(CorrectionVO correctionVO) throws Exception;
	
	/**
	 * 중간점검 삭제 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int deleteCorrection2(CorrectionVO correctionVO) throws Exception;
	
}
