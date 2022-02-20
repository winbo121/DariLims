package iit.lims.system.dao;

import iit.lims.util.sms.vo.SmsVO;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SmsManageDAO extends EgovAbstractMapper {
	
	public List<SmsVO> selectSmsManage(SmsVO vo) throws Exception {
        return selectList("sms.selectSmsManage", vo);
    }
	public SmsVO selectSmsManageDetail(SmsVO vo) throws Exception {
        return selectOne("sms.selectSmsManageDetail", vo);
    }
	public int insertSmsManage(SmsVO vo) throws Exception{
		return insert("sms.insertSmsManage", vo);
	}
	public int updateSmsManage(SmsVO vo) throws Exception{
		return update("sms.updateSmsManage", vo);
	}
	public int deleteSmsManage(SmsVO vo) throws Exception{
		return update("sms.deleteSmsManage", vo);
	}
	public String selectSmsKeyCheck(SmsVO vo) throws Exception{
		return selectOne("sms.selectSmsKeyCheck", vo);
	}
}
