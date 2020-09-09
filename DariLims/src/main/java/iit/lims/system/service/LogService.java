package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.LogVO;

/**
 * LogService
 * @logor 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface LogService {

	
	/**
	 * 로그 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<LogVO> selectLogList(LogVO logVO) throws Exception;
	
	/**
	 * 로그 페이징
	 *
	 * @param LogVO
	 * @return LogVO
	 * @exception Exception	 
	 */
	public int selectPagingListTotCnt(LogVO logVO) throws Exception;
	
}
