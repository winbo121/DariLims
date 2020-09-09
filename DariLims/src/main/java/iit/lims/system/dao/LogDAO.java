package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.LogVO;
import iit.lims.system.vo.UserInfoVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class LogDAO extends EgovAbstractMapper {

	public List<LogVO> selectLogList(LogVO logVO) throws Exception {
        return selectList("system.selectLogList", logVO);
    }
	
	public int insertLoginLog(UserInfoVO userInfoVO){
		insert("system.insertLoginLog", userInfoVO);
		return 1;
	}
	
	public int insertLogoutLog(UserInfoVO userInfoVO) throws Exception {
		insert("system.insertLogoutLog", userInfoVO);
		return 1;
	}
	
	public int logCnt(LogVO logVO) {
		return (Integer) selectOne("system.logCnt", logVO);
	}
	
}
