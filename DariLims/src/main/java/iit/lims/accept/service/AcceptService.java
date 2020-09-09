package iit.lims.accept.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;

/**
 * MenuService
 * 
 * @author 진영민
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.13  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
public interface AcceptService {
	/**
	 * 접수 > 의뢰 상세 조회
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @exception Exception
	 */
	public AcceptVO selectAcceptDetail(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 의뢰 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectAcceptList(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 시료 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectAcceptSampleList(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 항목 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectAcceptItemList(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 의뢰 삽입
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public AcceptVO insertAccept(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 의뢰 수정
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public AcceptVO updateAccept(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 시료 리스트 멀티 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveSampleGrid(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 항목 리스트 멀티 삭제
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteItemGrid(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 항목 리스트 항목수수료 라디오 조회
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int selectCommissionGrid(AcceptVO vo) throws Exception;
	

	/**
	 * 접수 > 항목 리스트 멀티 추가
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertItemGrid(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 항목 리스트 멀티 수정(수수료 수정)
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateItemFeeGrid(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 항목 시험자 수정
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateItemGrid(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 의뢰처 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReqOrgVO> selectReqOrgList(ReqOrgVO vo) throws Exception;

	/**
	 * 접수 > 항목/시료 갯수 조회
	 * 
	 * @param AcceptVO
	 * @return HashMap
	 * @exception Exception
	 */
	public HashMap<String, Integer> itemCalculate(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 수수료 조회
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public AcceptVO selectFeeTotal(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 접수 처리
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<String> updateAcceptState(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 반려 처리
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int returnAcceptState(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 템플릿 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectTempleteSampleList(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 템플릿에 속한 항목 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectTempleteItemList(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 템플릿 삽입
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public String insertTemplete(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 템플릿 수정
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateTemplete(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 템플릿 에 속한 항목 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveTemplete(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 항목 추가 팝업 > 항목 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectPopAllTestItemList(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 항목 추가 팝업 > 기준&품목별 항목 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectPopStdTestItemList(AcceptVO vo) throws Exception;

	/**
	 * 접수 삭제
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteAccept(AcceptVO vo) throws Exception;

	/**
	 * 접수 복사
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public String copyAccept(AcceptVO vo) throws Exception;

	/**
	 * 접수 재시험
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public String retestAccept(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 팀 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> teamListPop(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 사업자등록팝업 사업자등록증파일 다운로드
	 *
	 * @param AcceptVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public AcceptVO bizFileDown(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 견적항목 리스트 멀티 추가
	 *
	 * @param AcceptVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public int insertEstimateItem(AcceptVO vo)throws Exception;
	
	/**
	 * 접수 > 장비대여 항목 리스트 멀티 추가
	 *
	 * @param AcceptVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public int insertInstRentItem(AcceptVO vo)throws Exception;
	
	/**
	 * 접수 > 검사기준관리(&수수료) 항목 리스트 멀티 추가
	 *
	 * @param AcceptVO
	 * @return TestMethodVO
	 * @exception Exception	 
	 */
	public int insertTestStdPrdItem(AcceptVO vo)throws Exception;
	
	
	/**
	 * 시료별 문서 목록 조회
	 *
	 * @param AcceptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AcceptVO> selectSampleFileList(AcceptVO vo) throws Exception;
	
	/**
	 * 항목별 문서 목록 조회
	 *
	 * @param AcceptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AcceptVO> selectSampleItemFileList(AcceptVO vo) throws Exception;
	
	/**
	 * 의뢰별 문서 목록 조회
	 *
	 * @param AcceptVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<AcceptVO> selectRequestFileList(AcceptVO vo) throws Exception;
	
	
	/**
	 * 접수 > 시료별 첨부파일 조회
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */	
	public AcceptVO sampleFilePop(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 시료별 첨부파일 등록 처리
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public int insertSampleFile(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 시료별 첨부파일 수정 처리
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public int updateSampleFile(AcceptVO vo) throws Exception;
	
	
	/**
	 * 접수 > 시료별 첨부파일 삭제 처리
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteSampleFile(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 시료별 첨부파일 다운로드
	 *
	 * @param AcceptVO
	 * @return AcceptVO
	 * @exception Exception	 
	 */
	public AcceptVO sampleFileDown(AcceptVO vo) throws Exception;
	
	
	/**
	 * 접수 > 항목별 첨부파일 조회
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */	
	public AcceptVO itemFilePop(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 항목별 첨부파일 등록 처리
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public int insertItemFile(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 항목별 첨부파일 수정 처리
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public int updateItemFile(AcceptVO vo) throws Exception;
	
	
	/**
	 * 접수 > 항목별 첨부파일 삭제 처리
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteItemFile(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 항목별 첨부파일 다운로드
	 *
	 * @param AcceptVO
	 * @return AcceptVO
	 * @exception Exception	 
	 */
	public AcceptVO itemFileDown(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 의뢰별 첨부파일 조회
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */	
	public AcceptVO requestFilePop(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 의뢰별 첨부파일 등록 처리
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public int insertRequestFile(AcceptVO vo) throws Exception;

	/**
	 * 접수 > 의뢰별 첨부파일 수정 처리
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public int updateRequestFile(AcceptVO vo) throws Exception;
	
	
	/**
	 * 접수 > 의뢰별 첨부파일 삭제 처리
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteRequestFile(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 의뢰별 첨부파일 다운로드
	 *
	 * @param AcceptVO
	 * @return AcceptVO
	 * @exception Exception	 
	 */
	public AcceptVO requestFileDown(AcceptVO vo) throws Exception;
	
	
	/**
	 * 접수 > 식약처기준 품목별 항목 리스트 조회 팝업
	 * 
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<TestPrdStdVO> selectPopAllMfdsStdItemList(TestPrdStdVO vo) throws Exception;
	
	/**
	 * 접수 > 자가기준 품목별 항목 리스트 조회 팝업
	 * 
	 * @param TestPrdStdVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectPopAllSelfStdItemList(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 항목 수수료 마스터 등록
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveItemMasterFee(AcceptVO vo)throws Exception;


	public AcceptVO selectFeeValue(AcceptVO vo) throws Exception;
	public CommissionCheckVO selectOrgUnpaid(CommissionCheckVO vo) throws Exception;
	
	//public AcceptVO smstest(AcceptVO vo) throws Exception;
	public List<AcceptVO> labelPrint(AcceptVO vo);	
	
	public List<AcceptVO> getCollectCodeList(AcceptVO vo);
	
	
	
	//팝업 스탠다드 추가
	public int insertStdPLItem(TestStandardVO vo) throws Exception;
	
	public int updateStdItemGrid(AcceptVO vo) throws Exception;

	public Object selectPopAllSelfGradeItemList(AcceptVO vo);
	
	/**
	 * 접수 > 전처리비용 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int savePretreatment(AcceptVO vo)throws Exception;

	public int insertGradeItemGrid(AcceptVO vo) throws Exception;

	//검체별 첨부 문서 업데이트
	public int updateFileDivision(AcceptVO vo) throws Exception;

	public int mailSend(HashMap<String, Object> param, HttpServletRequest request);
	
	public int reportMailSend(HashMap<String, Object> param, MultipartHttpServletRequest request) throws Exception;
	
	//성적서 항목 순서 수정
	public int updateOrder(AcceptVO vo) throws Exception;

	public int insertStdItemGrid(AcceptVO vo) throws Exception;
	
	public int insertGrdItemGrid(AcceptVO vo) throws Exception;
	
	/**
	 * 접수 > 비고 수정
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public int updateReqSampleMessage(AcceptVO vo) throws Exception;
	
	//성적서 표시순서 팝업 > 조회
	public List<AcceptVO> selectReportOrder(AcceptVO vo) throws Exception;
	
	/**
	 * 성적서 발행완료 후 접수 복사
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public String copyPieceAccept(AcceptVO vo) throws Exception;
}
