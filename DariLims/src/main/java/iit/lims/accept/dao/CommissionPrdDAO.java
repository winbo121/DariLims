package iit.lims.accept.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestPrdStdVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * CommissionPrdService
 * 
 * @author 최은향
 * @since 2016.01.25
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2016.01.25  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */
@Repository
public class CommissionPrdDAO extends EgovAbstractMapper {

	/**	 
	 * 시험기준별 시험항목(및 수수료) 목록 조회
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> stdPrdItemCommissionList(TestPrdStdVO vo) throws DataAccessException {
		return selectList("commissionPrd.stdPrdItemCommissionList", vo);
	}
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 저장 처리 
	 * @param map
	 * @return int
	 * @exception Exception
	 */
	public int insertStdItemCommissionPrd(HashMap<String, String> m) throws DataAccessException {
		return insert("commissionPrd.insertStdItemCommissionPrd", m);
	}
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 수정 처리 
	 * @param map
	 * @return int
	 * @exception Exception
	 */
	public int updateStdPrdItemCommission(HashMap<String, String> m) throws DataAccessException {
		return update("commissionPrd.updateStdPrdItemCommission", m);	
	}
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 삭제 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteStdPrdItemCommission(HashMap<String, String> m) throws DataAccessException {
		return delete("commissionPrd.deleteStdPrdItemCommission", m);
	}
	
	/**	 
	 * 시험기준분류 개정이력 수정 처리 
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */
	public int updateTestStdRev(TestPrdStdVO vo) {
		return update("testStd.updateTestStdRev", vo);
	}
	
	/**	 
	 * 수수료 프로세스 사용 여부 조회 
	 * @param 
	 * @return List
	 * @exception Exception
	 */	
	public String commissionFlag() {
		return selectOne("commission.commissionFlag");
	}
	
	/**	 
	 * 수수료 프로세스 사용 여부 수정
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */
	public int updateCommissionFlag(TestPrdStdVO vo) {
		return update("commission.updateCommissionFlag", vo);
	}
}