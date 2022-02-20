package iit.lims.accept.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.SamplingVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * SamplingDAO
 * 
 * @author 허태원
 * @since 2019.11.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2019.11.26  허태원   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Repository
public class SamplingDAO extends EgovAbstractMapper {
	
	public List<SamplingVO> selectSamplingList(SamplingVO vo) {
		return selectList("sampling.selectSamplingList", vo);
	}
	
	public SamplingVO selectSamplingDetail(SamplingVO vo) {
		return selectOne("sampling.selectSamplingDetail", vo);
	}
	
	public SamplingVO samplingFileDown(SamplingVO vo) throws Exception {
		return selectOne("sampling.samplingFileDown", vo);
	}
	
	public String selectPickNo() {
		return selectOne("sampling.selectPickNo", null);
	}
	
	public int insertSampling(SamplingVO vo) throws DataAccessException {
		insert("sampling.insertSampling", vo);
		return 1;
	}

	public int updateSampling(SamplingVO vo) throws DataAccessException {
		return update("sampling.updateSampling", vo);
	}
	
	public int updateReqSampling(SamplingVO vo) throws DataAccessException {
		return update("sampling.updateReqSampling", vo);
	}
	
	public List<SamplingVO> selectSamplingLtList(SamplingVO vo) {
		return selectList("sampling.selectSamplingLtList", vo);
	}
	
	public List<SamplingVO> selectSamplingMesureList(SamplingVO vo) {
		return selectList("sampling.selectSamplingMesureList", vo);
	}
	
	public int insertSamplingLt(HashMap<String, String> m) throws DataAccessException {
		return update("sampling.insertSamplingLt", m);
	}
	
	public int deleteSamplingLt(SamplingVO vo) throws DataAccessException {
		return delete("sampling.deleteSamplingLt", vo);
	}
	
	public int insertSamplingMesure(HashMap<String, String> m) throws DataAccessException {
		return update("sampling.insertSamplingMesure", m);
	}
	
	public int deleteSamplingMesure(SamplingVO vo) throws DataAccessException {
		return delete("sampling.deleteSamplingMesure", vo);
	}
	
	// 채취 정보 저장시 채취로트 생성
	public int saveSplorePick(SamplingVO vo) throws DataAccessException {
		return update("sampling.saveSplorePick", vo);
	}
	
	// 채취 정보 저장시 채취측정 생성
	public int saveMesure(SamplingVO vo) throws DataAccessException {
		return update("sampling.saveMesure", vo);
	}
}