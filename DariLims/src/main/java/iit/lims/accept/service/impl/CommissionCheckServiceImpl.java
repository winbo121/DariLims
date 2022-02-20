package iit.lims.accept.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.CommissionCheckDAO;
import iit.lims.accept.service.CommissionCheckService;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.accept.vo.CommissionTaxInvoiceVO;
import iit.lims.util.ConverObjectToMap;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * CommissionChecktServiceImpl
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
@Service
public class CommissionCheckServiceImpl extends EgovAbstractServiceImpl implements CommissionCheckService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "commissionCheckDAO")
	private CommissionCheckDAO commissionCheckDAO;
	
	/**
	 * 수수료입금확인 > 업체 목록 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectCommissionCheckList(CommissionCheckVO vo) throws Exception {
		return commissionCheckDAO.selectCommissionCheckList(vo);
	}
	
	/**
	 * 수수료입금확인 > 업체 상세 목록 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectCommissionDetailList(CommissionCheckVO vo) throws Exception {
		return commissionCheckDAO.selectCommissionDetailList(vo);
	}
	
	/**
	 * 수수료입금확인 > 입금처리
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public int saveCommissionDeposit(CommissionCheckVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1)
									value = valueArr[1];
								map.put(valueArr[0], value);
							}
						}
						
						map.put("req_org_no", vo.getReq_org_no());
						String crud = map.get("crud");
						
						/*int cntChk = commissionCheckDAO.selectCommissionDepositCount(map);*/
						
						if ("u".equals(crud)){
							/*if(cntChk == 0){
								//입금 저장
								commissionCheckDAO.insertCommissionDeposit(map);
							}else{
								//입금 수정
								commissionCheckDAO.updateCommissionDeposit(map);
							}*/
							
							commissionCheckDAO.saveCommissionDeposit(map);
						}
					}
				}
			}
			return 1;

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 세금계산서 발행내역 조회
	 * 
	 * @param CommissionCheckVO
	 * @return List
	 * @exception Exception
	 */
	public List<CommissionCheckVO> selectTaxInvoiceList(CommissionCheckVO vo) throws Exception {
		return commissionCheckDAO.selectTaxInvoiceList(vo);
	}

	@Override
	public List<HashMap<String, Object>> selectTaxInvoiceHisList(CommissionTaxInvoiceVO vo) {
		return commissionCheckDAO.selectTaxInvoiceHisList(vo);
	}

}
