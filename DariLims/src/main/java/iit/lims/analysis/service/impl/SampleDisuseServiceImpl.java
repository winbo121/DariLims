package iit.lims.analysis.service.impl;

import iit.lims.analysis.dao.SampleDisuseDAO;
import iit.lims.analysis.service.SampleDisuseService;
import iit.lims.analysis.vo.ResultInputVO;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SampleDisuse
 * 
 * @author 정우용
 * @since 2015.03.05
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.05  정우용   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class SampleDisuseServiceImpl extends EgovAbstractServiceImpl implements SampleDisuseService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "sampleDisuseDAO")
	private SampleDisuseDAO sampleDisuseDAO;

	/**
	 * 시료페기 목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectSampleDisuseList(ResultInputVO vo) throws Exception {
		return sampleDisuseDAO.selectSampleDisuseList(vo);
	}

	/**
	 * 시료폐기 상세정보 조회
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public ResultInputVO sampleDisuseDetail(HttpServletRequest request, ResultInputVO vo) {
		try {			
			//System.out.println(vo.getTest_sample_seq());
			return sampleDisuseDAO.sampleDisuseDetail(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 시료폐기 저장 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int updateSampleDisuse(ResultInputVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("user_id", vo.getUser_id());
						sampleDisuseDAO.updateSampleDisuse(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시료폐기 삭제 처리
	 * 
	 * @param ResultInputVO
	 * @throws Exception
	 */
	public int deleteSampleDisuse(ResultInputVO vo) throws Exception {
		try {
			 sampleDisuseDAO.deleteSampleDisuse(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
