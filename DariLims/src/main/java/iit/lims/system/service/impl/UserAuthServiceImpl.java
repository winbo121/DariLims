package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.UserAuthDAO;
import iit.lims.system.service.UserAuthService;
import iit.lims.system.vo.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * AuthServiceImpl
 * 
 * @author 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class UserAuthServiceImpl extends EgovAbstractServiceImpl implements UserAuthService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "userAuthDAO")
	private UserAuthDAO userAuthDAO;

	/**
	 * 부서관리 목록 조회
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public List<UserVO> selectCmmnUserList(UserVO userVO) throws Exception {
		return userAuthDAO.selectCmmnUserList(userVO);
	}

	/**
	 * 부서관리 목록 조회
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public List<UserVO> selectAuthUserList(UserVO userVO) throws Exception {
		return userAuthDAO.selectAuthUserList(userVO);
	}

	/**
	 * 부서관리 저장/수정 처리
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public int insertAuthUser(UserVO userVO) throws Exception {
		int result = -1;
		try {
			String[] arr;
			arr = userVO.getUser_id().split(",");
			for (String t : arr) {
				userVO.setUser_id(t);
				result = userAuthDAO.insertAuthUser(userVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	/**
	 * 부서관리 저장/수정 처리
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public int deleteAuthUser(UserVO userVO) throws Exception {
		int result = -1;
		try {
			String[] arr;
			arr = userVO.getUser_id().split(",");
			for (String t : arr) {
				userVO.setUser_id(t);
				result = userAuthDAO.deleteAuthUser(userVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

}
