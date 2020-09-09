package iit.lims.accept.service;

import iit.lims.accept.vo.InstRentVO;

import java.util.List;

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

public interface InstRentService {
	
	/**
	 * 장비대여 업체목록 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRentList(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 업체 등록 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int insertInstRentOrg(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 업체 수정 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int updateInstRentOrg(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 업체 삭제 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int deleteInstRent(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 업체 상세 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public InstRentVO selectInstRentDetail(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 장비목록 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRentDetailList(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 장비목록 저장
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int saveInstRent_inst(InstRentVO instRentVO) throws Exception;
		
	/**
	 * 장비대여 사용결과 시료 저장
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int saveInstRent_sample(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 시료목록 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRent_sampleList(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 항목 등록
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int insertInstRent_item(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 항목 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRent_itemList(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 시료 삭제 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int deleteInstRent_sample(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 항목 삭제 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int deleteInstRent_item(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 항목 비고 추가
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int saveSampleEtc(InstRentVO instRentVO) throws Exception;
	
	/**
	 * 장비대여 사용결과 항목 비고 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public InstRentVO selectSampleEtc(InstRentVO instRentVO) throws Exception;
}
