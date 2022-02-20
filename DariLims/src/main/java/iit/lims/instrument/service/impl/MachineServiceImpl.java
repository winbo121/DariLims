package iit.lims.instrument.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.instrument.dao.MachineDAO;
import iit.lims.instrument.service.MachineService;
import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MachineServiceImpl
 * 
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class MachineServiceImpl extends EgovAbstractServiceImpl implements MachineService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "machineDAO")
	private MachineDAO machineDAO;

	/**
	 * 장비관리 목록 조회
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public List<MachineVO> selectMachineList(MachineVO machineVO) throws Exception {

		if (machineVO.getM_img() != null && machineVO.getM_img().getSize() > 0) {
			machineVO.setAdd_file(machineVO.getM_img().getBytes());
			machineVO.setImg_file_nm(machineVO.getM_img().getOriginalFilename());
		}
		return machineDAO.selectMachineList(machineVO);
	}

	/**
	 * 장비관리 부서리스트 조회
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public List<MachineVO> selectMachineDeptList(MachineVO machineVO) throws Exception {

		return machineDAO.selectMachineDeptList(machineVO);
	}

	/**
	 * 장비관리 상세정보 조회
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public MachineVO machineDetail(MachineVO machineVO) {
		try {
			return machineDAO.machineDetail(machineVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 장비관리 저장 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int insertMachine(MachineVO machineVO) throws Exception {
		try {
			if (machineVO.getM_img() != null && machineVO.getM_img().getSize() > 0) {
				machineVO.setAdd_file(machineVO.getM_img().getBytes());
				machineVO.setImg_file_nm(machineVO.getM_img().getOriginalFilename());
			}
			return machineDAO.insertMachine(machineVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 장비관리 수정 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int updateMachine(MachineVO machineVO) throws Exception {
		try {
			if (machineVO.getM_img() != null && machineVO.getM_img().getSize() > 0) {
				machineVO.setAdd_file(machineVO.getM_img().getBytes());
				machineVO.setImg_file_nm(machineVO.getM_img().getOriginalFilename());
			}
			return machineDAO.updateMachine(machineVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 장비관리 삭제 처리
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public int deleteMachine(MachineVO machineVO) throws Exception {
		try {
			if (machineVO.getM_img() != null && machineVO.getM_img().getSize() > 0) {
				machineVO.setAdd_file(machineVO.getM_img().getBytes());
				machineVO.setImg_file_nm(machineVO.getM_img().getOriginalFilename());
			}
			return machineDAO.deleteMachine(machineVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 장비관리 파일저장
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public MachineVO machineDown(MachineVO machineVO) {
		try {
			return machineDAO.machineDown(machineVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 장비 삭제 여부 조회
	 * 
	 * @param MachineVO
	 * @throws Exception
	 */
	public MachineVO machineDeleteFlag(MachineVO machineVO) {
		try {
			return machineDAO.machineDeleteFlag(machineVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	public byte[] machineImage(MachineVO machineVO) throws Exception {
		try {
			MachineVO m = machineDAO.machineImage(machineVO);
			if (m != null) {
				return m.getAdd_file();
			}
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	public List<MachineVO> selectMachineManager(MachineVO machineVO) throws Exception {
		return machineDAO.selectMachineManager(machineVO);
	}

	public int saveManager(MachineVO machineVO) throws Exception {
		try {
			machineDAO.saveManager(machineVO);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public int deleteManager(MachineVO machineVO) throws Exception {
		try {
			machineDAO.deleteManager(machineVO);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
}
