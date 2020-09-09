package iit.lims.accept.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.dao.CounselDAO;
import iit.lims.accept.service.CounselService;
import iit.lims.accept.vo.CounselVO;
import iit.lims.instrument.vo.MachineVO;
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
public class CounselServiceImpl extends EgovAbstractServiceImpl implements CounselService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "counselDAO")
	private CounselDAO counselDAO;
	
	/**
	 * 통합상담 목록 조회
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public List<CounselVO> selectCounselTotalList(CounselVO counselVO) throws Exception {	
		return counselDAO.selectCounselTotalList(counselVO);
	}
	
	/**
	 * 개별상담 목록 조회
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public List<CounselVO> selectCounselPersonalList(CounselVO counselVO) throws Exception {	
		return counselDAO.selectCounselPersonalList(counselVO);
	}
	
	/**
	 * 통합상담 등록 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int insertCounselTotal(CounselVO counselVO) throws Exception {
		try {
			return counselDAO.insertCounselTotal(counselVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 개별상담 등록 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int insertCounselPersonal(CounselVO counselVO) throws Exception {
		try {			
			return counselDAO.insertCounselPersonal(counselVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
		
	/**
	 * 통합상담 상세 데이터 조회
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public CounselVO selectCounselTotalDetail(CounselVO counselVO) {
		try {
			return counselDAO.selectCounselTotalDetail(counselVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 개별상담 상세 데이터 조회
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public CounselVO selectCounselPersonalDetail(CounselVO counselVO) {
		try {
			return counselDAO.selectCounselPersonalDetail(counselVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 통합상담 수정 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int updateCounselTotal(CounselVO counselVO) throws Exception {
		try {			
			return counselDAO.updateCounselTotal(counselVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 개별상담 수정 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int updateCounselPersonal(CounselVO counselVO) throws Exception {
		try {			
			return counselDAO.updateCounselPersonal(counselVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 통합상담 삭제 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int deleteCounselTotal(CounselVO counselVO) throws Exception {
		try {
			String[] total_no_arr = counselVO.getTotal_no().split(",", -1);
			if (total_no_arr.length > 0) {
				for (String total_no_seq : total_no_arr) {
					counselVO.setTotal_no(total_no_seq);
					counselDAO.deleteCounselTotal(counselVO);
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 개별상담 삭제 처리
	 * 
	 * @param CounselVO
	 * @throws Exception
	 */
	public int deleteCounselPersonal(CounselVO counselVO) throws Exception {
		try {			
			
			String[] total_no_arr = counselVO.getTotal_no().split(",", -1);
			String[] personal_no_arr = counselVO.getPersonal_no().split(",", -1);
			if (total_no_arr.length > 0) {
				for (String total_no_seq : total_no_arr) {
					counselVO.setTotal_no(total_no_seq);
					for(String personal_no_seq : personal_no_arr){
						counselVO.setPersonal_no(personal_no_seq);
						counselDAO.deleteCounselPersonal(counselVO);
					}					
				}
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
