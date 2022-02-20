package iit.lims.master.service;
import java.util.List;

import iit.lims.master.vo.UnitWorkVO;

/**
 * UnitWorkService
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface UnitWorkService {
	
	/**
	 * 단위업무 목록 조회
	 *
	 * @param UnitWorkVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UnitWorkVO> unitWork(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 단위업무 상세정보 조회
	 *
	 * @param UnitWorkVO
	 * @return List
	 * @exception Exception	 
	 */
	public UnitWorkVO unitWorkDetail(UnitWorkVO unitWorkVO);
		
	
	/**
	 * 단위업무 저장(등록/수정) 처리
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public int insertUnitWork(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 단위업무 삭제 처리 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public int deleteUnitWork(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 부서 목록 조회
	 *
	 * @param UnitWorkVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UnitWorkVO> deptList(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 부서별 단위업무 목록 조회(모든 부서 조회) 
	 *
	 * @param UnitWorkVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UnitWorkVO> deptUnitWork(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 부서별 단위업무 목록 조회(부서별 단위업무 조회) 
	 *
	 * @param UnitWorkVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<UnitWorkVO> selectDeptUnitWork(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 부서별단위업무 저장 처리(저장, 삭제)
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public int saveDeptUnitWork(UnitWorkVO unitWorkVO) throws Exception;
	
	
	/**
	 * 단위업무 삭제여부 조회
	 *
	 * @param UnitWorkVO
	 * @return List
	 * @exception Exception
	 */
	public UnitWorkVO deptUnitWorkDeleteFlag(UnitWorkVO unitWorkVO);
}