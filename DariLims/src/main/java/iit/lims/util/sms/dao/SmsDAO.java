package iit.lims.util.sms.dao;

import iit.lims.util.sms.vo.SmsVO;
import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SmsDAO extends EgovAbstractMapper {

	public SmsVO selectSmsTarget(SmsVO vo) throws Exception{
		return selectOne("sms.selectSmsTarget", vo);
	}
	public void insertSmsLog(SmsVO vo) throws Exception{
		insert("sms.insertSmsLog", vo);
	}
	
	public String selectSmsCont(SmsVO vo) throws Exception{
		return selectOne("sms.selectSmsCont", vo);
	}
}
