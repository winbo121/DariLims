package iit.lims.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.ReqOrgDAO;
import iit.lims.master.service.ReqOrgService;
import iit.lims.master.vo.ReqOrgVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * ReqOrgServiceImpl
 * 
 * @author 석은주
 * @since 2015.01.23
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.23  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ReqOrgServiceImpl extends EgovAbstractServiceImpl implements ReqOrgService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "reqOrgDAO")
	private ReqOrgDAO reqOrgDAO;

	/**
	 * 의뢰처관리 목록 조회
	 * 
	 * @param ReqOrgVO
	 * @throws Exception
	 */
	@Override
	public List<ReqOrgVO> selectReqOrgList(ReqOrgVO vo) throws Exception {
		return reqOrgDAO.selectReqOrgList(vo);
	}

	/**
	 * 의뢰처관리 상세정보 조회 /추가 화면 디테일 열기
	 * 
	 * @param ReqOrgVO
	 * @throws Exception
	 */
	@Override
	public ReqOrgVO selectReqOrgDetail(ReqOrgVO vo) throws Exception {
		try {
			if (vo.getPageType().equals("detail")) {
				return reqOrgDAO.selectReqOrgDetail(vo);
			} else {
				return new ReqOrgVO();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 의뢰처관리 저장 처리
	 * 
	 * @param ReqOrgVO
	 * @throws Exception
	 */
	@Override
	public int insertReqOrg(ReqOrgVO vo) throws Exception {
		try {
			if (vo.getBiz_file() != null && vo.getBiz_file().getSize() > 0) {
				vo.setBiz_file_byte(vo.getBiz_file().getBytes());
				vo.setFile_nm(vo.getBiz_file().getOriginalFilename());
			}
			return reqOrgDAO.insertReqOrg(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 의뢰처관리 수정 처리
	 * 
	 * @param ReqOrgVO
	 * @throws Exception
	 */
	@Override
	public int updateReqOrg(ReqOrgVO vo) throws Exception {
		try {
			return reqOrgDAO.updateReqOrg(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 의뢰처관리 삭제 처리
	 * 
	 * @param ReqOrgVO
	 * @throws Exception
	 */
	@Override
	public int deleteReqOrg(ReqOrgVO vo) throws Exception {
		try {
			return reqOrgDAO.deleteReqOrg(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int copyReqOrg(ReqOrgVO vo) throws Exception {
	
		try {
			return reqOrgDAO.copyReqOrg(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}