package iit.lims.accept.service;

import java.util.List;

import iit.lims.accept.vo.SamplingVO;

public interface SamplingService {

	public List<SamplingVO> selectSamplingList(SamplingVO vo) throws Exception;
	
	public SamplingVO selectSamplingDetail(SamplingVO vo) throws Exception;
	
	public SamplingVO samplingFileDown(SamplingVO vo) throws Exception;
	
	public String insertSampling(SamplingVO vo) throws Exception;

	public int updateSampling(SamplingVO vo) throws Exception;
	
	public List<SamplingVO> selectSamplingLtList(SamplingVO vo) throws Exception;
	
	public List<SamplingVO> selectSamplingMesureList(SamplingVO vo) throws Exception;
	
	public int saveSamplingLt(SamplingVO vo) throws Exception;
	
	public int saveSamplingMesure(SamplingVO vo) throws Exception;
	
	// 채취 정보 저장시 채취로트 생성
	public int saveSplorePick(SamplingVO vo) throws Exception;
	
	// 채취 정보 저장시 채취측정 생성
	public int saveMesure(SamplingVO vo) throws Exception;
	
	//로트전체삭제
	public int deleteSamplingLt(SamplingVO vo) throws Exception;
	
	//측정전체삭제
	public int deleteSamplingMesure(SamplingVO vo) throws Exception;
}
