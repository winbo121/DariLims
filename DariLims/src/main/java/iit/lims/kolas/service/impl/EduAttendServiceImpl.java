package iit.lims.kolas.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.kolas.dao.EduAttendDAO;
import iit.lims.kolas.service.EduAttendService;
import iit.lims.kolas.vo.EduAttendVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * EduAttendServiceImpl
 * @author 석은주
 * @since 2015.01.28
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.28  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class EduAttendServiceImpl extends EgovAbstractServiceImpl implements EduAttendService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "eduAttendDAO")
	private EduAttendDAO eduAttendDAO;

	/**
	 * 교육참석자 목록 조회 
	 * @param EduAttendVO
	 * @throws Exception
	 */
	@Override
	public List<EduAttendVO> selectEduAttendList(EduAttendVO vo) throws Exception {		
		try {
			List<EduAttendVO> list = new ArrayList<EduAttendVO>();
			if(vo.getPageType() != null && vo.getPageType().equals("all")) {
				list = eduAttendDAO.selectAllUserList(vo);
			} else if (vo.getPageType() == null || "".equals(vo.getPageType())) {
				list = eduAttendDAO.selectEduAttendList(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 교육참석자 상세보기/추가 화면 보기
	 * @param EduAttendVO
	 * @throws Exception
	 */
	@Override
	public EduAttendVO selectEduAttendDetail(EduAttendVO vo) throws Exception {
		try {			
			return eduAttendDAO.selectEduAttendDetail(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 교육참석자 목록 저장 
	 * @param EduAttendVO
	 * @throws Exception
	 */
	@Override
	public int insertEduAttend(EduAttendVO vo) throws Exception {
		try {
			if (vo.getGridData().equals("☆★☆★")) {
				eduAttendDAO.deleteEduAttend(vo);
			} else {
				String[] rowArr = vo.getGridData().split("◆★◆");
				if (rowArr != null && rowArr.length > 0) {
					List<HashMap<String, String>> e_arr = new ArrayList<HashMap<String, String>>();
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
							map.put("edu_result_no", vo.getEdu_result_no());
							e_arr.add(map);
						}
					}
					List<EduAttendVO> e_arr2 = eduAttendDAO.selectEduAttendList(vo);
					if(e_arr2.size() > 0) {
						for(EduAttendVO e2 : e_arr2) {
							boolean check = false;
							for(HashMap<String, String> e : e_arr) {
								if(e2.getUser_no().equals(e.get("user_no")))
									check = true;
							}
							if(!check)
								eduAttendDAO.deleteEduAttend(e2);
						}
						for(HashMap<String, String> e : e_arr) {
							boolean check = false;
							for(EduAttendVO e2 : e_arr2) {
								if(e.get("user_no").equals(e2.getUser_no()))
									check = true;
							}
							if(!check)
								eduAttendDAO.insertEduAttend(e);
							/*else {
								if(e.get("file_nm") == null || e.get("file_nm").equals("")) 
									eduAttendDAO.updateEduAttend(e);
							}*/
						}
					} else {
						for(HashMap<String, String> e : e_arr) {
							eduAttendDAO.insertEduAttend(e);
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
	 * 교육결과 팝업 첨부파일 업데이트 
	 * @param EduAttendVO
	 * @throws Exception
	 */
	@Override
	public int updateEduAttend(EduAttendVO vo) throws Exception {
		try {
			if (vo.getEdu_attend_file() != null && vo.getEdu_attend_file().getSize() > 0) {
				vo.setAtt_file(vo.getEdu_attend_file().getBytes());
				vo.setFile_nm(vo.getEdu_attend_file().getOriginalFilename());
			}
			return eduAttendDAO.updateEduAttend(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 교육결과 팝업 첨부파일 다운로드
	 * @param EduAttendVO
	 * @throws Exception
	 */
	@Override
	public EduAttendVO eduAttendFileDown(EduAttendVO vo) throws Exception {
		try {
			return eduAttendDAO.eduAttendFileDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
}
