package iit.lims.analysis.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.analysis.vo.ReqStartStopVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class ReqStartStopDAO extends EgovAbstractMapper {
	
	
	public int reqStop(ReqStartStopVO vo) throws Exception {
		return update("reqStartStop.reqStop", vo);
	}

	
	public int reqStart(ReqStartStopVO vo) throws Exception {
		return update("reqStartStop.reqStart", vo);
	}

}