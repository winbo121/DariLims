package iit.lims.master.service.impl;


import iit.lims.master.dao.SampleGradeDAO;
import iit.lims.master.service.SampleGradeService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.master.vo.SampleGradeVO;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;


@Service
public class SampleGradeServiceImpl  implements SampleGradeService {

	static final Logger log = LogManager.getLogger();
	
	@Resource(name = "sampleGradeDAO")
	private SampleGradeDAO sampleGradeDAO;
	
	/**
	 * 시험기준별 시험항목 목록 조회
	 * 
	 * @param testPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<HashMap<String, Object>> selectSampleGradeList(HashMap<String, Object> param) throws Exception {
		return sampleGradeDAO.selectSampleGradeList(param);
	}
	
	@Override
	public List<SampleGradeVO> selectSampleGradePList(SampleGradeVO vo) throws Exception {
		return sampleGradeDAO.selectSampleGradePList(vo);
	}
	
	/*
	 * 항목 등급 등록
	 */
	public int insertGrade(SampleGradeVO vo) throws Exception {
		int result = 0;
		
		try {
			
			if(vo.getGrade_seq() == ""){ // key 값이 없을경우 insert 
				result = sampleGradeDAO.insertGrade(vo);
			
			} else { //update
				
				result = sampleGradeDAO.updateGrade(vo); 
				System.out.println(">>>> 업데이트: " + result);
			}
			System.out.println(">>>> result: " + result);
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/*
	 * 항목 등급 삭제 deleteGrade
	 */
	public int deleteGrade(SampleGradeVO vo) throws Exception {
		int result = 0;
		
		try {
			result = sampleGradeDAO.deleteGrade(vo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int deleteSampleGradeTestItem(SampleGradeVO vo) throws Exception {
		int result = 0;
		
		try {
			result = sampleGradeDAO.deleteSampleGradeTestItem(vo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateGradeItem(SampleGradeVO vo) throws Exception {
		int result = 0;
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
						
						String crud = map.get("crud");
						
						if ("u".equals(crud)){
							result = sampleGradeDAO.updateGradeItem(map);
						}
					}
				}
			}
			
			return result;
		
/*			//품목 최대 등급 저장
			HashMap<String, Object> paramSample = new HashMap<String, Object>();
			paramSample.put("prdlstCd", param.get("prdlstCd").toString());
			paramSample.put("maxGrade", param.get("maxGrade").toString());
			
			sampleGradeDAO.updateSampleMaxGrde(paramSample);
			
			
			ArrayList<HashMap<String,String>> arrayList = ConverterUtils.jsonToArrayList(param.get("gridData").toString());
			
			//항목 등급정보 저장
			ObjectMapper mapper = new ObjectMapper();
			for(int i=0; i<arrayList.size(); i++){
				String jsonString = mapper.writeValueAsString(arrayList.get(i));
				HashMap<String, Object> jsonMap = ConverterUtils.jsonToJsonParam(jsonString);
				sampleGradeDAO.updateGradeItem(jsonMap);
			}*/
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	@Override
	public int insertGradeItem(SampleGradeVO vo) throws Exception {
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
						map.put("user_id", vo.getUser_id());
						sampleGradeDAO.insertGradeItem(map);
					}
				}
			}
			return 1;

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	@Override
	public int updateSampleMaxGrde(PrdLstVO vo) throws Exception {
		int result = 0;
		try {
			result = sampleGradeDAO.updateSampleMaxGrde(vo);
			return result;
		
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	@Override
	public int copyGradeItem(SampleGradeVO vo) throws Exception {
		int result = 0;
		try {
			result = sampleGradeDAO.copyGradeItem(vo);
			return result;
		
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	@Override
	public List<SampleGradeVO> selectSampleGradeListPop(SampleGradeVO vo) throws Exception {
		return sampleGradeDAO.selectSampleGradeListPop(vo);
	}
}
