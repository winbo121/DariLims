package iit.lims.master.service;
import java.util.List;

import iit.lims.master.vo.SampleVO;

/**
 * SampleService
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

public interface SampleService {
	
	/**
	 * 시료유형 목록 조회
	 *
	 * @param DemoSampleVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<SampleVO> sampleInsert(SampleVO sampleVO) throws Exception;
	
	/**
	 * 시료유형 상세정보 조회
	 *
	 * @param DemoSampleVO
	 * @return List
	 * @exception Exception	 
	 */
	public SampleVO sampleInsertDetail(SampleVO sampleVO);
	
	/**
	 * 시료유형 저장 처리 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public int insertSampleInsert(SampleVO sampleVO) throws Exception;
		
	/**
	 * 시료유형 수정 처리 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public int updateSampleInsert(SampleVO sampleVO) throws Exception;
	
	/**
	 * 시료유형 삭제 처리 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public int deleteSampleInsert(SampleVO sampleVO) throws Exception;
	
}