package iit.lims.accept.service.impl;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import iit.lims.accept.dao.AcceptDAO;
import iit.lims.accept.dao.CommissionCheckDAO;
import iit.lims.accept.service.AcceptService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.analysis.dao.ResultCheckDAO;
import iit.lims.analysis.dao.TestReportDAO;
import iit.lims.analysis.vo.TestReportVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.util.Base64DecodePdf;
import iit.lims.util.ConverObjectToMap;
import iit.lims.util.PDF2Image;
import iit.lims.util.SessionCheck;
import iit.lims.util.Sms;
import iit.lims.util.sms.service.SmsService;
import iit.lims.util.sms.vo.SmsVO;
import m2soft.ers.invoker.InvokerException;
import m2soft.ers.invoker.http.ReportingServerInvoker;

/**
 * MenuService
 * 
 * @author ?????????
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  ?????????      ?????????   ????????????
 *  ---------- -------- ---------------------------
 *  2015.01.13  ?????????   ?????? ??????
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Service
public class AcceptServiceImpl extends EgovAbstractServiceImpl implements AcceptService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "acceptDAO")
	private AcceptDAO acceptDAO;

	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;

	@Resource(name = "testReportDAO")
	private TestReportDAO testReportDAO;
	
	@Resource(name = "commissionCheckDAO")
	private CommissionCheckDAO commissionCheckDAO;

	@Resource(name = "resultCheckDAO")
	private ResultCheckDAO resultCheckDAO;

	@Resource
	private SmsService smsService;

	@Resource
	private CommonDAO commonDAO;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
	 * ?????? > ?????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectAcceptList(AcceptVO vo) throws Exception {
		return acceptDAO.selectAcceptList(vo);
	}

	/**
	 * ?????? > ?????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectAcceptSampleList(AcceptVO vo) throws Exception {
		return acceptDAO.selectAcceptSampleList(vo);
	}

	/**
	 * ?????? > ?????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectAcceptItemList(AcceptVO vo) throws Exception {
		return acceptDAO.selectAcceptItemList(vo);
	}

	/**
	 * ?????? > ?????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @exception Exception
	 */
	public AcceptVO selectAcceptDetail(AcceptVO vo) throws Exception {
		return acceptDAO.selectAcceptDetail(vo);
	}

	/**
	 * ?????? > ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public AcceptVO insertAccept(AcceptVO vo) throws Exception {
		try {
			String test_req_seq = "";
			String test_req_no = "";

			test_req_seq = acceptDAO.selectReqSeq();

			HashMap<String, String> reqNoMap = new HashMap<String, String>();
			reqNoMap.put("gubun", "1");
			System.out.println("@@"+vo.getReq_class());
			reqNoMap.put("param", vo.getReq_class());
			test_req_no = acceptDAO.selectReqNo(reqNoMap);
			vo.setRec_req_no(test_req_no);
			vo.setReq_act_user_id(vo.getUser_id());
			vo.setState("A");

			vo.setTest_req_seq(test_req_seq);
			vo.setTest_req_no(test_req_no);
			
			if (vo.getQR_file_upload() != null && vo.getQR_file_upload().getSize() > 0) {
				vo.setQR_file(vo.getQR_file_upload().getBytes());
				vo.setQR_nm(vo.getQR_file_upload().getOriginalFilename());
			}
			acceptDAO.insertAccept(vo);
			
			this.insertCollect(vo);
			
			AcceptVO acceptVO = new AcceptVO();
			acceptVO.setTest_req_seq(vo.getTest_req_seq());
			acceptVO.setTest_req_no(vo.getTest_req_no());
			return acceptVO;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? ?????? ??? ?????? ??????/?????? ????????? ??????
	 */
	public void insertCollect (AcceptVO param) {
		AcceptVO collectVO = null;
		
		if(null != param.getCollect_method()){
			String[] methodCds = param.getCollect_method().split(",");
			for(String methodCd : methodCds){
				collectVO = new AcceptVO();
				collectVO.setTest_req_seq(param.getTest_req_seq());
				collectVO.setCollect_pre_code("C71");
				// ?????? ????????? ????????? ????????? ???????????? set
				if( methodCd.equals("C71007") && null != param.getCollect_method_etc() ){
					collectVO.setCollect_code_etc(param.getCollect_method_etc());
				} else {
					collectVO.setCollect_code_etc("");
				}
				collectVO.setCollect_code(methodCd);
				acceptDAO.insertCollect(collectVO);
			}
		}
		
		if(null != param.getCollect_div()){
			String[] divCds = param.getCollect_div().split(",");
			for(String divCd : divCds){
				collectVO = new AcceptVO();
				collectVO.setTest_req_seq(param.getTest_req_seq());
				collectVO.setCollect_pre_code("C72");
				// ?????? ????????? ????????? ????????? ???????????? set
				if( divCd.equals("C72006") && null != param.getCollect_div_etc() ){
					collectVO.setCollect_code_etc(param.getCollect_div_etc());
				} else {
					collectVO.setCollect_code_etc("");
				}
				collectVO.setCollect_code(divCd);
				acceptDAO.insertCollect(collectVO);
			}
		}
	}
	

	/**
	 * ?????? > ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public AcceptVO updateAccept(AcceptVO vo) throws Exception {
		try {
			if (vo.getQR_file_upload() != null && vo.getQR_file_upload().getSize() > 0) {
				vo.setQR_file(vo.getQR_file_upload().getBytes());
				vo.setQR_nm(vo.getQR_file_upload().getOriginalFilename());
			}
			acceptDAO.updateOrgCommission(vo); // ???????????? ????????? ????????? ??????
			acceptDAO.updateAccept(vo);
			/**
			 * ?????? ?????? ??? ?????? ??????/?????? ????????? ?????? ??????
			 */
			acceptDAO.deleteCollect(vo);
			this.insertCollect(vo);
			
			AcceptVO acceptVO = new AcceptVO();
			acceptVO.setTest_req_seq(vo.getTest_req_seq());
			acceptVO.setTest_req_no(vo.getTest_req_no());
			return acceptVO;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveSampleGrid(AcceptVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						/* AUDIT_TRAIL SETTING*/
						map.put("menu_cd", vo.getMenu_cd()); // ???????????? ??????
						map.put("worker_id", vo.getUser_id()); // ????????????????????? ????????? ??????
						map.put("at_ip", vo.getAt_ip()); // ????????????????????? ????????? ??????
						map.put("at_cont", map.toString()); // ??????????????? ??????
						
						String crud = map.get("crud");
						map.put("state", vo.getState());
						if (crud != "" && crud != null) {
							if ("c".equals(crud)) {
								String sample_temp_cd = map.get("sample_temp_cd");
								String test_req_seq = map.get("test_req_seq");
								vo.setTest_req_seq(test_req_seq);
								map.put("test_sample_seq", acceptDAO.selectAcceptSampleSeq(map));
								if (sample_temp_cd != null && !"".equals(sample_temp_cd)) {
									vo.setSample_temp_cd(sample_temp_cd);
									ArrayList<AcceptVO> lst = (ArrayList<AcceptVO>) acceptDAO.selectTempleteItemList(vo);
									if (lst != null) {
										map.put("tot_item_count", String.valueOf(lst.size()));
									}
									acceptDAO.insertAcceptSample(map);
									map.put("at_proc", "????????????(?????????)");
									/* AUDIT_TRAIL */
									auditTrailDAO.insertAuditTrail(map);
									
									if (lst != null && lst.size() > 0) {
										for (AcceptVO tmp : lst) {
											tmp.setUser_id(vo.getUser_id());
											tmp.setTest_sample_seq(map.get("test_sample_seq"));
											tmp.setState("A");
											acceptDAO.insertAcceptTempleteItem(tmp);
											/* AUDIT_TRAIL */
											map.put("test_item_cd", tmp.getTest_item_cd());
											map.put("at_proc", "????????????(?????????)");
											auditTrailDAO.insertAuditTrail(map);
											map.put("test_item_cd", "");
										}
										acceptDAO.updateAcceptFee(vo);
									}
								} else {
									acceptDAO.insertAcceptSample(map);
									/* AUDIT_TRAIL */
									map.put("at_proc", "????????????");
									auditTrailDAO.insertAuditTrail(map);
								}
							} else if ("r".equals(crud)) {
								String test_req_seq = map.get("test_req_seq");
								String test_sample_seq = map.get("sample_temp_cd");
								vo.setTest_req_seq(test_req_seq);
								vo.setTest_sample_seq(test_sample_seq);
								map.put("test_sample_seq", acceptDAO.selectAcceptSampleSeq(map));
								ArrayList<AcceptVO> lst = (ArrayList<AcceptVO>) acceptDAO.selectAcceptItemList(vo); // ????????? ?????? ????????? ??????
								if (lst != null) {
									map.put("tot_item_count", String.valueOf(lst.size()));
								}
								acceptDAO.copyTestSample(map);
								/* AUDIT_TRAIL */
								map.put("at_proc", "????????????(????????????)");
								auditTrailDAO.insertAuditTrail(map);
								if (lst != null && lst.size() > 0) {
									TestReportVO tvo = new TestReportVO();
									int i = 1;
									for (AcceptVO tmp : lst) {
										tmp.setDisp_order(String.valueOf(i));
										tmp.setTest_req_seq(test_req_seq);
										tmp.setTest_sample_seq(map.get("test_sample_seq"));
										tmp.setUser_id(vo.getUser_id());
										acceptDAO.insertAcceptTempleteItem(tmp); // ?????? ??????
										/* AUDIT_TRAIL */
										map.put("test_item_cd", tmp.getTest_item_cd());
										map.put("at_proc", "????????????(????????????)");
										auditTrailDAO.insertAuditTrail(map);
										map.put("test_item_cd", "");
										
										/* ??????(15.11.04) */
										tvo.setTest_sample_seq(map.get("test_sample_seq"));
										tvo.setTest_item_cd(tmp.getTest_item_cd());
										tvo.setTest_method_no(tmp.getTest_method_no());
										tvo.setInst_no(tmp.getTest_inst_no());
										tvo.setUser_id(vo.getUser_id());											
										
										int cnt = testReportDAO.selectTestReportCount(tvo); // ????????? ??????????????? ????????? ??????
										// ??????????????? ?????????
										if(cnt == 0){
											testReportDAO.insertTestReport(tvo);
										}
										/* ??????(15.11.04) ???*/
										i++;
									}
									acceptDAO.updateAcceptFee(vo);
								}
							} else if ("d".equals(crud)) {
								acceptDAO.deleteAcceptSample(map);
								/* AUDIT_TRAIL */
								map.put("at_proc", "????????????");
								auditTrailDAO.insertAuditTrail(map);
								AcceptVO a = new AcceptVO();
								a.setTest_req_seq(map.get("test_req_seq"));
								a.setTest_sample_seq(map.get("test_sample_seq"));
								acceptDAO.deleteAcceptItem(a);
								acceptDAO.deleteTestReport(a); // ???????????? ??????
								acceptDAO.updateAcceptFee(a);
							} else if ("u".equals(crud)) {
								acceptDAO.updateAcceptSample(map);
								/* AUDIT_TRAIL */
								map.put("at_proc", "????????????");
								auditTrailDAO.insertAuditTrail(map);
							}
						}
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int deleteItemGrid(AcceptVO vo) throws Exception {
		try {
			String[] test_item_seq_arr = vo.getTest_item_seq().split(",", -1);
			String[] test_item_cd_arr = vo.getTest_item_cd().split(",", -1);
			 
			if (test_item_seq_arr.length > 0) {
				for (String test_item_seq : test_item_seq_arr) {
					vo.setTest_item_seq(test_item_seq);
					acceptDAO.deleteAcceptItem(vo);
				}
				for (String test_item_cd : test_item_cd_arr) {
					vo.setTest_item_cd(test_item_cd);
					acceptDAO.deleteTestReport(vo); // ?????? ??????????????? ??????
					/* AUDIT_TRAIL */
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("worker_id", vo.getUser_id()); // ????????????????????? ????????? ??????
					map.put("menu_cd", vo.getMenu_cd()); // ???????????? ??????
					map.put("at_ip", SessionCheck.getUserIp()); // ????????????????????? ????????? ??????
					map.put("test_item_cd", test_item_cd);
					map.put("test_req_seq", vo.getTest_req_seq());
					map.put("test_sample_seq", vo.getTest_sample_seq());
					map.put("crud", "d");
					map.put("at_proc", "????????????");
					map.put("at_cont", map.toString()); // ??????????????? ??????
					auditTrailDAO.insertAuditTrail(map);
					map.put("test_item_cd", "");
				}
				acceptDAO.updateSampleItemCount(vo);
				acceptDAO.updateAcceptFee(vo);
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	
	/**
	 * ?????? > ?????? ????????? ??????????????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int selectCommissionGrid(AcceptVO vo) throws Exception {
		try {
			acceptDAO.updateSampleItemCount(vo);
			acceptDAO.updateAcceptFee(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	
	/**
	 * ?????? > ?????? ????????? ?????? ?????? ( ?????? ???????????? ?????? )
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertItemGrid(AcceptVO vo) throws Exception {
		try {
			TestReportVO tvo = new TestReportVO();
			HashMap<String, String> map = new HashMap<String, String>();			
			map.put("user_id", vo.getUser_id());
			
			/* ???????????? */
			String tmp_test_sample_seq = vo.getTest_sample_seq();
			String tmp_test_req_no = vo.getTest_req_no();
			String tmp_prdlst_cd = vo.getPrdlst_cd();
			String tmp_prdlst_nm = vo.getPrdlst_nm();
			String tmp_test_std_no = vo.getTest_std_no();
			String tmp_test_req_seq = vo.getTest_req_seq();
			String tmp_type = "";
			
			/*if (vo.getPageType().equals("receipt")){
				map.put("state", "A"); // ??????
			} else {
				map.put("state", "Z"); // ??????
			}*/
			
			map.put("state", "A");
			
			// ???????????? ??????
			map.put("test_req_no", tmp_test_req_no);
			// ??????SEQ ??????
			map.put("test_req_seq", tmp_test_req_seq);

			if (tmp_test_sample_seq == null || tmp_test_sample_seq.trim() == "" || tmp_test_sample_seq.trim().equals("")){ // ????????????
				tmp_test_sample_seq = acceptDAO.selectAcceptSampleSeq(map);
				tmp_type = "insert" ; 
			} else {
				tmp_test_sample_seq = vo.getTest_sample_seq();
			}
			//???????????? ??????
			map.put("test_sample_seq", tmp_test_sample_seq);
			tvo.setTest_sample_seq(tmp_test_sample_seq);
			//??????????????????
			map.put("test_std_no", tmp_test_std_no);
			map.put("std_dept_cd", vo.getStd_dept_cd()); // ????????????
			map.put("std_dept_nm", vo.getStd_dept_nm()); // ???????????????
			
			// ??????(??????)??? ?????????????????? ?????? ????????? ?????? ????????????.
			// ?????? ?????? : vo.getTest_sample_seq() ??????????????? ?????????????????? UI??????????????? ??????????????? ??????????????? ?????? ???????????? ???????????? ???????????????
			// ????????? ????????? ?????? ????????? ????????????
			if (tmp_type == "insert"){
				map.put("prdlst_cd", tmp_prdlst_cd);//map.put("sample_cd", tmp_prdlst_cd); ?????????????????? ????????????
				if (vo.getType().equals("mfds")){
					map.put("kfda_yn", "Y");
					map.put("sample_reg_nm", "" + tmp_prdlst_nm);
				} else {
					map.put("kfda_yn", "N");
					map.put("sample_reg_nm", "" + tmp_prdlst_nm);
				}
				acceptDAO.insertAcceptSample(map);
			}
			
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					for (String column : columnArr) {
						String[] valueArr = column.split("?????????");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
							
							if(valueArr[0].equals("test_item_cd")){
								if(value != null && value != ""){
									tvo.setTest_item_cd(value);
								}
							}
							
							// ????????? ????????????
							if(valueArr[0].equals("test_method_no")){
								if(value != null && value != ""){
									tvo.setTest_method_no(value);
								}
							}
							
							// ????????? ????????????
							if(valueArr[0].equals("test_inst_no")){
								if(value != null && value != ""){
									tvo.setTest_inst_no(value);
								}
							}
						}
					}
					
					int cnt = testReportDAO.selectTestReportCount(tvo); // ????????? ??????????????? ????????? ??????
					// ??????????????? ?????????
					if(cnt == 0){
						tvo.setUser_id(vo.getUser_id());
						testReportDAO.insertTestReport(tvo);
					}					
					acceptDAO.insertAcceptItem(map);
				}
				
				/* ????????????????????? VO??? ????????? ?????? ????????? ????????????.
				 * VO??? ????????? ????????? MAP??? ??????????????? ??????????????? ???????????? ???????????? ????????? ??????
				 * updateSampleItemCount() ???   ????????? 3????????? ?????????????????? ?????? ??????
				 */
				vo.setTest_sample_seq(tmp_test_sample_seq);
				vo.setTest_req_no(tmp_test_req_no);
				
				acceptDAO.updateSampleItemCount(vo);// ????????????
				acceptDAO.updateAcceptFee(vo);
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	/**
	 * ?????? > ???????????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertEstimateItem(AcceptVO vo) throws Exception {
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("est_no", vo.getTest_sample_seq());
			map.put("user_id", vo.getUser_id());
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					for (String column : columnArr) {
						String[] valueArr = column.split("?????????");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
						}
					}
					acceptDAO.insertEstimateItem(map);
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? > ???????????? ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertInstRentItem(AcceptVO vo) throws Exception {
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("test_sample_seq", vo.getTest_sample_seq());
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					for (String column : columnArr) {
						String[] valueArr = column.split("?????????");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
						}
					}
					acceptDAO.insertInstRentItem(map);
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? > ?????????????????? ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int insertTestStdPrdItem(AcceptVO vo) throws Exception {
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("test_std_no", vo.getTest_std_no());
			map.put("rev_no", vo.getRev_no());
			map.put("user_id", vo.getUser_id());
			map.put("dept_cd", vo.getDept_cd());
			map.put("sel_dept_cd", vo.getSel_dept_cd()); /*???????????? ?????? ?????? ??????*/
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					for (String column : columnArr) {
						String[] valueArr = column.split("?????????");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
						}
					}
					map.put("user_id", vo.getUser_id());
					if(vo.getPageType().equals("FEE")){
						acceptDAO.insertTestStdItem(map);
					} else {
						acceptDAO.insertTestStdPrdItem(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? > ?????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateItemGrid(AcceptVO vo) throws Exception {
		try {
			acceptDAO.updateAcceptItem(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	
	/**
	 * ?????? > ?????? ????????? ?????? (15.12.28)
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateItemFeeGrid(AcceptVO vo) throws Exception {
		try {
			int tot = 0;

			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
								
								if(valueArr[0].equals("fee")){
									if(value != null && value != ""){
									}
								}
							}
						}
						map.put("user_id", vo.getUser_id());
						String crud = map.get("crud");
						if ("c".equals(crud)) {
							acceptDAO.insertAcceptItem(map);
							tot++;
						} else if ("d".equals(crud)) {
							acceptDAO.deleteAcceptItem(map);
						} else if ("u".equals(crud)) {
							acceptDAO.updateAcceptItem(map);
							tot++;
						}
					}
				}
			}
			vo.setTot_item_count(String.valueOf(tot));
			acceptDAO.updateAcceptSampleTot(vo);
			acceptDAO.updateAcceptFee(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	

	/**
	 * ?????? > ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	/*public int saveItemGrid(AcceptVO vo) throws Exception {
		try {
			int tot = 0;

			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					//System.out.println(row);
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							//System.out.println(column);
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("user_id", vo.getUser_id());
						String crud = map.get("crud");
						if ("c".equals(crud)) {
							acceptDAO.insertAcceptItem(map);
							tot++;
						} else if ("d".equals(crud)) {
							acceptDAO.deleteAcceptItem(map);
						} else {
							acceptDAO.updateAcceptItem(map);
							tot++;
						}
					}
				}
			}
			vo.setTot_item_count(String.valueOf(tot));
			acceptDAO.updateAcceptSampleTot(vo);
			acceptDAO.updateAcceptFee(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}*/

	/**
	 * ?????? > ????????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReqOrgVO> selectReqOrgList(ReqOrgVO vo) throws Exception {
		return acceptDAO.selectReqOrgList(vo);
	}

	/**
	 * ?????? > ??????/?????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return HashMap
	 * @exception Exception
	 */
	public HashMap<String, Integer> itemCalculate(AcceptVO vo) throws Exception {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		try {
			int sampleCnt = 0;
			int itemCnt = 0;
			int feeTotal = 0;
			ArrayList<AcceptVO> lst = (ArrayList<AcceptVO>) acceptDAO.selectSampleItemCount(vo);
			if (lst != null && lst.size() > 0) {
				for (AcceptVO s : lst) {
					sampleCnt++;
					if (s != null) {
						String c = s.getTot_item_count();
						feeTotal += Integer.parseInt(s.getSample_fee());
						itemCnt += Integer.parseInt(c);
					}
				}
			}
			map.put("feeTotal", feeTotal);
			map.put("sampleCnt", sampleCnt);
			map.put("itemCnt", itemCnt);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return HashMap
	 * @exception Exception
	 */
	public AcceptVO selectFeeTotal(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.selectFeeTotal(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public List<String> updateAcceptState(AcceptVO vo) throws Exception {
		try {
			int s = acceptDAO.checkSampleCount(vo);
			// ????????? ?????????
			if (s == 0) {
				List<String> c = new ArrayList<String>();
				c.add("2");
				return c;
			}
			List<String> c = acceptDAO.checkSampleItemCount(vo);
			
			// ????????? ????????? ????????????
			if (c != null && c.size() > 0) {
				
			} else {
				//???????????? ???????????? ??????
				List<String> u = acceptDAO.checkSampleItemUser(vo);
				if (u != null && u.size() > 0) {
					u.add("3");
					return u;
				}
				
				if(vo.getState() == "" || vo.getState() == null || vo.getState().trim().equals("")){
					if ("receipt".equals(vo.getType())) {
						vo.setState("A");
					} else {
						vo.setState("B");
					}
				}
				//|| tmp_test_sample_seq.trim().equals("")
				acceptDAO.updateAcceptState(vo);
				List<String> seqList = commonDAO.selectSampleSeqList(vo.getTest_req_seq());
				if (seqList != null && seqList.size() > 0) {
					for (String seq : seqList) {
						HistoryVO historyVO = new HistoryVO();
						historyVO.setTest_sample_seq(seq);
						if(vo.getSample_state() != null && vo.getSample_state() != "" &&  !vo.getSample_state().trim().equals("") ){
							historyVO.setSample_state(vo.getSample_state());
						} else {
							historyVO.setSample_state(vo.getState());
						}
						historyVO.setDept_cd(vo.getDept_cd());
						historyVO.setTest_dept_cd(vo.getDept_cd());
						historyVO.setUser_id(vo.getUser_id());
						historyVO.setTest_req_seq(vo.getTest_req_seq());
						commonDAO.insertSampleHistory(historyVO);
					}
				}
				
				/* AUDIT_TRAIL START*/
				HashMap<String, String> map = new HashMap<String, String>();
				String data = ConverObjectToMap.conver(vo).toString();
				log.debug("Log[Lims AUDIT TRAIL] :" + data);
				map.put("crud", "u");
				map.put("at_cont", data); // ??????????????? ??????
				map.put("menu_cd", vo.getMenu_cd()); // ???????????? ??????
				map.put("worker_id", vo.getUser_id()); // ????????????????????? ????????? ??????
				map.put("test_req_no", vo.getTest_req_no()); // ???????????? ??????(????????????)
				map.put("worker_id", vo.getUser_id()); // ????????????????????? ????????? ??????
				map.put("at_ip", SessionCheck.getUserIp()); // ????????????????????? ????????? ??????
				map.put("test_req_seq", vo.getTest_req_seq()); // ??????????????????
				//map.put("test_sample_seq", "TEST_SAMPLE_SEQ"); // ???????????? ??????(????????????)
				
				// ?????? -> ??????
				
				if(vo.getState() == "Z" || vo.getState().equals("Z")){
					map.put("at_proc", "????????????");
				// ???????????? -> ????????????
				} else {
					vo.setRec_req_no(vo.getTest_req_no());
					map.put("at_proc", "????????????");
/*					
					//SMS ??????
		        	SmsVO searchVO = new SmsVO();
		        	searchVO.setTest_req_seq(vo.getTest_req_seq());
		        	SmsVO tagetVO = smsService.selectSmsTarget(searchVO);
		        	//????????????
		            if(tagetVO.getSms_flag() !=null && tagetVO.getSms_flag().equals("Y")){												
						Sms sms = new Sms();
						tagetVO.setProcess("A");				
						String custom_message = smsService.selectSmsCont(tagetVO);
						tagetVO.setCustom_msg(custom_message);			
						
						SmsVO returnVO = sms.SmsSend(tagetVO);
			        	smsService.insertSmsLog(returnVO);
		            }*/
				}				
				auditTrailDAO.insertAuditTrail(map);
				/* AUDIT_TRAIL END*/
				
				
				// ?????? -> ???????????????
				acceptDAO.updateItemSeq(vo); // ???????????? ??????
				acceptDAO.updateSampleSeq(vo); // ???????????? ??????
				acceptDAO.updateAcceptSeq(vo); // ???????????? ??????
				
				if ("accept".equals(vo.getType())) {
					/* ??????????????? ???????????? ????????? */
					ArrayList<AcceptVO> l = (ArrayList<AcceptVO>) acceptDAO.selectAcceptItemState(vo);
					if (l != null && l.size() > 0) {
						for (AcceptVO a : l) {
							Object dept_Cd = a.getDept_cd();
							if (dept_Cd != null) {
								if (!"".equals(dept_Cd) && vo.getDept_cd() != null && !"".equals(vo.getDept_cd())) {
									if (vo.getDept_cd().equals(dept_Cd)) {
										a.setColla_flag("N");
									} else {
										a.setColla_flag("Y");
									}
								}
							}
							acceptDAO.updateAcceptItemState(a); // ?????? STATE ??????
							
							/* ??????(15.11.04) - ???????????? ??????????????? ?????? ??? ?????? ?????? */
							// ???????????? -> ????????????
							int cnt = testReportDAO.selectTestReportCount(a); // ????????? ??????????????? ????????? ??????
							
							// ??????????????? ?????????
							if(cnt == 0){							
								if(vo.getState() == "B" || vo.getState().equals("B")){
									a.setUser_id(vo.getUser_id());
									acceptDAO.insertTestReport(a); // ??????????????? ??????
								}
							}
							/* ??????(15.11.04) ???*/
							
							/* AUDIT_TRAIL START*/
							data = ConverObjectToMap.conver(a).toString();
							log.debug("Log[Lims AUDIT TRAIL] :" + ConverObjectToMap.conver(a).toString());
							map.put("crud", "u");
							map.put("at_cont", data); // ??????????????? ??????
							map.put("menu_cd", vo.getMenu_cd()); // ???????????? ??????
							map.put("worker_id", vo.getUser_id()); // ????????????????????? ????????? ??????
							map.put("test_req_no", vo.getTest_req_no()); // ???????????? ??????(????????????)
							map.put("at_ip", SessionCheck.getUserIp()); // ????????????????????? ????????? ??????
							map.put("at_proc", "??????????????????("+vo.getState()+")");
							map.put("test_sample_seq", vo.getTest_sample_seq()); // ???????????? ??????(????????????)
							auditTrailDAO.insertAuditTrail(map);
							/* AUDIT_TRAIL END*/
						}
						
						int cntChk = commissionCheckDAO.selectCommissionDepositCount(vo); // ????????? ???????????? ????????? ??????
						
						// ????????? ????????? ???????????? ?????????
						if(cntChk == 0){
							if(vo.getState() == "B" || vo.getState().equals("B")){
								acceptDAO.insertCommissionDeposit(vo); // ????????? ????????? ???????????? ??????
							}
						}
					}
				}
				c = new ArrayList<String>();
				c.add("1");		
			}
			return c;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int returnAcceptState(AcceptVO vo) throws Exception {
		try {
			acceptDAO.returnAcceptState(vo);
			/* AUDIT_TRAIL START*/
			String data = ConverObjectToMap.conver(vo).toString();
			HashMap<String, String> map = new HashMap<String, String>();
			log.debug("Log[Lims AUDIT TRAIL] :" + data);
			map.put("crud", "u");
			map.put("at_cont", data); // ??????????????? ??????
			map.put("menu_cd", vo.getMenu_cd()); // ???????????? ??????
			map.put("worker_id", vo.getUser_id()); // ????????????????????? ????????? ??????
			map.put("test_req_no", vo.getTest_req_no()); // ???????????? ??????(????????????)
			map.put("at_proc", "????????????");
			map.put("at_ip", SessionCheck.getUserIp()); // ????????????????????? ????????? ??????
			//map.put("test_sample_seq", "TEST_SAMPLE_SEQ"); // ???????????? ??????(????????????)
			auditTrailDAO.insertAuditTrail(map);
			/* AUDIT_TRAIL END*/
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ????????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectTempleteSampleList(AcceptVO vo) throws Exception {
		return acceptDAO.selectTempleteSampleList(vo);
	}

	/**
	 * ?????? > ???????????? ?????? ?????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> selectTempleteItemList(AcceptVO vo) throws Exception {
		return acceptDAO.selectTempleteItemList(vo);
	}

	/**
	 * ?????? > ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	public String insertTemplete(AcceptVO vo) throws Exception {
		try {
			String cd = acceptDAO.selectTempleteCd();
			vo.setSample_temp_cd(cd);
			acceptDAO.insertTemplete(vo);
			return cd;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateTemplete(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.updateTemplete(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ?????? > ????????? ??? ?????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveTemplete(AcceptVO vo) throws Exception {
		try {
			acceptDAO.deleteTempleteItem(vo);

			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("user_id", vo.getUser_id());
						map.put("sample_temp_cd", vo.getSample_temp_cd());
						acceptDAO.insertTempleteItem(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public List<AcceptVO> selectPopAllTestItemList(AcceptVO vo) throws Exception {
		return acceptDAO.selectPopAllTestItemList(vo);
	}
	
	public List<AcceptVO> selectPopStdTestItemList(AcceptVO vo) throws Exception {
		return acceptDAO.selectPopStdTestItemList(vo);
	}

	public int deleteAccept(AcceptVO vo) throws Exception {
		try {
			acceptDAO.deleteAccept(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public String copyAccept(AcceptVO vo) throws Exception {
		try {
			/*if (vo.getPageType().equals("receipt")){
				vo.setState("A"); // ??????
			} else {
				vo.setState("Z"); // ??????
			}*/
			String reqSeq = acceptDAO.selectReqSeq();
			vo.setNew_test_req_seq(reqSeq);
			vo.setState("A"); // ??????
			acceptDAO.copyAccept(vo);
			return reqSeq;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public String retestAccept(AcceptVO vo) throws Exception {
		try {
			/*if (vo.getPageType().equals("receipt")){
				vo.setState("A"); // ??????
			} else {
				vo.setState("Z"); // ??????
			}*/
			vo.setState("A");
			acceptDAO.retestAccept(vo);
			return "";
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? > ??? ???????????????
	 * 
	 * @param AcceptVO
	 * @return List
	 * @exception Exception
	 */
	public List<AcceptVO> teamListPop(AcceptVO vo) throws Exception {
		return acceptDAO.teamListPop(vo);
	}
	
	/**
	 * ?????? >  ????????????????????? ???????????????????????? ????????????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public AcceptVO bizFileDown(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.bizFileDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * ?????? >  ????????? ?????? ?????? ?????? 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public List<AcceptVO> selectSampleFileList(AcceptVO vo) throws Exception {
		return acceptDAO.selectSampleFileList(vo);
	}
	
	/**
	 * ?????? >  ????????? ?????? ?????? ?????? 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public List<AcceptVO> selectSampleItemFileList(AcceptVO vo) throws Exception {
		return acceptDAO.selectSampleItemFileList(vo);
	}
	
	/**
	 * ?????? >  ????????? ?????? ?????? ?????? 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public List<AcceptVO> selectRequestFileList(AcceptVO vo) throws Exception {
		return acceptDAO.selectRequestFileList(vo);
	}
	
	/**
	 * ?????? >  ????????? ???????????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public AcceptVO sampleFilePop(AcceptVO vo) {
		try {
			return acceptDAO.sampleFilePop(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int insertSampleFile(AcceptVO vo) throws Exception {
		try {			
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
				result = acceptDAO.insertSampleFile(vo);
			} else {
				if(vo.getFile_nm() != null && !vo.getFile_nm().equals("")) 
					result = acceptDAO.insertSampleFile(vo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int updateSampleFile(AcceptVO vo) throws Exception {
		try {			
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {				
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
					result = acceptDAO.updateSampleFile(vo);
			} else {				
				result = acceptDAO.updateSampleFile(vo);			
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int deleteSampleFile(AcceptVO vo) throws Exception {
		try {
			acceptDAO.deleteSampleFile(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ???????????? 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public AcceptVO sampleFileDown(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.sampleFileDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * ?????? >  ????????? ???????????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public AcceptVO itemFilePop(AcceptVO vo) {
		try {
			return acceptDAO.itemFilePop(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int insertItemFile(AcceptVO vo) throws Exception {
		try {			
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
				result = acceptDAO.insertItemFile(vo);
			} else {
				if(vo.getFile_nm() != null && !vo.getFile_nm().equals("")) 
					result = acceptDAO.insertItemFile(vo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int updateItemFile(AcceptVO vo) throws Exception {
		try {			
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {				
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
					result = acceptDAO.updateItemFile(vo);
			} else {				
				result = acceptDAO.updateItemFile(vo);			
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int deleteItemFile(AcceptVO vo) throws Exception {
		try {
			acceptDAO.deleteItemFile(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ???????????? 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public AcceptVO itemFileDown(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.itemFileDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * ?????? >  ????????? ???????????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public AcceptVO requestFilePop(AcceptVO vo) {
		try {
			return acceptDAO.requestFilePop(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int insertRequestFile(AcceptVO vo) throws Exception {
		try {			
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
				result = acceptDAO.insertRequestFile(vo);
			} else {
				if(vo.getFile_nm() != null && !vo.getFile_nm().equals("")) 
					result = acceptDAO.insertRequestFile(vo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int updateRequestFile(AcceptVO vo) throws Exception {
		try {			
			int result = 0;
			if (vo.getMul_file_att() != null && vo.getMul_file_att().getSize() > 0) {				
				vo.setFile_att(vo.getMul_file_att().getBytes());
				vo.setFile_nm(vo.getMul_file_att().getOriginalFilename());				
					result = acceptDAO.updateRequestFile(vo);
			} else {				
				result = acceptDAO.updateRequestFile(vo);			
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ?????? ??????
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public int deleteRequestFile(AcceptVO vo) throws Exception {
		try {
			acceptDAO.deleteRequestFile(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? >  ????????? ???????????? ???????????? 
	 * @param AcceptVO
	 * @throws Exception
	 */
	@Override
	public AcceptVO requestFileDown(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.requestFileDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	
	/**
	 * ?????? > ??????????????? ????????? ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public List<TestPrdStdVO> selectPopAllMfdsStdItemList(TestPrdStdVO vo) throws Exception {
		return acceptDAO.selectPopAllMfdsStdItemList(vo);
	}
	
	/**
	 * ?????? > ???????????? ????????? ?????? ????????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @throws Exception
	 */
	public List<AcceptVO> selectPopAllSelfStdItemList(AcceptVO vo) throws Exception {
		return acceptDAO.selectPopAllSelfStdItemList(vo);
	}
	
	
	/**
	 * ?????? > ?????? ????????? ????????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int saveItemMasterFee(AcceptVO vo) throws Exception {
		try {
			String[] test_item_cd_arr = vo.getTest_item_cd().split(",", -1);
			String[] dept_fee_arr = vo.getDept_fee().split(",", -1);
			String[] prdlst_fee_arr = vo.getPrdlst_fee().split(",", -1);
			 
			if (test_item_cd_arr.length > 0) {
				for(int i=0; i < test_item_cd_arr.length ; i++){	
					
					vo.setTest_item_cd(test_item_cd_arr[i]);
					vo.setDept_fee(dept_fee_arr[i]);
					vo.setPrdlst_fee(prdlst_fee_arr[i]);
					
					acceptDAO.saveItemMasterFee(vo); 
				}
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public AcceptVO selectFeeValue(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.selectFeeValue(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public CommissionCheckVO selectOrgUnpaid(CommissionCheckVO vo) throws Exception {
		try {
			return acceptDAO.selectOrgUnpaid(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	public List<AcceptVO> labelPrint(AcceptVO vo) {
		return acceptDAO.labelPrint(vo);
	}
//	/*sms_test*/
//	public AcceptVO smstest(AcceptVO vo) throws Exception{
//		try{
//
//			
//			
//			
//			//SMS ??????
//        	SmsVO searchVO = new SmsVO();
//        	searchVO.setTest_req_seq(vo.getTest_req_seq());
//        	SmsVO tagetVO = smsService.selectSmsTarget(searchVO);
//        	//????????????
//            if(tagetVO.getSms_flag().equals("Y")){
//				Sms sms = new Sms();
//				tagetVO.setProcess("A");				
//				String custom_message = smsService.selectSmsCont(tagetVO);
//				tagetVO.setCustom_msg(custom_message);			
//				
//				SmsVO returnVO = sms.SmsSend(tagetVO);
//	        	//smsService.insertSmsLog(returnVO);
//            }
//		}catch(Exception e){
//			e.printStackTrace();
//			throw e;
//		}
//		return vo;
//	}

	@Override
	public List<AcceptVO> getCollectCodeList(AcceptVO vo) {
		return acceptDAO.getCollectCodeList(vo);
	}
	
	
	/**
	 * ???????????? ????????? ?????? ?????? ??????
	 * 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int insertStdPLItem(TestStandardVO vo) throws Exception {
		try {
			acceptDAO.insertStdPLItem(vo);
			
			AcceptVO acceptVO = new AcceptVO();
			acceptVO.setTest_req_seq(vo.getTest_req_seq());
			acceptVO.setTest_sample_seq(vo.getTest_sample_seq());
			
			acceptDAO.updateGradeResetItem(acceptVO);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ???????????? ????????? ?????? ?????? ??????
	 * 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int updateStdItemGrid(AcceptVO vo) throws Exception {
		try {
			acceptDAO.updateStandardResetItem(vo);
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("user_id", vo.getUser_id());
						map.put("test_req_seq", vo.getTest_req_seq());
						map.put("test_sample_seq", vo.getTest_sample_seq());						
						acceptDAO.updateStdItemGrid(map);
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * ????????? ?????? ??????
	 * 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int insertGradeItemGrid(AcceptVO vo) throws Exception {
		try {
			acceptDAO.updateStandardResetItem(vo);
			acceptDAO.updateGradeResetItem(vo);
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("user_id", vo.getUser_id());
						map.put("test_req_seq", vo.getTest_req_seq());
						map.put("test_sample_seq", vo.getTest_sample_seq());
						acceptDAO.updateGradeItemGrid(map);
					}
				}
			}
			//?????? ???????????? ????????????
			acceptDAO.updateSampleMaxGrade(vo);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<TestPrdStdVO> selectPopAllSelfGradeItemList(AcceptVO vo) {
		return acceptDAO.selectPopAllSelfGradeItemList(vo);
	}
	
	/**
	 * ?????? > ??????????????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int savePretreatment(AcceptVO vo) throws Exception {
		try {
			int result = -1;
			//??????????????? ????????????
			result = acceptDAO.savePretreatmentSample(vo);
			//??????????????? ????????????
			result = acceptDAO.savePretreatmentReq(vo);
			return result;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	@Override
	
	
	/**
	 * ?????? > ????????? ???????????? ????????????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateFileDivision(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.updateFileDivision(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	
	
	/**
	 * ?????? > ????????? ?????? ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return int
	 * @exception Exception
	 */
	public int updateOrder(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.updateOrder(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int mailSend(HashMap<String, Object> param, HttpServletRequest request) {

		String uploadPath = request.getSession().getServletContext().getRealPath("/Temp") + "/";
		
		//??????
		String title = param.get("title").toString();
		//??????
		String contents = param.get("contents").toString();
		//?????????
		String est = param.get("est").toString();
		
		// ????????????
        String to = param.get("mailTo").toString();
        // ??????
        String cc = param.get("mailCc").toString();
        // ????????????
        String bcc = param.get("mailBcc").toString();
        // ???????????????
        String from = "analysis@dari.re.kr";
        // SMTP ??????
        String host = "smtps.hiworks.com";
        // Get system properties
        Properties properties = System.getProperties();
        // Setup mail server
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
        // Get the Session object.// and pass username and password
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("jyj@dari.re.kr", "rhaehfdl1429^^");
            }
        });
        // Used to debug SMTP issues
        session.setDebug(true);
        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);
            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));
            // ????????????
            message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            //??????
            message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(cc));
            //????????????
            message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc));
            // ??????
            message.setSubject(title);
            
            
            Multipart multipart = new MimeMultipart();
            
            /* ??????*/
            String data_server = propertyService.getString("rdReport.data_server");
            String reporting_server = propertyService.getString("rdReport.reporting_server");
            String report_mrd_path = propertyService.getString("rdReport.mrd_path");
            String rd_service_nm = propertyService.getString("rdReport.rd_service_nm");
            String report_id = propertyService.getString("rdReport.report_id");
    		String report_pw = propertyService.getString("rdReport.report_pw");
    		String report_download_path = propertyService.getString("rdReport.download_path");
    		
            String[] mrdPathLst = param.get("mrd_path").toString().trim().split("???");
            String[] mrdParamLst = param.get("mrd_param").toString().trim().split("???");
            
            char sep = (char)0x04;
            String mrd_param = "";
            String mrd_path = "";
            String reportServerParam = " /rfn ["+ data_server +"] /rchartopt [2] /rcontype [Data Server] /rsn ["+rd_service_nm+"] /rui [" + report_id + "] /rpw [" + report_pw + "]";
            for (int i=0; i<mrdParamLst.length; i++) {
        		mrd_param += sep + mrdParamLst[i].toString().trim() + reportServerParam;
        		mrd_path += sep + report_mrd_path + mrdPathLst[i].toString().trim();
            }
            
            ReportingServerInvoker invoker = new ReportingServerInvoker(reporting_server);
            invoker.setCharacterEncoding("euc-kr"); //????????????
		    invoker.setReconnectionCount(3);        //????????? ?????? ??????
		    invoker.setConnectTimeout(5);           //????????? ????????????
		    invoker.setReadTimeout(30);             //????????? ????????????
		    
		    invoker.addParameter("opcode", "500");
		    invoker.addParameter("mrd_path", mrd_path.substring(1));
			invoker.addParameter("mrd_param", mrd_param.substring(1));
			invoker.addParameter("export_type", "pdf");
			invoker.addParameter("export_name",param.get("fileNm").toString());
			invoker.addParameter("protocol", "sync");
			
			ArrayList<HashMap<String, Object>> result =  new ArrayList<HashMap<String, Object>>();
			
			String resp = invoker.invoke();   //???????????? ????????????
			HashMap<String, Object> tmpMap = new HashMap<String, Object>();
			tmpMap.put("fileNm", resp);
			tmpMap.put("downloadPath", report_download_path);
			result.add(tmpMap);
			
			String filePath = resp.substring(resp.lastIndexOf("|")+1);
			String fileUri = report_download_path + "/" + filePath;
/*			
			//??????????????????
			try (BufferedInputStream in = new BufferedInputStream(new URL(fileUri).openStream());
					FileOutputStream fileOutputStream = new FileOutputStream(uploadPath + param.get("fileNm").toString())) {
				byte dataBuffer[] = new byte[1024];
			    int bytesRead;
			    while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
			        fileOutputStream.write(dataBuffer, 0, bytesRead);
			    }
			} catch (IOException e) {
			    e.printStackTrace();
			}
			
    */        
			//PDF -> Image (?????????)
			String fileNm = param.get("fileNm").toString();
            String fileNmNoExt = fileNm.substring(0,fileNm.length()-4);
            int dpi = Integer.parseInt(param.get("dpi").toString());
            conversionPdf2Img(uploadPath + fileNm, fileNm, param.get("est").toString(), dpi, request);

            contents += "<img src='"+propertyService.getString("web.server_url")+"/Temp/" + fileNmNoExt + ".png' usemap='#imgMap'>";
            contents += "<map name='imgMap'><area shape='rect' coords='340,912,486,927' href='"+propertyService.getString("homePage_url")+"' target='_blank' alt='???????????????????????????'></map>";
            
            //????????? PDF ??????
           MimeBodyPart mimeBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(uploadPath + fileNm);
            mimeBodyPart.setDataHandler(new DataHandler(source));
            mimeBodyPart.setFileName(param.get("fileNm").toString());
            if(param.get("est").toString().equals("Y")){
            	multipart.addBodyPart(mimeBodyPart);
            } 
            
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(contents,"text/html; charset=utf-8");
            multipart.addBodyPart(messageBodyPart);
            message.setContent(multipart,"text/html; charset=utf-8");
            
            System.out.println("sending...");
            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
            return 1;
            
        } catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
        
	}

	@Override
	public int reportMailSend(HashMap<String, Object> param, MultipartHttpServletRequest request) throws Exception {

		String uploadPath = request.getSession().getServletContext().getRealPath("/Temp") + "/";
		
		//??????
		String title = request.getParameter("title").toString() + "\r\n" +request.getParameter("mailTitleAdd").toString().replaceAll("\r\n", "<br>");
		//??????
		String contents = request.getParameter("contents").toString() + "<br/><br/>" + request.getParameter("mailContents").toString().replaceAll("\r\n", "<br>");
		
		// ????????????
        String to = request.getParameter("mailTo").toString();
        // ??????
        String cc = request.getParameter("mailToCc").toString();
        // ????????????
        String bcc = request.getParameter("mailToBcc").toString();
        // ???????????????
        String from = "analysis@dari.re.kr";
        // SMTP ??????
        String host = "smtps.hiworks.com";
        // Get system properties
        Properties properties = System.getProperties();
        // Setup mail server
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
        // Get the Session object.// and pass username and password
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("jyj@dari.re.kr", "rhaehfdl1429^^");
            }
        });
        // Used to debug SMTP issues
        session.setDebug(true);
        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);
            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));
            // ????????????
            message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            //??????
            message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(cc));
            //????????????
            message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc));
            // ??????
            message.setSubject(title);
            
            
            Multipart multipart = new MimeMultipart();
            
            /*????????? ??????*/
            String data_server = propertyService.getString("rdReport.data_server");
            String reporting_server = propertyService.getString("rdReport.reporting_server");
            String report_mrd_path = propertyService.getString("rdReport.mrd_path");
            String rd_service_nm = propertyService.getString("rdReport.rd_service_nm");
            String report_id = propertyService.getString("rdReport.report_id");
    		String report_pw = propertyService.getString("rdReport.report_pw");
    		String report_download_path = propertyService.getString("rdReport.download_path");
    		
            String[] mrdPathLst = request.getParameter("mrd_path").split("???");
            String[] mrdParamLst = request.getParameter("mrd_param").split("???");
            
            char sep = (char)0x04;
            String mrd_param = "";
            String mrd_path = "";
            String reportServerParam = " /rfn ["+ data_server +"] /rchartopt [2] /rcontype [Data Server] /rsn ["+rd_service_nm+"] /rui [" + report_id + "] /rpw [" + report_pw + "]";
            for (int i=0; i<mrdParamLst.length; i++) {
        		mrd_param += sep + mrdParamLst[i].toString() + reportServerParam;
        		mrd_path += sep + report_mrd_path + mrdPathLst[i].toString();
            }
            
            ReportingServerInvoker invoker = new ReportingServerInvoker(reporting_server);
            invoker.setCharacterEncoding("euc-kr"); //????????????
		    invoker.setReconnectionCount(3);        //????????? ?????? ??????
		    invoker.setConnectTimeout(5);           //????????? ????????????
		    invoker.setReadTimeout(30);             //????????? ????????????
		    
		    invoker.addParameter("opcode", "500");
		    invoker.addParameter("mrd_path", mrd_path.substring(1));
			invoker.addParameter("mrd_param", mrd_param.substring(1));
			invoker.addParameter("export_type", "pdf");
			invoker.addParameter("export_name",request.getParameter("fileNm").toString());
			invoker.addParameter("protocol", "sync");
			
			ArrayList<HashMap<String, Object>> result =  new ArrayList<HashMap<String, Object>>();
			
			String resp = invoker.invoke();   //???????????? ????????????
			HashMap<String, Object> tmpMap = new HashMap<String, Object>();
			tmpMap.put("fileNm", resp);
			tmpMap.put("downloadPath", report_download_path);
			result.add(tmpMap);
			
			String filePath = resp.substring(resp.lastIndexOf("|")+1);
			String fileUri = report_download_path + "/" + filePath;
	/*		
			//??????????????????
			try (BufferedInputStream in = new BufferedInputStream(new URL(fileUri).openStream());
					FileOutputStream fileOutputStream = new FileOutputStream(uploadPath + request.getParameter("fileNm").toString())) {
				byte dataBuffer[] = new byte[1024];
			    int bytesRead;
			    while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
			        fileOutputStream.write(dataBuffer, 0, bytesRead);
			    }
			} catch (IOException e) {
			    e.printStackTrace();
			}
			
 */           
            //????????? PDF ??????
            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(uploadPath + request.getParameter("fileNm").toString());
            mimeBodyPart.setDataHandler(new DataHandler(source));
            mimeBodyPart.setFileName(request.getParameter("fileNm").toString());
            multipart.addBodyPart(mimeBodyPart);
            
            //???????????? ????????? ??????
            List<MultipartFile> mailAttachs = request.getFiles("mailAttach");
            for (MultipartFile mf : mailAttachs) {
            	if (!mf.isEmpty()) {
            		String originFileName = mf.getOriginalFilename(); // ?????? ?????? ???
                    //long fileSize = mf.getSize(); // ?????? ?????????
                    String safeFile = uploadPath + System.currentTimeMillis() + originFileName;
                    mf.transferTo(new File(safeFile));
                    
                    //????????? ????????????
                    MimeBodyPart mimeBodyPartAtt = new MimeBodyPart();
                    DataSource sourceAtt = new FileDataSource(safeFile);
                    mimeBodyPartAtt.setDataHandler(new DataHandler(sourceAtt));
                    mimeBodyPartAtt.setFileName(originFileName);
                    multipart.addBodyPart(mimeBodyPartAtt);	
            	}
            }
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(contents,"text/html; charset=utf-8");
            multipart.addBodyPart(messageBodyPart);
            message.setContent(multipart,"text/html; charset=utf-8");
            
            System.out.println("sending...");
            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
            return 1;
            
        } catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	private void conversionPdf2Img(String filePath, String fileName, String estChk, int dpi, HttpServletRequest request) {
        try {
        	File pdfFile = new File(filePath); 
            PDDocument pdfDoc = PDDocument.load(pdfFile); //Document ??????
            PDFRenderer pdfRenderer = new PDFRenderer(pdfDoc);
            String uploadPath = request.getSession().getServletContext().getRealPath("/Temp");
            String fileNameNoExt = fileName.substring(0,fileName.length()-4);
            
            //????????? ??????????????? 
            String imgFileName = uploadPath + "/" + fileNameNoExt + ".png";
	        //DPI ??????
            BufferedImage bim = pdfRenderer.renderImageWithDPI(0, dpi, ImageType.RGB);
            // ???????????? ?????????.
            ImageIOUtil.writeImage(bim, imgFileName , dpi);
                
            //????????? ???????????? ????????? ???????????? ???????????? PDF??? ??????
            if (estChk.equals("Y")) {
            	pdfDoc.removePage(0);
                pdfDoc.save(uploadPath + "/" + fileNameNoExt + ".pdf");	
            }
            pdfDoc.close(); //?????? ????????? PDF ????????? ?????????.
        }
        catch (Exception e) {
        	e.printStackTrace();
        }
    }

	/**
	 * ???????????? ????????? ?????? ?????? ??????
	 * 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int insertStdItemGrid(AcceptVO vo) throws Exception {
		try {
			TestReportVO tvo = new TestReportVO();
			HashMap<String, String> map = new HashMap<String, String>();			
			map.put("user_id", vo.getUser_id());
			
			/* ???????????? */
			String tmp_test_sample_seq = "";
			String tmp_test_req_no = vo.getTest_req_no();
			String tmp_test_req_seq = vo.getTest_req_seq();
			String tmp_prdlst_cd = vo.getPrdlst_cd();
			String tmp_sm_code = vo.getSm_code();
			
			map.put("state", "A");
			map.put("test_req_seq", tmp_test_req_seq);
			map.put("prdlst_cd", tmp_prdlst_cd);
			map.put("sm_code", tmp_sm_code);

			tmp_test_sample_seq = acceptDAO.selectAcceptSampleSeq(map);
			
			//???????????? ??????
			map.put("test_sample_seq", tmp_test_sample_seq);
			map.put("kfda_yn", "N");
			tvo.setTest_sample_seq(tmp_test_sample_seq);
			//??????????????????
			map.put("result_input_type", "C85001"); //????????????
			// ??????(??????)??? ?????????????????? ?????? ????????? ?????? ????????????.
			// ?????? ?????? : vo.getTest_sample_seq() ??????????????? ?????????????????? UI??????????????? ??????????????? ??????????????? ?????? ???????????? ???????????? ???????????????
			// ????????? ????????? ?????? ????????? ????????????
			acceptDAO.insertAcceptSample(map);
			
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					for (String column : columnArr) {
						String[] valueArr = column.split("?????????");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
							
							if(valueArr[0].equals("testitm_cd")){
								if(value != null && value != ""){
									tvo.setTest_item_cd(value);
								}
							}
							// ????????? ????????????
							if(valueArr[0].equals("test_method_no")){
								if(value != null && value != ""){
									tvo.setTest_method_no(value);
								}
							}
							// ????????? ????????????
							if(valueArr[0].equals("test_inst_no")){
								if(value != null && value != ""){
									tvo.setTest_inst_no(value);
								}
							}
						}
					}
					
					int cnt = testReportDAO.selectTestReportCount(tvo); // ????????? ??????????????? ????????? ??????
					// ??????????????? ?????????
					if(cnt == 0){
						tvo.setUser_id(vo.getUser_id());
						testReportDAO.insertTestReport(tvo);
					}					
					acceptDAO.insertAcceptStdItem(map);
				}
				
				/* ????????????????????? VO??? ????????? ?????? ????????? ????????????.
				 * VO??? ????????? ????????? MAP??? ??????????????? ??????????????? ???????????? ???????????? ????????? ??????
				 * updateSampleItemCount() ???   ????????? 3????????? ?????????????????? ?????? ??????
				 */
				vo.setTest_sample_seq(tmp_test_sample_seq);
				vo.setTest_req_no(tmp_test_req_no);
				
				tvo.setTest_req_seq(tmp_test_req_seq);
				
				acceptDAO.updateSampleItemCount(vo);// ????????????
				acceptDAO.updateAcceptFee(tvo);
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? ????????? ?????? ?????? ??????
	 * 
	 * @param TestStandardVO
	 * @return int
	 * @exception Exception
	 */	
	@Override
	public int insertGrdItemGrid(AcceptVO vo) throws Exception {
		try {
			TestReportVO tvo = new TestReportVO();
			HashMap<String, String> map = new HashMap<String, String>();			
			map.put("user_id", vo.getUser_id());
			
			/* ???????????? */
			String tmp_test_sample_seq = "";
			String tmp_test_req_no = vo.getTest_req_no();
			String tmp_test_req_seq = vo.getTest_req_seq();
			String tmp_prdlst_cd = vo.getPrdlst_cd();
			String tmp_max_grade = vo.getMax_grade();
			
			map.put("state", "A");
			map.put("test_req_seq", tmp_test_req_seq);
			map.put("prdlst_cd", tmp_prdlst_cd);
			map.put("max_grade", tmp_max_grade);

			tmp_test_sample_seq = acceptDAO.selectAcceptSampleSeq(map);
			
			//???????????? ??????
			map.put("test_sample_seq", tmp_test_sample_seq);
			map.put("kfda_yn", "N");
			tvo.setTest_sample_seq(tmp_test_sample_seq);
			//??????????????????
			map.put("result_input_type", "C85002"); //????????????
			// ??????(??????)??? ?????????????????? ?????? ????????? ?????? ????????????.
			// ?????? ?????? : vo.getTest_sample_seq() ??????????????? ?????????????????? UI??????????????? ??????????????? ??????????????? ?????? ???????????? ???????????? ???????????????
			// ????????? ????????? ?????? ????????? ????????????
			acceptDAO.insertAcceptSample(map);
			
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					for (String column : columnArr) {
						String[] valueArr = column.split("?????????");
						if (valueArr != null) {
							String value = "";
							if (valueArr.length != 1) {
								value = valueArr[1];
							}
							map.put(valueArr[0], value);
							
							if(valueArr[0].equals("testitm_cd")){
								if(value != null && value != ""){
									tvo.setTest_item_cd(value);
								}
							}
							// ????????? ????????????
							if(valueArr[0].equals("test_method_no")){
								if(value != null && value != ""){
									tvo.setTest_method_no(value);
								}
							}
							// ????????? ????????????
							if(valueArr[0].equals("test_inst_no")){
								if(value != null && value != ""){
									tvo.setTest_inst_no(value);
								}
							}
						}
					}
					
					int cnt = testReportDAO.selectTestReportCount(tvo); // ????????? ??????????????? ????????? ??????
					// ??????????????? ?????????
					if(cnt == 0){
						tvo.setUser_id(vo.getUser_id());
						testReportDAO.insertTestReport(tvo);
					}					
					acceptDAO.insertAcceptGrdItem(map);
				}
				
				/* ????????????????????? VO??? ????????? ?????? ????????? ????????????.
				 * VO??? ????????? ????????? MAP??? ??????????????? ??????????????? ???????????? ???????????? ????????? ??????
				 * updateSampleItemCount() ???   ????????? 3????????? ?????????????????? ?????? ??????
				 */
				vo.setTest_sample_seq(tmp_test_sample_seq);
				vo.setTest_req_no(tmp_test_req_no);
				tvo.setTest_req_seq(tmp_test_req_seq);
				
				acceptDAO.updateSampleItemCount(vo);// ????????????
				acceptDAO.updateAcceptFee(tvo);
			}
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * ?????? > ?????? ??????
	 * 
	 * @param AcceptVO
	 * @return String
	 * @exception Exception
	 */
	
	public int updateReqSampleMessage(AcceptVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("?????????");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("?????????");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						
						for (String column : columnArr) {
							String[] valueArr = column.split("?????????");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						
						acceptDAO.updateReqSampleMessage(map); 
					}
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//????????????????????? ??????
	public List<AcceptVO> selectReportOrder(AcceptVO vo) throws Exception {
		try {
			return acceptDAO.selectReportOrder(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//????????? ???????????? ??? ?????? ??????
	public String copyPieceAccept(AcceptVO vo) throws Exception {
		try {
			/*if (vo.getPageType().equals("receipt")){
				vo.setState("A"); // ??????
			} else {
				vo.setState("Z"); // ??????
			}*/
			String reqSeq = acceptDAO.selectReqSeq();
			vo.setNew_test_req_seq(reqSeq);
			vo.setState("A"); // ??????
			acceptDAO.copyPieceAccept(vo);
			return reqSeq;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

}
