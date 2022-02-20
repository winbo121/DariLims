package iit.lims.resultStatistical.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.common.vo.MakeGridVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * SampleStatisticsDAO
 * 
 * @author 최은향
 * @since 2015.06.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.06.17           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class SampleStatisticsDAO extends EgovAbstractMapper {

	public List<String> selectSampleStatisticsColumn(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectSampleStatisticsColumn", vo);
	}

	public List<HashMap<String, String>> selectSampleStatistics(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectSampleStatistics", vo);
	}
}
