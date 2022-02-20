package iit.lims.system.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.DeptDAO;
import iit.lims.system.service.DeptService;
import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * DeptServiceImpl
 * @author 윤상준
 * @since 2015.08.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.08.24  윤상준   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class DeptServiceImpl extends EgovAbstractServiceImpl implements DeptService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "deptDAO")
	private DeptDAO deptDAO;
	
	/**
	 * 공통부서 목록 조회 
	 * @param DeptVO
	 * @throws Exception
	 */
	public List<DeptVO> selectDeptCmmnList(DeptVO deptVO) throws Exception {
        return deptDAO.selectDeptCmmnList(deptVO);
    }
	
	/**
	 * LIMS사용부서 목록 조회 
	 * @param DeptVO
	 * @throws Exception
	 */
	public List<DeptVO> selectDeptLimsList(DeptVO deptVO) throws Exception {
        return deptDAO.selectDeptLimsList(deptVO);
    }
	
	/**
	 * 부서관리 확인 처리 
	 * @param DeptVO
	 * @throws Exception
	 */
	public int saveDeptLims(DeptVO deptVO) throws Exception {
		int result = -1;
		try {
			result = deptDAO.saveDeptLims(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 부서관리 수정 처리 
	 * @param DeptVO
	 * @throws Exception
	 */
	public int updateDeptLims(DeptVO deptVO) throws Exception {
		int result = -1;
		try {
			result = deptDAO.updateDeptLims(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 부서 등록
	 * @param deptVO
	 * @throws Exception
	 */
	public int insertDeptInfo(DeptVO deptVO) throws Exception {
		try {
			return deptDAO.insertDeptInfo(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 부서정보 수정
	 * @param deptVO
	 * @throws Exception
	 */
	public int updateDeptInfo(DeptVO deptVO) throws Exception {
		try {
			return deptDAO.updateDeptInfo(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 부서 상세 조회
	 * 
	 * @param deptVO
	 * @return int
	 * @exception Exception
	 */
	public DeptVO selectDeptLimsDetail(DeptVO deptVO) throws Exception {
		return deptDAO.selectDeptLimsDetail(deptVO);
	}
	
	/**
	 * 부서 팀 목록 조회 
	 * @param DeptVO
	 * @throws Exception
	 */
	public List<DeptVO> selectDeptTeamList(DeptVO deptVO) throws Exception {
        return deptDAO.selectDeptTeamList(deptVO);
    }
	
	/**
	 * 부서 팀 사용자 목록 조회 
	 * @param DeptVO
	 * @throws Exception
	 */
	public List<DeptVO> selectDeptTeamUserList(DeptVO deptVO) throws Exception {
        return deptDAO.selectDeptTeamUserList(deptVO);
    }
	
	

	/**
	 * 부서 팀 상세 조회
	 * 
	 * @param deptVO
	 * @return int
	 * @exception Exception
	 */
	public DeptVO selectDeptTeamDetail(DeptVO deptVO) throws Exception {
		return deptDAO.selectDeptTeamDetail(deptVO);
	}
	
	/**
	 * 팀 등록
	 * @param deptVO
	 * @throws Exception
	 */
	public int insertDeptTeam(DeptVO deptVO) throws Exception {
		try {
			return deptDAO.insertDeptTeam(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 팀정보 수정
	 * @param deptVO
	 * @throws Exception
	 */
	public int updateDeptTeam(DeptVO deptVO) throws Exception {
		try {
			return deptDAO.updateDeptTeam(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 팀정보 삭제
	 * @param deptVO
	 * @throws Exception
	 */
	public int deleteDeptTeam(DeptVO deptVO) throws Exception {
		try {
			return deptDAO.deleteDeptTeam(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 팀 사용자 등록
	 * @param deptVO
	 * @throws Exception
	 */
	public int insertDeptTeamUser(DeptVO deptVO) throws Exception {
		try {
			int result = -1;
			int userCnt = deptDAO.selectDeptTeamUserChk(deptVO);			
			if(userCnt == 0){
				result = deptDAO.insertDeptTeamUser(deptVO);				
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 팀 사용자 삭제
	 * @param deptVO
	 * @throws Exception
	 */
	public int deleteDeptTeamUser(DeptVO deptVO) throws Exception {
		try {
			return deptDAO.deleteDeptTeamUser(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
