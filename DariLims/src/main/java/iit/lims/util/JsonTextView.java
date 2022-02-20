package iit.lims.util;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

import com.google.gson.Gson;

public class JsonTextView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/plain");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		Object object = model.get("resultData");
		Gson gson = new Gson();
		String json = gson.toJson(object);
		PrintWriter writer = response.getWriter();
		writer.write(json);
		writer.close();
		
	}
}
