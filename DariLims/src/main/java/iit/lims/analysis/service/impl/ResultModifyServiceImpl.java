package iit.lims.analysis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.analysis.dao.ResultModifyDAO;
import iit.lims.analysis.service.ResultModifyService;
import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MenuService
 * 
 * @author 조재환
 * @since 2015.01.14
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.14  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ResultModifyServiceImpl extends EgovAbstractServiceImpl implements ResultModifyService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultModifyDAO")
	private ResultModifyDAO resultModifyDAO;

	/**
	 * 결과입력 (시료유형) 시료유형 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectModifyReqList(ResultInputVO vo) throws Exception {
		return resultModifyDAO.selectModifyReqList(vo);
	}

	/**
	 * 결과입력 (시료유형) 시험항목 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectModifyResultList(ResultInputVO vo) throws Exception {
		return resultModifyDAO.selectModifyResultList(vo);
	}

}
