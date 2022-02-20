package iit.lims.instrument.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.instrument.vo.RepairVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class RepairDAO extends EgovAbstractMapper {

	public List<RepairVO> selectRepairList(RepairVO repairVO) throws DataAccessException {
		return selectList("repair.repair", repairVO);
	}

	public RepairVO repairDetail(RepairVO repairVO) {
		return (RepairVO) selectOne("repair.repairDetail", repairVO);
	}

	public int insertRepair(RepairVO repairVO) throws DataAccessException {
		insert("repair.insertRepair", repairVO);
		return 1; 
	}

	public int updateRepair(RepairVO repairVO) throws DataAccessException {
		return update("repair.updateRepair", repairVO);
	}

	public int deleteRepair(RepairVO repairVO) throws DataAccessException {
		return delete("repair.deleteRepair", repairVO);
	}
}
