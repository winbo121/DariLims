package iit.lims.master.service;

import java.util.HashMap;
import java.util.List;

import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;


/**
 * MailGroupService
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

public interface MailGroupService {

	List<HashMap<String, Object>> selectListMailGroup(HashMap<String, Object> param);

	List<HashMap<String, Object>> selectListMailAddress(HashMap<String, Object> param);

	int saveMailGroup(HashMap<String, Object> param);

	int saveMailAddress(HashMap<String, Object> param);

	int deleteMailGroup(HashMap<String, Object> param);

	int deleteMailAddress(HashMap<String, Object> param);

}
