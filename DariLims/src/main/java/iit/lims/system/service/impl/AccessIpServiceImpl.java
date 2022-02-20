package iit.lims.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.AccessIpDAO;
import iit.lims.system.service.AccessIpService;
import iit.lims.system.vo.AccessIpVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * AccessIpServiceImpl
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
@Service
public class AccessIpServiceImpl extends EgovAbstractServiceImpl implements AccessIpService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "accessIpDAO")
	private AccessIpDAO accessIpDAO;
		
	/**
	 * 접근IP정보 목록 조회 
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public List<AccessIpVO> selectAccessIp(AccessIpVO vo) throws Exception {
        return accessIpDAO.selectAccessIp(vo);
    }
	
	/**
	 * 접근IP정보 상세 조회
	 * 
	 * @param AccessIpVO
	 * @return int
	 * @exception Exception
	 */
	public AccessIpVO selectAccessIpDetail(AccessIpVO vo) throws Exception {
		return accessIpDAO.selectAccessIpDetail(vo);
	}
	
	/**
	 * 접근IP정보 등록
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public int insertAccessIp(AccessIpVO vo) throws Exception {
		try {
			return accessIpDAO.insertAccessIp(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 접근IP정보 수정
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public int updateAccessIp(AccessIpVO vo) throws Exception {
		try {
			return accessIpDAO.updateAccessIp(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 접근IP정보 삭제
	 * @param AccessIpVO
	 * @throws Exception
	 */
	public int deleteAccessIp(AccessIpVO vo) throws Exception {
		try {
			return accessIpDAO.deleteAccessIp(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
