package iit.lims.analysis.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ResultInputReportDAO
 * 
 * @author 최은향
 * @since 2015.10.07
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.07  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ResultInputReportDAO extends EgovAbstractMapper {

	public List<ResultInputVO> sampleList(ResultInputVO vo) {
		return selectList("resultInputReport.sampleList", vo);
	}
	
	public List<ResultInputVO> selectsampleReportList(ResultInputVO vo) {
		return selectList("resultInputReport.selectsampleReportList", vo);
	}
	
}