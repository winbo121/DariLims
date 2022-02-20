package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.AbsenceDAO;
import iit.lims.system.service.AbsenceService;
import iit.lims.system.vo.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * UserServiceImpl
 * 
 * @author 진영민
 * @since 2015.06.11
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.11  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class AbsenceServiceImpl extends EgovAbstractServiceImpl implements AbsenceService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "absenceDAO")
	private AbsenceDAO absenceDAO;

	/**
	 * 부재자 목록 조회
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public List<UserVO> selectAbsenceList(UserVO userVO) throws Exception {
		return absenceDAO.selectAbsenceList(userVO);
	}

	/**
	 * 부재자 상세 조회
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public UserVO selectAbsenceDetail(UserVO userVO) throws Exception {
		return absenceDAO.selectAbsenceDetail(userVO);
	}

	/**
	 * 부재자 삽입
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public int saveAbsence(UserVO userVO) throws Exception {
		try {
			absenceDAO.saveAbsence(userVO);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 부재자 삭제
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public int deleteAbsence(UserVO userVO) throws Exception {
		try {
			absenceDAO.deleteAbsence(userVO);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 대리자 목록 조회
	 * 
	 * @param UserVO
	 * @throws Exception
	 */
	public List<UserVO> selectAbsenceUserList(UserVO userVO) throws Exception {
		return absenceDAO.selectAbsenceUserList(userVO);
	}

}
