package iit.lims.analysis.service;

import java.util.List;

import iit.lims.analysis.vo.ReqStartStopVO;
import iit.lims.analysis.vo.ResultInputVO;

public interface ReqStartStopService {
	
	public int updateStopStart(ReqStartStopVO vo) throws Exception;

}
