package iit.lims.instrument.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.instrument.dao.StateDAO;
import iit.lims.instrument.service.StateService;
import iit.lims.instrument.vo.StateVO;
import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * StateServiceImpl
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
public class StateServiceImpl extends EgovAbstractServiceImpl implements StateService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "stateDAO")
	private StateDAO stateDAO;

	/**
	 * 장비현황 전체 목록 조회
	 * 
	 * @param StateVO
	 * @throws Exception
	 */
	public List<MachineVO> machineState(MachineVO machineVO) throws Exception {
		return stateDAO.machineState(machineVO);
	}
	
	/**
	 * 장비현황 목록 조회
	 * 
	 * @param StateVO
	 * @throws Exception
	 */
	public List<StateVO> selectStateList(StateVO stateVO) throws Exception {
		return stateDAO.selectStateList(stateVO);
	}

	/**
	 * 장비현황 상세정보 조회 
	 * @param StateVO
	 * @throws Exception
	 */
	public StateVO stateDetail(StateVO stateVO) {
		try {
			return stateDAO.stateDetail(stateVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 장비현황 저장 처리 
	 * @param StateVO
	 * @throws Exception
	 */
	public int insertState(StateVO stateVO) throws Exception {
		try {
			return stateDAO.insertState(stateVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 장비현황 수정 처리 
	 * @param StateVO
	 * @throws Exception
	 */
	public int updateState(StateVO stateVO) throws Exception {
		try {
			return stateDAO.updateState(stateVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 장비현황 삭제 처리 
	 * @param StateVO
	 * @throws Exception
	 */
	public int deleteState(StateVO stateVO) throws Exception {
		try {
			return stateDAO.deleteState(stateVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
