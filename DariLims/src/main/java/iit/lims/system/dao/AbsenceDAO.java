package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.UserVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class AbsenceDAO extends EgovAbstractMapper {

	public List<UserVO> selectAbsenceList(UserVO userVO) throws Exception {
		return selectList("system.selectAbsenceList", userVO);
	}

	public UserVO selectAbsenceDetail(UserVO userVO) throws Exception {
		return selectOne("system.selectAbsenceDetail", userVO);
	}

	public void saveAbsence(UserVO userVO) throws Exception {
		insert("system.saveAbsence", userVO);
	}

	public void deleteAbsence(UserVO userVO) throws Exception {
		insert("system.deleteAbsence", userVO);
	}

	public List<UserVO> selectAbsenceUserList(UserVO userVO) throws Exception {
		return selectList("system.selectAbsenceUserList", userVO);
	}

}
