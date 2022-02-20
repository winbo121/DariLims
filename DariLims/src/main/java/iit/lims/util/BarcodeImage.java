package iit.lims.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;

/*import org.krysalis.barcode4j.BarcodeClassResolver;
import org.krysalis.barcode4j.DefaultBarcodeClassResolver;
import org.krysalis.barcode4j.impl.AbstractBarcodeBean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;*/



public class BarcodeImage {

	private final static boolean isAntiAliasing = false;

    /**
	 * barcode 이미지 생성
     * @param String-바코드 타입
	 * 	"codabar", "code39", "postnet", "intl2of5", "ean-128"			
	 * 	"royal-mail-cbc", "ean-13", "itf-14", "datamatrix", "code128"			
	 * 	"pdf417", "upc-a", "upc-e", "usps4cb", "ean-8", "ean-13" 
     * @param String-바코드 데이터
     * @param String-이미지의 dpi
     * @return ByteArray
     * @throws Exception
     */
	public byte[] barcodeImageBinary(String barcodeType, String barcodeData, int imageDpi) throws Exception {
		byte[] retImage = null;
		//이미지 바이너리로
		/*int imageType = BufferedImage.TYPE_BYTE_BINARY;

		AbstractBarcodeBean bean = null;
		BarcodeClassResolver resolver = new DefaultBarcodeClassResolver();
		Class clazz = resolver.resolveBean(barcodeType);
		bean = (AbstractBarcodeBean)clazz.newInstance();
		bean.doQuietZone(true);			

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {
			BitmapCanvasProvider provider = new BitmapCanvasProvider(
			    out, "image/x-png", imageDpi, imageType, isAntiAliasing, 0);
			bean.generateBarcode(provider, barcodeData);
			provider.finish();
			retImage = out.toByteArray();
		} finally {
			out.close();
		}*/
		return retImage;
	}
}
