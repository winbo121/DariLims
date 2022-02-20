package iit.lims.report.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.report.dao.PaperWriteDAO;
import iit.lims.report.service.PaperWriteService;
import iit.lims.report.vo.PaperVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * PaperWriteServiceImpl
 * 
 * @author 진영민
 * @since 2015.03.10
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.03.10  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class PaperWriteServiceImpl extends EgovAbstractServiceImpl implements PaperWriteService {
	static final Logger log = LogManager.getLogger();
	@Resource(name = "paperWriteDAO")
	private PaperWriteDAO paperWriteDAO;

	public List<PaperVO> selectPaperList(PaperVO vo) throws Exception {
		return paperWriteDAO.selectPaperList(vo);
	}

	public PaperVO selectPaperDetail(PaperVO vo) throws Exception {
		return paperWriteDAO.selectPaperDetail(vo);
	}

	public String savePaperDetail(PaperVO vo) throws Exception {
		try {
			if (vo.getQreport_no() != null && !"".equals(vo.getQreport_no())) {
				paperWriteDAO.updatePaperDetail(vo);
				return vo.getQreport_no();
			} else {
				String qreport_no = paperWriteDAO.selectPaperNo();
				vo.setQreport_no(qreport_no);
				paperWriteDAO.insertPaperDetail(vo);
				return qreport_no;
			}

		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public int deletePaperDetail(PaperVO vo) throws Exception {
		try {
			paperWriteDAO.deletePaperDetail(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

}