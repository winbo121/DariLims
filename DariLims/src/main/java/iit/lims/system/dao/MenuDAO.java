package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.MenuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class MenuDAO extends EgovAbstractMapper {

	public List<MenuVO> selectMenuGroupList(MenuVO menuVO) throws Exception {
        return selectList("system.selectMenuGroupList", menuVO);
    }
	
	public int insertMenuGroup(MenuVO menuVO) throws Exception {
		insert("system.insertMenuGroup", menuVO);
		return 1; 
	}
	
	public int updateMenuGroup(MenuVO menuVO) throws Exception {
		return update("system.updateMenuGroup", menuVO);
	}
	
	public int deleteMenu(MenuVO menuVO) throws Exception {
		return delete("system.deleteMenu", menuVO);
	}
	
	public List<MenuVO> selectMenuDetailList(MenuVO menuVO) throws Exception {
        return selectList("system.selectMenuDetailList", menuVO);
    }
	
	public int insertMenuDetail(MenuVO menuVO) throws Exception {
		insert("system.insertMenuDetail", menuVO);
		return 1; 
	}
	
	public int updateMenuDetail(MenuVO menuVO) throws Exception {
		return update("system.updateMenuDetail", menuVO);
	}
}
