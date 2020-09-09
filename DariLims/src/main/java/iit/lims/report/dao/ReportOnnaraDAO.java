package iit.lims.report.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.report.vo.ReportVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ReportOnnaraDAO
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ReportOnnaraDAO extends EgovAbstractMapper {

	public List<ReportVO> selectReportOnnaraList(ReportVO vo) throws Exception {
		return selectList("reportOnnara.selectReportOnnaraList", vo);
	}

	public int updateReportOnnara(ReportVO vo) throws Exception {
		return update("reportOnnara.updateReportOnnara", vo);
	}

}
