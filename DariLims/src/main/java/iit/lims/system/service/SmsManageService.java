package iit.lims.system.service;



import iit.lims.util.sms.vo.SmsVO;

import java.util.List;

/**
 * SmsManageService
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


public interface SmsManageService {

	/**
	 * SMS관리 목록 조회
	 *
	 * @param SmsVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<SmsVO> selectSmsManage(SmsVO vo) throws Exception;
	/**
	 * SMS관리 상세 조회
	 *
	 * @param SmsVO
	 * @return List
	 * @exception Exception	 
	 */
	public SmsVO selectSmsManageDetail(SmsVO vo) throws Exception;
	
	/**
	 * SMS관리 등록
	 * @param SmsVO
	 * @throws Exception
	 */
	public int insertSmsManage(SmsVO vo) throws Exception;
	
	/**
	 * SMS관리 수정
	 * @param SmsVO
	 * @throws Exception
	 */
	public int updateSmsManage(SmsVO vo) throws Exception;
	
	/**
	 * SMS관리 삭제
	 * @param SmsVO
	 * @throws Exception
	 */
	public int deleteSmsManage(SmsVO vo) throws Exception;
	
	/**
	 * SMS관리 키 중복 조회
	 *
	 * @param SmsVO
	 * @return List
	 * @exception Exception	 
	 */
	public String selectSmsKeyCheck(SmsVO vo) throws Exception;
}
