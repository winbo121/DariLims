package iit.lims.accept.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.CommissionDAO;
import iit.lims.accept.service.CommissionService;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.service.CommonService;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.system.vo.NoticeVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.accept.vo.CounselVO;
/**
 * CommissionServiceImpl
 * 
 * @author 최은향
 * @since 2015.04.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.04.16  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class CommissionServiceImpl extends EgovAbstractServiceImpl implements CommissionService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "commissionDAO")
	private CommissionDAO commissionDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;


	@Resource
	private CommonService commonService;

	@Resource
	private CommonDAO commonDAO;

	/**
	 * 시험기준별 시험항목(및 수수료) 목록 조회
	 * 
	 * @param TestPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestPrdStdVO> stdItemCommissionList(TestPrdStdVO vo) throws Exception {
		return commissionDAO.stdItemCommissionList(vo);
	}
	
	/**
	 * 시험기준별 시험항목(및 수수료) 저장 처리
	 * 
	 * @param StdTestItemVO
	 * @throws Exception
	 */
	@Override
	public int insertStdItemCommission(TestPrdStdVO vo) throws Exception {
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
								if (valueArr.length != 1)
									value = valueArr[1];
								map.put(valueArr[0], value);
							}
						}
						map.put("test_std_no", vo.getTest_std_no());
						map.put("rev_no", vo.getRev_no());
						map.put("user_id", vo.getUser_id());
						String crud = map.get("crud");
						if (vo.getPageType().equals("testStdRev")) {
							if (!"d".equals(crud))
								commissionDAO.insertStdItemCommission(map);
						} else {
							if ("n".equals(crud))
								commissionDAO.insertStdItemCommission(map);							
							else if ("d".equals(crud))
								commissionDAO.deleteStdItemCommission(vo);			
							else if ("u".equals(crud))
								commissionDAO.updateStdItemCommission(map);
						}
					}
				}
			}
			//개정이력 table update
			commissionDAO.updateTestStdRev(vo);
			return 1;

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 수수료 프로세스 사용 여부 조회
	 * 
	 * @param accountFlag
	 * @throws Exception
	 */
	@Override
	public String commissionFlag() throws Exception {
		try {
			return commissionDAO.commissionFlag();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}
	
	/**
	 * 수수료 프로세스 사용 여부 수정
	 * 
	 * @param accountFlag
	 * @throws Exception
	 */
	public int updateCommissionFlag(TestPrdStdVO vo) throws Exception {
		try {			
			return commissionDAO.updateCommissionFlag(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 수수료 프로세스 사용 여부 삭제
	 * 
	 * @param accountFlag
	 * @throws Exception
	 */
	@Override
	public int deleteStdItemCommission(TestPrdStdVO vo) throws Exception {
		try {			
			return commissionDAO.deleteStdItemCommission(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
