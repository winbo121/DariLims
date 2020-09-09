package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class DeptDAO extends EgovAbstractMapper {

	public List<DeptVO> selectDeptCmmnList(DeptVO deptVO) throws Exception {
        return selectList("system.selectDeptCmmnList", deptVO);
    }
	
	public List<DeptVO> selectDeptLimsList(DeptVO deptVO) throws Exception {
        return selectList("system.selectDeptLimsList", deptVO);
    }
	
	public int saveDeptLims(DeptVO deptVO) throws Exception {
		return update("system.saveDeptLims", deptVO);
	}
	
	public int updateDeptLims(DeptVO deptVO) throws Exception {
		return update("system.updateDeptLims", deptVO);
	}
	
	public DeptVO selectDeptLimsDetail(DeptVO deptVO) throws Exception {
        return selectOne("system.selectDeptLimsDetail", deptVO);
    }
	
	public int insertDeptInfo(DeptVO deptVO) throws Exception{
		return insert("system.insertDeptInfo", deptVO);
	}

	public int updateDeptInfo(DeptVO deptVO) throws Exception{
		return update("system.updateDeptInfo", deptVO);
	}
	
	public List<DeptVO> selectDeptTeamList(DeptVO deptVO) throws Exception {
        return selectList("system.selectDeptTeamList", deptVO);
    }
	
	public List<DeptVO> selectDeptTeamUserList(DeptVO deptVO) throws Exception {
        return selectList("system.selectDeptTeamUserList", deptVO);
    }
	
	public DeptVO selectDeptTeamDetail(DeptVO deptVO) throws Exception {
        return selectOne("system.selectDeptTeamDetail", deptVO);
    }
	
	public int insertDeptTeam(DeptVO deptVO) throws Exception{
		return insert("system.insertDeptTeam", deptVO);
	}

	public int updateDeptTeam(DeptVO deptVO) throws Exception{
		return update("system.updateDeptTeam", deptVO);
	}

	public int deleteDeptTeam(DeptVO deptVO) throws Exception{
		return update("system.deleteDeptTeam", deptVO);
	}
	
	public int selectDeptTeamUserChk(DeptVO deptVO) throws Exception {
        return selectOne("system.selectDeptTeamUserChk", deptVO);
    }
	
	public int insertDeptTeamUser(DeptVO deptVO) throws Exception{
		return insert("system.insertDeptTeamUser", deptVO);
	}
    
    public int deleteDeptTeamUser(DeptVO deptVO) throws Exception{
		return update("system.deleteDeptTeamUser", deptVO);
	}
}
