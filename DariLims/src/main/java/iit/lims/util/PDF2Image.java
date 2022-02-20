package iit.lims.util;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
//import org.apache.pdfbox.pdmodel.PDPageNode;


import javax.imageio.ImageIO;

import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class PDF2Image {

	/** use pdfbox_1.8.13 **/

	public static List<String> PDF2Img(String filePath, String destPath) {
	  File file = new File(filePath);
	  if (!file.exists()) {
	    return null;
	  }

//	  List<String> fileNames = new ArrayList<String>();
//	  try {
//	    PDDocument document = PDDocument.load(file);
//	    PDPageNode node = document.getDocumentCatalog().getPages();
//	    List<PDPage> pages = node.getKids();
//	    int count = 0;
//	    for (PDPage page: pages) {
//	      BufferedImage img = page.convertToImage(BufferedImage.TYPE_INT_RGB, 128);
//	      File imageFile = new File(destPath + count++ + ".jpg");
//	      ImageIO.write(img, "jpg", imageFile);
//	      fileNames.add(imageFile.getName());
//	    }
//	    return fileNames;
//	  } catch (IOException e) {
//	    e.printStackTrace();
//	  }
	  return null;
	}
	  
	public static List<String> PDF2Base64Img(String filePath) {
	  File file = new File(filePath);
	  if (!file.exists()) {
	    return null;
	  }

	  List<String> fileNames = new ArrayList<String>();
//	  try {
//	    PDDocument document = PDDocument.load(file);
//	    PDPageNode node = document.getDocumentCatalog().getPages();
//	    List<PDPage> pages = node.getKids();
//	    for (PDPage page: pages) {
//	      final ByteArrayOutputStream os = new ByteArrayOutputStream();
//	      BufferedImage img = page.convertToImage(BufferedImage.TYPE_INT_RGB, 128);
//	      ImageIO.write(img, "jpg", os);
//	      fileNames.add(Base64.getEncoder().encodeToString(os.toByteArray()));
//	    }
//	    return fileNames;
//	  } catch (IOException e) {
//	    e.printStackTrace();
//	  }
	  return null;

	}
}
