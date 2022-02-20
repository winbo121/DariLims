package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class DeptOthersDAO extends EgovAbstractMapper {

	public List<DeptVO> selectDeptOthersList(DeptVO vo) throws Exception {
		return selectList("system.selectDeptOthersList", vo);
	}

	public List<DeptVO> selectDeptOthersUserList(DeptVO vo) throws Exception {
		return selectList("system.selectDeptOthersUserList", vo);
	}

	public void insertDeptOthers(DeptVO vo) throws Exception {
		insert("system.insertDeptOthers", vo);
	}

	public void updateDeptOthers(DeptVO vo) throws Exception {
		update("system.updateDeptOthers", vo);
	}

	public void saveDeptOthersUser(UserVO vo) throws Exception {
		update("system.saveDeptOthersUser", vo);
	}
}
