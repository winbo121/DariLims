package iit.lims.resultStatistical.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.common.vo.MakeGridVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * ItemStatisticsDAO
 * 
 * @author 진영민
 * @since 2015.03.31
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.31           최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ItemStatisticsDAO extends EgovAbstractMapper {

	public List<String> selectItemStatisticsColumn(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectItemStatisticsColumn", vo);
	}

	public List<HashMap<String, String>> selectItemStatistics(MakeGridVO vo) throws Exception {
		return selectList("resultStatistical.selectItemStatistics", vo);
	}
}
