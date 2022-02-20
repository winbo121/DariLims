package iit.lims.util.sync.service;

import java.util.ArrayList;
import java.util.HashMap;


public interface SyncService {

	public String selectLastSyncLog(HashMap map) throws Exception;
	public void insertSyncLog(HashMap map) throws Exception;
	public void updateSyncLog(HashMap map) throws Exception;
	
	public void insertSyncTarget(String category, ArrayList<HashMap> mapList) throws Exception;
}