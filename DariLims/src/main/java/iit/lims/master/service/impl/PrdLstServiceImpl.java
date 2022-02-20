package iit.lims.master.service.impl;

import iit.lims.master.dao.PrdLstDAO;
import iit.lims.master.service.PrdLstService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.system.vo.CodeVO;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * PrdLstServiceImpl
 * 
 * @author 윤상준
 * @since 2015.12.18
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.12.18  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class PrdLstServiceImpl extends EgovAbstractServiceImpl implements PrdLstService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "prdLstDAO")
	private PrdLstDAO prdLstDAO;

	/**
	 * 품목 조회
	 * 
	 * @param PrdLstVO
	 * @throws Exception
	 */
	@Override
	public List<PrdLstVO> selectPrdLstList(PrdLstVO prdLstVO) throws Exception {
		return prdLstDAO.selectPrdLstList(prdLstVO);
	}

	/**
	 * 품목 상세 조회
	 * 
	 * @param PrdLstVO
	 * @throws Exception
	 */
	@Override
	public PrdLstVO selectPrdLstListDetail(PrdLstVO vo) throws Exception {
		return prdLstDAO.selectPrdLstListDetail(vo);
	}

	
	/**
	 * 품목관리 저장 처리
	 * 
	 * @param PrdLstVO
	 * @throws Exception
	 */
	@Override
	public int insertPrdlst(PrdLstVO vo) throws Exception {
		try {
			return prdLstDAO.insertPrdlst(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 품목관리 수정 처리
	 * 
	 * @param PrdLstVO
	 * @throws Exception
	 */
	@Override
	public int updatePrdlst(PrdLstVO vo) throws Exception {
		try {
			return prdLstDAO.updatePrdlst(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}