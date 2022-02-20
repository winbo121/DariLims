package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class TestStandardDAO extends EgovAbstractMapper {

	
	/**
	 * 스탠다드 리스트 조회
	 *
	 * @param TestStandardVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<TestStandardVO> selectStandardList(TestStandardVO vo) throws Exception {
		return selectList("testStandard.selectStandardList", vo);
	}
	
	//스탠다드 등록
	public int insertStandardItem(TestStandardVO vo) throws Exception {
		insert("testStandard.insertStandardItem", vo);
		return 1;
	}
	
	//스탠다드 수정
	public int updateStandardItem(TestStandardVO vo) throws Exception {
		update("testStandard.updateStandardItem", vo);
		return 1;
	}
	
	//스탠다드 복사
	public int copyStandard(TestStandardVO vo) throws Exception {
		insert("testStandard.copyStandard", vo);
		return 1;
	}
	
	//스탠다드별 항목 리스트
	public List<TestStandardVO> selectStandardRItemList(TestStandardVO vo) throws DataAccessException {
		return selectList("testStandard.selectStandardRItemList", vo);
	}
	//스탠다드별 항목 리스트 -팝업
	public List<TestStandardVO> selectStandardRItemListPop(TestStandardVO vo) throws DataAccessException {
		return selectList("testStandard.selectStandardRItemListPop", vo);
	}
	
	//스탠다드 항목 추가 팝업 리스트
	public List<TestStandardVO> selectStandardPIList(TestStandardVO vo) throws Exception {
		return selectList("testStandard.selectStandardPIList", vo);
	}
	
	/**
	 * 스탠다드 > 항목 멀티추가
	 * @param map
	 * @return List
	 * @exception Exception
	 */
	public int insertStandardInsItemPop(HashMap<String, String> m) throws Exception {
		insert("testStandard.insertStandardInsItemPop", m);
		return 1;
	}
	
	/**	 
	 * 스탠다드별 시험항목 삭제 처리 //
	 * @param map
	 * @return int
	 * @exception Exception
	 */
	public int deleteStandardSpItem(HashMap<String, String> m) throws DataAccessException {
		return update("testStandard.deleteStandardSpItem", m);
	}
	
	/**	 
	 * 스탠다드별 시험항목 수정 처리 //
	 * @param map
	 * @return int
	 * @exception Exception
	 */
	public int updateStandardSpItem(HashMap<String, String> m) throws DataAccessException {
		return update("testStandard.updateStandardSpItem", m);	
	}
	
	/**	 
	 * 스탠다드별 시험항목 복사 처리 //
	 * @param map
	 * @return int
	 * @exception Exception
	 */
	public int copyTestStandardItem(HashMap<String, String> m) throws DataAccessException {
		return update("testStandard.copyTestStandardItem", m);	
	}
}
