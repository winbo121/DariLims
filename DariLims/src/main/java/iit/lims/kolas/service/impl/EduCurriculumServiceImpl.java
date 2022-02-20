package iit.lims.kolas.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.kolas.dao.EduCurriculumDAO;
import iit.lims.kolas.service.EduCurriculumService;
import iit.lims.kolas.vo.EduAttendVO;
import iit.lims.kolas.vo.EduResultVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * EduCurriculumServiceImpl
 * @author 석은주
 * @since 2015.01.26
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.26  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class EduCurriculumServiceImpl extends EgovAbstractServiceImpl implements EduCurriculumService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "eduCurriculumDAO")
	private EduCurriculumDAO eduCurriculumDAO;

	/**
	 * 교육과정 목록 조회 
	 * @param EduResultVO
	 * @throws Exception
	 */
	@Override
	public List<EduResultVO> selectEduCurrList(EduResultVO vo) throws Exception {
		return eduCurriculumDAO.selectEduCurrList(vo);
	}

	/**
	 * 교육과정 등록 상세정보 조회 
	 * @param EduResultVO
	 * @throws Exception
	 */
	@Override
	public EduResultVO selectEduCurriculumDetail(EduResultVO vo) throws Exception {
		return eduCurriculumDAO.selectEduCurriculumDetail(vo);
	}

	/**
	 * 교육과정 등록 저장 
	 * @param EduResultVO
	 * @throws Exception
	 */
	@Override
	public int insertEduCurriculum(EduResultVO vo) throws Exception {
		try {
			String eduResultNo = eduCurriculumDAO.getNewEduResultNo();
			vo.setEdu_result_no(eduResultNo);			
			int result = eduCurriculumDAO.insertEduCurriculum(vo);
			
			if (vo.getEdu_file() != null && vo.getEdu_file().getSize() > 0) {
				vo.setAtt_file(vo.getEdu_file().getBytes());
				vo.setFile_nm(vo.getEdu_file().getOriginalFilename());
				eduCurriculumDAO.insertEduCurrDocFile(vo);
			} else {
				if(vo.getDoc_nm() != null && !vo.getDoc_nm().equals("")) 
					eduCurriculumDAO.insertEduCurrDocFile(vo);
			}			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 교육과정 등록 수정 
	 * @param EduResultVO
	 * @throws Exception
	 */
	@Override
	public int updateEduCurriculum(EduResultVO vo) throws Exception {
		try {			
			if (vo.getEdu_file() != null && vo.getEdu_file().getSize() > 0) {
				vo.setAtt_file(vo.getEdu_file().getBytes());
				vo.setFile_nm(vo.getEdu_file().getOriginalFilename());
				//해당되는 no에 저장된 첨부파일이 있었는지 확인
				int count = eduCurriculumDAO.selectEduCurrDocFile(vo);
				if(count > 0) 				
					eduCurriculumDAO.updateEduCurrDocFile(vo);
				else 
					eduCurriculumDAO.insertEduCurrDocFile(vo);				
			} else {				
				if(vo.getDoc_nm() != null && !vo.getDoc_nm().equals("")) {
					//해당되는 no에 저장된 첨부파일이 있었는지 확인		
					int count = eduCurriculumDAO.selectEduCurrDocFile(vo);
					if(count > 0)				
						eduCurriculumDAO.updateEduCurrDocFile(vo);
					else 
						eduCurriculumDAO.insertEduCurrDocFile(vo);	
				} else
					if(vo.getFile_nm() == null || vo.getFile_nm().equals(""))
						eduCurriculumDAO.deleteEduCurrDocFile(vo);
					else
						eduCurriculumDAO.updateEduCurrDocFile(vo);
			}
			int result = eduCurriculumDAO.updateEduCurriculum(vo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 교육과정 등록 삭제 
	 * @param EduResultVO
	 * @throws Exception
	 */
	@Override
	public int deleteEduCurriculum(EduResultVO vo) throws Exception {
		try {
			int result = 1;
			//해당하는 no에 교육이 끝났는지 확인
			String eduEndDt = eduCurriculumDAO.selectEduEndDt(vo);
			Date today = new Date();
			SimpleDateFormat dt = new SimpleDateFormat("yyyyMMdd");
			String tDt = dt.format(today);
			int compare = eduEndDt.compareTo(tDt);
			if(compare == 0){
				result = -1;
			}
			else{
				//해당하는 no에 참석자가 있는지 확인
				int attendCnt = eduCurriculumDAO.selectEduAttendCnt(vo);
				if(attendCnt == 0){
					//해당되는 no에 저장된 첨부파일이 있는지 확인
					int fileCnt = eduCurriculumDAO.selectEduCurrDocFile(vo);
					if(fileCnt > 0){ 				
						eduCurriculumDAO.deleteEduCurrDocFile(vo);
					}			
					eduCurriculumDAO.deleteEduCurriculum(vo);			
				}else{
					result = 0;
				}
			}			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 교육참석자 팝업 참석자 목록 조회
	 * @param EduAttendVO
	 * @throws Exception
	 */
	@Override
	public List<EduAttendVO> selectEduAttendInfoList(EduAttendVO vo) throws Exception {
		return eduCurriculumDAO.selectEduAttendInfoList(vo);
	}

	/**
	 * 교육과정 등록 첨부파일 다운로드
	 * @param EduResultVO
	 * @throws Exception
	 */
	@Override
	public EduResultVO eduCurriculumDown(EduResultVO vo) throws Exception {
		try {
			return eduCurriculumDAO.eduCurriculumDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}	
}
