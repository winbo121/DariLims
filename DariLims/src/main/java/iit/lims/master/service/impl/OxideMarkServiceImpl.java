package iit.lims.master.service.impl;

import iit.lims.master.dao.OxideMarkDAO;
import iit.lims.master.service.OxideMarkService;
import iit.lims.master.vo.OxideMarkVO;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * oxideMarkServiceImpl
 * 
 * @author 한지연
 * @since 2020.01.14
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 * 2020.01.14  한지연   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2020 by interfaceIT., All right reserved.
 */

@Service
public class OxideMarkServiceImpl extends EgovAbstractServiceImpl implements OxideMarkService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "oxideMarkDAO")
	private OxideMarkDAO OxideMarkDAO;

	/**
	 * 산화물표기 목록 조회
	 * 
	 * @param OxideMarkVO
	 * @throws Exception
	 */
	@Override
	public List<OxideMarkVO> selectOxideMarkList(OxideMarkVO vo) throws Exception {
		return OxideMarkDAO.selectOxideMarkList(vo);
	}

	/**
	 * 산화물표기 상세정보 조회 / 신규페이지 열기
	 * 
	 * @param OxideMarkVO
	 * @throws Exception
	 */
	@Override
	public OxideMarkVO selectOxideMarkListDetail(OxideMarkVO vo) throws Exception {
		try {
			if (vo.getPageType().equals("detail")) {
				return OxideMarkDAO.selectOxideMarkListDetail(vo);
			} else {
				return new OxideMarkVO();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 산화물표기 신규등록
	 * 
	 * @param OxideMarkVO
	 * @throws Exception
	 */
	@Override
	public int insertOxideMark(OxideMarkVO vo) throws Exception {
		try {
			return OxideMarkDAO.insertOxideMark(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 산화물표기 수정
	 * 
	 * @param OxideMarkVO
	 * @throws Exception
	 */
	@Override
	public int updateOxideMark(OxideMarkVO vo) throws Exception {
		try {
			return OxideMarkDAO.updateOxideMark(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}