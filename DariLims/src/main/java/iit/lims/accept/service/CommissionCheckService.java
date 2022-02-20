package iit.lims.accept.service;

import java.util.HashMap;
import java.util.List;

import com.popbill.api.IssueResponse;

import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.accept.vo.CommissionTaxInvoiceVO;

/**
 * CommissionCheckService
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
public interface CommissionCheckService {
	
	/**
	 * 수수료입금확인 > 업체 목록 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectCommissionCheckList(CommissionCheckVO vo) throws Exception;
	
	/**
	 * 수수료입금확인 > 업체 상세 목록 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectCommissionDetailList(CommissionCheckVO vo) throws Exception;
	
	/**
	 * 수수료입금확인 > 입금 처리
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public int saveCommissionDeposit(CommissionCheckVO vo) throws Exception;
	

	/**
	 * 세금계산서 발행내역 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectTaxInvoiceList(CommissionCheckVO vo) throws Exception;

	public List<HashMap<String, Object>> selectTaxInvoiceHisList(CommissionTaxInvoiceVO vo);
}
