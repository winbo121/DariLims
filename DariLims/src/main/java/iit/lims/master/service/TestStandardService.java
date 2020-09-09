package iit.lims.master.service;

import java.util.List;

import iit.lims.master.vo.TestItemVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;

public interface TestStandardService {
	
	public int insertStandardItem(TestStandardVO vo) throws Exception;
	
	public int updateStandardItem(TestStandardVO vo) throws Exception;
	
	public int copyStandard(TestStandardVO vo) throws Exception;
	
	public List<TestStandardVO> selectStandardList(TestStandardVO vo) throws Exception;
	
	
	//스탠다드별 항목 리스트
	public List<TestStandardVO> selectStandardRItemList(TestStandardVO vo) throws Exception;
	
	//스탠다드별 항목 리스트-팝업
	public List<TestStandardVO> selectStandardRItemListPop(TestStandardVO vo) throws Exception;
	
	//스탠다드 항목추가 팝업 리스트
	public List<TestStandardVO> selectStandardPIList(TestStandardVO vo) throws Exception;
	
	/**
	 * 스탠다드 팝업창 항목 멀티 추가
	 *
	 * @param TestStandardVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public int insertStandardInsItemPop(TestStandardVO vo) throws Exception;
	
	
	/**	 
	 * 스탠다드별 시험항목 저장 처리 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */
	public int insertTestStandardItem(TestStandardVO vo) throws Exception;	
	
	
	/**	 
	 * 스탠다드별 시험항목 저장 처리 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */
	public int copyTestStandardItem(TestStandardVO vo) throws Exception;	
}
