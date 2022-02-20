package iit.lims.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.system.dao.DeptOthersDAO;
import iit.lims.system.service.DeptOthersService;
import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class DeptOthersServiceImpl extends EgovAbstractServiceImpl implements DeptOthersService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "deptOthersDAO")
	private DeptOthersDAO deptOthersDAO;

	public List<DeptVO> selectDeptOthersList(DeptVO deptVO) throws Exception {
		return deptOthersDAO.selectDeptOthersList(deptVO);
	}

	public List<DeptVO> selectDeptOthersUserList(DeptVO deptVO) throws Exception {
		return deptOthersDAO.selectDeptOthersUserList(deptVO);
	}

	public int saveDeptOthers(DeptVO vo) throws Exception {
		try {
			if (vo != null && !"".equals(vo.getDept_cd())) {
				deptOthersDAO.updateDeptOthers(vo);
			} else {
				deptOthersDAO.insertDeptOthers(vo);
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public int saveDeptOthersUser(UserVO vo) throws Exception {
		try {
			deptOthersDAO.saveDeptOthersUser(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

}