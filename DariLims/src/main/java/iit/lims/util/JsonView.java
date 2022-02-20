package iit.lims.util;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.view.AbstractView;

import com.google.gson.Gson;

public class JsonView extends AbstractView {

	private static Logger _Logger = Logger.getLogger(JsonView.class.getName());
	
	@Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType("application/x-json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		Object object = model.get("resultData");
		Gson gson = new Gson();
		String json = gson.toJson(object);
		_Logger.debug("***** JsonView.renderMergedOutputModel() json = "+ json+ "****");
		PrintWriter writer = response.getWriter();
		writer.write(json);
		writer.close();
		
	}
}
