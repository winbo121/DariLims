package iit.lims.instrument.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.instrument.vo.StateVO;
import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class StateDAO extends EgovAbstractMapper {

	public List<MachineVO> machineState(MachineVO machineVO) throws DataAccessException {
		return selectList("state.machineState", machineVO);
	}
	
	public List<StateVO> selectStateList(StateVO stateVO) throws DataAccessException {
		return selectList("state.state", stateVO);
	}

	public StateVO stateDetail(StateVO stateVO) {
		return (StateVO) selectOne("state.stateDetail", stateVO);
	}

	public int insertState(StateVO stateVO) throws DataAccessException {
		insert("state.insertState", stateVO);
		return 1; 
	}

	public int updateState(StateVO stateVO) throws DataAccessException {
		return update("state.updateState", stateVO);
	}

	public int deleteState(StateVO stateVO) throws DataAccessException {
		return delete("state.deleteState", stateVO);
	}
}
