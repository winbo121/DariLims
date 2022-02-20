package iit.lims.analysis.dao;

import iit.lims.analysis.vo.ResultInputVO;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * SampleDisuse
 * 
 * @author 정우용
 * @since 2015.03.05
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.05  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class SampleDisuseDAO extends EgovAbstractMapper {
	
	public List<ResultInputVO> selectSampleDisuseList(ResultInputVO vo) {
		return selectList("sampleDisuse.selectSampleDisuseList", vo);
	}

	public ResultInputVO sampleDisuseDetail(ResultInputVO vo) {
		return (ResultInputVO) selectOne("sampleDisuse.sampleDisuseDetail", vo);
	}
	
	public int updateSampleDisuse(HashMap<String, String> m) throws Exception {
		return update("sampleDisuse.updateSampleDisuse", m);
	}
	
	public int updateSampleDisuseFlag(ResultInputVO vo) throws DataAccessException {
		return update("sampleDisuse.updateSampleDisuseFlag", vo);
	}

	public int deleteSampleDisuse(ResultInputVO vo) throws DataAccessException {
		return update("sampleDisuse.deleteSampleDisuse", vo);
	}
}