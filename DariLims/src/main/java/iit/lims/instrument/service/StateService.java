package iit.lims.instrument.service;

import java.util.List;
import iit.lims.instrument.vo.StateVO;
import iit.lims.instrument.vo.MachineVO;

/**
 * StateService
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

public interface StateService {
	
	/**
	 * 장비현황 전체 목록 조회
	 *
	 * @param StateVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MachineVO> machineState(MachineVO MachineVO) throws Exception;	
	
	/**
	 * 장비현황 목록 조회
	 *
	 * @param StateVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<StateVO> selectStateList(StateVO stateVO) throws Exception;	
	
	/**
	 * 장비현황 상세 조회
	 *
	 * @param StateVO
	 * @return StateVO
	 * @exception Exception	 
	 */
	public StateVO stateDetail(StateVO stateVO);	

	/**
	 * 장비현황 저장 처리 
	 * @param StateVO
	 * @throws Exception
	 */
	public int insertState(StateVO stateVO) throws Exception;

	/**
	 * 장비현황 수정 처리 
	 * @param StateVO
	 * @throws Exception
	 */
	public int updateState(StateVO stateVO) throws Exception;
	
	/**
	 * 장비현황 삭제 처리 
	 * @param StateVO
	 * @throws Exception
	 */
	public int deleteState(StateVO stateVO) throws Exception;
}
