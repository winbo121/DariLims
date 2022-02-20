package iit.lims.instrument.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.instrument.dao.RepairDAO;
import iit.lims.instrument.service.RepairService;
import iit.lims.instrument.vo.RepairVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * RepairServiceImpl
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
public class RepairServiceImpl extends EgovAbstractServiceImpl implements RepairService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "repairDAO")
	private RepairDAO repairDAO;

	/**
	 * 수리등록 목록 조회
	 * 
	 * @param RepairVO
	 * @throws Exception
	 */
	public List<RepairVO> selectRepairList(RepairVO repairVO) throws Exception {
		return repairDAO.selectRepairList(repairVO);
	}

	/**
	 * 수리등록 상세정보 조회 
	 * @param RepairVO
	 * @throws Exception
	 */
	public RepairVO repairDetail(RepairVO repairVO) {
		try {
			return repairDAO.repairDetail(repairVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 수리등록 저장 처리 
	 * @param RepairVO
	 * @throws Exception
	 */
	public int insertRepair(RepairVO repairVO) throws Exception {
		try {
			return repairDAO.insertRepair(repairVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 수리등록 수정 처리 
	 * @param RepairVO
	 * @throws Exception
	 */
	public int updateRepair(RepairVO repairVO) throws Exception {
		try {
			return repairDAO.updateRepair(repairVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 수리등록 삭제 처리 
	 * @param RepairVO
	 * @throws Exception
	 */
	public int deleteRepair(RepairVO repairVO) throws Exception {
		try {
			return repairDAO.deleteRepair(repairVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
