package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * TestItemInstrumentDAO
 * 
 * @author 석은주
 * @since 2015.01.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.26  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class TestItemInstrumentDAO extends EgovAbstractMapper {
	
	/**
	 * 시험기기 목록 전체 조회
	 *
	 * @param MachineVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MachineVO> selectAllInstList(MachineVO vo) throws Exception {
		return selectList("testItemInst.selectAllInstList", vo);
	}

	/**
	 * 항목별 시험기기 목록 조회
	 *
	 * @param MachineVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<MachineVO> selectTestItemInstList(MachineVO vo) throws Exception {
		return selectList("testItemInst.selectTestItemInstList", vo);
	}

	/**
	 * 항목별 시험기기 기기 목록 저장
	 *
	 * @param MachineVO
	 * @return int
	 * @exception Exception	 
	 */
	public int insertTestItemInst(HashMap<String, String> m) throws Exception {
		return insert("testItemInst.insertTestItemInst", m);		
	}

	/**
	 * 항목별 시험기기 기기 목록 삭제
	 *
	 * @param MachineVO
	 * @return int
	 * @exception Exception	 
	 */
	public int deleteTestItemInst(MachineVO vo) throws Exception {
		return delete("testItemInst.deleteTestItemInst", vo);		
	}	

}
