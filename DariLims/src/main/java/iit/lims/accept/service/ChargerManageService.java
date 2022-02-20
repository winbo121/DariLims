package iit.lims.accept.service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;

import java.util.List;

public interface ChargerManageService {

	/**
	 * 시험담당자변경 접수목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectChargerManageReqList(ResultInputVO vo) throws Exception;
	
	/**
	 * 시험담당자변경 시료 정보 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public AcceptVO selectChargerManageSampleDetail(AcceptVO vo) throws Exception;
	
	/**
	 * 시험담당자변경 항목 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @throws Exception
	 */
	public List<AcceptVO> selectChargerManageItemList(AcceptVO vo) throws Exception;
}
