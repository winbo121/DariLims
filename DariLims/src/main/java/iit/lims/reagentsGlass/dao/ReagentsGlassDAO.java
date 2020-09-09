package iit.lims.reagentsGlass.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.instrument.vo.MachineVO;
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
public class ReagentsGlassDAO extends EgovAbstractMapper {

	public List<ReagentsGlassVO> reagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) {
		return selectList("reagentsGlass.reagentsGlassInfo", reagentsGlassVO);
	}

	public ReagentsGlassVO reagentsGlassInfoDetail(ReagentsGlassVO reagentsGlassVO) {
		return (ReagentsGlassVO) selectOne("reagentsGlass.reagentsGlassInfoDetail", reagentsGlassVO);
	}

	public int insertReagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) {
		insert("reagentsGlass.insertReagentsGlassInfo", reagentsGlassVO);
		return 1;
	}

	public int updateReagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) throws DataAccessException {
		return update("reagentsGlass.updateReagentsGlassInfo", reagentsGlassVO);
	}

	/**
	 * 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectBuyingInfoList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.selectBuyingInfoList", vo);
	}

	/**
	 * 구매정보 등록 상세정보 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ReagentsGlassVO
	 * @throws Exception
	 */
	public ReagentsGlassVO selectBuyingInfoDetail(ReagentsGlassVO vo) throws Exception {
		return selectOne("reagentsGlass.selectBuyingInfoDetail", vo);
	}

	/**
	 * 구매정보 신규 등록
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int insertBuyingInfo(ReagentsGlassVO vo) throws Exception {
		return insert("reagentsGlass.insertBuyingInfo", vo);
	}

	/**
	 * 구매정보 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int updateBuyingInfo(ReagentsGlassVO vo) throws Exception {
		return update("reagentsGlass.updateBuyingInfo", vo);
	}

	/**
	 * 구매정보 삭제
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteBuyingInfo(ReagentsGlassVO vo) throws Exception {
		return delete("reagentsGlass.deleteBuyingInfo", vo);
	}

	/**
	 * 구매요청 등록 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectBuyingRequestList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.selectBuyingRequestList", vo);
	}

	/**
	 * 시약/실험기구정보 수불 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int insertReceivePay(HashMap<String, String> m) throws Exception {
		insert("reagentsGlass.insertReceivePay", m);
		return 1;
	}

	/**
	 * 시약/실험기구 마스터여부 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updateReagentsGlassInfoMaster(HashMap<String, String> map) throws Exception {
		return update("reagentsGlass.updateReagentsGlassInfoMaster", map);
	}

	/**
	 * 시약/실험기구정보 수불 삭제
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteReceivePay(ReagentsGlassVO reagentsGlassVO) throws Exception {
		return delete("reagentsGlass.deleteReceivePay", reagentsGlassVO);
	}

	/**
	 * 구매요청 목록 삭제
	 * 
	 * @param BuyingRequestVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteBuyingRequestList(ReagentsGlassVO vo) throws Exception {
		return delete("reagentsGlass.deleteBuyingRequestList", vo);
	}

	/**
	 * 구매요청 목록 등록
	 * 
	 * @param BuyingRequestVO
	 * @return int
	 * @exception Exception
	 */
	public int insertBuyingRequestList(HashMap<String, String> map) throws Exception {
		return insert("reagentsGlass.insertBuyingRequestList", map);
	}

	/**
	 * 구매요청 목록 삭제
	 * 
	 * @param BuyingRequestVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteBuyingRequestList(HashMap<String, String> map) throws Exception {
		return delete("reagentsGlass.deleteBuyingRequestList", map);
	}

	/**
	 * 구매요청 목록 수정
	 * 
	 * @param BuyingRequestVO
	 * @return int
	 * @exception Exception
	 */
	public int updateBuyingRequestList(HashMap<String, String> map) throws Exception {
		return update("reagentsGlass.updateBuyingRequestList", map);
	}

	/**
	 * 시약/실험기구정보 팝업 목록 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> popReagentsGlassInfoList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.popReagentsGlassInfoList", vo);
	}

	/**
	 * 시약/실험기구정보 수불 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> selectReagentsGlassInOutList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.selectReagentsGlassInOutList", vo);
	}

	/**
	 * 시약/실험기구정보 수불 디테일 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> selectReagentsGlassInOutDetail(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.selectReagentsGlassInOutDetail", vo);
	}
	
	/**
	 * 시약/실험기구정보 수불 업데이트
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	public int updateReagentsGlassInOutDetail(HashMap<String, String> m) throws Exception {
		return update("reagentsGlass.updateReagentsGlassInOutDetail", m);
	}

	/**
	 * 시약/실험기구정보 수불 저장 처리(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int insertReagentsGlassInOut(ReagentsGlassVO vo) throws Exception {
		return insert("reagentsGlass.insertReagentsGlassInOut", vo);
	}

	/**
	 * 시약/실험기구정보 수불 수정 처리(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	public int updateReagentsGlassInOut(ReagentsGlassVO vo) throws Exception {
		return insert("reagentsGlass.updateReagentsGlassInOut", vo);
	}

	/**
	 * 시약/실험기구정보 수불(결재) 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> receivePayPaymentList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.receivePayPaymentList", vo);
	}

	/**
	 * 시약/실험기구정보 수불(결재) 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updateReceivePayPayment(HashMap<String, String> map) {
		return update("reagentsGlass.updateReceivePayPayment", map);
	}

	/**
	 * 시약/실험기구정보 수불현황 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectReagentsGlassStateList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.selectReagentsGlassStateList", vo);
	}

	/**
	 * 구매품목현황 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> buyingProductStateList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.buyingProductStateList", vo);
	}

	/**
	 * 시약/실험기구 팝업 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public String insertPopReagentsGlassInfo(ReagentsGlassVO vo) throws Exception {
		selectOne("reagentsGlass.insertPopReagentsGlassInfo", vo);
		return vo.getMtlr_no();
	}

	/**
	 * 시약/실험기구 팝업 수정 처리
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updatePopReagentsGlassInfo(ReagentsGlassVO vo) {
		return update("reagentsGlass.updateReagentsGlassInfo", vo); //updatePopReagentsGlassInfo
	}

	/**
	 * 구매검수 등록 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> selectBuyingConfirmList(ReagentsGlassVO vo) throws Exception {
		return selectList("reagentsGlass.selectBuyingConfirmList", vo);
	}

	/**
	 * 구매확정에 진행상태 수정(-> 검수완료)
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int updateStateBuyingConfirm(HashMap<String, String> map) throws Exception {
		return update("reagentsGlass.updateStateBuyingConfirm", map);
	}
	
	/**
	 * MSDS 등록이미지 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public ReagentsGlassVO reagentsGlassImage(ReagentsGlassVO vo) {
		return (ReagentsGlassVO) selectOne("reagentsGlass.reagentsGlassImage", vo);
	}
	
	/**
	 * MSDS 등록이미지 다운로드
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public ReagentsGlassVO reagentsGlassImageDown(ReagentsGlassVO vo) throws Exception {
		return (ReagentsGlassVO) selectOne("reagentsGlass.reagentsGlassImageDown", vo);
	}	
}
