package iit.lims.system.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.AuthVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class AuthDAO extends EgovAbstractMapper {

	public List<AuthVO> selectAuthGroupList(AuthVO authVO) throws Exception {
        return selectList("system.selectAuthGroupList", authVO);
    }
	
	public int insertAuthGroup(AuthVO authVO) throws Exception {
		insert("system.insertAuthGroup", authVO);
		return 1;
	}
	
	public int updateAuthGroup(AuthVO authVO) throws Exception {
		return delete("system.updateAuthGroup", authVO);
	}

	public int delAuthGroup(AuthVO authVO) {
		return delete("system.delAuthGroup", authVO);
	}
	
	public List<AuthVO> selectCmmnMenuList(AuthVO authVO) throws Exception {
        return selectList("system.selectCmmnMenuList", authVO);
    }
	
	public List<AuthVO> selectAuthMenuList(AuthVO authVO) throws Exception {
        return selectList("system.selectAuthMenuList", authVO);
    }
	
	public int insertAuthMenu(AuthVO authVO) throws Exception {
		insert("system.insertAuthMenu", authVO);
		return 1;
	}
	
	public int deleteAuthMenu(AuthVO authVO) throws Exception {
		return delete("system.deleteAuthMenu", authVO);
	}
	
	public int saveAuthMenu(HashMap<String, String> m) throws Exception {
		return delete("system.saveAuthMenu", m);
	}
}
