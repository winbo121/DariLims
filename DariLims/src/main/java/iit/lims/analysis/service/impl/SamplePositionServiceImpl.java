package iit.lims.analysis.service.impl;

import iit.lims.analysis.dao.SamplePositionDAO;
import iit.lims.analysis.service.SamplePositionService;
import iit.lims.analysis.vo.ResultInputVO;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SamplePosition
 * 
 * @author 허태원
 * @since 2020.05.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일			수정자		수정내용
 *  ---------- -------- ---------------------------
 *  2020.05.19	허태원		최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class SamplePositionServiceImpl extends EgovAbstractServiceImpl implements SamplePositionService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "samplePositionDAO")
	private SamplePositionDAO samplePositionDAO;

	/**
	 * 검체위치 검체 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSamplePositionSampleList(ResultInputVO vo) throws Exception {
		return samplePositionDAO.selectSamplePositionSampleList(vo);
	}

	/**
	 * 검체위치 이력 목록 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSamplePositionHistoryList(ResultInputVO vo) {
		return samplePositionDAO.selectSamplePositionHistoryList(vo);
	}

	/**
	 * 검체위치 등록 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int insertSamplePosition(ResultInputVO vo) throws Exception {
		try {
			samplePositionDAO.insertSamplePosition(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 검체위치 수정 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateSamplePosition(ResultInputVO vo) throws Exception {
		try {
			samplePositionDAO.updateSamplePosition(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
