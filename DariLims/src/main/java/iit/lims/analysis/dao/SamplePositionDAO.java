package iit.lims.analysis.dao;

import iit.lims.analysis.vo.ResultInputVO;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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

@Repository
public class SamplePositionDAO extends EgovAbstractMapper {
	
	public List<ResultInputVO> selectSamplePositionSampleList(ResultInputVO vo) {
		return selectList("samplePosition.selectSamplePositionSampleList", vo);
	}

	public List<ResultInputVO> selectSamplePositionHistoryList(ResultInputVO vo) {
		return selectList("samplePosition.selectSamplePositionHistoryList", vo);
	}
	
	public int insertSamplePosition(ResultInputVO vo) throws Exception {
		return update("samplePosition.insertSamplePosition", vo);
	}
	
	public int updateSamplePosition(ResultInputVO vo) throws DataAccessException {
		return update("samplePosition.updateSamplePosition", vo);
	}
}