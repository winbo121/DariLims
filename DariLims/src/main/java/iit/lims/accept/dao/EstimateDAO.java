package iit.lims.accept.dao;

import iit.lims.accept.vo.EstimateVO;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * AstimateDAO
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
@Repository
public class EstimateDAO extends EgovAbstractMapper {

	public List<EstimateVO> selectEstimateList(EstimateVO estimateVO) throws Exception {
		return selectList("estimate.selectEstimateList", estimateVO);
	}
	
	public EstimateVO selectEstimateDetail(EstimateVO estimateVO) throws Exception {
		return selectOne("estimate.selectEstimateDetail", estimateVO);
	}

	public List<EstimateVO> selectEstimateItemList(EstimateVO estimateVO) throws Exception {
		return selectList("estimate.selectEstimateItemList", estimateVO);
	}

	public List<EstimateVO> selectEstimateItemFeeList(EstimateVO estimateVO) throws Exception {
		return selectList("estimate.selectEstimateItemFeeList", estimateVO);
	}
	
	public int insertEstimate(EstimateVO estimateVO) throws Exception{
		
		return insert("estimate.insertEstimate", estimateVO);
	}
	
	public int copyEstimate(EstimateVO estimateVO) throws Exception{
		
		return insert("estimate.copyEstimate",estimateVO);
		
	}

	public int updateEstimate(EstimateVO estimateVO) throws Exception{
		return update("estimate.updateEstimate", estimateVO);
	}
	
	public int updateEstimateState(String est_no) throws Exception{
		return update("estimate.updateEstimateState", est_no);
	}

	public int deleteEstimate(EstimateVO estimateVO) throws Exception{
		return update("estimate.deleteEstimate", estimateVO);
	}
	
	public int insertInstGrid(HashMap<String, String> m) throws Exception {
		insert("estimate.insertInstGrid", m);
		return 1;
	}
	
	public int insertEstimateItemFee(HashMap<String, String> m) throws Exception {
		insert("estimate.insertEstimateItemFee", m);
		return 1;
	}
	
	public int updateEstimateItemFee(HashMap<String, String> m) throws Exception {
		insert("estimate.updateEstimateItemFee", m);
		return 1;
	}
	
	public int deleteEstimateItemFee(HashMap<String, String> m) throws Exception {
		insert("estimate.deleteEstimateItemFee", m);
		return 1;
	}

	
	public int updateEstimateItem(HashMap<String, String> m) throws Exception {
		insert("estimate.updateEstimateItem", m);
		return 1;
	}
	
	public int deleteEstimateItem(HashMap<String, String> m) throws Exception {
		insert("estimate.deleteEstimateItem", m);
		return 1;
	}
	
	public int updateEstFeeTot(EstimateVO vo) throws Exception {
		insert("estimate.updateEstFeeTot", vo);
		return 1;
	}
	
	public List<EstimateVO> selectEstimateTemplateList(EstimateVO estimateVO) throws Exception {
		return selectList("estimate.selectEstimateTemplateList", estimateVO);
	}
	
	public List<EstimateVO> selectEstimateItemTemplateList(EstimateVO estimateVO) throws Exception {
		return selectList("estimate.selectEstimateItemTemplateList", estimateVO);
	}
	
	public List<EstimateVO> selectEstimateItemFeeTemplateList(EstimateVO estimateVO) throws Exception {
		return selectList("estimate.selectEstimateItemFeeTemplateList", estimateVO);
	}
	
	public int insertEstimateTemplate(EstimateVO vo) throws Exception{
		return insert("estimate.insertEstimateTemplate", vo);
	}
	
	public int insertSelectEstimateTemplate(EstimateVO vo) throws Exception{
		return insert("estimate.insertSelectEstimateTemplate", vo);
	}
	
	public int insertEstimateItemGrid(HashMap<String, String> m) throws Exception {
		insert("estimate.insertEstimateItemGrid", m);
		return 1;
	}
}