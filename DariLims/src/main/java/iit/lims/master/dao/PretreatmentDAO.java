package iit.lims.master.dao;

import iit.lims.master.vo.PretreatmentVO;
import iit.lims.master.vo.SampleGradeVO;
import iit.lims.master.vo.TestPrdStdVO;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class PretreatmentDAO extends EgovAbstractMapper {
	
	/**	 
	 * 품목별 전처리비용 목록 조회 //
	 * @param testPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectPretMList(PretreatmentVO vo) throws DataAccessException {
		return selectList("pretreatment.selectPretMList", vo);
	}
	
	/*
	 * 전처리비용 등록
	 */
	public int insertPretreatment(PretreatmentVO vo) throws Exception {
		insert("pretreatment.insertPretreatment", vo);
		return 1;
	}
	
	/*
	 * 전처리비용수정
	 */
	public int updatePretreatment(PretreatmentVO vo) throws Exception {
		return update("pretreatment.updatePretreatment", vo);
	}
	
	/*
	 * 전처리 삭제
	 */
	public int deletePretreatment(PretreatmentVO vo) throws Exception {
		return update("pretreatment.deletePretreatment", vo);
	}

}
