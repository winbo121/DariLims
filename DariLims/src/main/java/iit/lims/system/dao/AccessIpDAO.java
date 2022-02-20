package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.AccessIpVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class AccessIpDAO extends EgovAbstractMapper {
	
	public List<AccessIpVO> selectAccessIp(AccessIpVO vo) throws Exception {
        return selectList("system.selectAccessIp", vo);
    }
	public AccessIpVO selectAccessIpDetail(AccessIpVO vo) throws Exception {
        return selectOne("system.selectAccessIpDetail", vo);
    }
	public int insertAccessIp(AccessIpVO vo) throws Exception{
		return insert("system.insertAccessIp", vo);
	}
	public int updateAccessIp(AccessIpVO vo) throws Exception{
		return update("system.updateAccessIp", vo);
	}
	public int deleteAccessIp(AccessIpVO vo) throws Exception{
		return delete("system.deleteAccessIp", vo);
	}
}
