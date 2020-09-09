package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.UserVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class UserAuthDAO extends EgovAbstractMapper {

	public List<UserVO> selectCmmnUserList(UserVO userVO) throws Exception {
        return selectList("system.selectCmmnUserList", userVO);
    }
	
	public List<UserVO> selectAuthUserList(UserVO userVO) throws Exception {
        return selectList("system.selectAuthUserList", userVO);
    }
	
	public int insertAuthUser(UserVO userVO) throws Exception {
		insert("system.insertAuthUser", userVO);
		return 1;
	}
	
	public int deleteAuthUser(UserVO userVO) throws Exception {
		return delete("system.deleteAuthUser", userVO);
	}
}
