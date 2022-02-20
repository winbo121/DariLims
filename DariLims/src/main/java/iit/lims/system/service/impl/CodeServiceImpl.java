package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.CodeDAO;
import iit.lims.system.service.CodeService;
import iit.lims.system.vo.CodeVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * CodeServiceImpl
 * @author 정우용
 * @since 2015.01.24
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.24  정우용   최초 생성
 * </pre>
 *
 * Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class CodeServiceImpl extends EgovAbstractServiceImpl implements CodeService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "codeDAO")
	private CodeDAO codeDAO;
	
	/**
	 * 코드그룹 목록 조회 
	 * @param CodeVO
	 * @throws Exception
	 */
	public List<CodeVO> selectCodeGroupList(CodeVO codeVO) throws Exception {
        return codeDAO.selectCodeGroupList(codeVO);
    }
	
	/**
	 * 코드그룹 저장/수정 처리 
	 * @param CodeVO
	 * @throws Exception
	 */
	public int saveCodeGroup(CodeVO codeVO) throws Exception {
		int result = -1;
		try {
			if(codeVO.getPageType().equals("insert")){
				result = codeDAO.insertCodeGroup(codeVO);
			}else{
				result = codeDAO.updateCodeGroup(codeVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 코드상세 목록 조회 
	 * @param CodeVO
	 * @throws Exception
	 */
	public List<CodeVO> selectCodeDetailList(CodeVO codeVO) throws Exception {
        return codeDAO.selectCodeDetailList(codeVO);
    }
	
	/**
	 * 코드상세 저장/수정 처리 
	 * @param CodeVO
	 * @throws Exception
	 */
	public int saveCodeDetail(CodeVO codeVO) throws Exception {
		int result = -1;
		try {
			if(codeVO.getPageType().equals("insert")){
				result = codeDAO.insertCodeDetail(codeVO);
			}else{
				result = codeDAO.updateCodeDetail(codeVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
}
