package iit.lims.system.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.vo.AccountVO;
import iit.lims.system.dao.AuthDAO;
import iit.lims.system.service.AuthService;
import iit.lims.system.vo.AuthVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * AuthServiceImpl
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
@Service
public class AuthServiceImpl extends EgovAbstractServiceImpl implements AuthService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "authDAO")
	private AuthDAO authDAO;
	
	/**
	 * 부서관리 목록 조회 
	 * @param AuthVO
	 * @throws Exception
	 */
	public List<AuthVO> selectAuthGroupList(AuthVO authVO) throws Exception {
        return authDAO.selectAuthGroupList(authVO);
    }
	
	/**
	 * 부서관리 저장/수정 처리 
	 * @param AuthVO
	 * @throws Exception
	 */
	public int saveAuthGroup(AuthVO authVO) throws Exception {
		int result = -1;
		try {
			if(authVO.getPageType().equals("insert")){
				result = authDAO.insertAuthGroup(authVO);
			}else if(authVO.getPageType().equals("update")){
				result = authDAO.updateAuthGroup(authVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 부서관리 목록 조회 
	 * @param AuthVO
	 * @throws Exception
	 */
	public List<AuthVO> selectCmmnMenuList(AuthVO authVO) throws Exception {
        return authDAO.selectCmmnMenuList(authVO);
    }
	
	/**
	 * 부서관리 목록 조회 
	 * @param AuthVO
	 * @throws Exception
	 */
	public List<AuthVO> selectAuthMenuList(AuthVO authVO) throws Exception {
        return authDAO.selectAuthMenuList(authVO);
    }
	
	/**
	 * 부서관리 저장/수정 처리 
	 * @param AuthVO
	 * @throws Exception
	 */
	public int insertAuthMenu(AuthVO authVO) throws Exception {
		int result = -1;
		try {
			String[] arr;
			arr = authVO.getMenu_cd().split(",");
			for(String t : arr){
				authVO.setMenu_cd(t);
				result = authDAO.insertAuthMenu(authVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 부서관리 저장/수정 처리 
	 * @param AuthVO
	 * @throws Exception
	 */
	public int deleteAuthMenu(AuthVO authVO) throws Exception {
		int result = -1;
		try {
			String[] arr;
			arr = authVO.getMenu_cd().split(",");
			for(String t : arr){
				authVO.setMenu_cd(t);
				result = authDAO.deleteAuthMenu(authVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	
	/**
	 *  
	 * 
	 * @param AccountVO
	 * @return int
	 * @exception Exception
	 */
	public int saveAuthMenu(AuthVO authVO) throws Exception {
		int result = -1;
		try {
			String[] rowArr = authVO.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						authDAO.saveAuthMenu(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	//권한그룹 삭제
	@Override
	public int delAuthGroup(AuthVO authVO) {
		return authDAO.delAuthGroup(authVO);
	}
}
