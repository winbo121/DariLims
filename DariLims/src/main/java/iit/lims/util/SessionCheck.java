package iit.lims.util;

import iit.lims.system.vo.UserInfoVO;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.google.gson.Gson;

public class SessionCheck extends HandlerInterceptorAdapter {
	static final Logger log = LogManager.getLogger();

	/**
	 * 세션정보 체크
	 * 
	 * @param request
	 * @return
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String uri = request.getServletPath();

		//log.info(uri);
		/*Enumeration eHeader = request.getHeaderNames();
		while (eHeader.hasMoreElements()) {
			String hName = (String) eHeader.nextElement();
			String hValue = request.getHeader(hName);

			System.out.println(hName + " : " + hValue);
		}
		System.out.println("==============");*/
		ArrayList<String> u = new ArrayList<String>();
		u.add("/login.lims");
		u.add("/begin.lims");
		u.add("/loginCheck.lims");
		u.add("/verifyReport.lims");
		u.add("/verifyReportAction.lims");
		if (!u.contains(uri)) {
			if (request.getSession().getAttribute("session") == null) {
				log.debug("사용자 세션이 만료되었습니다.[noSession]");
				response.setContentType("text/html");
				response.setHeader("Cache-Control", "no-cache");
				response.setCharacterEncoding("UTF-8");

				String data = "";
				if ("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) { // ajax
					if (request.getHeader("accept").contains("text/html")) { // html
						data = "noSession";
					} else { // json
						Gson gson = new Gson();
						data = gson.toJson("noSession");
					}
					PrintWriter writer = response.getWriter();
					writer.write(data);
					writer.close();
					return false;
				} else {
					String contentType = request.getHeader("content-type");
					if (contentType != null) {
						if (contentType.contains("multipart/form-data")) {
							Gson gson = new Gson();
							data = gson.toJson("noSession");

							PrintWriter writer = response.getWriter();
							writer.write(data);
							writer.close();
							return false;
						}
					} else {
						data = "common/login";
						throw new ModelAndViewDefiningException(new ModelAndView(data));
						// return true; // 페이지 이동할때는 세션체크 하지 않음
					}
				}
			} else {
				return true;
			}
		}
		return true;
	}

	/**
	 * 세션정보 받아오기
	 * 
	 * @param request
	 * @return
	 */
	public static UserInfoVO getSession(HttpServletRequest request) {
		return (UserInfoVO) request.getSession().getAttribute("session");
	}
	
	/*
	 * 사용자 IP 
	 */
	public static String getUserIp(){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	
}
