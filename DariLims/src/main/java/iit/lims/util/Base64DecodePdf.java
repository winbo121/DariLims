package iit.lims.util;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Base64;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64DecodePdf {

	public static void Base64ToPdf(String base64String, String uploadPath, String fileNm) {
		try {
			
			base64String = base64String.replace(" ", "+");
		    BASE64Decoder decoder = new BASE64Decoder();
		    byte[] decodedBytes = decoder.decodeBuffer(base64String);

		    File file = new File(uploadPath + fileNm);;
		    FileOutputStream fop = new FileOutputStream(file);

		    fop.write(decodedBytes);
		    fop.flush();
		    fop.close();
		    
		    
		} catch (Exception e) {
			e.printStackTrace();
	    }
	}
}
