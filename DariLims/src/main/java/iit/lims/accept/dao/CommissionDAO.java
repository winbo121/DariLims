package iit.lims.accept.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.system.vo.NoticeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * CommissionService
 * 
 * @author 최은향
 * @since 2015.04.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.04.16  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Repository
public class CommissionDAO extends EgovAbstractMapper {

	/**	 
	 * 시험기준별 시험항목(및 수수료) 목록 조회
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> stdItemCommissionList(TestPrdStdVO vo) throws DataAccessException {
		return selectList("commission.stdItemCommissionList", vo);
	}
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 저장 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdItemCommission(HashMap<String, String> m) throws DataAccessException {
		return insert("commission.insertStdItemCommission", m);
	}
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 수정 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int updateStdItemCommission(HashMap<String, String> m) throws DataAccessException {
		return update("commission.updateStdItemCommission", m);	
	}
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 삭제 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteStdItemCommission(TestPrdStdVO vo)  {
		return delete("commission.deleteStdItemCommission", vo);
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