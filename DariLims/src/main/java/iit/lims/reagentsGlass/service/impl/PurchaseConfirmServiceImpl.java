package iit.lims.reagentsGlass.service.impl;

import iit.lims.reagentsGlass.dao.PurchaseConfirmDAO;
import iit.lims.reagentsGlass.service.PurchaseConfirmService;
import iit.lims.reagentsGlass.vo.ReagentsGlassVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class PurchaseConfirmServiceImpl extends EgovAbstractServiceImpl implements PurchaseConfirmService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "purchaseConfirmDAO")
	private PurchaseConfirmDAO purchaseConfirmDAO;

	/**
	 * 구매확정용 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> purchaseInfoList(ReagentsGlassVO vo) throws Exception {
		return purchaseConfirmDAO.purchaseInfoList(vo);
	}

	/**
	 * 구매확정용 구매요청 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public List<ReagentsGlassVO> purchaseReqList(ReagentsGlassVO reagentsGlassVO) throws Exception {
		return purchaseConfirmDAO.purchaseReqList(reagentsGlassVO);
	}

	/**
	 * 구매확정 목록 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int savePurchaseConfirm(ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			String[] rowArr = reagentsGlassVO.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				// 줄수 만큼 for
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						// 컬럼 만큼 for
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1]; // 그리드 컬럼 값
								}
								map.put(valueArr[0], value); // 그리드 컬럼 name

								//System.out.println("컬럼:"+ valueArr[0]);
								//System.out.println("값:"+ value);
								map.put("mtlr_mst_no", reagentsGlassVO.getMtlr_mst_no()); // 구매번호
								map.put("create_dept", reagentsGlassVO.getCreate_dept()); // 부서
								map.put("creater_id", reagentsGlassVO.getUser_id()); // 유저
							}
						}

						String crud = map.get("crud");

						if ("c".equals(crud)) {
							purchaseConfirmDAO.insertPurchaseConfirm(map);
						} else if ("d".equals(crud)) {
							purchaseConfirmDAO.deletePurchaseConfirm(map);
						} else {
							purchaseConfirmDAO.updatePurchaseConfirm(map);
						}
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
	 * 구매요청 목록 확정 처리(시약/실험기구정보 수불 저장)
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public String purchaseConfirm(ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			ReagentsGlassVO ret = purchaseConfirmDAO.checkPurchaseConfirmValue(reagentsGlassVO);
			if (ret != null) {
				return ret.getItem_nm() + "◆★◆" + ret.getFix_qty() + "◆★◆" + ret.getCost() + "◆★◆" + ret.getMtlr_req_no();
			} else {
				purchaseConfirmDAO.updatePurchaseInfoConfirm(reagentsGlassVO);

				//purchaseConfirmDAO.insertReceivePay(map); 				// 수불 테이블에 저장
				//System.out.println("구매확정번호: " + reagentsGlassVO.getMtlr_cnfr_no());
				purchaseConfirmDAO.updateStatePurchaseConfirm(reagentsGlassVO); // 구매 확정 테이블에 '진행상태' -> 구매확정으로 변경
				//System.out.println("시약/실험기기: " + reagentsGlassVO.getMtlr_no());
				purchaseConfirmDAO.updateReagentsGlassInfoMaster(reagentsGlassVO); // 시약/실험기기는 마스터로 변경

				return "1";
			}
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public Workbook excelDownloadPurchaseConfirm(ReagentsGlassVO vo) throws Exception {
		Workbook wb = null;
		try {
			List<ReagentsGlassVO> lst = purchaseConfirmDAO.purchaseReqList(vo);

			wb = new XSSFWorkbook();
			XSSFSheet sheet = (XSSFSheet) wb.createSheet("Sheet1");
			XSSFRow row = sheet.createRow(0);
			Font font = wb.createFont();
			font.setBoldweight(Font.BOLDWEIGHT_BOLD); //글씨 bold

			XSSFCellStyle titleStyle = (XSSFCellStyle) wb.createCellStyle();
			titleStyle.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex());
			titleStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			titleStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			titleStyle.setFont(font);
			titleStyle.setLocked(true);

			XSSFCellStyle dataStyle = (XSSFCellStyle) wb.createCellStyle();
			dataStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			dataStyle.setLocked(true);

			XSSFCellStyle dataStyle2 = (XSSFCellStyle) wb.createCellStyle();
			dataStyle2.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			dataStyle2.setLocked(true);

			XSSFCellStyle dataStyle3 = (XSSFCellStyle) wb.createCellStyle();
			dataStyle3.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			dataStyle3.setLocked(true);

			XSSFCellStyle inputStyle = (XSSFCellStyle) wb.createCellStyle();
			inputStyle.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.getIndex());
			inputStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			inputStyle.setAlignment(XSSFCellStyle.ALIGN_RIGHT);

			String[] arr = new String[16];
			arr[0] = "마스터여부";
			arr[1] = "대분류";
			arr[2] = "중분류";
			arr[3] = "시약/실험기구명";
			arr[4] = "요청부서";
			arr[5] = "요청수량";
			arr[6] = "확정수량";
			arr[7] = "단가(원)";
			arr[8] = "규격1";
			arr[9] = "규격2";
			arr[10] = "규격기타";
			arr[11] = "단위";
			arr[12] = "용도";
			arr[13] = "비고";
			arr[14] = "MTLR_MST_NO";
			arr[15] = "MTLR_REQ_NO";
			XSSFCell cell = null;
			int c = 0;
			for (String s : arr) {
				cell = row.createCell(c);
				cell.setCellValue(s);
				cell.setCellStyle(titleStyle);
				if (c == 3 || c == 8 || c == 9 || c == 10 || c == 12 || c == 13) {
					sheet.setColumnWidth(c, 7000);
				} else if (c == 14 || c == 15) {
					sheet.setColumnHidden(c, true);
				} else {
					sheet.setColumnWidth(c, 3000);
				}
				c++;
			}

			if (lst != null && lst.size() > 0) {
				c = 1;
				for (ReagentsGlassVO r : lst) {
					String[] dataArr = new String[16];
					dataArr[0] = r.getMaster_yn();
					dataArr[1] = r.getH_mtlr_info();
					dataArr[2] = r.getM_mtlr_info();
					dataArr[3] = r.getItem_nm();
					dataArr[4] = r.getDept_nm();
					dataArr[5] = String.valueOf(r.getReq_qty());
					dataArr[6] = r.getFix_qty();
					dataArr[7] = r.getCost();
					dataArr[8] = r.getSpec1();
					dataArr[9] = r.getSpec2();
					dataArr[10] = r.getSpec_etc();
					dataArr[11] = r.getUnit();
					dataArr[12] = r.getUse();
					dataArr[13] = r.getEtc();
					dataArr[14] = r.getMtlr_mst_no();
					dataArr[15] = r.getMtlr_req_no();

					row = sheet.createRow(c);
					int b = 0;
					for (String d : dataArr) {
						cell = row.createCell(b);
						cell.setCellValue(d);
						if (b == 6 || b == 7) {
							cell.setCellStyle(inputStyle);
						} else if (b == 5) {
							cell.setCellStyle(dataStyle3);
						} else if (b == 3 || b == 8 || b == 9 || b == 10 || b == 12 || b == 13) {
							cell.setCellStyle(dataStyle2);
						} else {
							cell.setCellStyle(dataStyle);
						}

						b++;
					}
					c++;
				}
			}

			return wb;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public String excelUploadPurchaseConfirm(ReagentsGlassVO vo) throws Exception {
		String ret = "";
		try {
			MultipartFile mfile = vo.getM_file();
			ArrayList<String> arr = new ArrayList<String>();
			ArrayList<ReagentsGlassVO> lst = new ArrayList<ReagentsGlassVO>();
			if (mfile != null) {
				XSSFWorkbook wb = new XSSFWorkbook(mfile.getInputStream());
				XSSFSheet sheet = wb.getSheetAt(0);

				int firstRow = sheet.getFirstRowNum();
				int lastRow = sheet.getLastRowNum();
				XSSFRow row = null;
				Boolean bool = false;
				for (int r = firstRow + 1; r <= lastRow; r++) {
					row = sheet.getRow(r);
					if (row != null) {
						ReagentsGlassVO reagentsGlassVO = new ReagentsGlassVO();
						String name = null;
						String data = null;
						XSSFCell cell = row.getCell(3);
						name = checkCellValue(cell, false);
						cell = row.getCell(6);
						data = checkCellValue(cell, true);
						if (data.equals("F")) {
							arr.add(name);
						}
						reagentsGlassVO.setFix_qty(data);
						cell = row.getCell(7);
						data = checkCellValue(cell, true);
						if (data.equals("F")) {
							arr.add(name);
						}
						reagentsGlassVO.setCost(data);
						cell = row.getCell(14);
						data = checkCellValue(cell, false);
						reagentsGlassVO.setMtlr_mst_no(data);
						cell = row.getCell(15);
						data = checkCellValue(cell, false);
						reagentsGlassVO.setMtlr_req_no(data);
						lst.add(reagentsGlassVO);
						if (!bool) {
							if ("F".equals(purchaseConfirmDAO.checkPurchaseInfo(reagentsGlassVO))) {
								return "구매요청중인 건이 아닙니다.";
							}
						}
						bool = true;
					}
				}
				if (arr.size() > 0) {
					for (String s : arr) {
						ret += s + "\n";
					}
					ret += "의 값이 부적절합니다.";
				} else {
					purchaseConfirmDAO.updatePurchaseConfirmExcel(lst);
					ret = "1";
				}
			}
			return ret;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	public String checkCellValue(XSSFCell cell, Boolean flag) {
		String data = null;
		try {
			if (cell != null) {
				int type = cell.getCellType();
				switch (type) {
				case HSSFCell.CELL_TYPE_BOOLEAN:
					boolean bdata = cell.getBooleanCellValue();
					data = String.valueOf(bdata);
					break;
				case HSSFCell.CELL_TYPE_NUMERIC:
					double ddata = cell.getNumericCellValue();
					data = String.valueOf(ddata);
					break;
				case HSSFCell.CELL_TYPE_STRING:
					data = cell.getStringCellValue();
					break;
				case HSSFCell.CELL_TYPE_BLANK:
					data = "";
					break;
				case HSSFCell.CELL_TYPE_ERROR:
					data = "" + cell.getErrorCellValue();
					break;
				case HSSFCell.CELL_TYPE_FORMULA:
					data = cell.getCellFormula();
					break;
				}
				if (flag) {
					data = data.replaceAll(",", "");
					try {
						if (data != null) {
							data = data.trim();
							if (!"".equals(data)) {
								Double.parseDouble(data);
							}
						}
					} catch (Exception e) {
						data = "F";
					}
				}
			}
		} catch (Exception e) {
			log.error(e);
		}
		return data;
	}
}