package iit.lims.master.service.impl;

import iit.lims.master.dao.DocumentDAO;
import iit.lims.master.service.DocumentService;
import iit.lims.master.vo.DocumentVO;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * Document
 * 
 * @author 최은향
 * @since 2015.10.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.01  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class DocumentServiceImpl extends EgovAbstractServiceImpl implements DocumentService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "documentDAO")
	private DocumentDAO documentDAO;
	
	@Autowired private ServletContext servletContext;
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	/**
	 * 양식 관리 목록 조회
	 * 
	 * @param DocumentVO
	 * @return List
	 * @throws Exception
	 */
	public List<DocumentVO> selectFormList(DocumentVO vo) throws Exception {
		return documentDAO.selectFormList(vo);
	}

	/**
	 * 양식 관리 저장 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int insertForm(DocumentVO vo) throws Exception {
		try {
			DocumentVO doc = documentDAO.selectFormNo(vo);
			vo.setForm_seq(doc.getForm_seq());
			documentDAO.insertForm(vo);
			return  1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 양식 관리 수정 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int updateForm(DocumentVO vo) throws Exception {
		try {
			 documentDAO.updateForm(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 양식 관리 삭제 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int deleteForm(DocumentVO vo) throws Exception {
		try {
			int count = (int) documentDAO.countDeleteDoc(vo);				
			if(count > 0){ 				
				//documentDAO.deleteForm(vo);
				return 0;
			} else{ 
				documentDAO.deleteForm(vo);
				return 1;
			}			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 문서 관리 목록 조회
	 * 
	 * @param DocumentVO
	 * @return List
	 * @throws Exception
	 */
	public List<DocumentVO> selectDocumentList(DocumentVO vo) throws Exception {
		return documentDAO.selectDocumentList(vo);
	}

	/**
	 * 문서 관리 상세정보 조회
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public DocumentVO documentDetail(HttpServletRequest request, DocumentVO vo) {
		try {			
			return documentDAO.documentDetail(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}


	/**
	 * 문서 관리 저장 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	@Override
	public int insertDocument(DocumentVO vo) throws Exception {
		try {
			String no = documentDAO.selectDocumentNo(vo);
			
			vo.setDoc_revision_seq(no);	
			vo.setDoc_seq(vo.getForm_seq() +"-"+ no);
			
			int result = documentDAO.insertDocument(vo);
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 문서 관리 수정 처리
	 * @param DocumentVO
	 * @throws Exception
	 */
	@Override
	public int updateDocument(DocumentVO vo) throws Exception {
		FileOutputStream fos =null;
		try {			
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {
				
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
				// 해당되는 no에 저장된 첨부파일이 있었는지 확인
				int count = (int) documentDAO.countFormDocFile(vo);				
				if(count > 0){ 				
					documentDAO.updateFormDocFile(vo);
				}else{ 
					documentDAO.insertFormDocFile(vo);
				}
				String reportPath = propertyService.getString("excelReport.path")+"/"+vo.getDoc_seq();
				/*String contextpath = servletContext.getRealPath(reportPath);*/
				log.debug(reportPath);
				File fileDir = new File(reportPath);
				
				if(!fileDir.exists()){
					fileDir.mkdirs();
					log.debug("MKDIR : "+ reportPath);
				}
				
				log.debug("file path : "+reportPath+"/"+vo.getMul_file_att().getOriginalFilename());
				File file = new File(reportPath+"/"+vo.getMul_file_att().getOriginalFilename());
				fos = new FileOutputStream(file);
				fos.write(vo.getMul_file_att().getBytes());
				log.debug("FileOutputStream WRITE : "+ file.getPath());
			} else {				
				// 해당되는 no에 저장된 첨부파일이 있었는지 확인
				int count = (int) documentDAO.countFormDocFile(vo);				
				if(vo.getFile_nm() != null && !vo.getFile_nm().equals("")) {					
					if(count > 0) {	
						documentDAO.updateFormDocFile(vo);
					} else 
						documentDAO.insertFormDocFile(vo);
				}
			}
			
			
			int result = documentDAO.updateDocument(vo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally{
			if(fos != null)fos.close();
		}
	}

	/**
	 * 문서 관리 삭제 처리
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public int deleteDocument(DocumentVO vo) throws Exception {
		try {
			 documentDAO.deleteDocument(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	
	
	/**
	 * 문서등록 첨부파일 다운로드 
	 * @param DocumentVO
	 * @throws Exception
	 */
	@Override
	public DocumentVO formDocDown(DocumentVO vo) throws Exception {
		try {
			return documentDAO.formDocDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * 다음 양식번호 조회
	 * 
	 * @param DocumentVO
	 * @throws Exception
	 */
	public DocumentVO selectFormNo(DocumentVO vo) {
		try {
			return documentDAO.selectFormNo(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
}
