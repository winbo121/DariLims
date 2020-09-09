package iit.lims.instrument.service;

import java.util.List;
import iit.lims.instrument.vo.UseLogVO;
import iit.lims.instrument.vo.MachineVO;

/**
 * UseLogService
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

public interface UseLogService {
	
	/**
	 * 장비사용일지 전체 목록 조회
	 *
	 * @param UseLogVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MachineVO> machineUseLog(MachineVO MachineVO) throws Exception;	
	
	/**
	 * 장비사용일지 목록 조회
	 *
	 * @param UseLogVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UseLogVO> selectUseLogList(UseLogVO useLogVO) throws Exception;	
	
	/**
	 * 장비사용일지 상세 조회
	 *
	 * @param UseLogVO
	 * @return UseLogVO
	 * @exception Exception	 
	 */
	public UseLogVO useLogDetail(UseLogVO useLogVO);	

	/**
	 * 장비사용일지 저장 처리 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public int insertUseLog(UseLogVO useLogVO) throws Exception;

	
	/**
	 * 장비사용일지 삭제 처리 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public int deleteUseLog(UseLogVO useLogVO) throws Exception;
}
