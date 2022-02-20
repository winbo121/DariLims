package iit.lims.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import iit.lims.system.dao.UserDAO;
import iit.lims.system.service.UserService;
import iit.lims.system.vo.UserVO;

/**
 * UserServiceImpl
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
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "userDAO")
	private UserDAO userDAO;
	
	/**
	 * 사용자관리 목록 조회 
	 * @param UserVO
	 * @throws Exception
	 */
	public List<UserVO> selectUserCmmnList(UserVO userVO) throws Exception {
        return userDAO.selectUserCmmnList(userVO);
    }
	
	/**
	 * 사용자관리 목록 조회 
	 * @param UserVO
	 * @throws Exception
	 */
	public List<UserVO> selectUserLimsList(UserVO userVO) throws Exception {
        return userDAO.selectUserLimsList(userVO);
    }
	
	/**
	 * 사용자관리 저장/수정 처리 
	 * @param UserVO
	 * @throws Exception
	 */
	public int saveUserLims(UserVO userVO) throws Exception {
		int result = -1;
		try {
			
			result = userDAO.saveUserLims(userVO);
			
			ArrayList<UserVO> userList = (ArrayList<UserVO>) userDAO.selectUserList(userVO);
			if (userList != null && userList.size() > 0) {
				for (UserVO a : userList) {
					result = userDAO.updateUserFlag(a);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 사용자 등록
	 * @param UserVO
	 * @throws Exception
	 */
	public int insertUserInfo(UserVO userVO) throws Exception {
		try {
			return userDAO.insertUserInfo(userVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 사용자정보 수정
	 * @param UserVO
	 * @throws Exception
	 */
	public int updateUserInfo(UserVO userVO) throws Exception {
		try {
			return userDAO.updateUserInfo(userVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 사용자정보수정
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateUserFlag(UserVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
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
						String crud = map.get("crud");
						if (crud != "" && crud != null) {
							map.put("user_id", vo.getCreater_id());
							if ("c".equals(crud)) {
								//userDAO.insertUser(map);
							}else if("u".equals(crud)) {
								userDAO.updateUser(map);
							}

							/* AUDIT_TRAIL START*/
							//HashMap<String, String> map = new HashMap<String, String>();
							//log.debug("Log[Lims AUDIT TRAIL] :" + map.toString());
							//map.put("at_cont", map.toString()); // 로우데이터 셋팅
							//map.put("menu_cd", "MENUCD"); // 메뉴코드 셋팅
							//map.put("worker_id", "WORKER_ID"); // 작업한사용자의 아이디 셋팅
							//map.put("test_req_no", "TEST_REQ_NO"); // 접수번호 셋팅(위에있음)
							//map.put("test_sample_seq", "TEST_SAMPLE_SEQ"); // 시료번호 셋팅(위에있음)
							//auditTrailDAO.insertAuditTrail(map);
							/* AUDIT_TRAIL END*/
						}
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 사용자 상세 조회
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public UserVO selectUserLimsDetail(UserVO userVO) throws Exception {
		return userDAO.selectUserLimsDetail(userVO);
	}

	@Override
	public int putSignFile(UserVO userVO) throws Exception {
		MultipartFile file = userVO.getSign_file();
		userVO.setByte_file(file.getBytes());
		userVO.setFile_name(file.getOriginalFilename());
		return userDAO.putSignFile(userVO);
	}

	@Override
	public int deleteSignFile(UserVO userVO) throws Exception {
		return userDAO.deleteSignFile(userVO);
	}
	
	
	
}
