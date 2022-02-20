package iit.lims.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.web.servlet.view.AbstractView;

public class JsonExcelView extends AbstractView {

	private static Logger _Logger = Logger.getLogger(JsonExcelView.class.getName());
	
	@Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("1212121212121");
		
		/* XLS 0.9X 버전
		 * response.setContentType("text/plain");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		HSSFWorkbook workbook = (HSSFWorkbook) model.get("excelData");
		//response.setHeader("Content-disposition", "inline;filename=test.xls");
		response.setHeader("Content-disposition", "attachment;filename="+fileNm);
        response.setContentType("application/vnd.ms-excel");
        workbook.write(response.getOutputStream());*/
        
		
	}
}
