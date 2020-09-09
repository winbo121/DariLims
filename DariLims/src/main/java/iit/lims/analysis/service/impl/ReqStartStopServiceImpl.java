package iit.lims.analysis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.analysis.dao.ReqStartStopDAO;
import iit.lims.analysis.service.ReqStartStopService;
import iit.lims.analysis.vo.ReqStartStopVO;
import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MenuService
 * 
 * @author 최은향
 * @since 2015.10.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.19  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ReqStartStopServiceImpl extends EgovAbstractServiceImpl implements ReqStartStopService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "reqStartStopDAO")
	private ReqStartStopDAO reqStartStopDAO;
	
	/**
	 * 요청에의한 시험 중지 및 시작
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateStopStart(ReqStartStopVO vo) throws Exception {
		try {
			if(vo.getStop_flag().equals("stop") || vo.getStop_flag().equals("ETC")){				
				return reqStartStopDAO.reqStop(vo);
			} else {			
				return reqStartStopDAO.reqStart(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
