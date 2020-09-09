package iit.lims.kolas.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.kolas.dao.KolasDocDAO;
import iit.lims.kolas.service.KolasDocService;
import iit.lims.kolas.vo.KolasDocVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestMethodServiceImpl
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class KolasDocServiceImpl extends EgovAbstractServiceImpl implements KolasDocService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "kolasDocDAO")
	private KolasDocDAO kolasDocDAO;

	/**
	 * KOLAS 문서 등록 목록 조회 
	 * @param KolasDocVO
	 * @throws Exception
	 */
	@Override
	public List<KolasDocVO> selectKolasDocList(KolasDocVO vo) throws Exception {
		return kolasDocDAO.selectKolasDocList(vo);
	}

	/**
	 * 시험방법 상세정보 조회 / 신규페이지 열기
	 * @param TestMethodVO
	 * @throws Exception
	 */
	@Override
	public KolasDocVO selectKolasDocDetail(KolasDocVO vo) throws Exception {
		try {
			if(vo.getPageType().equals("detail")) {
				return kolasDocDAO.selectKolasDocDetail(vo);
			} else {
				return new KolasDocVO();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}
	
	/**
	 * 문서등록 신규등록
	 * @param KolasDocVO
	 * @throws Exception
	 */
	@Override
	public int insertKolasDoc(KolasDocVO vo) throws Exception {
		try {
			String kolasDocNo = kolasDocDAO.getNewKolasDocNo();
			vo.setKolas_doc_no(kolasDocNo);			
			int result = kolasDocDAO.insertKolasDoc(vo);
			
			if (vo.getKolas_file() != null && vo.getKolas_file().getSize() > 0) {
				vo.setAtt_file(vo.getKolas_file().getBytes());
				vo.setAdd_file_nm(vo.getKolas_file().getOriginalFilename());
				kolasDocDAO.insertKolasAddFile(vo);
			} else {
				if(vo.getAdd_file_nm() != null && !vo.getAdd_file_nm().equals("")) 
					kolasDocDAO.insertKolasAddFile(vo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 문서등록 수정
	 * @param KolasDocVO
	 * @throws Exception
	 */
	@Override
	public int updateKolasDoc(KolasDocVO vo) throws Exception {
		try {			
			if (vo.getKolas_file() != null && vo.getKolas_file().getSize() > 0) {
				vo.setAtt_file(vo.getKolas_file().getBytes());
				vo.setAdd_file_nm(vo.getKolas_file().getOriginalFilename());
				
				//해당되는 no에 저장된 첨부파일이 있었는지 확인
				int count = (int) kolasDocDAO.selectKolasAddFile(vo);
				if(count > 0) 				
					kolasDocDAO.updateKolasAddFile(vo);
				else 
					kolasDocDAO.insertKolasAddFile(vo);					
			} else {	
				//해당되는 no에 저장된 첨부파일이 있었는지 확인
				int count = (int) kolasDocDAO.selectKolasAddFile(vo);
				
				if(vo.getFile_nm() != null && !vo.getFile_nm().equals("")) {					
					if(count > 0) {	
						/*if(vo.getAdd_file_nm() == null || vo.getAdd_file_nm().equals(""))
							vo.setPageType("emptyFile");*/
						kolasDocDAO.updateKolasAddFile(vo);
					} else 
						kolasDocDAO.insertKolasAddFile(vo);
				} else {
					if(vo.getAdd_file_nm() != null && !vo.getAdd_file_nm().equals("")) 
						kolasDocDAO.updateKolasAddFile(vo);						
					else
						kolasDocDAO.deleteKolasAddFile(vo);
				}
			}
			int result = kolasDocDAO.updateKolasDoc(vo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 문서등록, 첨부파일 삭제 
	 * @param KolasDocVO
	 * @throws Exception
	 */
/*	@Override
	public int deleteKolasDoc(KolasDocVO vo) throws Exception {
		try {
			//해당되는 no에 저장된 첨부파일이 있었는지 확인
			int count = (int) kolasDocDAO.selectKolasAddFile(vo);
			if(count > 0)
					kolasDocDAO.deleteKolasAddFile(vo);
			return kolasDocDAO.deleteKolasDoc(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}*/

	/**
	 * 문서등록 첨부파일 다운로드 
	 * @param KolasDocVO
	 * @throws Exception
	 */
	@Override
	public KolasDocVO kolasDocDown(KolasDocVO vo) throws Exception {
		try {
			return kolasDocDAO.kolasDocDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
}