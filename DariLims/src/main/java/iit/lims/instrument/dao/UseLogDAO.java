package iit.lims.instrument.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.instrument.vo.UseLogVO;
import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class UseLogDAO extends EgovAbstractMapper {

	public List<MachineVO> machineUseLog(MachineVO machineVO) throws DataAccessException {
		return selectList("useLog.machineUseLog", machineVO);
	}
	
	public List<UseLogVO> selectUseLogList(UseLogVO useLogVO) throws DataAccessException {
		return selectList("useLog.useLog", useLogVO);
	}

	public UseLogVO useLogDetail(UseLogVO useLogVO) {
		return (UseLogVO) selectOne("useLog.useLogDetail", useLogVO);
	}

	public int insertUseLog(UseLogVO useLogVO) throws DataAccessException {
		insert("useLog.insertUseLog", useLogVO);
		return 1; 
	}

	public int updateUseLog(UseLogVO useLogVO) throws DataAccessException {
		return update("useLog.updateUseLog", useLogVO);
	}

	public int deleteUseLog(UseLogVO useLogVO) throws DataAccessException {
		return delete("useLog.deleteUseLog", useLogVO);
	}
}
