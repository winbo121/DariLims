package iit.lims.system.service.impl;

import iit.lims.system.dao.SmsManageDAO;
import iit.lims.system.service.SmsManageService;
import iit.lims.util.sms.vo.SmsVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SmsManageServiceImpl
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
public class SmsManageServiceImpl extends EgovAbstractServiceImpl implements SmsManageService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "smsManageDAO")
	private SmsManageDAO smsManageDAO;
		
	/**
	 * SMS관리 목록 조회 
	 * @param SmsVO
	 * @throws Exception
	 */
	public List<SmsVO> selectSmsManage(SmsVO vo) throws Exception {
        return smsManageDAO.selectSmsManage(vo);
    }
	
	/**
	 * SMS관리 상세 조회
	 * 
	 * @param SmsVO
	 * @return int
	 * @exception Exception
	 */
	public SmsVO selectSmsManageDetail(SmsVO vo) throws Exception {
		return smsManageDAO.selectSmsManageDetail(vo);
	}
	
	/**
	 * SMS관리 등록
	 * @param SmsVO
	 * @throws Exception
	 */
	public int insertSmsManage(SmsVO vo) throws Exception {
		try {
			return smsManageDAO.insertSmsManage(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * SMS관리 수정
	 * @param SmsVO
	 * @throws Exception
	 */
	public int updateSmsManage(SmsVO vo) throws Exception {
		try {
			return smsManageDAO.updateSmsManage(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * SMS관리 삭제
	 * @param SmsVO
	 * @throws Exception
	 */
	public int deleteSmsManage(SmsVO vo) throws Exception {
		try {
			return smsManageDAO.deleteSmsManage(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * SMS관리 키 조회
	 * 
	 * @param SmsVO
	 * @return int
	 * @exception Exception
	 */
	public String selectSmsKeyCheck(SmsVO vo) throws Exception {
		return smsManageDAO.selectSmsKeyCheck(vo);
	}
}
