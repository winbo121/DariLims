package iit.lims.reagentsGlass.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.instrument.vo.MachineVO;
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

public interface ReagentsGlassService {

	/**
	 * 시약/실험기구 목록 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> reagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) throws Exception;

	/**
	 * 시약/실험기구 상세정보 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public ReagentsGlassVO reagentsGlassInfoDetail(HttpServletRequest request, ReagentsGlassVO reagentsGlassVO);

	/**
	 * 시약/실험기구 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public int insertReagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) throws Exception;

	/**
	 * 시약/실험기구 수정 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public int updateReagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) throws Exception;

	/**
	 * 구매정보 등록 상세정보 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public ReagentsGlassVO selectBuyingInfoDetail(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매정보 신규등록
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int insertBuyingInfo(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매정보 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int updateBuyingInfo(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매정보 삭제
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteBuyingInfo(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectBuyingInfoList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매요청 등록 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectBuyingRequestList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구 마스터여부 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int updateReagentsGlassInfoMaster(ReagentsGlassVO rgentsGlassVO) throws Exception;

	/**
	 * 구매요청 목록 저장 처리
	 * 
	 * @param BuyingRequestVO
	 * @return int
	 * @exception Exception
	 */
	public int insertBuyingRequestList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구정보 팝업 목록 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> popReagentsGlassInfoList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구정보 수불 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> selectReagentsGlassInOutList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구정보 수불 디테일 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> selectReagentsGlassInOutDetail(ReagentsGlassVO vo) throws Exception;
	
	/**
	 * 시약/실험기구정보 수불 업데이트
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	public int updateReagentsGlassInOutDetail(ReagentsGlassVO vo) throws Exception ;
	
	/**
	 * 시약/실험기구정보 수불 저장(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	public int insertReagentsGlassInOut(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구정보 수불 수정(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	public int updateReagentsGlassInOut(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구정보 수불(결재) 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> receivePayPaymentList(ReagentsGlassVO rgentsGlassVO) throws Exception;

	/**
	 * 시약/실험기구정보 수불(결재) 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updateReceivePayPayment(ReagentsGlassVO rgentsGlassVO) throws Exception;

	/**
	 * 시약/실험기구정보 수불현황 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> selectReagentsGlassStateList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매품목현황 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> buyingProductStateList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구 팝업 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public String insertPopReagentsGlassInfo(ReagentsGlassVO vo) throws Exception;

	/**
	 * 시약/실험기구 팝업 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updatePopReagentsGlassInfo(ReagentsGlassVO rgentsGlassVO) throws Exception;

	/**
	 * 구매검수 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectBuyingConfirmList(ReagentsGlassVO vo) throws Exception;

	/**
	 * 구매검수등록(= 수불 저장)
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int saveConfirm(ReagentsGlassVO rgentsGlassVO) throws Exception;
	
	
	/**
	 * MSDS 등록이미지 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public byte[] reagentsGlassImage(ReagentsGlassVO vo) throws Exception;
	
	/**
	 * MSDS 등록이미지 다운로드
	 *
	 * @param ReagentsGlassVO
	 * @return ReagentsGlassVO
	 * @exception Exception	 
	 */
	public ReagentsGlassVO reagentsGlassImageDown(ReagentsGlassVO vo) throws Exception;

}
