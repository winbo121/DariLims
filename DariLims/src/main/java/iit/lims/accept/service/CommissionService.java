package iit.lims.accept.service;

import java.util.List;

import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.accept.vo.CounselVO;
import iit.lims.master.vo.SamplingPointVO;

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
 *  2015.01.13  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
public interface CommissionService {
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 목록 조회 
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> stdItemCommissionList(TestPrdStdVO vo) throws Exception;
	
	/**	 
	 * 시험기준별 시험항목(및 수수료) 저장 처리 
	 * @param StdTestItemVO
	 * @return int
	 * @exception Exception
	 */
	public int insertStdItemCommission(TestPrdStdVO vo) throws Exception;
	
	
	/**
	 * 수수료 프로세스 사용 여부 조회
	 * @param 
	 * @return TestPrdStdVO
	 * @exception Exception	 
	 */
	public String commissionFlag() throws Exception;

	/**
	 * 수수료 프로세스 사용 여부 수정
	 * @param TestPrdStdVO
	 * @return TestPrdStdVO
	 * @exception Exception	 
	 */
	public int updateCommissionFlag(TestPrdStdVO vo) throws Exception;
	
	/**
	 * 수수료 프로세스 사용 여부 삭제
	 * @param TestPrdStdVO
	 * @return TestPrdStdVO
	 * @exception Exception	 
	 */
	public int deleteStdItemCommission(TestPrdStdVO vo) throws Exception;
	
}
