package iit.lims.util.sync.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.util.sync.dao.SyncDAO;
import iit.lims.util.sync.service.SyncService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class SyncServiceImpl extends EgovAbstractServiceImpl implements SyncService{
	static final Logger log = LogManager.getLogger();

	@Resource(name = "syncDAO")
	private SyncDAO syncDAO;


	public String selectLastSyncLog(HashMap map) throws Exception{
		return syncDAO.selectLastSyncLog(map);
	}
	public void insertSyncLog(HashMap map) throws Exception{
		syncDAO.insertSyncLog(map);
	}
	public void updateSyncLog(HashMap map) throws Exception{
		syncDAO.updateSyncLog(map);
	}
	
	
	/**
	 * 품목분류(PRDLST_CL) : I2510
	 * 공통기준종류(CMMN_SPEC_KIND) : I2590
	 * 시함항목코드(ANALYSIS) : I2530
	 * 개별기준규격(INDV_SPEC) : I2580
	 * 공통기준규격(CMMN_SPEC) : I2600
	 * 공통기준제외(CMMN_SPEC_KIND_EXPT_PRDLST) : I2610
	 */
	public void insertSyncTarget(String category, ArrayList<HashMap> mapList) throws Exception{
		for (int i = 0; i < mapList.size(); i++) {
			HashMap map = mapList.get(i);
			if(category.equals("I2510")){
				int cnt = syncDAO.selectPrdlstCl(map);
				if(cnt > 0){
					syncDAO.updatePrdlstCl(map);
				}else{
					syncDAO.insertPrdlstCl(map);
				}
			}else if(category.equals("I2530")){
				int cnt = syncDAO.selectAnalysis(map);
				if(cnt > 0){
					syncDAO.updateAnalysis(map);
				}else{
					syncDAO.insertAnalysis(map);
				}	
			}else if(category.equals("I2580")){
				int cnt = syncDAO.selectIndvSpec(map);
				if(cnt > 0){
					syncDAO.updateIndvSpec(map);
				}else{
					syncDAO.insertIndvSpec(map);
				}	
			}else if(category.equals("I2590")){
				int cnt = syncDAO.selectCmmnSpecKind(map);
				if(cnt > 0){
					syncDAO.updateCmmnSpecKind(map);
				}else{
					syncDAO.insertCmmnSpecKind(map);
				}	
			}else if(category.equals("I2600")){
				int cnt = syncDAO.selectCmmnSpec(map);
				if(cnt > 0){
					syncDAO.updateCmmnSpec(map);
				}else{
					syncDAO.insertCmmnSpec(map);
				}	
			}else if(category.equals("I2610")){
				int cnt = syncDAO.selectCmmnSpecKindExptPrdlst(map);
				if(cnt > 0){
					syncDAO.updateCmmnSpecKindExptPrdlst(map);
				}else{
					syncDAO.insertCmmnSpecKindExptPrdlst(map);
				}	
			}
		}
	}
}