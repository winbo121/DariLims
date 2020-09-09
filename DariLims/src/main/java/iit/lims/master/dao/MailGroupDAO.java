package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.util.JsonView;

/**
 * MailGroupDAO
 * @author zestysong
 * @since 2020.01.06
 * @version 1.0
 * @see
 *
 * <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2020.01.06  zestysong   최초 생성
 * </pre>
 *
 * Copyright (C) 2020 by interfaceIT., All right reserved.
 */

@Repository
public class MailGroupDAO extends EgovAbstractMapper {

	public List<HashMap<String, Object>> selectListMailGroup(HashMap<String, Object> param) {
		return selectList("mailgroup.selectListMailGroup", param);
	}

	public List<HashMap<String, Object>> selectListMailAddress(HashMap<String, Object> param) {
		return selectList("mailgroup.selectListMailAddress", param);
	}

	public int saveMailGroup(HashMap<String, Object> param) {
		return update("mailgroup.saveMailGroup", param);
	}

	public int saveMailAddress(HashMap<String, Object> param) {
		return update("mailgroup.saveMailAddress", param);
	}

	public int deleteMailGroup(HashMap<String, Object> param) {
		return delete("mailgroup.deleteMailGroup", param);
	}

	public int deleteMailAddress(HashMap<String, Object> param) {
		return delete("mailgroup.deleteMailAddress", param);
	}

}
