package iit.lims.accept.service;

import java.util.List;
import iit.lims.master.vo.TestPrdStdVO;

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
 *      Copyright (C) 2016. by interfaceIT., All right reserved.
 */
public interface CommissionPrdService {
	
	/**	 
	 * 시험기준 & 품목별 항목(및 수수료) 목록 조회 
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> stdPrdItemCommissionList(TestPrdStdVO vo) throws Exception;
	
	/**	 
	 * 시험기준 & 품목별 항목(및 수수료) 저장 
	 * @param TestPrdStdVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdPrdItemCommission(TestPrdStdVO vo) throws Exception;
}
