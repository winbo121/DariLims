package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.CodeVO;

/**
 * CodeService
 * @author 정우용
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


public interface CodeService {

	/**
	 * 코드그룹 목록 조회
	 *
	 * @param CodeVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<CodeVO> selectCodeGroupList(CodeVO codeVO) throws Exception;
	
	/**
	 * 코드그룹 저장/수정 처리
	 *
	 * @param CodeVO
	 * @return List
	 * @exception Exception	 
	 */
	public int saveCodeGroup(CodeVO codeVO) throws Exception;
	
	/**
	 * 코드상세 목록 조회
	 *
	 * @param CodeVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<CodeVO> selectCodeDetailList(CodeVO codeVO) throws Exception;
	
	/**
	 * 코드상세 저장/수정 처리
	 *
	 * @param CodeVO
	 * @return List
	 * @exception Exception	 
	 */
	public int saveCodeDetail(CodeVO codeVO) throws Exception;

}
