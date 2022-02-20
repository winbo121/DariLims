package iit.lims.analysis.service;

import java.util.List;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.vo.TestMethodVO;

public interface ResultInputSampleService {
	/**
	 * 결과입력 (시료유형) 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultReqList(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 (시료유형) 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectResultSampleList(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 결과 저장
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @throws Exception
	 */
	public String updateItemResult(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 결과 입력완료
	 * 
	 * @param ResultInputVO
	 * @return String
	 * @throws Exception
	 */
	public String completeResultInput(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 시험방법 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestMethodVO> selectTestMethodList(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 시험기기 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<MachineVO> selectTestMachineList(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 특기사항 조회
	 * 
	 * @param ResultInputVO
	 * @return String
	 * @throws Exception
	 */
	public String showReqmessage(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 자동기준일때 기준 가져오기
	 * 
	 * @param ResultInputVO
	 * @return String
	 * @throws Exception
	 */
	public ResultInputVO selectOriginalSTD(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 시료 상세 데이터 조회
	 * 
	 * @param ResultInputVO
	 * @return String
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSampleList(ResultInputVO vo) throws Exception;
	
	/**
	 * 결과입력 > 첨부파일 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */	
	public ResultInputVO reportFilePop(ResultInputVO vo) throws Exception;
	
	/**
	 * 결과입력 > 첨부파일 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int insertReportFile(ResultInputVO vo) throws Exception;

	/**
	 * 결과입력 > 첨부파일 수정 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateReportFile(ResultInputVO vo) throws Exception;
	
	
	/**
	 * 결과입력 > 첨부파일 삭제 처리
	 * 
	 * @param ResultInputVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteReportFile(ResultInputVO vo) throws Exception;
	
	/**
	 * 결과입력 > 첨부파일 다운로드
	 *
	 * @param ResultInputVO
	 * @return ResultInputVO
	 * @exception Exception	 
	 */
	public ResultInputVO reportDown(ResultInputVO vo) throws Exception;	
}
