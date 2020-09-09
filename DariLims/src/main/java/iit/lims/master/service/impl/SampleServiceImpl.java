package iit.lims.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.vo.SampleVO;
import iit.lims.master.dao.SampleDAO;
import iit.lims.master.service.SampleService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SampleServiceImpl
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class SampleServiceImpl extends EgovAbstractServiceImpl implements SampleService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	/**
	 * 시료유형 목록 조회 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public List<SampleVO> sampleInsert(SampleVO sampleVO) throws Exception {
		return sampleDAO.sampleInsert(sampleVO);
	}


	/**
	 * 시료유형 상세정보 조회 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public SampleVO sampleInsertDetail(SampleVO sampleVO) {
		try {
			return sampleDAO.sampleInsertDetail(sampleVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 시료유형 저장 처리 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public int insertSampleInsert(SampleVO sampleVO) throws Exception {
		try {
			return sampleDAO.insertSampleInsert(sampleVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 시료유형 수정 처리 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public int updateSampleInsert(SampleVO sampleVO) throws Exception {
		try {
			return sampleDAO.updateSampleInsert(sampleVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 시료유형 삭제 처리 
	 * @param DemoSampleVO
	 * @throws Exception
	 */
	public int deleteSampleInsert(SampleVO sampleVO) throws Exception {
		try {
			return sampleDAO.deleteSampleInsert(sampleVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}