package iit.lims.accept.service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.EstimateVO;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.system.vo.DeptVO;

import java.util.List;

/**
 * AstimateService
 * 
 * @author 윤상준
 * @since 2015.09.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.10  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
public interface EstimateService {
	
	/**
	 * 견적관리> 견적 리스트 조회
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateList(EstimateVO estimateVO) throws Exception;

	/**
	 * 견적관리> 견적 등록
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int insertEstimate(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적정보 수정
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int updateEstimate(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적정보 삭제
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int deleteEstimate(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적 등록 팝업
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public EstimateVO selectEstimateDetail(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적 항목 리스트
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemList(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 항목 리스트 멀티 추가
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int insertInstGrid(MachineVO vo)throws Exception;

	/**
	 * 견적관리> 견적 항목 수수료 리스트
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemFeeList(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적항목수수료저장
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int saveEstimateItemFee(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적항목저장
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int saveEstimateItem(EstimateVO estimateVO)throws Exception;

	/**
	 * 견적관리> 견적서 출력
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public int updateEstimateState(String est_no)throws Exception;
	
	/**
	 * 견적관리> 견적서별 항목 템플릿 리스트
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateTemplateList(EstimateVO estimateVO)throws Exception;
	
	/**
	 * 견적관리> 견적서 템플릿 리스트
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemTemplateList(EstimateVO estimateVO)throws Exception;
	
	/**
	 * 견적관리> 견적서별 항목 수수료 템플릿 리스트
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemFeeTemplateList(EstimateVO estimateVO)throws Exception;
	
	/**
	 * 견적서별 템플릿 등록
	 *
	 * @param EstimateVO
	 * @return List
	 * @exception Exception	 
	 */
	public int insertEstimateTemplate(EstimateVO vo)throws Exception;
	
	/**
	 * 견적서별 템플릿 견적서로 등록
	 *
	 * @param EstimateVO
	 * @return List
	 * @exception Exception	 
	 */
	public int insertSelectEstimateTemplate(EstimateVO vo)throws Exception;
	
	/**
	 * 견적 > 항목 리스트 멀티 추가
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertEstimateItemGrid(EstimateVO vo) throws Exception;
	
	/*복사기능*/
	public int copyEstimate(EstimateVO vo) throws Exception;
	
	
}
