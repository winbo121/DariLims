package iit.lims.util;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.view.AbstractView;

@Repository("cmm.ByteDownloadView")
public class ByteDownloadView extends AbstractView {

	protected Log log = LogFactory.getLog(this.getClass());

	/** ENCODING */
	private static final String ENCODING = "UTF-8";

	public ByteDownloadView() {
		super.setContentType("application/octet-stream");
	}

	protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		byte[] bt = (byte[]) model.get("data");

		final String fileName = (String) model.get("fileName");

		response.setContentType("application/smnet; charset=UTF-8");
		response.setHeader("Accept-Ranges", "bytes");
		response.setContentLength((int) bt.length);

		String sUserAgent = request.getHeader("User-Agent");
		boolean isFirefox = (sUserAgent.toLowerCase().indexOf("firefox") != -1) ? true : false;

		// response.setHeader("Content-Transfer-Encoding", "binary");
		// response.setHeader("Pragma", "no-cache;");
		// response.setHeader("Expires", "-1;");

		if (sUserAgent.indexOf("MSIE 5.5") != -1) {
			response.setHeader("Content-Disposition", "attachment;fileName=\"" + ENCODING + encodeURLEncoding(fileName) + "\";");

			// Safari 브라우저 경우 인코딩 처리
		} else if (sUserAgent.indexOf("Safari") != -1) {
			// response.setContentType("application/octet-stream;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment;fileName=\"" + encodeURLEncoding(fileName) + "\";");
			// 크롬에서 다운로드시 파일명 오류(15.11.05)
			//response.setHeader("Content-Disposition", "attachment;fileName=\"" + "\"" + encodeURLEncoding(fileName) + "\"" + "\";");

		} else {
			if (isFirefox) {
				response.setHeader("Content-Disposition", "attachment;fileName=\"" + "=?" + ENCODING + "?Q?" + encodeQuotedPrintable(fileName) + "?=" + "\";");
			} else {
				response.setHeader("Content-Disposition", "attachment;fileName=\"" + encodeURLEncoding(fileName) + "\";");
			}
		}

		ByteArrayInputStream bin = new ByteArrayInputStream(bt);
		BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
		try {
			byte[] buf = new byte[4 * 1024];
			int readCount = 0;
			while ((readCount = bin.read(buf)) != -1) {
				out.write(buf, 0, readCount);
			}
		} catch (java.io.IOException ioe) {
			ioe.printStackTrace();
		} finally {
			out.flush();
			bin.close();
			out.close();
		}

	}

	/**
	 * 인코딩 타입에 맞게 변환한다.
	 * 
	 * @param p_sStr
	 *            의심되는 문자열
	 * @return 결과값
	 * @throws UnsupportedEncodingException
	 */
	private String encodeURLEncoding(String p_sStr) throws UnsupportedEncodingException {
		String filename = p_sStr;
		filename = java.net.URLEncoder.encode(filename, this.ENCODING);
		filename = filename.replaceAll("\\+", "%20");
		return filename;
	}

	/**
	 * 인코딩 타입에 맞게 변환한다.
	 * 
	 * @param p_sStr
	 *            의심되는 문자열
	 * @return 결과값
	 * @throws UnsupportedEncodingException
	 */
	private String encodeQuotedPrintable(String p_sStr) throws UnsupportedEncodingException {
		String sUrlEncodingStr = URLEncoder.encode(p_sStr, this.ENCODING);
		sUrlEncodingStr = sUrlEncodingStr.replaceAll("\\+", "_");
		sUrlEncodingStr = sUrlEncodingStr.replaceAll("%", "=");
		return sUrlEncodingStr;
	}
}
