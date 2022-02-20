package iit.lims.accept.service.impl;

import iit.lims.accept.dao.EstimateDAO;
import iit.lims.accept.service.EstimateService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.EstimateVO;
import iit.lims.analysis.vo.TestReportVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.service.CommonService;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.system.dao.AuditTrailDAO;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * AstimateServiceImpl
 * 
 * @author 윤상준
 * @since 2015.09.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.10  윤상준   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class EstimateServiceImpl extends EgovAbstractServiceImpl implements EstimateService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "estimateDAO")
	private EstimateDAO estimateDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;


	@Resource
	private CommonService commonService;

	@Resource
	private CommonDAO commonDAO;
	
	
	
	/**
	 * 견적관리> 견적 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateList(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateList(estimateVO);
	}
	
	/**
	 * 견적관리> 견적 상세 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public EstimateVO selectEstimateDetail(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateDetail(estimateVO);
	}
	
	/**
	 * 견적관리> 견적 항목리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemList(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateItemList(estimateVO);
	}
	
	
	/**
	 * 견적관리> 견적 항목수수료리스트 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemFeeList(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateItemFeeList(estimateVO);
	}
	
	/**
	 * 견적 등록
	 * @param estimateVO
	 * @throws Exception
	 */
	public int insertEstimate(EstimateVO estimateVO) throws Exception {
		try {
			return estimateDAO.insertEstimate(estimateVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 견적 상태업데이트
	 * @param estimateVO
	 * @throws Exception
	 */
	public int updateEstimateState(String est_no) throws Exception {
		try {
			return estimateDAO.updateEstimateState(est_no);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 견적정보 수정
	 * @param estimateVO
	 * @throws Exception
	 */
	public int updateEstimate(EstimateVO estimateVO) throws Exception {
		try {
			return estimateDAO.updateEstimate(estimateVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 견적정보 삭제
	 * @param estimateVO
	 * @throws Exception
	 */
	public int deleteEstimate(EstimateVO estimateVO) throws Exception {
		try {
			return estimateDAO.deleteEstimate(estimateVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 접수 > 견적항목 리스트 멀티 추가
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertInstGrid(MachineVO vo) throws Exception {
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("est_no", vo.getTest_sample_seq());
			map.put("user_id", vo.getUser_id());
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					for (String column : columnArr) {
						String[] valueArr = column.split("●★●");
						//System.out.println(column);
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
						}
					}
					estimateDAO.insertInstGrid(map);
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	
	/**
	 * 접수 > 견적항목 리스트 멀티 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveEstimateItem(EstimateVO vo) throws Exception {
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
								if(valueArr[0].equals("est_no")){
									vo.setEst_no(value);
								}
							}
						}
						String crud = map.get("crud");
						if (crud != "" && crud != null) {
							map.put("user_id", vo.getCreater_id());
							if ("c".equals(crud)) {
								
							}else if("u".equals(crud)) {
								estimateDAO.updateEstimateItem(map);
							}else if("d".equals(crud)) {
								estimateDAO.deleteEstimateItem(map);
							}
						}
					}
				}				
				estimateDAO.updateEstFeeTot(vo);				
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 접수 > 견적항목 리스트 멀티 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveEstimateItemFee(EstimateVO vo) throws Exception {
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
								if(valueArr[0].equals("est_no")){
									vo.setEst_no(value);
								}
							}
						}
						String crud = map.get("crud");
						if (crud != "" && crud != null) {
							map.put("user_id", vo.getCreater_id());
							if ("c".equals(crud)) {
								estimateDAO.insertEstimateItemFee(map);
							}else if("u".equals(crud)) {
								estimateDAO.updateEstimateItemFee(map);
							}else if("d".equals(crud)) {
								estimateDAO.deleteEstimateItemFee(map);
							}
						}
					}
				}
				estimateDAO.updateEstFeeTot(vo);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 견적관리> 견적서 템플릿
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateTemplateList(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateTemplateList(estimateVO);
	}
	
	/**
	 * 견적관리> 견적서별 항목 템플릿
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemTemplateList(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateItemTemplateList(estimateVO);
	}
	
	/**
	 * 견적관리> 견적서별 항목 수수료 템플릿
	 * 
	 * @param EstimateVO
	 * @return List
	 * @exception Exception
	 */
	public List<EstimateVO> selectEstimateItemFeeTemplateList(EstimateVO estimateVO) throws Exception {
		return estimateDAO.selectEstimateItemFeeTemplateList(estimateVO);
	}
	
	/**
	 * 견적서별 템플릿 등록
	 * 
	 * @param EstimateVO
	 * @throws Exception
	 */
	public int insertEstimateTemplate(EstimateVO vo) throws Exception {
		try {
			return estimateDAO.insertEstimateTemplate(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 견적서별 템플릿 견적서로 등록
	 * 
	 * @param EstimateVO
	 * @throws Exception
	 */
	public int insertSelectEstimateTemplate(EstimateVO vo) throws Exception {
		try {
			return estimateDAO.insertSelectEstimateTemplate(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 접수 > 항목 리스트 멀티 추가 ( 시험 일지에도 추가 )
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertEstimateItemGrid(EstimateVO vo) throws Exception {
		try {
			TestReportVO tvo = new TestReportVO();
			HashMap<String, String> map = new HashMap<String, String>();			
			map.put("user_id", vo.getUser_id());
			
			// 변수선언 
			String tmp_est_no = vo.getEst_no();
			String tmp_est_item_no = vo.getEst_item_no();
			
			// 견적번호 셋팅
			map.put("est_no", tmp_est_no);
			map.put("est_item_no", tmp_est_item_no);
			
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					for (String column : columnArr) {
						String[] valueArr = column.split("●★●");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
							
							if(valueArr[0].equals("test_item_cd")){
								if(value != null && value != ""){
									tvo.setTest_item_cd(value);
								}
							}
	
						}
					}
					estimateDAO.insertEstimateItemGrid(map);
				}
				
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	@Override
	public int copyEstimate(EstimateVO vo) throws Exception {
		
		return estimateDAO.copyEstimate(vo);
	}

	



	

}
