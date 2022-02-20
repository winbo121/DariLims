package iit.lims.resultStatistical.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.resultStatistical.vo.ResultStatisticalVO;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.CommonCodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ResultStatisticalDAO
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


@Repository
public class ResultStatisticalDAO extends EgovAbstractMapper {	
	
	/**
	 * 통계보고서 목록 조회
	 *
	 * @param SynclVO
	 * @return List
	 * @exception Exception	 
	 */
	public List<ResultStatisticalVO> statisticalReports(ResultStatisticalVO resultStatisticalVO) {
		return selectList("resultStatistical.statisticalReports", resultStatisticalVO);
	}

	/**
	 * 시험결과검색 목록 조회
	 * 
	 * @param SynclVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectTestReultList(ResultStatisticalVO vo) throws Exception {
		return  selectList("resultStatistical.selectTestReultList", vo);
	}

	/**
	 * 단위업무 공통코드 조회
	 * 
	 * @param CommonCodeVO
	 * @return List
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeUnitWork(CommonCodeVO vo) throws Exception {
		return selectList("resultStatistical.selectCommonCodeUnitWork", vo);
	}

	/**
	 * 시료정보조회 목록 조회
	 * 
	 * @param SynclVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectTestSampleStateList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectTestSampleStateList", vo);
	}

	/**
	 * 시험결과검색(이전) 목록 조회
	 * 
	 * @param SynclVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectTestReultBList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectTestReultBList", vo);
	}

	/**
	 * 시험결과검색(이전) 단위업무 팝업 페이지 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectUnitWorkList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectUnitWorkList", vo);
	}

	/**
	 * 시험결과검색(이전) 검체 팝업 페이지 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectSampleChoiceList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectSampleChoiceList", vo);
	}

	/**
	 * 시험결과검색(이전) 시험항목 팝업 페이지 목록 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectTestItemSearchList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectTestItemSearchList", vo);
	}

	/**
	 * 과별단위업무실적 목록 조회(월별)
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectDeptUnitWorkPerfMList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectDeptUnitWorkPerfMList", vo);
	}
	
	/**
	 * 과별단위업무실적 목록 조회(분기별)
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectDeptUnitWorkPerfQList(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectDeptUnitWorkPerfQList", vo);
	}

	/**
	 * 과별단위업무실적 시료구분콤보 목록 조회
	 * 
	 * @param HttpServletRequest, Model, ResultStatisticalVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ResultStatisticalVO> selectSampleCombo(ResultStatisticalVO vo) throws Exception {
		return selectList("resultStatistical.selectSampleCombo", vo);
	}
	
	/**
	 * 시험결과검색 페이징 번호 조회
	 * 
	 * @param SynclVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int selectTestReultListTotCnt(ResultStatisticalVO vo) {
		return (Integer) selectOne("resultStatistical.selectTestReultListTotCnt", vo);
	}
	
}
