package iit.lims.common.service.impl;

import iit.lims.accept.dao.AcceptDAO;
import iit.lims.accept.dao.CommissionCheckDAO;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultApprovalVO;
import iit.lims.analysis.vo.SampleStateVO;
import iit.lims.common.dao.CommonDAO;
import iit.lims.common.service.CommonService;
import iit.lims.common.vo.DemoSampleVO;
import iit.lims.common.vo.ExcelVO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.common.vo.TreeVO;
import iit.lims.common.vo.ZipCodeVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.report.vo.ReportVO;
import iit.lims.system.dao.AuditTrailDAO;
import iit.lims.system.dao.LogDAO;
import iit.lims.system.vo.RoleVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.common.vo.CommonVO;
import iit.lims.util.ConverObjectToMap;
import iit.lims.util.SessionCheck;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {
	static final Logger log = LogManager.getLogger();
	
	@Resource(name = "acceptDAO")
	private AcceptDAO acceptDAO;
	
	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name = "logDAO")
	private LogDAO logDAO;
	
	@Resource(name = "auditTrailDAO")
	private AuditTrailDAO auditTrailDAO;
	
	@Resource(name = "commissionCheckDAO")
	private CommissionCheckDAO commissionCheckDAO;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	
	public UserInfoVO loginCheck(UserInfoVO userInfoVO) {
		try {			
			// ID 체크
			Integer userIdCnt = commonDAO.selectUserIdCheck(userInfoVO);
			if (userIdCnt == 1) {
				// PW 체크
				Integer userPwCnt = commonDAO.selectUserPwCheck(userInfoVO);
				if (userPwCnt == 1) {					
					// IP 가져오기
					HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
					String ip = req.getHeader("X-FORWARDED-FOR");
					if (ip == null) {
						ip = req.getRemoteAddr();
					}
					userInfoVO.setUser_ip(ip);
					// IP 체크 사용여부
					UserInfoVO vo = commonDAO.selectAccessIpFlag(userInfoVO);
					if( vo.getAccess_ip_flag().equals("Y") ){				
						// IP 체크
						Integer userIpCnt = commonDAO.selectUserIpCheck(userInfoVO);
						
						if (userIpCnt > 0) {
							userInfoVO = commonDAO.selectUserInfoCheck(userInfoVO);
							
							if (userInfoVO.getUse_flag().equals("N")) { // 사용여부확인
								userInfoVO.setMessage("LOGIN_NOT_FLAG");
							} else {
								userInfoVO.setMessage("LOGIN_SUCESS");
								logDAO.insertLoginLog(userInfoVO); // 로그 기록 처리
							}
						} else {
							// 사용가능 IP가 아님..
							userInfoVO.setMessage("LOGIN_NOT_IP");
						}
					} else {
						userInfoVO = commonDAO.selectUserInfoCheck(userInfoVO);
						
						if (userInfoVO.getUse_flag().equals("N")) { // 사용여부확인
							userInfoVO.setMessage("LOGIN_NOT_FLAG");
						} else {
							userInfoVO.setMessage("LOGIN_SUCESS");
							logDAO.insertLoginLog(userInfoVO); // 로그 기록 처리
						}
					}
				} else {
					// 패스워드 틀림..
					userInfoVO.setMessage("LOGIN_NOT_PW");
				}
			} else {
				// 등록된 아이디 없음.
				userInfoVO.setMessage("LOGIN_NOT_ID");
			}
/*			log.debug("loginCheck S");
			userInfoVO.setMessage("LOGIN_SUCESS");
			
			 임시 정보 
			userInfoVO.setUser_nm("시스템");
			userInfoVO.setPotal_id("interface");
			userInfoVO.setUser_id("interface");
			userInfoVO.setDept_nm("개발부서");
			userInfoVO.setTotal_role_nm("시스템권한");*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfoVO;
	}
	
	
	
	public ArrayList<TreeVO> selectMenuList(HashMap<String, String> map) {
		ArrayList<TreeVO> menuList = new ArrayList<TreeVO>();   
		try {
			ArrayList<RoleVO> _LV1 = (ArrayList<RoleVO>) commonDAO.preMenu(map);
			ArrayList<RoleVO> _LV2 = (ArrayList<RoleVO>) commonDAO.menu(map);
			//vo.setMenu_Level(3);
			//map.put("menu_Level", "3");
			//ArrayList<RoleVO> _LV3 = (ArrayList<RoleVO>) systemDAO.menu(map);

			
/*			// 임시메뉴 셋팅
			ArrayList<RoleVO> _LV1 = new ArrayList<RoleVO>();
			ArrayList<RoleVO> _LV2 = new ArrayList<RoleVO>();

			
			
			RoleVO tempPreVO = new RoleVO();
			tempPreVO.setMenu_cd("m01");
			tempPreVO.setMenu_nm("SampleMenu");
			
			RoleVO tempVO = new RoleVO();
			tempVO.setMenu_cd("m01001");
			tempVO.setMenu_nm("그리드샘플");
			tempVO.setMenu_url("gridSample");
			
			_LV1.add(0, tempPreVO);
			_LV2.add(0, tempVO);
			
			RoleVO temp1VO = new RoleVO();
			temp1VO.setMenu_cd("m01002");
			temp1VO.setMenu_nm("REPORT SAMPLE");
			temp1VO.setMenu_url("reportSample");
			RoleVO temp2VO = new RoleVO();
			temp2VO.setMenu_cd("m01003");
			temp2VO.setMenu_nm("TEMP");
			temp2VO.setMenu_url("");
			RoleVO temp3VO = new RoleVO();
			temp3VO.setMenu_cd("m01004");
			temp3VO.setMenu_nm("CHART SAMPLE");
			temp3VO.setMenu_url("chartSample");
			
			_LV2.add(1, temp1VO);
			_LV2.add(2, temp2VO);
			_LV2.add(3, temp3VO);*/
		

			
			
			if (_LV1 != null) {
				for (RoleVO lv1 : _LV1) {
					TreeVO lv1Tree = new TreeVO();
					lv1Tree.setFolder(true);
					lv1Tree.setExpanded(true);
					lv1Tree.setTitle(lv1.getMenu_nm());
					ArrayList<TreeVO> lv2TreeList = new ArrayList<TreeVO>();
					String lv1Cd = lv1.getMenu_cd().substring(0, 2);
					for (RoleVO lv2 : _LV2) {
						String lv2Cd = lv2.getMenu_cd().substring(0, 2);
						if (lv2Cd.equals(lv1Cd)) {
							TreeVO lv2Tree = new TreeVO();
							lv2Tree.setRefKey(lv2.getMenu_cd());
							lv2Tree.setTitle(lv2.getMenu_nm());
							lv2Tree.setAuth_save(lv2.getAuth_save());
							lv2Tree.setAuth_select(lv2.getAuth_select());
							boolean folder = false;
							/*ArrayList<TreeVO> lv3TreeList = new ArrayList<TreeVO>();
							lv2Cd = lv2.getMenu_Cd().substring(0, 4);
							for (RoleVO lv3 : _LV3) {
								String lv3Cd = lv3.getMenu_Cd().substring(0, 4);
								if (lv3Cd.equals(lv2Cd)) {
									folder = true;
									TreeVO lv3Tree = new TreeVO();
									lv3Tree.setTitle(lv3.getMenu_Name());
									lv3Tree.setKey(lv3.getMenu_Url());
									lv3TreeList.add(lv3Tree);
								} else {
									lv2Tree.setKey(lv2.getMenu_Url());
								}
							}
							lv2Tree.setChildren(lv3TreeList);*/
							lv2Tree.setKey(lv2.getMenu_url());
							lv2Tree.setFolder(folder);
							lv2TreeList.add(lv2Tree);
						}
					}
					lv1Tree.setChildren(lv2TreeList);
					menuList.add(lv1Tree);
				}
			}
		} catch (Exception e) {
			log.error(e);
		}
		return menuList;
	}


	/**
	 * 그리드샘플 > 샘플 리스트 조회
	 * 
	 * @param DemoSampleVO
	 * @return List
	 * @exception Exception
	 */
	public List<DemoSampleVO> selectSampleList(DemoSampleVO sampleVO) throws Exception{
		// TODO Auto-generated method stub
		System.out.println("selectSampleList2");
		return commonDAO.selectSampleList(sampleVO);
	}

	

	public List<Map<String, Object>> selectSampleListMAP(DemoSampleVO sampleVO) throws Exception{
		// TODO Auto-generated method stub
		return commonDAO.selectSampleListMAP(sampleVO);
	}

	
	/**
	 * 의뢰정보 팝업 > 의뢰정보 조회
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @throws Exception
	 */
	public AcceptVO selectAcceptInfo(AcceptVO vo) throws Exception {
		return commonDAO.selectAcceptInfo(vo);
	}

	/**
	 * 결과입력 > 분석의견 조회
	 * 
	 * @param ResultInputVO
	 * @return List<ResultInputVO>
	 * @throws Exception
	 */
	public List<AcceptVO> selectTestComment(AcceptVO vo) throws Exception {
		return commonDAO.selectTestComment(vo);
	}
	
	/**
	 * 진행상태정보 팝업 > 진행상태정보 조회
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @throws Exception
	 */
	public List<SampleStateVO> selectStateInfoList(AcceptVO vo) throws Exception {
		return commonDAO.selectStateInfoList(vo);
	}
	
	/**
	 * 진행상태정보 팝업 > 진행상태정보 조회
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @throws Exception
	 */
	public List<SampleStateVO> selectStateInfo(AcceptVO vo) throws Exception {
		return commonDAO.selectStateInfo(vo);
	}

	/**
	 * 진행상태정보 팝업 > 결과보기 조회
	 * 
	 * @param MakeGridVO
	 * @return MakeGridVO
	 * @throws Exception
	 */
	public MakeGridVO selectAcceptResultInfo(MakeGridVO vo) throws Exception {
		try {
			List<String> lst = commonDAO.selectAcceptResultInfoColumn(vo);
			List<String> lst2 = new ArrayList<String>();
			if (lst != null && lst.size() > 0) {
				for (String r : lst) {
					String[] s = r.split("♥■◆", -1);
					if (s.length == 2) {
						lst2.add(s[0]);
					}
				}
				vo.setHead(lst2);
				vo.setBody(commonDAO.selectAcceptResultInfo(vo));
				vo.setHead(lst);
			}
			return vo;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * 진행상태정보 팝업 > 재접수(접수대기로 변경)
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @throws Exception
	 */
	
	public int returnToBegining(AcceptVO vo) throws Exception {
		try {
			commonDAO.returnToBegining(vo);
			/* AUDIT_TRAIL START*/
			HashMap<String, String> map = new HashMap<String, String>();
			String data = ConverObjectToMap.conver(vo).toString();
			//log.debug("Log[Lims AUDIT TRAIL] :" + data);
			map.put("at_cont", data); // 로우데이터 셋팅
			map.put("crud", "u"); // 로우데이터 셋팅
			map.put("menu_cd", vo.getMenu_cd()); // 메뉴코드 셋팅
			map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
			map.put("test_req_no", vo.getTest_req_no()); // 접수번호 셋팅
			map.put("at_proc", "재접수(팝업)");
			map.put("worker_id", vo.getUser_id()); // 작업한사용자의 아이디 셋팅
			map.put("at_ip", SessionCheck.getUserIp()); // 작업한사용자의 아이피 셋팅
			map.put("test_req_seq", vo.getTest_req_seq()); // 의뢰일련번호 셋팅
			auditTrailDAO.insertAuditTrail(map);
			/* AUDIT_TRAIL END*/
			
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	
	/**
	 * 주소정보 조회(팝업)
	 * 
	 * @param HttpServletRequest
	 *            , Model, CommonVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<ZipCodeVO> selectAddrList(ZipCodeVO vo) throws Exception {
		return commonDAO.selectAddrList(vo);
	}
	
	/**
	 * 반려 항목 체크
	 * 
	 * @param HttpServletRequest
	 *            , Model, AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int updateReturnFlag(AcceptVO vo) throws Exception {
		try {
			commonDAO.updateReturnFlag(vo);
			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}

	
	/**
	 * 반려 사유 조회
	 * 
	 * @param AcceptVO
	 * @return AcceptVO
	 * @throws Exception
	 */
	public List<ResultApprovalVO> selectReturnCommentList(AcceptVO vo) throws Exception {
		return commonDAO.selectReturnCommentList(vo);
	}

	/**
	 * 반려 항목 취소
	 * 
	 * @param AcceptVO
	 * @return int
	 * @throws Exception
	 */
	public int cancelReturnFlag(AcceptVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					//System.out.println(row);
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							//System.out.println(column);
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						commonDAO.cancelReturnFlag(map);
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
	 * 반려 항목 모든 시료에 반영
	 * 
	 * @param AcceptVO
	 * @return int
	 * @throws Exception
	 */
	public int copyReturnFlag(AcceptVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					//System.out.println(row);
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							//System.out.println(column);
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("test_dept_cd", vo.getTest_dept_cd());
						map.put("type", vo.getType());
						commonDAO.copyReturnFlag(map);
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
	 * 반려 저장
	 * 
	 * @param AcceptVO
	 * @return int
	 * @throws Exception
	 */
	public int updateReturnComment(AcceptVO vo) throws Exception {
		try {

			AcceptVO insVo = new AcceptVO();
			insVo.setTest_req_seq(vo.getTest_req_seq());
			insVo.setReturn_flag("Y");			
			insVo.setReturn_comment(vo.getReturn_comment());
			commonDAO.updateReturnComment(insVo);
			insVo.setState(vo.getState());
			commonDAO.updateTestStateAll(insVo);
			insVo.setTest_dept_cd(vo.getTest_dept_cd());
			commonDAO.deleteApprLine(insVo);

			HistoryVO historyVO = new HistoryVO();
			historyVO.setTest_req_seq(vo.getTest_req_seq());
			//historyVO.setSample_state("H");
			historyVO.setSample_state("F");
			historyVO.setDept_cd(vo.getDept_cd());
			historyVO.setUser_id(vo.getUser_id());
			historyVO.setTest_dept_cd(vo.getTest_dept_cd());
			historyVO.setEtc("[반려] " + vo.getReturn_comment());
			commonDAO.insertSampleHistoryAll(historyVO);

			return 1;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
	}
	
	/**
	 * RAWDATA
	 * 
	 * @param HttpServletRequest
	 *            , Model
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int rdmsViewer(HashMap<String, String> m) throws Exception {
		try {
			List<String> l = commonDAO.selectRDMSViwer(m);
			if (l != null && l.size() > 0) {
				String docIDs = "";
				for (String s : l) {
					docIDs += s + "|";
				}
				docIDs = docIDs.substring(0, docIDs.length() - 1);
				m.put("docIDs", docIDs);
				commonDAO.insertRDMSViewer(m);
				return 1;
			}
		} catch (Exception e) {
			log.error(e);
		}
		return 0;
	}
	
	/**
	 * 성적서 정보 조회
	 */
	public ReportVO selectReportInfo(ReportVO vo)throws Exception {
		return commonDAO.selectReportInfo(vo);
	}
	
	
	/**
	 * 성적서 정보 조회 항목
	 */
	public List<ReportVO> selectReportInfoItem(ReportVO vo)throws Exception {
		return commonDAO.selectReportInfoItem(vo);
	}
	
	/**
	 * 성적서 정보 조회 항목(불검출)
	 */
	public List<ReportVO> selectReportInfoItem2(ReportVO vo)throws Exception {
		return commonDAO.selectReportInfoItem2(vo);
	}
	
	/**
	 * 성적서 진위확인 조회
	 */
	public ReportVO selectReportVerify(ReportVO vo)throws Exception {
		return commonDAO.selectReportVerify(vo);
	}
	
	/**
	 * 메인 처리임박 리스트
	 */
	public ArrayList<AcceptVO> selectDeadlineSampleList(UserInfoVO vo) throws Exception {
		return (ArrayList<AcceptVO>) commonDAO.selectDeadlineSampleList(vo);
	}

	/**
	 * 메인 시험대기 접수 리스트
	 */
	public ArrayList<AcceptVO> selectResultInputList(UserInfoVO vo) throws Exception {
		return (ArrayList<AcceptVO>) commonDAO.selectResultInputList(vo);
	}

	/**
	 * 메인 COUNT(시험)
	 */
	public CommonVO selectResultMainCntList(UserInfoVO vo) throws Exception {
		return (CommonVO) commonDAO.selectResultMainCntList(vo);
	}
	
	/**
	 * 메인 COUNT(장비)
	 */
	public CommonVO selectMachineMainCntList(UserInfoVO vo) throws Exception {
		return (CommonVO) commonDAO.selectMachineMainCntList(vo);
	}
	
	public ArrayList<ExcelVO> excelDownload(ExcelVO vo) throws Exception {
		try {
			if (vo != null && vo.getGridData() != null) {
				ArrayList<ExcelVO> lst = new ArrayList<ExcelVO>();
				String gridData = vo.getGridData();
				String[] gridArr = gridData.split("◆■●", -1);
				for (String d : gridArr) {
					ExcelVO e = excelMake(d);
					if (e != null) {
						lst.add(e);
					}
				}
				return lst;
			}
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return null;
	}
	
	public ExcelVO excelMake(String gridData) throws Exception {
		try {
			ExcelVO excelVO = new ExcelVO();
			String[] gridArr = gridData.split("◆★◆", -1);
			if (gridArr.length > 3) {
				String[] labelArr = gridArr[0].split("●★●", -1);
				String[] dataArr = gridArr[2].split("●★●", -1);
				ArrayList<String[]> label = new ArrayList<String[]>();
				for (String valuses : labelArr) {
					String[] value = valuses.split("■★■", -1);
					label.add(value);
				}
				excelVO.setLabel(label);

				if (!"".equals(gridArr[1])) {
					String[] labelArr2 = gridArr[1].split("●★●", -1);
					ArrayList<String[]> label_sub = new ArrayList<String[]>();
					for (String values : labelArr2) {
						String[] value = values.split("■★■", -1);
						label_sub.add(value);
					}
					excelVO.setLabel_sub(label_sub);
				}

				ArrayList<ArrayList<String>> row = new ArrayList<ArrayList<String>>();
				for (int i = 0; i < dataArr.length; i++) {
					String[] valueArr = dataArr[i].split("■★■", -1);
					ArrayList<String> data = new ArrayList<String>();
					for (int r = 0; r < valueArr.length; r++) {
						data.add(valueArr[r]);
					}
					row.add(data);
				}
				excelVO.setData(row);

				if (!"".equals(gridArr[3])) {
					String[] footArr = gridArr[3].split("●★●", -1);
					ArrayList<String[]> foot = new ArrayList<String[]>();
					for (String values : footArr) {
						String[] value = values.split("■★■", -1);
						foot.add(value);
					}
					excelVO.setFoot(foot);
				}
				return excelVO;
			}
			return null;
		} catch (Exception e) {
			throw e;
		}
	}
	
	
	public List<UserInfoVO> menuAuthCheck(UserInfoVO vo) throws Exception{
		// TODO Auto-generated method stub
		return commonDAO.menuAuthCheck(vo);
	}
	
	// 양식 파일경로
	public String selectDocFileInfo(String doc_seq) throws Exception{
		return commonDAO.selectDocFileInfo(doc_seq);
	}
	
	// 양식MAX 파일경로
	public String selectMaxDocFileInfo(String doc_seq) throws Exception{
		return commonDAO.selectMaxDocFileInfo(doc_seq);
	}

	/**
	 * 로그아웃 로그등록
	 */
	public void logout(UserInfoVO userInfoVO) throws Exception {
		logDAO.insertLogoutLog(userInfoVO);
	}
	
	/**
	 * 페이징
	 * 
	 * @param ZipCodeVO
	 * @throws Exception
	 */
	@Override
	public int selectAddrPagingListTotCnt(ZipCodeVO vo) throws Exception {
		return commonDAO.addrZipCnt(vo);
	}


	public ReportVO selectRequestInfo(ReportVO vo)throws Exception {
		return commonDAO.selectRequestInfo(vo);
	}

	public List<ReportVO> selectRequestInfoItem(ReportVO vo)throws Exception {
		return commonDAO.selectRequestInfoItem(vo);
	}

	public ReqOrgVO selectOrgInfo(ReqOrgVO vo)throws Exception {
		return commonDAO.selectOrgInfo(vo);
	}
	public List<AcceptVO> selectTransactionDetails(AcceptVO vo)throws Exception {
		return commonDAO.selectTransactionDetails(vo);
	}
	public List<AcceptVO> selectTransactionStatement(AcceptVO vo)throws Exception {
		return commonDAO.selectTransactionStatement(vo);
	}
	
}
