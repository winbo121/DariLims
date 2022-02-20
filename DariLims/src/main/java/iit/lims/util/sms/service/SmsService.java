package iit.lims.util.sms.service;

import iit.lims.util.sms.vo.SmsVO;


public interface SmsService {
	public SmsVO selectSmsTarget(SmsVO vo) throws Exception;
	public void insertSmsLog(SmsVO vo) throws Exception;
	
	public String selectSmsCont(SmsVO vo) throws Exception;
}
