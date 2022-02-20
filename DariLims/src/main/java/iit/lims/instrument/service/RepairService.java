package iit.lims.instrument.service;

import java.util.List;
import iit.lims.instrument.vo.RepairVO;

/**
 * RepairService
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

public interface RepairService {
	
	/**
	 * 수리등록 목록 조회
	 *
	 * @param RepairVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<RepairVO> selectRepairList(RepairVO repairVO) throws Exception;	
	
	/**
	 * 수리등록 상세 조회
	 *
	 * @param RepairVO
	 * @return RepairVO
	 * @exception Exception	 
	 */
	public RepairVO repairDetail(RepairVO repairVO);	

	/**
	 * 수리등록 저장 처리 
	 * @param RepairVO
	 * @throws Exception
	 */
	public int insertRepair(RepairVO repairVO) throws Exception;

	/**
	 * 수리등록 수정 처리 
	 * @param RepairVO
	 * @throws Exception
	 */
	public int updateRepair(RepairVO repairVO) throws Exception;
	
	/**
	 * 수리등록 삭제 처리 
	 * @param RepairVO
	 * @throws Exception
	 */
	public int deleteRepair(RepairVO repairVO) throws Exception;
	
}
