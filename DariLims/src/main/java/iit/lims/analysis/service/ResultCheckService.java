package iit.lims.analysis.service;

import java.util.List;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;

/**
 * ResultCheckService
 * 
 * @author 윤상준
 * @since 2015.02.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.17  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

public interface ResultCheckService {
	/**
	 * 기본결재라인 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public ResultInputVO selectApprLineDefaultList(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 (시료유형) 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectCheckReqList(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 시료판정값 수정
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public int updateResultCheck(ResultInputVO vo) throws Exception;

	/**
	 * 결과확인 결과 확인 완료 처리
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public int completeResultCheck(ResultInputVO vo) throws Exception;

	/**
	 * 결과확인 상신 회수
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public int cancelResultCheck(ResultInputVO vo) throws Exception;

	/**
	 * 결재라인 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultInputVO> selectApprLineList(ResultInputVO vo) throws Exception;

	/**
	 * 결재라인 등록
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public int insertApprLine(ResultInputVO vo) throws Exception;

	/**
	 * 결재라인 수정
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public int updateApprLine(ResultInputVO vo) throws Exception;


	public int updateApprDefault(ResultInputVO vo) throws Exception;
	

	public int deleteApprLine(ResultInputVO vo) throws Exception;
	
	
	/**
	 * 전체사용자 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultInputVO> selectCmmnUserList(ResultInputVO vo) throws Exception;

	/**
	 * 결재라인 사용자 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultInputVO> selectApprLineUserList(ResultInputVO vo) throws Exception;

	/**
	 * 결재라인 사용자 저장 처리
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public int saveApprovalUser(ResultInputVO vo) throws Exception;
	
	/**
	 * 시험 확인 > 시료판정 값 수정
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public int updateSampleJdg(ResultInputVO vo) throws Exception;
	
	/**
	 * 시험 확인, 승인 > 항목별 결과값 수정 목록
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @exception Exception
	 */
	public List<ResultInputVO> selectItemResultHistory(ResultInputVO vo)throws Exception;

}
