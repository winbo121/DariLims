package iit.lims.reagentsGlass.service;

import java.util.List;

import org.apache.poi.ss.usermodel.Workbook;

import iit.lims.reagentsGlass.vo.ReagentsGlassVO;

/**
 * BuyingRequestService
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
 *  2015.02.16  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface PurchaseConfirmService {

	/**
	 * 구매확정용 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> purchaseInfoList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매확정용 구매요청 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> purchaseReqList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매확정 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int savePurchaseConfirm(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매확정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public String purchaseConfirm(ReagentsGlassVO vo) throws Exception;

	/**
	 * 엑셀다운
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public Workbook excelDownloadPurchaseConfirm(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구정보 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public String excelUploadPurchaseConfirm(ReagentsGlassVO vo) throws Exception;

}
