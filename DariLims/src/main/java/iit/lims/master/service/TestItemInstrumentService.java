package iit.lims.master.service;

import java.util.List;

import iit.lims.instrument.vo.MachineVO;
/**
 * TestItemInstrumentService
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface TestItemInstrumentService {
	
	/**
	 * 항목별 시험기기 목록 조회
	 *
	 * @param MachineVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MachineVO> selectTestItemInstList(MachineVO vo) throws Exception;

	/**
	 * 항목별 시험기기 기기 목록 저장
	 *
	 * @param MachineVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertTestItemInst(MachineVO vo) throws Exception;	

}
