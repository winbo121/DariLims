package iit.lims.instrument.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.instrument.dao.UseLogDAO;
import iit.lims.instrument.service.UseLogService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.instrument.vo.UseLogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * UseLogServiceImpl
 * 
 * @author 최은향
 * @since 2015.01.27
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.27  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class UseLogServiceImpl extends EgovAbstractServiceImpl implements UseLogService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "useLogDAO")
	private UseLogDAO useLogDAO;

	/**
	 * 장비사용일지 전체 목록 조회
	 * 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public List<MachineVO> machineUseLog(MachineVO machineVO) throws Exception {
		return useLogDAO.machineUseLog(machineVO);
	}

	/**
	 * 장비사용일지 목록 조회
	 * 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public List<UseLogVO> selectUseLogList(UseLogVO useLogVO) throws Exception {
		return useLogDAO.selectUseLogList(useLogVO);
	}

	/**
	 * 장비사용일지 상세정보 조회
	 * 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public UseLogVO useLogDetail(UseLogVO useLogVO) {
		try {
			return useLogDAO.useLogDetail(useLogVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 장비사용일지 저장(등록/수정) 처리
	 * 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public int insertUseLog(UseLogVO useLogVO) throws Exception {
		int result = -1;
		try {
			if (useLogVO.getPageType().equals("insert")) {
				result = useLogDAO.insertUseLog(useLogVO);
			} else {
				result = useLogDAO.updateUseLog(useLogVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	/**
	 * 장비사용일지 삭제 처리
	 * 
	 * @param UseLogVO
	 * @throws Exception
	 */
	public int deleteUseLog(UseLogVO useLogVO) throws Exception {
		try {
			return useLogDAO.deleteUseLog(useLogVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
