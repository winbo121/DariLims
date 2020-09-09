package iit.lims.master.service;
import java.util.List;

import iit.lims.master.vo.SamplingPointVO;
import iit.lims.system.vo.BoardVO;

/**
 * SamplingPointService
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface SamplingPointService {	

	/**
	 * 채수장소 목록 조회
	 *
	 * @param SamplingPointVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<SamplingPointVO> samplingPoint(SamplingPointVO samplingPointVO) throws Exception;
	
	/**
	 * 채수장소 상세정보 조회
	 *
	 * @param SamplingPointVO
	 * @return List
	 * @exception Exception	 
	 */
	public SamplingPointVO samplingPointDetail(SamplingPointVO samplingPointVO);	
	
	
	/**
	 * 채수장소 저장 처리 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public int insertSamplingPoint(SamplingPointVO samplingPointVO) throws Exception;
		
	/**
	 * 채수장소 수정 처리 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public int updateSamplingPoint(SamplingPointVO samplingPointVO) throws Exception;
	
	/**
	 * 채수장소 삭제 처리 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public int deleteSamplingPoint(SamplingPointVO samplingPointVO) throws Exception;
	
	/**
	 * 채수장소관리 사업소 팝업
	 *
	 * @param SamplingPointVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<SamplingPointVO> selectOfficeList(SamplingPointVO samplingPointVO) throws Exception;
	
	/**
	 * 페이징
	 *
	 * @param SamplingPointVO
	 * @return SamplingPointVO
	 * @exception Exception	 
	 */
	public int selectPagingListTotCnt(SamplingPointVO samplingPointVO) throws Exception;
	
}