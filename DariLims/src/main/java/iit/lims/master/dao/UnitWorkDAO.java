package iit.lims.master.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.master.vo.UnitWorkVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class UnitWorkDAO extends EgovAbstractMapper {
	
	public List<UnitWorkVO> unitWork(UnitWorkVO unitWorkVO) throws DataAccessException {
		return selectList("unitWork.unitWork", unitWorkVO);
	}

	public UnitWorkVO unitWorkDetail(UnitWorkVO unitWorkVO) {
		return (UnitWorkVO) selectOne("unitWork.unitWorkDetail", unitWorkVO);
	}

	public int insertUnitWork(UnitWorkVO unitWorkVO) throws DataAccessException {
		insert("unitWork.insertUnitWork", unitWorkVO);
		return 1;
	}

	public int updateUnitWork(UnitWorkVO unitWorkVO) throws DataAccessException {
		return update("unitWork.updateUnitWork", unitWorkVO);
	}

	public int deleteUnitWork(UnitWorkVO unitWorkVO) throws DataAccessException {
		return update("unitWork.deleteUnitWork", unitWorkVO);
	}
	
	public List<UnitWorkVO> deptList(UnitWorkVO unitWorkVO) throws DataAccessException {
		return selectList("unitWork.deptList", unitWorkVO);
	}
	
	public List<UnitWorkVO> deptUnitWork(UnitWorkVO unitWorkVO) {
		return selectList("unitWork.allDeptUnitWork", unitWorkVO);
	}
	
	public List<UnitWorkVO> selectDeptUnitWork(UnitWorkVO unitWorkVO) {
		return selectList("unitWork.selectDeptUnitWork", unitWorkVO);
	}

	public int insertDeptUnitWork(HashMap<String, String> m) throws Exception {
		insert("unitWork.insertDeptUnitWork", m);
		return 1;
	}

	public void deleteDeptUnitWork(UnitWorkVO unitWorkVO) {
		delete("unitWork.deleteDeptUnitWork", unitWorkVO);
	}
	
	public UnitWorkVO deptUnitWorkDeleteFlag(UnitWorkVO unitWorkVO) {
		return (UnitWorkVO) selectOne("unitWork.deptUnitWorkDeleteFlag", unitWorkVO);
	}
}