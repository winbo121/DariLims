package iit.lims.accept.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.InstRentDAO;
import iit.lims.accept.service.InstRentService;
import iit.lims.accept.vo.InstRentVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * MachineServiceImpl
 * 
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class InstRentServiceImpl extends EgovAbstractServiceImpl implements InstRentService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "instRentDAO")
	private InstRentDAO instRentDAO;
	
	/**
	 * 장비대여 업체목록 조회
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRentList(InstRentVO instRentVO) throws Exception {	
		return instRentDAO.selectInstRentList(instRentVO);
	}	
	
	/**
	 * 장비대여 업체 등록처리
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public int insertInstRentOrg(InstRentVO instRentVO) throws Exception {
		return instRentDAO.insertInstRentOrg(instRentVO);
	}
	
	/**
	 * 장비대여 업체 수정처리
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public int updateInstRentOrg(InstRentVO instRentVO) throws Exception {
		return instRentDAO.updateInstRentOrg(instRentVO);
	}
	
	/**
	 * 장비대여 업체 삭제 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int deleteInstRent(InstRentVO instRentVO) throws Exception {
		return instRentDAO.deleteInstRent(instRentVO);
	}
	
	/**
	 * 장비대여 업체 상세조회
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public InstRentVO selectInstRentDetail(InstRentVO instRentVO) throws Exception {		
		return instRentDAO.selectInstRentDetail(instRentVO);
	}
	
	/**
	 * 장비대여 장비목록 조회
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRentDetailList(InstRentVO instRentVO) throws Exception {
		return instRentDAO.selectInstRentDetailList(instRentVO);
	}
	
	/**
	 * 장비대여 장비 저장 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int saveInstRent_inst(InstRentVO instRentVO) throws Exception {
		try {
			
			String[] rowArr = instRentVO.getGridData().split("◆★◆");
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
						String crud = map.get("crud");
						if (crud != "" && crud != null) {
							map.put("user_id", instRentVO.getCreater_id());
							if ("c".equals(crud)) {
								instRentDAO.insertInstRent_inst(map);
							}else if("u".equals(crud)) {
								instRentDAO.updateInstRent_inst(map);
							}
							else if("d".equals(crud)) {
								instRentDAO.deleteInstRent_inst(map);
							}
						}
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
	 * 장비대여 사용결과 시료 저장
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int saveInstRent_sample(InstRentVO instRentVO) throws Exception {
		try {
			
			String[] rowArr = instRentVO.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					//System.out.println(row);
					if (columnArr != null && columnArr.length > 0) {						
						HashMap<String, String> map = new HashMap<String, String>();
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
						if(instRentVO.getGridData() != ""){
							String crud = map.get("crud");
							map.put("instRent_rent_no", instRentVO.getInstRent_rent_no());
							if (crud != "" && crud != null) {								
								if ("c".equals(crud)) {
									instRentDAO.insertInstRent_sample(map);
								}else if("u".equals(crud)) {
									instRentDAO.updateInstRent_sample(map);
								}
							}							
						}						
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
	 * 장비대여 사용결과 시료목록 조회
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRent_sampleList(InstRentVO instRentVO) throws Exception {
		return instRentDAO.selectInstRent_sampleList(instRentVO);
	}
	
	/**
	 * 장비대여 사용결과 항목 등록
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int insertInstRent_item(InstRentVO instRentVO) throws Exception {
		try {
			
			String[] rowArr = instRentVO.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				instRentDAO.deleteInstRent_item_all(instRentVO);
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
						if(instRentVO.getGridData() != ""){
							map.put("instRent_sample_no", instRentVO.getInstRent_sample_no());
							instRentDAO.insertInstRent_item(map);
						}						
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
	 * 장비대여 사용결과 항목 조회
	 * 
	 * @param InstRentVO
	 * @throws Exception
	 */
	public List<InstRentVO> selectInstRent_itemList(InstRentVO instRentVO) throws Exception {
		return instRentDAO.selectInstRent_itemList(instRentVO);
	}
	
	/**
	 * 장비대여 사용결과 시료 삭제 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int deleteInstRent_sample(InstRentVO instRentVO) throws Exception {
		try {
			instRentDAO.deleteInstRent_sample(instRentVO);
			instRentDAO.deleteInstRent_item_all(instRentVO);
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 장비대여 사용결과 항목 삭제 처리
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int deleteInstRent_item(InstRentVO instRentVO) throws Exception {
		try {
			String[] sample_no_arr = instRentVO.getInstRent_sample_no().split(",", -1);
			String[] item_cd_arr = instRentVO.getTest_item_cd().split(",", -1);
			if (sample_no_arr.length > 0) {
				for (String sample_no_seq : sample_no_arr) {
					instRentVO.setInstRent_sample_no(sample_no_seq);
					for(String item_cd_seq : item_cd_arr){
						instRentVO.setTest_item_cd(item_cd_seq);
						instRentDAO.deleteInstRent_item(instRentVO);
					}					
				}
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 장비대여 사용결과 항목 비고 추가
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public int saveSampleEtc(InstRentVO instRentVO) throws Exception {
		try {
				instRentDAO.saveSampleEtc(instRentVO);
				
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 장비대여 사용결과 항목 비고 조회
	 * 
	 * @param instRentVO
	 * @throws Exception
	 */
	public InstRentVO selectSampleEtc(InstRentVO instRentVO) throws Exception {
		return instRentDAO.selectSampleEtc(instRentVO);
	}
}
