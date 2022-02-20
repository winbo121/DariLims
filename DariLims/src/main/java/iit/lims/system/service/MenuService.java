package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.MenuVO;

/**
 * MenuService
 * @author 정우용
 * @since 2015.01.13
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.13  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */


public interface MenuService {

	
	/**
	 * 메뉴관리 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MenuVO> selectMenuGroupList(MenuVO menuVO) throws Exception;
	
	
	
	/**
	 * 메뉴관리 저장/수정 처리
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public int saveMenuGroup(MenuVO menuVO) throws Exception;
	
	/**
	 * 메뉴관리 삭제 처리
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public int deleteMenu(MenuVO menuVO) throws Exception;
	
	
	/**
	 * 메뉴관리 목록 조회
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MenuVO> selectMenuDetailList(MenuVO menuVO) throws Exception;
	
	/**
	 * 메뉴관리 저장/수정 처리
	 *
	 * @param MenuVO
	 * @return List
	 * @exception Exception	 
	 */
	public int saveMenuDetail(MenuVO menuVO) throws Exception;

}
