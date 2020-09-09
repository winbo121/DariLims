package iit.lims.accept.service.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import iit.lims.accept.dao.SamplingDAO;
import iit.lims.accept.service.SamplingService;
import iit.lims.accept.vo.SamplingVO;

/**
 * SamplingServiceImpl
 * 
 * @author 허태원
 * @since 2019.11.26
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2019.11.26  허태원   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2016 by interfaceIT., All right reserved.
 */

@Service
public class SamplingServiceImpl extends EgovAbstractServiceImpl implements SamplingService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "samplingDAO")
	private SamplingDAO samplingDAO;

	public List<SamplingVO> selectSamplingList(SamplingVO vo) throws Exception {
		return samplingDAO.selectSamplingList(vo);
	}
	
	public SamplingVO selectSamplingDetail(SamplingVO vo) throws Exception {
		return samplingDAO.selectSamplingDetail(vo);
	}
	
	public SamplingVO samplingFileDown(SamplingVO vo) throws Exception {
		try {
			return samplingDAO.samplingFileDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	public String insertSampling(SamplingVO vo) throws Exception {
		try {
			int result = -1;
			vo = this.imgPnSetting(vo);
			
			String pick_no = samplingDAO.selectPickNo();
			
			vo.setPick_no(pick_no);
			
			result = samplingDAO.insertSampling(vo);
			
			/*result = samplingDAO.updateReqSampling(vo);*/
			
			return pick_no;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public int updateSampling(SamplingVO vo) throws Exception {
		try {
			vo = this.imgPnSetting(vo);
			return samplingDAO.updateSampling(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public List<SamplingVO> selectSamplingLtList(SamplingVO vo) throws Exception {
		return samplingDAO.selectSamplingLtList(vo);
	}
	
	public List<SamplingVO> selectSamplingMesureList(SamplingVO vo) throws Exception {
		return samplingDAO.selectSamplingMesureList(vo);
	}
	
	public int saveSamplingLt(SamplingVO vo) throws Exception {
		try {
			int result = -1;
			
			result = samplingDAO.deleteSamplingLt(vo);
			
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");					
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");							
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("pick_no", vo.getPick_no());
						samplingDAO.insertSamplingLt(map);
					}
				}
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public int saveSamplingMesure(SamplingVO vo) throws Exception {
		try {
			int result = -1;
			
			result = samplingDAO.deleteSamplingMesure(vo);			
			
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");					
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");							
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("pick_no", vo.getPick_no());
						samplingDAO.insertSamplingMesure(map);
					}
				}
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public SamplingVO imgPnSetting(SamplingVO vo) throws Exception {
		if (vo.getPick_place_photo_img() != null && vo.getPick_place_photo_img().getSize() > 0) {
			vo.setPick_place_photo(vo.getPick_place_photo_img().getBytes());
			vo.setPick_place_pn(vo.getPick_place_photo_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getPick_place_photo());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setPick_place_photo(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getPick_utnsil_photo_img() != null && vo.getPick_utnsil_photo_img().getSize() > 0) {
			vo.setPick_utnsil_photo(vo.getPick_utnsil_photo_img().getBytes());
			vo.setPick_utnsil_pn(vo.getPick_utnsil_photo_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getPick_utnsil_photo());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setPick_utnsil_photo(resizeImagePngFinal);//이미지를 vo에 넣음
			
		}
		if (vo.getLt_atch_photo1_img() != null && vo.getLt_atch_photo1_img().getSize() > 0) {
			vo.setLt_atch_photo1(vo.getLt_atch_photo1_img().getBytes());
			vo.setLt_atch_pn1(vo.getLt_atch_photo1_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getLt_atch_photo1());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setLt_atch_photo1(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getLt_atch_photo2_img() != null && vo.getLt_atch_photo2_img().getSize() > 0) {
			vo.setLt_atch_photo2(vo.getLt_atch_photo2_img().getBytes());
			vo.setLt_atch_pn2(vo.getLt_atch_photo2_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getLt_atch_photo2());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setLt_atch_photo2(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getLt_atch_photo3_img() != null && vo.getLt_atch_photo3_img().getSize() > 0) {
			vo.setLt_atch_photo3(vo.getLt_atch_photo3_img().getBytes());
			vo.setLt_atch_pn3(vo.getLt_atch_photo3_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getLt_atch_photo3());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setLt_atch_photo3(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getLt_atch_photo4_img() != null && vo.getLt_atch_photo4_img().getSize() > 0) {
			vo.setLt_atch_photo4(vo.getLt_atch_photo4_img().getBytes());
			vo.setLt_atch_pn4(vo.getLt_atch_photo4_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getLt_atch_photo4());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setLt_atch_photo4(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getMesure_atch_photo1_img() != null && vo.getMesure_atch_photo1_img().getSize() > 0) {
			vo.setMesure_atch_photo1(vo.getMesure_atch_photo1_img().getBytes());
			vo.setMesure_atch_pn1(vo.getMesure_atch_photo1_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getMesure_atch_photo1());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setMesure_atch_photo1(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getMesure_atch_photo2_img() != null && vo.getMesure_atch_photo2_img().getSize() > 0) {
			vo.setMesure_atch_photo2(vo.getMesure_atch_photo2_img().getBytes());
			vo.setMesure_atch_pn2(vo.getMesure_atch_photo2_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getMesure_atch_photo2());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setMesure_atch_photo2(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getMesure_atch_photo3_img() != null && vo.getMesure_atch_photo3_img().getSize() > 0) {
			vo.setMesure_atch_photo3(vo.getMesure_atch_photo3_img().getBytes());
			vo.setMesure_atch_pn3(vo.getMesure_atch_photo3_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getMesure_atch_photo3());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setMesure_atch_photo3(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		if (vo.getMesure_atch_photo4_img() != null && vo.getMesure_atch_photo4_img().getSize() > 0) {
			vo.setMesure_atch_photo4(vo.getMesure_atch_photo4_img().getBytes());
			vo.setMesure_atch_pn4(vo.getMesure_atch_photo4_img().getOriginalFilename());
			
			//시료 이미지 화질 저하
        	ByteArrayInputStream inputStream = new ByteArrayInputStream(vo.getMesure_atch_photo4());//이미지 가져오기
        	byte [] resizeImagePngFinal = this.imgResizingSetting(vo, inputStream);//실행
            vo.setMesure_atch_photo4(resizeImagePngFinal);//이미지를 vo에 넣음
		}
		return vo;
	}
	
	//시료 이미지 화질 저하
    private static final int IMG_WIDTH = 300;
    private static final int IMG_HEIGHT = 300;
    
	public  byte [] imgResizingSetting(SamplingVO vo, ByteArrayInputStream inputStream) throws Exception {
		byte [] resizeImagePngFinal = null;
        try {
        	 //byte 파일을 이미지로 변경해줌
            BufferedImage originalImage = ImageIO.read(inputStream); 
            
            int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
            System.out.println("originFile Height : " + originalImage.getHeight());//기존 이미지 높이
            System.out.println("originFile Width : " + originalImage.getWidth());//기존 이미지 넓이
            
            BufferedImage resizeImagePng = resizeImage(originalImage, type);//이미지 리사이징
            
            //이미지를 byte로 변경
            BufferedImage bImage = resizeImagePng;
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ImageIO.write(bImage, "png", bos );
            resizeImagePngFinal = bos.toByteArray();
            
            System.out.println("===========================================================");
            System.out.println("resizeFile Height : " + resizeImagePng.getHeight());
            System.out.println("resizeFile Width : " + resizeImagePng.getWidth());
            
            
        } catch (Exception e){
            e.printStackTrace();
        }
		return resizeImagePngFinal;
		
	}
	
    private static BufferedImage resizeImage(BufferedImage originalImage, int type){
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g.dispose();
            
        return resizedImage;
    }

	// 채취 정보 저장시 채취로트 생성
	public int saveSplorePick(SamplingVO vo) throws Exception {
		try {
			int result = -1;
			
			vo.setPick_no(vo.getPick_no());
			vo.setPick_lt_no(vo.getPick_lt_no());
			vo.setIncrement_no(vo.getIncrement_no());
			
			samplingDAO.saveSplorePick(vo);
				
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 채취 정보 저장시 채취측정 생성
	public int saveMesure(SamplingVO vo) throws Exception {
		try {
			int result = -1;
			
			vo.setPick_no(vo.getPick_no());
			vo.setPick_mesure_no(vo.getPick_mesure_no());
			vo.setSplore_no(vo.getSplore_no());
			
			samplingDAO.saveMesure(vo);
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//로트전체삭제
	public int deleteSamplingLt(SamplingVO vo) throws Exception {
		try {
			return samplingDAO.deleteSamplingLt(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//측정전체삭제
	public int deleteSamplingMesure(SamplingVO vo) throws Exception {
		try {
			return samplingDAO.deleteSamplingMesure(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
