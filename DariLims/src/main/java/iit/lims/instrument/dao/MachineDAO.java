package iit.lims.instrument.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class MachineDAO extends EgovAbstractMapper {

	public List<MachineVO> selectMachineList(MachineVO machineVO) throws DataAccessException {
		return selectList("machine.machine", machineVO);
	}

	public List<MachineVO> selectMachineDeptList(MachineVO machineVO) throws DataAccessException {
		return selectList("machine.machineDept", machineVO);
	}

	public MachineVO machineDetail(MachineVO machineVO) {
		return (MachineVO) selectOne("machine.machineDetail", machineVO);
	}

	public int insertMachine(MachineVO machineVO) throws DataAccessException {
		insert("machine.insertMachine", machineVO);
		return 1;
	}

	public int updateMachine(MachineVO machineVO) throws DataAccessException {
		return update("machine.updateMachine", machineVO);
	}

	public int deleteMachine(MachineVO machineVO) throws DataAccessException {
		return update("machine.deleteMachine", machineVO);
	}

	public MachineVO machineDown(MachineVO machineVO) {
		return (MachineVO) selectOne("machine.machineDown", machineVO);
	}

	public MachineVO machineDeleteFlag(MachineVO machineVO) {
		return (MachineVO) selectOne("machine.machineDeleteFlag", machineVO);
	}

	public MachineVO machineImage(MachineVO machineVO) {
		return (MachineVO) selectOne("machine.machineImage", machineVO);
	}

	public List<MachineVO> selectMachineManager(MachineVO machineVO) {
		return selectList("machine.selectMachineManager", machineVO);
	}

	public void saveManager(MachineVO machineVO) throws DataAccessException {
		insert("machine.insertManager", machineVO);
	}

	public void deleteManager(MachineVO machineVO) throws DataAccessException {
		delete("machine.deleteManager", machineVO);
	}

}
