package iit.lims.system.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.system.vo.UserVO;

@Repository
public class UserDAO extends EgovAbstractMapper {

	public List<UserVO> selectUserCmmnList(UserVO userVO) throws Exception {
        return selectList("system.selectUserCmmnList", userVO);
    }
	
	public List<UserVO> selectUserLimsList(UserVO userVO) throws Exception {
        return selectList("system.selectUserLimsList", userVO);
    }
	
	public int saveUserLims(UserVO userVO) throws Exception {
		return update("system.saveUserLims", userVO);
	}
	
	public List<UserVO> selectUserList(UserVO vo) {
		return selectList("system.selectUserList", vo);
	}
	
	public int updateUserFlag(UserVO vo) throws Exception {
		return update("system.updateUserFlag", vo);
	}
	
	public int insertUser(HashMap<String, String> map) throws Exception {
		insert("system.insertUser", map);
		return 1;
	}
	
	public int updateUser(HashMap<String, String> map) throws Exception {
		return update("system.updateUser", map);
	}
	
	public UserVO selectUserLimsDetail(UserVO userVO) throws Exception {
        return selectOne("system.selectUserLimsDetail", userVO);
        
    }

	public int insertUserInfo(UserVO userVO) throws Exception{
		return insert("system.insertUserInfo", userVO);
	}

	public int updateUserInfo(UserVO userVO) throws Exception{
		return update("system.updateUserInfo", userVO);
	}
	
	public int putSignFile(UserVO userVO) throws Exception {
		return update("system.putSignFile", userVO);
	}
	
	public int deleteSignFile(UserVO userVO) throws Exception {
		return delete("system.deleteSignFile", userVO);
	}
	
}
