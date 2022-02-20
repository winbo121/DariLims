package iit.lims.accept.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.accept.vo.CommissionTaxInvoiceVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * CommissionCheckDAO
 * 
 * @author 허태원
 * @since 2015.10.02
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Repository
public class CommissionCheckDAO extends EgovAbstractMapper {

	//업체 목록 조회
	public List<CommissionCheckVO> selectCommissionCheckList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionCheck.selectCommissionCheckList", vo);
	}
	
	//업체 상세 목록 조회
	public List<CommissionCheckVO> selectCommissionDetailList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionCheck.selectCommissionDetailList", vo);
	}	
	
	//의뢰 납부 중복 조회
	public int selectCommissionDepositCount(AcceptVO vo) {
		return selectOne("commissionCheck.selectCommissionDepositCount", vo);
	}
	
	//입금 저장
	public int insertCommissionDeposit(HashMap<String, String> m) throws DataAccessException {
		return insert("commissionCheck.insertCommissionDeposit", m);
	}
	
	//입금 수정
	public int saveCommissionDeposit(HashMap<String, String> m) throws DataAccessException {
		return update("commissionCheck.saveCommissionDeposit", m);
	}
	
	// 업체별 수수료 삭제
	public int deleteCommissionDeposit(AcceptVO vo) throws Exception {
		return delete("commissionCheck.deleteCommissionDeposit", vo);
	}
	

	public List<CommissionCheckVO> selectTaxInvoiceList(CommissionCheckVO vo) throws Exception {
		return selectList("commissionCheck.selectTaxInvoiceList", vo);
	}

	public int saveCommissionTaxInvoiceResult(HashMap<String, Object> param) {
		return update("commissionCheck.saveCommissionTaxInvoiceResult", param);
		
	}

	public List<HashMap<String, Object>> selectTaxInvoiceHisList(CommissionTaxInvoiceVO vo) {
		return selectList("commissionCheck.selectTaxInvoiceHisList", vo);
	}

	public int updateCommissionDeposit(HashMap<String, Object> param) {
		return update("commissionCheck.updateCommissionDeposit", param);
	}
	
	public String selectTaxInvoiceSeq() {
		return selectOne("commissionCheck.selectTaxInvoiceSeq", null);
	}
}