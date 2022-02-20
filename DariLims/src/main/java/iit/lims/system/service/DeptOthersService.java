package iit.lims.system.service;

import java.util.List;

import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserVO;

public interface DeptOthersService {

	public List<DeptVO> selectDeptOthersList(DeptVO deptVO) throws Exception;

	public List<DeptVO> selectDeptOthersUserList(DeptVO deptVO) throws Exception;

	public int saveDeptOthers(DeptVO deptVO) throws Exception;

	public int saveDeptOthersUser(UserVO deptVO) throws Exception;

}
