package iit.lims.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import iit.lims.master.dao.PretreatmentDAO;
import iit.lims.master.dao.SampleGradeDAO;
import iit.lims.master.service.PretreatmentService;
import iit.lims.master.vo.PretreatmentVO;
import iit.lims.master.vo.SampleGradeVO;
import iit.lims.master.vo.TestPrdStdVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class PretreatmentServiceImpl implements PretreatmentService {

	static final Logger log = LogManager.getLogger();
	
	@Resource(name = "pretreatmentDAO")
	private PretreatmentDAO pretreatmentDAO;
	
	/**
	 * 품목별 전처리비용 목록 조회
	 * 
	 * @param testPrdStdVO
	 * @throws Exception
	 */
	@Override
	public List<TestPrdStdVO> selectPretMList(PretreatmentVO vo) throws Exception {
		System.out.println("@@@"+vo.getPrdlst_cd());
		return pretreatmentDAO.selectPretMList(vo);
	}
	
	/*
	 * 전처리비용 등록
	 */
	public int insertPretreatment(PretreatmentVO vo) throws Exception {
		int result = 0;
		
		try {
			
			if(vo.getPretreatment_cd() == ""){ // key 값이 없을경우 insert 
				System.out.println("등록");
				result = pretreatmentDAO.insertPretreatment(vo);
			
			} else { //update
				
				result = pretreatmentDAO.updatePretreatment(vo); 
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
	public int deletePretreatment(PretreatmentVO vo) throws Exception {
		int result = 0;
		
		try {
			result = pretreatmentDAO.deletePretreatment(vo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
