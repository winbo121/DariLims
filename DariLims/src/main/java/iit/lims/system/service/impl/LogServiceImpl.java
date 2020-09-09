package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.LogDAO;
import iit.lims.system.service.LogService;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.LogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * LogServiceImpl
 * @logor 정우용
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
public class LogServiceImpl extends EgovAbstractServiceImpl implements LogService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "logDAO")
	private LogDAO logDAO;
	
	/**
	 * 부서관리 목록 조회 
	 * @param LogVO
	 * @throws Exception
	 */
	public List<LogVO> selectLogList(LogVO logVO) throws Exception {
        return logDAO.selectLogList(logVO);
    }
	
	/**
	 * 부서관리 저장/수정 처리 
	 * @param LogVO
	 * @throws Exception
	 */
	public int saveLogGroup(LogVO logVO) throws Exception {
		int result = -1;
		try {
			
			
			//result = logDAO.insertLogGroup(logVO);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 로그 페이징
	 * 
	 * @param LogVO
	 * @throws Exception
	 */
	@Override
	public int selectPagingListTotCnt(LogVO logVO) throws Exception {
		return logDAO.logCnt(logVO);
	}
	
}
