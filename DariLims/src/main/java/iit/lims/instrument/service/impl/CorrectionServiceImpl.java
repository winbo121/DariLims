package iit.lims.instrument.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.instrument.dao.CorrectionDAO;
import iit.lims.instrument.service.CorrectionService;
import iit.lims.instrument.vo.CorrectionVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * CorrectionServiceImpl
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
public class CorrectionServiceImpl extends EgovAbstractServiceImpl implements CorrectionService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "correctionDAO")
	private CorrectionDAO correctionDAO;

	/**
	 * 교정 목록 조회
	 * 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public List<CorrectionVO> selectCorrectionList(CorrectionVO correctionVO) throws Exception {
		return correctionDAO.selectCorrectionList(correctionVO);
	}

	/**
	 * 교정 상세정보 조회 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public CorrectionVO correctionDetail(CorrectionVO correctionVO) {
		try {
			return correctionDAO.correctionDetail(correctionVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 교정 담당자 조회 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public CorrectionVO correctionMng(CorrectionVO correctionVO) {
		try {
			return correctionDAO.correctionMng(correctionVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 교정 저장 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int insertCorrection(CorrectionVO correctionVO) throws Exception {
		try {
			return correctionDAO.insertCorrection(correctionVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 교정 수정 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int updateCorrection(CorrectionVO correctionVO) throws Exception {
		try {
			return correctionDAO.updateCorrection(correctionVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 교정 삭제 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int deleteCorrection(CorrectionVO correctionVO) throws Exception {
		try {
			return correctionDAO.deleteCorrection(correctionVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 중간점검 목록 조회
	 * 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public List<CorrectionVO> selectCorrectionList2(CorrectionVO correctionVO) throws Exception {
		return correctionDAO.selectCorrectionList2(correctionVO);
	}

	/**
	 * 중간점검 상세정보 조회 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public CorrectionVO correctionDetail2(CorrectionVO correctionVO) {
		try {
			return correctionDAO.correctionDetail2(correctionVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 중간점검 저장 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int insertCorrection2(CorrectionVO correctionVO) throws Exception {
		try {
			return correctionDAO.insertCorrection2(correctionVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 중간점검 수정 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int updateCorrection2(CorrectionVO correctionVO) throws Exception {
		try {
			return correctionDAO.updateCorrection2(correctionVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 중간점검 삭제 처리 
	 * @param CorrectionVO
	 * @throws Exception
	 */
	public int deleteCorrection2(CorrectionVO correctionVO) throws Exception {
		try {
			return correctionDAO.deleteCorrection2(correctionVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
