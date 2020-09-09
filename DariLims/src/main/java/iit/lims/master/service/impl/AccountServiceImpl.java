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
import iit.lims.master.service.AccountService;
import iit.lims.master.vo.AccountVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.util.JsonView;

/**
 * AccountServiceImpl
 * 
 * @author 최은향
 * @since 2015.09.18
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.09.18  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class AccountServiceImpl extends EgovAbstractServiceImpl implements AccountService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "accountDAO")
	private AccountDAO accountDAO;

	/**
	 * 계산식관리 목록 조회
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public List<AccountVO> selectAccountList(AccountVO vo) throws Exception {
		return accountDAO.selectAccountList(vo);
	}

	
	/**
	 * 계산식관리 상세정보
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public AccountVO selectAccountDetail(AccountVO vo) throws Exception {
		return accountDAO.selectAccountDetail(vo);
	}
	/**
	 * 계산식관리 상세리스트
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public List<AccountVO> selectAccountDetailList(AccountVO vo) throws Exception {
		return accountDAO.selectAccountDetailList(vo);
	}
	/**
	 * 계산식적용 리스트
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public List<AccountVO> selectAccountApplyList(AccountVO vo) throws Exception {
		return accountDAO.selectAccountApplyList(vo);
	}
	
	/**
	 * 계산식적용 리스트
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public String checkAccount(AccountVO vo) throws Exception {
		return accountDAO.checkAccount(vo);
	}
	
	/**
	 * 계산식관리 저장 처리
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public int insertAccount(AccountVO vo) throws Exception {
		try {
			return accountDAO.insertAccount(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 계산식관리 수정 처리
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public int updateAccount(AccountVO vo) throws Exception {
		try {
			return accountDAO.updateAccount(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 계산식관리 삭제 처리
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public int deleteAccount(AccountVO vo) throws Exception {
		try {
			return accountDAO.deleteAccount(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	

	/**
	 * 계산식관리 삭제 처리
	 * 
	 * @param AccountVO
	 * @throws Exception
	 */
	@Override
	public int deleteAccountDetail(AccountVO vo) throws Exception {
		try {
			return accountDAO.deleteAccountDetail(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 세부계산식저장 
	 * 
	 * @param AccountVO
	 * @return int
	 * @exception Exception
	 */
	public int saveAccountDetail(AccountVO vo) throws Exception {
		try {
			
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						String crud = map.get("crud");
						if (crud != "" && crud != null) {
							map.put("user_id", vo.getCreater_id());
							if ("c".equals(crud)) {
								accountDAO.insertAccountDetail(map);
							}else if("u".equals(crud)) {
								accountDAO.updateAccountDetail(map);
							}else if("d".equals(crud)) {
								accountDAO.deleteAccountDetail(map);
							}
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
	 * 세부계산식적용값저장 
	 * 
	 * @param AccountVO
	 * @return int
	 * @exception Exception
	 */
	public int saveAccountApply(AccountVO vo) throws Exception {
		try {
			
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						String crud = map.get("crud");
						if (crud != "" && crud != null) {
							map.put("user_id", vo.getCreater_id());
							if ("c".equals(crud)) {
								accountDAO.insertAccountApply(map);
							}else if("u".equals(crud)) {
								accountDAO.updateAccountApply(map);
							}else if("d".equals(crud)) {
								accountDAO.deleteAccountApply(map);
							}
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

	@Override
	public List<TestItemVO> selectMasterList(TestItemVO param) throws Exception {
		return accountDAO.selectMasterList(param);
	}

}