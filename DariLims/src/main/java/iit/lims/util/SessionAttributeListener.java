package iit.lims.util;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import iit.lims.system.dao.LogDAO;
import iit.lims.system.vo.UserInfoVO;

public class SessionAttributeListener implements HttpSessionAttributeListener {
	String xml[] = new String[2];

	public SessionAttributeListener() {
		xml[0] = "spring/context-datasource.xml";
		xml[1] = "spring/context-mapper.xml";
	}

	public void attributeAdded(HttpSessionBindingEvent se) {
	}

	public void attributeRemoved(HttpSessionBindingEvent se) {
		/*UserInfoVO userInfoVO = (UserInfoVO) se.getValue();
		ApplicationContext ac = new ClassPathXmlApplicationContext(xml);
		LogDAO logDAO = ac.getBean("LogDAO", LogDAO.class);
		try {
			logDAO.insertLogoutLog(userInfoVO);
		} catch (Exception e) {
			e.printStackTrace();
		}*/
	}

	public void attributeReplaced(HttpSessionBindingEvent se) {
		UserInfoVO userInfoVO = (UserInfoVO) se.getValue();
		ApplicationContext ac = new ClassPathXmlApplicationContext(xml);
		LogDAO logDAO = ac.getBean("LogDAO", LogDAO.class);
		try {
			logDAO.insertLogoutLog(userInfoVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
