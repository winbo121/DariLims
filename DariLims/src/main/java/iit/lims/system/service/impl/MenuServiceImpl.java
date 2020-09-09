package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.MenuDAO;
import iit.lims.system.service.MenuService;
import iit.lims.system.vo.MenuVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MenuServiceImpl
 * 
 * @author 정우용
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.13  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class MenuServiceImpl extends EgovAbstractServiceImpl implements MenuService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "menuDAO")
	private MenuDAO menuDAO;

	/**
	 * 메뉴관리 목록 조회
	 * 
	 * @param MenuVO
	 * @throws Exception
	 */
	public List<MenuVO> selectMenuGroupList(MenuVO menuVO) throws Exception {
		return menuDAO.selectMenuGroupList(menuVO);
	}

	/**
	 * 메뉴관리 저장/수정 처리
	 * 
	 * @param MenuVO
	 * @throws Exception
	 */
	public int saveMenuGroup(MenuVO menuVO) throws Exception {
		int result = -1;
		try {
			if (menuVO.getPageType().equals("insert")) {
				result = menuDAO.insertMenuGroup(menuVO);
			} else {
				result = menuDAO.updateMenuGroup(menuVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	/**
	 * 메뉴관리 삭제 처리
	 * 
	 * @param MenuVO
	 * @throws Exception
	 */
	public int deleteMenu(MenuVO menuVO) throws Exception {
		try {
			return menuDAO.deleteMenu(menuVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 메뉴관리 목록 조회
	 * 
	 * @param MenuVO
	 * @throws Exception
	 */
	public List<MenuVO> selectMenuDetailList(MenuVO menuVO) throws Exception {
		return menuDAO.selectMenuDetailList(menuVO);
	}

	/**
	 * 메뉴관리 저장/수정 처리
	 * 
	 * @param MenuVO
	 * @throws Exception
	 */
	public int saveMenuDetail(MenuVO menuVO) throws Exception {
		int result = -1;
		try {
			if (menuVO.getPageType().equals("insert")) {
				result = menuDAO.insertMenuDetail(menuVO);
			} else {
				result = menuDAO.updateMenuDetail(menuVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
}
