package iit.lims.util.sms.service.impl;

import iit.lims.util.sms.dao.SmsDAO;
import iit.lims.util.sms.service.SmsService;
import iit.lims.util.sms.vo.SmsVO;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class SmsServiceImpl extends EgovAbstractServiceImpl implements SmsService{
	static final Logger log = LogManager.getLogger();

	@Resource(name = "smsDAO")
	private SmsDAO smsDAO;

	public SmsVO selectSmsTarget(SmsVO vo) throws Exception{
		return smsDAO.selectSmsTarget(vo);
	}
	public void insertSmsLog(SmsVO vo) throws Exception{
		smsDAO.insertSmsLog(vo);
	}
	
	public String selectSmsCont(SmsVO vo) throws Exception{
		System.out.println("1234");
		return smsDAO.selectSmsCont(vo);
	}
}
