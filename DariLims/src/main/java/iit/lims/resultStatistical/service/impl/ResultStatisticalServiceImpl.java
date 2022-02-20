package iit.lims.resultStatistical.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.resultStatistical.vo.ResultStatisticalVO;
import iit.lims.resultStatistical.dao.ResultStatisticalDAO;
import iit.lims.resultStatistical.service.ResultStatisticalService;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.CommonCodeVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ResultStatisticalServiceImpl
 * @author 
 * @since 2015.03.13
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.13           최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ResultStatisticalServiceImpl extends EgovAbstractServiceImpl implements ResultStatisticalService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "resultStatisticalDAO")
	private ResultStatisticalDAO resultStatisticalDAO;
	
	/**
	 * 시약/실험기구 목록 조회 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> statisticalReports(ResultStatisticalVO resultStatisticalVO) throws Exception {
		return resultStatisticalDAO.statisticalReports(resultStatisticalVO);
	}

	/**
	 * 시험결과검색 목록 조회
	 * 
	 * @param SynclVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectTestReultList(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectTestReultList(vo);
	}

	/**
	 * 단위업무 공통코드 조회
	 * 
	 * @param CommonCodeVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<CommonCodeVO> selectCommonCodeUnitWork(CommonCodeVO vo) throws Exception {
		return resultStatisticalDAO.selectCommonCodeUnitWork(vo);
	}

	/**
	 * 시료정보조회 목록 조회
	 * 
	 * @param SynclVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectTestSampleStateList(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectTestSampleStateList(vo);
	}
	
	/**
	 * 시험결과검색(이전) 목록 조회
	 * 
	 * @param SynclVO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectTestReultBList(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectTestReultBList(vo);
	}

	/**
	 * 시험결과검색(이전) 단위업무 팝업 페이지 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectUnitWorkList(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectUnitWorkList(vo);
	}

	/**
	 * 시험결과검색(이전) 검체 팝업 페이지 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectSampleChoiceList(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectSampleChoiceList(vo);
	}

	/**
	 * 시험결과검색(이전) 시험항목 팝업 페이지 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectTestItemSearchList(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectTestItemSearchList(vo);
	}

	/**
	 * 과별단위업무실적 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectDeptUnitWorkPerfList(ResultStatisticalVO vo) throws Exception {		
		try {
			//월별, 분기별 조회
			if(vo.getType().equals("month"))
				return resultStatisticalDAO.selectDeptUnitWorkPerfMList(vo);
			else
				return resultStatisticalDAO.selectDeptUnitWorkPerfQList(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 과별단위업무실적 시료구분콤보 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@Override
	public List<ResultStatisticalVO> selectSampleCombo(ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectSampleCombo(vo);
	}
	
	/**
	 * 시험결과검색 페이징
	 * 
	 * @param SynclVO
	 * @throws Exception
	 */
	@Override
	public int selectTestReultListTotCnt (ResultStatisticalVO vo) throws Exception {
		return resultStatisticalDAO.selectTestReultListTotCnt(vo);
	}


}