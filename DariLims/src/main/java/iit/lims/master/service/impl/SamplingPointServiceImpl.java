package iit.lims.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.SamplingPointDAO;
import iit.lims.master.service.SamplingPointService;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.system.vo.BoardVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SamplingPointServiceImpl
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
public class SamplingPointServiceImpl extends EgovAbstractServiceImpl implements SamplingPointService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "samplingPointDAO")
	private SamplingPointDAO samplingPointDAO;

	/**
	 * 채수장소관리 목록 조회
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public List<SamplingPointVO> samplingPoint(SamplingPointVO samplingPointVO) throws Exception {
		return samplingPointDAO.samplingPoint(samplingPointVO);
	}

	/**
	 * 채수장소관리 상세정보 조회
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public SamplingPointVO samplingPointDetail(SamplingPointVO samplingPointVO) {
		try {
			return samplingPointDAO.samplingPointDetail(samplingPointVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 채수장소관리 저장 처리
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public int insertSamplingPoint(SamplingPointVO samplingPointVO) throws Exception {
		try {
			return samplingPointDAO.insertSamplingPoint(samplingPointVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 채수장소관리 수정 처리
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public int updateSamplingPoint(SamplingPointVO samplingPointVO) throws Exception {
		try {
			return samplingPointDAO.updateSamplingPoint(samplingPointVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 채수장소관리 삭제 처리
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public int deleteSamplingPoint(SamplingPointVO samplingPointVO) throws Exception {
		try {
			return samplingPointDAO.deleteSamplingPoint(samplingPointVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 채수장소관리 사업소 팝업
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	public List<SamplingPointVO> selectOfficeList(SamplingPointVO samplingPointVO) throws Exception {
		return samplingPointDAO.selectReqOrgList(samplingPointVO);
	}
	
	/**
	 * 페이징
	 * 
	 * @param SamplingPointVO
	 * @throws Exception
	 */
	@Override
	public int selectPagingListTotCnt(SamplingPointVO samplingPointVO) throws Exception {
		return samplingPointDAO.samplingPointCnt(samplingPointVO);
	}

}