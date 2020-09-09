package iit.lims.system.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.AuditTrailVO;
import iit.lims.system.vo.LogVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class AuditTrailDAO extends EgovAbstractMapper {

	public List<AuditTrailVO> selectAuditTrailList(AuditTrailVO auditTrailVO) throws Exception {
        return selectList("system.selectAuditTrailList", auditTrailVO);
    }
	
	public List<AuditTrailVO> selectAuditTrailDetail(AuditTrailVO auditTrailVO) throws Exception {
        return selectList("system.selectAuditTrailDetail", auditTrailVO);
    }
	
	public int insertAuditTrail(HashMap<String, String> map) throws Exception {
		insert("system.insertAuditTrail", map);
		return 1;
	}
	
	public int auditTrailCnt(AuditTrailVO auditTrailVO) {
		return (Integer) selectOne("system.auditTrailCnt", auditTrailVO);
	}
	
}
