package iit.lims.reagentsGlass.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.reagentsGlass.vo.ReagentsGlassVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * BuyingRequestDAO
 * 
 * @author 석은주
 * @since 2015.02.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.16 석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class PurchaseConfirmDAO extends EgovAbstractMapper {

	/**
	 * 구매확정용 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> purchaseInfoList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.purchaseInfoList", vo);
	}

	/**
	 * 구매확정용 구매요청 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> purchaseReqList(ReagentsGlassVO reagentsGlassVO) {
		return selectList("reagentsGlass.purchaseReqList", reagentsGlassVO);
	}

	/**
	 * 구매확정 목록 등록
	 * 
	 * @param HashMap
	 * @return int
	 * @throws Exception
	 */
	public void insertPurchaseConfirm(HashMap<String, String> m) throws Exception {
		update("reagentsGlass.insertPurchaseConfirm", m);
	}

	/**
	 * 구매확정 목록 수정
	 * 
	 * @param HashMap
	 * @return int
	 * @throws Exception
	 */
	public void updatePurchaseConfirm(HashMap<String, String> m) throws Exception {
		update("reagentsGlass.updatePurchaseConfirm", m);
	}

	/**
	 * 구매요청 목록 삭제
	 * 
	 * @param HashMap
	 * @return int
	 * @exception Exception
	 */
	public int deletePurchaseConfirm(HashMap<String, String> map) throws Exception {
		return delete("reagentsGlass.deleteBuyingRequestList", map);
	}

	/**
	 * 구매 확인 확정등록 여부(COUNT)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	public Integer buyingConfirmationCount(HashMap<String, String> m) {
		//		selectOne("reagentsGlass.buyingConfirmationCount", m);
		return (Integer) selectOne("reagentsGlass.buyingConfirmationCount", m);
	}

	/**
	 * 구매 확인 리스트 ROW(COUNT)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	public Integer buyingConfirmationRowCount(HashMap<String, String> m) {
		return (Integer) selectOne("reagentsGlass.buyingConfirmationRowCount", m);
	}

	/**
	 * 구매정보 (확정으로) 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updatePurchaseInfoConfirm(ReagentsGlassVO vo) throws Exception {
		return delete("reagentsGlass.updatePurchaseInfoConfirm", vo);
	}

	public int updateStatePurchaseConfirm(ReagentsGlassVO vo) throws Exception {
		return update("reagentsGlass.updateStatePurchaseConfirm", vo);
	}

	public ReagentsGlassVO checkPurchaseConfirmValue(ReagentsGlassVO vo) throws Exception {
		return selectOne("reagentsGlass.checkPurchaseConfirmValue", vo);
	}

	/**
	 * 시약/실험기구 마스터여부 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updateReagentsGlassInfoMaster(ReagentsGlassVO vo) throws Exception {
		return update("reagentsGlass.updateReagentsGlassInfoMaster", vo);
	}

	public void updatePurchaseConfirmExcel(ArrayList<ReagentsGlassVO> lst) throws Exception {
		update("reagentsGlass.updatePurchaseConfirmExcel", lst);
	}

	public String checkPurchaseInfo(ReagentsGlassVO vo) throws Exception {
		return selectOne("reagentsGlass.checkPurchaseInfo", vo);
	}
}
