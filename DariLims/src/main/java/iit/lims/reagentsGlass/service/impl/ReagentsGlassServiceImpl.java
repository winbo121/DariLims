package iit.lims.reagentsGlass.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.reagentsGlass.dao.ReagentsGlassDAO;
import iit.lims.reagentsGlass.service.ReagentsGlassService;
import iit.lims.reagentsGlass.vo.ReagentsGlassVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * BuyingRequestServiceImpl
 * 
 * @author 석은주
 * @since 2015.02.16
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.16  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class ReagentsGlassServiceImpl extends EgovAbstractServiceImpl implements ReagentsGlassService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "reagentsGlassDAO")
	private ReagentsGlassDAO reagentsGlassDAO;

	/**
	 * 시약/실험기구 목록 조회
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> reagentsGlassInfo(ReagentsGlassVO reagentsGlassVO) throws Exception {
		return reagentsGlassDAO.reagentsGlassInfo(reagentsGlassVO);
	}

	/**
	 * 시약/실험기구 상세정보 조회
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public ReagentsGlassVO reagentsGlassInfoDetail(HttpServletRequest request, ReagentsGlassVO reagentsGlassVO) {
		try {			
			reagentsGlassVO.setMtlr_no(request.getParameter("mtlr_no"));
			reagentsGlassVO.setMtlr_req_no(request.getParameter("mtlr_req_no"));
			return reagentsGlassDAO.reagentsGlassInfoDetail(reagentsGlassVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	/**
	 * 시약/실험기구 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public int insertReagentsGlassInfo(ReagentsGlassVO vo) throws Exception {
		try {
			if (vo.getM_img() != null && vo.getM_img().getSize() > 0) {
				vo.setAdd_file(vo.getM_img().getBytes());
				vo.setImg_file_nm(vo.getM_img().getOriginalFilename());
			}
			return reagentsGlassDAO.insertReagentsGlassInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시약/실험기구 수정 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public int updateReagentsGlassInfo(ReagentsGlassVO vo) throws Exception {
		try {
			if (vo.getM_img() != null && vo.getM_img().getSize() > 0) {
				vo.setAdd_file(vo.getM_img().getBytes());
				vo.setImg_file_nm(vo.getM_img().getOriginalFilename());
			}
			return reagentsGlassDAO.updateReagentsGlassInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 구매정보 등록 상세정보 조회 / 신규 페이지 열기
	 * 
	 * @param ReagentsGlassVO
	 * @return ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public ReagentsGlassVO selectBuyingInfoDetail(ReagentsGlassVO vo) throws Exception {
		try {
			if (vo.getPageType().equals("detail")) {
				return reagentsGlassDAO.selectBuyingInfoDetail(vo);
				//				return new ReagentsGlassVO();
			} else {
				return new ReagentsGlassVO();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 구매정보 신규 등록
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int insertBuyingInfo(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.insertBuyingInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 구매정보 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int updateBuyingInfo(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.updateBuyingInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 구매정보 삭제
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int deleteBuyingInfo(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.deleteBuyingInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 구매정보 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> selectBuyingInfoList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.selectBuyingInfoList(vo);
	}

	/**
	 * 구매요청 등록 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> selectBuyingRequestList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.selectBuyingRequestList(vo);
	}

	/**
	 * 구매요청 목록 저장 처리
	 * 
	 * @param BuyingRequestVO
	 * @throws Exception
	 */
	@Override
	public int insertBuyingRequestList(ReagentsGlassVO vo) throws Exception {
		try {
			String[] rowArr = vo.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				for (String row : rowArr) {
					//System.out.println(row);
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
						//System.out.println("mtlr_no:" + map.get("mtlr_no"));

						map.put("mtlr_mst_no", vo.getMtlr_mst_no());
						String crud = map.get("crud");

						if ("n".equals(crud))
							reagentsGlassDAO.insertBuyingRequestList(map);
						else if ("d".equals(crud))
							reagentsGlassDAO.deleteBuyingRequestList(map);
						else
							reagentsGlassDAO.updateBuyingRequestList(map);
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
	 * 시약/실험기구정보 팝업 목록 조회
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	public List<ReagentsGlassVO> popReagentsGlassInfoList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.popReagentsGlassInfoList(vo);
	}

	/**
	 * 시약/실험기구정보 수불 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> selectReagentsGlassInOutList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.selectReagentsGlassInOutList(vo);
	}

	/**
	 * 시약/실험기구정보 수불 디테일 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> selectReagentsGlassInOutDetail(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.selectReagentsGlassInOutDetail(vo);
	}

	/**
	 * 시약/실험기구정보 수불 저장 처리(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	@Override
	public int insertReagentsGlassInOut(ReagentsGlassVO vo) throws Exception {
		try {
			//수불상세구분이 이관출고일 경우 이관하는 부서에 입고
			if (vo.getInout_flag_detail().equals("C53002")) {
				ReagentsGlassVO trsDeptInVO = new ReagentsGlassVO();
				trsDeptInVO.setMtlr_no(vo.getMtlr_no());
				trsDeptInVO.setIn_qty(vo.getOut_qty());
				trsDeptInVO.setIn_date(vo.getIn_date()); //in_data, out_data통합
				trsDeptInVO.setDept_cd(vo.getTrs_dept_cd());
				trsDeptInVO.setTrs_dept_cd(vo.getDept_cd());
				trsDeptInVO.setInout_flag("C50001");
				trsDeptInVO.setInout_flag_detail("C51003");
				trsDeptInVO.setUser_id(vo.getUser_id());
				trsDeptInVO.setInout_txt(vo.getInout_txt());
				reagentsGlassDAO.insertReagentsGlassInOut(trsDeptInVO);
			}
			//System.out.println("확인 : "  + vo.getIn_date());
			return reagentsGlassDAO.insertReagentsGlassInOut(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시약/실험기구정보 수불 수정 처리(부서별)
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @exception Exception
	 */
	@Override
	public int updateReagentsGlassInOut(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.updateReagentsGlassInOut(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시약/실험기구정보 수불(결재) 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> receivePayPaymentList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.receivePayPaymentList(vo);
	}

	/**
	 * 시약/실험기구정보 수불(결재) 수정
	 * 
	 * @param ReagentsGlassVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int updateReceivePayPayment(ReagentsGlassVO reagentsGlassVO) throws Exception {
		try {
			String[] rowArr = reagentsGlassVO.getGridData().split("◆★◆");
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
						//System.out.println("승인번호"+vo.getInout_no());
						//map.put("mtlr_mst_no", reagentsGlassVO.getManager_sign());		//과장승인
						map.put("appr_flag", reagentsGlassVO.getAppr_flag()); // 담담승인
						reagentsGlassDAO.updateReceivePayPayment(map);
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
	 * 시약/실험기구정보 수불현황 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	@Override
	public List<ReagentsGlassVO> selectReagentsGlassStateList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.selectReagentsGlassStateList(vo);
	}

	/**
	 * 구매품목현황 리스트 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	@Override
	public List<ReagentsGlassVO> buyingProductStateList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.buyingProductStateList(vo);
	}

	/**
	 * 시약/실험기구 팝업 저장 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public String insertPopReagentsGlassInfo(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.insertPopReagentsGlassInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시약/실험기구 팝업 수정 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public int updatePopReagentsGlassInfo(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.updatePopReagentsGlassInfo(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시약/실험기기 마스터여부 수정 처리
	 * 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public int updateReagentsGlassInfoMaster(ReagentsGlassVO rgentsGlassVO) throws Exception {
		return 0;
	}

	/**
	 * 구매검수 목록 조회
	 * 
	 * @param BuyingRequestVO
	 * @throws Exception
	 */
	@Override
	public List<ReagentsGlassVO> selectBuyingConfirmList(ReagentsGlassVO vo) throws Exception {
		return reagentsGlassDAO.selectBuyingConfirmList(vo);
	}

	/**
	 * 검수 확정(시약/실험기구정보 수불 저장)
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public int saveConfirm(ReagentsGlassVO reagentsGlassVO) throws Exception {
//		ReagentsGlassVO trsDeptInVO = new ReagentsGlassVO();
		try {
			//reagentsGlassDAO.updateBuyingInfoConf(reagentsGlassVO);			
			String[] rowArr = reagentsGlassVO.getGridData().split("◆★◆");
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
								
//								if(valueArr[0].equals("mtlr_no")){
//									trsDeptInVO.setMtlr_no(value);
//								}
//								if(valueArr[0].equals("create_dept")){
//									trsDeptInVO.setDept_cd(value);
//								}								
//								if(valueArr[0].equals("fix_qty")){
//									if(value != "" && value != null){
//										trsDeptInVO.setIn_qty(Integer.parseInt(value));
//									}else{
//										trsDeptInVO.setIn_qty(0);										
//									}
//								}
//								if(valueArr[0].equals("cost")){
//									trsDeptInVO.setPrice(value);
//								}								
//								trsDeptInVO.setInout_flag("C50001");
//								trsDeptInVO.setInout_flag_detail("C51001");
//								trsDeptInVO.setUser_id(reagentsGlassVO.getUser_id());
//								trsDeptInVO.setInout_txt("");
							}
						}
						map.put("user_id", reagentsGlassVO.getUser_id());
						String state = map.get("state");
						
						if (state != null && !"C39005".equals(state)) {
							reagentsGlassDAO.insertReceivePay(map); // 수불 테이블에 저장
						}
						reagentsGlassDAO.updateStateBuyingConfirm(map); // 구매 확정 테이블에 '진행상태' -> '검수완료'로 변경
						
						// 수불내역 등록 추가
						//reagentsGlassDAO.insertReagentsGlassInOut(trsDeptInVO);
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
	 * MSDS 등록이미지 조회
	 * 
	 * @param ReagentsGlassVO
	 * @return List
	 * @exception Exception
	 */
	public byte[] reagentsGlassImage(ReagentsGlassVO vo) throws Exception {
		try {
			ReagentsGlassVO r = reagentsGlassDAO.reagentsGlassImage(vo);
			if (r != null) {
				return r.getAdd_file();
			}
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * MSDS 등록이미지 다운로드 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public ReagentsGlassVO reagentsGlassImageDown(ReagentsGlassVO vo) throws Exception {
		try {
			return reagentsGlassDAO.reagentsGlassImageDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
    
	/**
	 * 업데이트 부분 
	 * @param ReagentsGlassVO
	 * @throws Exception
	 */
	@Override
	public int updateReagentsGlassInOutDetail(ReagentsGlassVO vo) throws Exception {
		try {
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
								if (valueArr.length != 1)
									value = valueArr[1];
								map.put(valueArr[0], value);
							}
						}
						 reagentsGlassDAO.updateReagentsGlassInOutDetail(map);	
						}
					}
				}
			
		
			
			
			
			
		} catch (Exception e) {
			log.error(e);
		}
		return 1;
	}
}