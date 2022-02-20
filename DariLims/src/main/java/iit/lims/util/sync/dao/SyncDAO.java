package iit.lims.util.sync.dao;

import java.util.HashMap;
import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SyncDAO extends EgovAbstractMapper {

	public String selectLastSyncLog(HashMap map) throws Exception{
		return selectOne("sync.selectLastSyncLog", map);
	}
	public void insertSyncLog(HashMap map) throws Exception{
		insert("sync.insertSyncLog", map);
	}
	public void updateSyncLog(HashMap map) throws Exception{
		update("sync.updateSyncLog", map);
	}
	
	/**
	 * 품목분류(PRDLST_CL) : I2510
	 */
	public int selectPrdlstCl(HashMap map) throws Exception{
		return selectOne("sync.selectPrdlstCl", map);
	}
	public void insertPrdlstCl(HashMap map) throws Exception{
		insert("sync.insertPrdlstCl", map);
	}
	public void updatePrdlstCl(HashMap map) throws Exception{
		update("sync.updatePrdlstCl", map);
	}

	/**
	 * 공통기준종류(CMMN_SPEC_KIND) : I2590
	 */
	public int selectCmmnSpecKind(HashMap map) throws Exception{
		return selectOne("sync.selectCmmnSpecKind", map);
	}
	public void insertCmmnSpecKind(HashMap map) throws Exception{
		insert("sync.insertCmmnSpecKind", map);
	}
	public void updateCmmnSpecKind(HashMap map) throws Exception{
		update("sync.updateCmmnSpecKind", map);
	}

	/**
	 * 공통기준규격(CMMN_SPEC) : I2600
	 */
	public int selectCmmnSpec(HashMap map) throws Exception{
		return selectOne("sync.selectCmmnSpec", map);
	}
	public void insertCmmnSpec(HashMap map) throws Exception{
		insert("sync.insertCmmnSpec", map);
	}
	public void updateCmmnSpec(HashMap map) throws Exception{
		update("sync.updateCmmnSpec", map);
	}

	/**
	 * 공통기준제외(CMMN_SPEC_KIND_EXPT_PRDLST) : I2610
	 */
	public int selectCmmnSpecKindExptPrdlst(HashMap map) throws Exception{
		return selectOne("sync.selectCmmnSpecKindExptPrdlst", map);
	}
	public void insertCmmnSpecKindExptPrdlst(HashMap map) throws Exception{
		insert("sync.insertCmmnSpecKindExptPrdlst", map);
	}
	public void updateCmmnSpecKindExptPrdlst(HashMap map) throws Exception{
		update("sync.updateCmmnSpecKindExptPrdlst", map);
	}
	

	/**
	 * 시함항목코드(ANALYSIS) : I2530
	 */
	public int selectAnalysis(HashMap map) throws Exception{
		return selectOne("sync.selectAnalysis", map);
	}
	public void insertAnalysis(HashMap map) throws Exception{
		insert("sync.insertAnalysis", map);
	}
	public void updateAnalysis(HashMap map) throws Exception{
		update("sync.updateAnalysis", map);
	}
	

	/**
	 * 개별기준규격(INDV_SPEC) : I2580
	 */
	public int selectIndvSpec(HashMap map) throws Exception{
		return selectOne("sync.selectIndvSpec", map);
	}
	public void insertIndvSpec(HashMap map) throws Exception{
		insert("sync.insertIndvSpec", map);
	}
	public void updateIndvSpec(HashMap map) throws Exception{
		update("sync.updateIndvSpec", map);
	}
}
