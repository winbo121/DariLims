package iit.lims.instrument.service;

import java.util.List;

import iit.lims.instrument.vo.MachineVO;

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

public interface MachineService {

	/**
	 * 장비관리 목록 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public List<MachineVO> selectMachineList(MachineVO machineVO) throws Exception;

	/**
	 * 장비관리 부서별 목록 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public List<MachineVO> selectMachineDeptList(MachineVO machineVO) throws Exception;

	/**
	 * 장비관리 상세 조회
	 * 
	 * @param MachineVO
	 * @return MachineVO
	 * @exception Exception
	 */
	public MachineVO machineDetail(MachineVO machineVO);

	/**
	 * 장비관리 저장 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int insertMachine(MachineVO machineVO) throws Exception;

	/**
	 * 장비관리 수정 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int updateMachine(MachineVO machineVO) throws Exception;

	/**
	 * 장비관리 삭제 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int deleteMachine(MachineVO machineVO) throws Exception;

	/**
	 * 장비관리 파일 저장
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public MachineVO machineDown(MachineVO machineVO);

	/**
	 * 장비 삭제여부 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public MachineVO machineDeleteFlag(MachineVO machineVO);

	/**
	 * 장비 등록이미지 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public byte[] machineImage(MachineVO machineVO) throws Exception;

	/**
	 * 관리자 이력 목록 조회
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public List<MachineVO> selectMachineManager(MachineVO machineVO) throws Exception;

	/**
	 * 관리자 저장 처리
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public int saveManager(MachineVO machineVO) throws Exception;

	/**
	 * 관리자 삭제 처리
	 * 
	 * @param MachineVO
	 * @return List
	 * @exception Exception
	 */
	public int deleteManager(MachineVO machineVO) throws Exception;

}
