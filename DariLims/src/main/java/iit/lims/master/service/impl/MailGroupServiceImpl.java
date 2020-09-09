package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import iit.lims.master.dao.AccountDAO;
import iit.lims.master.dao.MailGroupDAO;
import iit.lims.master.service.AccountService;
import iit.lims.master.service.MailGroupService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.util.JsonView;

/**
 * MailGroupServiceImpl
 * 
 * @author zestysong
 * @since 2020.01.06
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.01.06  zestysong  최초 생성
 * </pre>
 * 
 *      Copyright (C) 2020 by interfaceIT., All right reserved.
 */

@Service
public class MailGroupServiceImpl extends EgovAbstractServiceImpl implements MailGroupService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "mailGroupDAO")
	private MailGroupDAO mailGroupDAO;

	@Override
	public List<HashMap<String, Object>> selectListMailGroup(HashMap<String, Object> param) {
		return mailGroupDAO.selectListMailGroup(param);
	}

	@Override
	public List<HashMap<String, Object>> selectListMailAddress(HashMap<String, Object> param) {
		return mailGroupDAO.selectListMailAddress(param);
	}

	@Override
	public int saveMailGroup(HashMap<String, Object> param) {
		return mailGroupDAO.saveMailGroup(param);
	}

	@Override
	public int saveMailAddress(HashMap<String, Object> param) {
		return mailGroupDAO.saveMailAddress(param);
	}

	@Override
	public int deleteMailGroup(HashMap<String, Object> param) {
		return mailGroupDAO.deleteMailGroup(param);
	}

	@Override
	public int deleteMailAddress(HashMap<String, Object> param) {
		return mailGroupDAO.deleteMailAddress(param);
	}
}