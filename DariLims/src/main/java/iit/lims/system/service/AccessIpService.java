package iit.lims.system.service;

import iit.lims.system.vo.AccessIpVO;

import java.util.List;

/**
 * AccessIpService
 * @author 최은향
 * @since 2015.12.08
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.08  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface AccessIpService {

	/**
	 * 접근IP정보 목록 조회
	 *
	 * @param AccessIpVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AccessIpVO> selectAccessIp(AccessIpVO vo) throws Exception;
	/**
	 * 접근IP정보 상세 조회
	 *
	 * @param AccessIpVO
	 * @return List
	 * @exception Exception	 
	 */
	public AccessIpVO selectAccessIpDetail(AccessIpVO vo) throws Exception;
	
	/**
	 * 접근IP정보 등록
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public int insertAccessIp(AccessIpVO vo) throws Exception;
	
	/**
	 * 접근IP정보 수정
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public int updateAccessIp(AccessIpVO vo) throws Exception;
	
	/**
	 * 접근IP정보 삭제
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public int deleteAccessIp(AccessIpVO vo) throws Exception;
}
