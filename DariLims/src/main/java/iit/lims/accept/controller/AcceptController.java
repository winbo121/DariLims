
package iit.lims.accept.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.service.AcceptService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.common.service.CommonService;
import iit.lims.master.service.SampleService;
import iit.lims.master.service.SamplingPointService;
import iit.lims.master.service.TestItemGroupService;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.SampleVO;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.master.vo.TestItemVO;
import iit.lims.master.vo.TestMethodVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;
import iit.lims.system.vo.BoardVO;
import iit.lims.system.vo.DeptVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.analysis.service.ResultCheckService;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.analysis.vo.SampleStateVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonTextView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;
import iit.lims.util.Sms;
import iit.lims.util.sms.service.SmsService;
import iit.lims.util.sms.vo.SmsVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * AcceptController
 * 
 * @author 진영민
 * @since 2015.01.13
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.19  진영민   최초 생성
 *  2016.01.14  윤상준   테이블구조변경 및 개선 
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/accept/")
public class AcceptController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private AcceptService acceptService;
	@Resource
	private TestItemGroupService testItemGroupService;
	@Resource
	private SamplingPointService samplingPointService;
	@Resource
	private SampleService sampleService;
	@Resource
	private CommonService commonService;

	@Resource
	private ResultCheckService resultCheckService;
	/**
	 * 접수 > 시료유형 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sampleChoice.lims")
	public String sampleChoice() {
		return "common/pop/sampleChoicePop";
	}

	/**
	 * 접수 > 시료유형 팝업 > 리스트 조회
	 * 
	 * @param DemoSampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSampleList.lims")
	public ModelAndView selectSampleList(Model model, SampleVO vo) {
		try {
			model.addAttribute("resultData", sampleService.sampleInsert(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/itemChoice.lims")
	public String itemChoice() {
		return "common/pop/itemChoicePop";
	}
	
	/**
	 * 접수 > 항목추가 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/stdItemChoice.lims")
	public String stdItemChoice() {
		return "common/pop/reqItemChoicePop";
	}

	/**
	 * 접수 > 항목 팝업 > 전체 그룹 리스트 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectItemGroupList.lims")
	public ModelAndView selectItemGroupList(Model model, TestItemVO vo) {
		try {
			model.addAttribute("resultData", testItemGroupService.selectItemGroupList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목 팝업 > 그룹에 속한 항목 리스트 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTestItemInGroupList.lims")
	public ModelAndView selectTestItemInGroupList(Model model, TestItemVO vo) {
		try {
			model.addAttribute("resultData", testItemGroupService.selectTestItemInGroupList(vo));
		} catch (Exception e) {
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 의뢰처 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reqOrgChoice.lims")
	public String reqOrgChoice() {
		return "common/pop/reqOrgChoicePop";
	}

	/**
	 * 접수 > 의뢰처 팝업 > 리스트 조회
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReqOrgList.lims")
	public ModelAndView selectReqOrgList(Model model, ReqOrgVO vo) {
		try {
			List<ReqOrgVO> gridList = acceptService.selectReqOrgList(vo);
			ReqOrgVO returnVO = new ReqOrgVO();
			if(gridList.size() > 0){
				returnVO.setRows(gridList);
				ReqOrgVO total = (ReqOrgVO)gridList.get(0);
				returnVO.setTotalCount(total.getTotalCount());
				returnVO.setPageNum(total.getPageNum());
				returnVO.setTotalPage(total.getTotalPage());
				returnVO.setTotal(total.getTotalCount());
			}
			model.addAttribute("resultData", returnVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 채수장소 팝업 > 페이지
	 * 
	 * @param ReqOrgVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/samplingPointChoice.lims")
	public String samplingPointChoice() {
		return "accept/accept/acceptP04";
	}

	/**
	 * 접수 > 채수장소 팝업 > 리스트 조회
	 * 
	 * @param SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSamplingPointList.lims")
	public ModelAndView selectSamplingPointList(Model model, SamplingPointVO vo) {
		try {			
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = samplingPointService.selectPagingListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);
			
			model.addAttribute("resultData", samplingPointService.samplingPoint(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 채수장소 팝업 페이징 처리
	 * 
	 * @param SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectSamplingPointListPaging.lims")
	public String selectSamplingPointListPaging(HttpServletRequest request, Model model, SamplingPointVO vo) throws Exception {
		try {
			int currPage = vo.getPageNo();
			Integer curPage = 0;
			if (currPage == 0) {
				curPage = new Integer(1);
			} else {
				curPage = vo.getPageNo();
			}

			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(curPage);
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(10);

			vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
			vo.setLastIndex(paginationInfo.getLastRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			int totCnt = samplingPointService.selectPagingListTotCnt(vo);

			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("pageInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/notice/noticePaging"; // 공지사항 폴더에 페이징 HTML(공통으로 사용)
	}

	/**
	 * 의뢰 > 페이지
	 * 
	 * @param SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/receipt.lims")
	public String receipt(HttpServletRequest request, Model model) throws Exception {

		UserInfoVO userInfoVO = SessionCheck.getSession(request);
		model.addAttribute("type", "receipt");
		return "accept/accept/acceptL01";
	}

	/**
	 * 접수 > 페이지
	 * 
	 * @param SamplingPointVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/accept.lims")
	public String accept(Model model, AcceptVO vo) {
		model.addAttribute("type", "accept");
		model.addAttribute("move", vo);
		return "accept/accept/acceptL01";
	}

	/**
	 * 접수 > 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAcceptList.lims")
	public ModelAndView selectAcceptList(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectAcceptList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 의뢰정보 상세 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAcceptDetail.lims")
	public String selectAcceptDetail(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			
//			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
//			vo.setReq_id(userInfoVO.getUser_id());
//			vo.setReq_nm(userInfoVO.getUser_nm());
			
			if (vo.getPageType() != null && "detail".equals(vo.getPageType())) {
				model.addAttribute("detail", acceptService.selectAcceptDetail(vo));
			} else {
				model.addAttribute("detail", new AcceptVO());
			}
			model.addAttribute("type", vo.getType());
			model.addAttribute("collect", acceptService.getCollectCodeList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "accept/accept/acceptD01";
	}
	
	/**
	 * 접수 > 의뢰정보 상세 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAcceptDetailInfo.lims")
	public ModelAndView selectAcceptDetailInfo(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectAcceptDetail(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 시료 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAcceptSampleList.lims")
	public ModelAndView selectAcceptSampleList(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectAcceptSampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectAcceptItemList.lims")
	public ModelAndView selectAcceptItemList(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectAcceptItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 의뢰 정보 삽입
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertAccept.lims")
	public ModelAndView insertAccept(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);

			vo.setUser_id(userInfoVO.getUser_id());
			vo.setPageType(request.getParameter("pageType"));
			vo.setCommission_amt_flag(request.getParameter("commission_amt_flag"));
			
			model.addAttribute("resultData", acceptService.insertAccept(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 의뢰 정보 수정
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateAccept.lims")
	public ModelAndView updateAccept(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			//vo.setPageType(request.getParameter("pageType"));
			vo.setCommission_amt_flag(request.getParameter("commission_amt_flag"));
			
			model.addAttribute("resultData", acceptService.updateAccept(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 시료 리스트 멀티 저장
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveSampleGrid.lims")
	public ModelAndView saveSampleGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setState(request.getParameter("state"));
			vo.setAt_ip(request.getRemoteAddr());
			model.addAttribute("resultData", acceptService.saveSampleGrid(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목/시료 갯수 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/itemCalculate.lims")
	public ModelAndView itemCalculate(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.itemCalculate(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목/시료 갯수 & 수수료 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectFeeTotal.lims")
	public ModelAndView feeCalculate(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectFeeTotal(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 접수처리
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateAcceptState.lims")
	public ModelAndView updateAcceptState(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			String tmp_state = vo.getState();
			// 의뢰등록자, 접수등록자
			if(tmp_state == "Z"){
				vo.setReq_act_user_id(userInfoVO.getUser_id());
			}else if(tmp_state == "B"){
				vo.setAct_user_id(userInfoVO.getUser_id());
			}
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
			model.addAttribute("resultData", acceptService.updateAcceptState(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
//	@Resource
//	private SmsService smsService;
//	
//	@RequestMapping("/smstest.lims")
//	public ModelAndView smstest(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
//		try {
//			model.addAttribute("resultData", acceptService.smstest(vo));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return new ModelAndView(new JsonView());
//	}

	/**
	 * 접수 > 반려 처리
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/returnAcceptState.lims")
	public ModelAndView returnAcceptState(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.returnAcceptState(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 템플릿 팝업 > 페이지
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sampleTemplete.lims")
	public String sampleTemplete() {
		return "common/pop/acceptTemPop";
	}

	/**
	 * 접수 > 템플릿 팝업 > 템플릿 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTempleteSampleList.lims")
	public ModelAndView selectTempleteSampleList(Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectTempleteSampleList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 템플릿 팝업 > 템플릿에 속한 항목 리스트 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectTempleteItemList.lims")
	public ModelAndView selectTempleteItemList(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectTempleteItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 템플릿 팝업 > 템플릿 삽입
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertTemplete.lims")
	public ModelAndView insertTemplete(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.insertTemplete(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 템플릿 팝업 > 템플릿 수정
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateTemplete.lims")
	public ModelAndView updateTemplete(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.updateTemplete(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 템플릿 팝업 > 템플릿에 속한 항목 리스트 멀티 저장
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveTemplete.lims")
	public ModelAndView saveTemplete(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.saveTemplete(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목 팝업 > 전체 항목 리스트 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopAllTestItemList.lims")
	public ModelAndView selectPopAllTestItemList(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			//vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", acceptService.selectPopAllTestItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	
	/**
	 * 접수 > 항목 팝업 > 기준 & 품목별 항목 리스트 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopStdTestItemList.lims")
	public ModelAndView selectPopStdTestItemList(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			//vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", acceptService.selectPopStdTestItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 삭제
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteAccept.lims")
	public ModelAndView deleteAccept(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.deleteAccept(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 복사
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/copyAccept.lims")
	public ModelAndView copyAccept(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.copyAccept(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 재시험
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/retestAccept.lims")
	public ModelAndView retestAccept(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.retestAccept(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 접수 > 항목 리스트 멀티 삭제
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteItemGrid.lims")
	public ModelAndView deleteItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.deleteItemGrid(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 항목 리스트 항목수수료 라디오 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectCommissionGrid.lims")
	public ModelAndView selectCommissionGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", acceptService.selectCommissionGrid(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	

	/**
	 * 접수 > 항목 리스트 멀티 추가(항목 선택 팝업)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertItemGrid.lims")
	public ModelAndView insertItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setDept_cd(userInfoVO.getDept_cd());
		
			
			if (vo.getPageType().equals("EST")){
				model.addAttribute("resultData", acceptService.insertEstimateItem(vo));
			} else if (vo.getPageType().equals("INSTRENT")){
				model.addAttribute("resultData", acceptService.insertInstRentItem(vo));
			} else if (vo.getPageType().equals("TESTSTD") || vo.getPageType().equals("PRDFEE") || vo.getPageType().equals("FEE")){
				model.addAttribute("resultData", acceptService.insertTestStdPrdItem(vo));
			} else if (vo.getPageType().equals("UPDATEFEE")){
				model.addAttribute("resultData", acceptService.updateItemFeeGrid(vo));
			} else{
				model.addAttribute("resultData", acceptService.insertItemGrid(vo));
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 > 항목 시험자 수정
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateItemGrid.lims")
	public ModelAndView updateItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUpdater_id(userInfoVO.getUser_id());
			vo.setTester_id(vo.getUser_id());
			
			model.addAttribute("resultData", acceptService.updateItemGrid(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 부서 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deptChoice.lims")
	public String deptChoice() {
		return "common/pop/deptChoicePop";
	}
	
	/**
	 * 접수 > 팀 선택 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reqTeamChoice.lims")
	public String reqTeamChoice() {
		return "common/pop/reqTeamChoicePop";
	}

	/**
	 * 접수 > 팀 리스트
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/teamListPop.lims")
	public ModelAndView teamListPop(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			if(request.getParameter("user_id") != "" && request.getParameter("user_id") != null){
				vo.setUser_id(request.getParameter("user_id"));
			}
			model.addAttribute("resultData", acceptService.teamListPop(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 접수>사업자등록 팝업 사업자등록증 첨부파일 다운로드
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("bizFileDown.lims")
	public ModelAndView bizFileDown(HttpServletResponse response, Model model, AcceptVO vo) throws Exception {
		try {
			AcceptVO v = acceptService.bizFileDown(vo);
		
			if (v != null) {
				model.addAttribute("data", v.getBiz_file_byte());
				model.addAttribute("fileName", v.getFile_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
	
	/**
	 * 접수 > 시료별 문서 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSampleFileList.lims")
	public ModelAndView selectSampleFileList(Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", acceptService.selectSampleFileList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 항목별 문서 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectSampleItemFileList.lims")
	public ModelAndView selectSampleItemFileList(Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", acceptService.selectSampleItemFileList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 의뢰별 문서 조회
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectRequestFileList.lims")
	public ModelAndView selectRequestFileList(Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", acceptService.selectRequestFileList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 >  첨부파일 팝업 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/filePop.lims")
	public String reportFilePop(HttpServletRequest request, AcceptVO vo, Model model) {
		try {
			if( request.getParameter("rowId") != "" && request.getParameter("rowId") != null ) {		
				vo.setTest_sample_seq(request.getParameter("test_sample_seq")); // 시료번호
				vo.setTest_item_seq(request.getParameter("test_item_cd")); // 항목번호
				vo.setAtt_seq(request.getParameter("rowId")); // seq				
				vo.setTest_req_seq(request.getParameter("test_req_seq")); // 의뢰번호
				
				if (vo.getTest_sample_seq() == "" || vo.getTest_sample_seq() == null ) {
					model.addAttribute("detail", acceptService.requestFilePop(vo));
				} else if(vo.getTest_item_seq() == "" || vo.getTest_item_seq() == null){
					model.addAttribute("detail", acceptService.sampleFilePop(vo));
				} else {
					model.addAttribute("detail", acceptService.itemFilePop(vo));
				}				
			} else {
				model.addAttribute("detail", new AcceptVO());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "common/pop/filePop";
	}
	
	/**
	 * 접수 >  첨부파일 저장(시료)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertSampleFile.lims")
	public ModelAndView insertSampleFile(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.insertSampleFile(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 *  접수 >  첨부파일 수정 처리(시료)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateSampleFile.lims")
	public ModelAndView updateSampleFile(HttpServletRequest request, @ModelAttribute("vo") AcceptVO vo, Model model) throws Exception {
		try {
			int result = acceptService.updateSampleFile(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 *  접수 >  첨부파일 삭제 처리(시료)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteSampleFile.lims")
	public ModelAndView deleteSampleFile(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			vo.setAtt_seq(request.getParameter("att_seq"));
			model.addAttribute("resultData", acceptService.deleteSampleFile(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 >  첨부파일 다운로드(시료)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/sampleFileDown.lims")
	public ModelAndView sampleFileDown(HttpServletResponse response, Model model, AcceptVO vo) throws Exception {
		try {
			AcceptVO D = acceptService.sampleFileDown(vo);
			if (D != null) {
				model.addAttribute("data", D.getFile_att());
				model.addAttribute("fileName", D.getFile_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
	
	
	/**
	 * 접수 >  첨부파일 저장(항목)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertItemFile.lims")
	public ModelAndView insertItemFile(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.insertItemFile(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 *  접수 >  첨부파일 수정 처리(항목)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateItemFile.lims")
	public ModelAndView updateItemFile(HttpServletRequest request, @ModelAttribute("vo") AcceptVO vo, Model model) throws Exception {
		try {
			int result = acceptService.updateItemFile(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 *  접수 >  첨부파일 삭제 처리(항목)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteItemFile.lims")
	public ModelAndView deleteItemFile(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			vo.setAtt_seq(request.getParameter("att_seq"));
			model.addAttribute("resultData", acceptService.deleteItemFile(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 >  첨부파일 다운로드(항목)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/itemFileDown.lims")
	public ModelAndView itemFileDown(HttpServletResponse response, Model model, AcceptVO vo) throws Exception {
		try {
			AcceptVO D = acceptService.itemFileDown(vo);
			if (D != null) {
				model.addAttribute("data", D.getFile_att());
				model.addAttribute("fileName", D.getFile_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
	
	/**
	 * 접수 >  첨부파일 저장(의뢰)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertRequestFile.lims")
	public ModelAndView insertRequestFile(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.insertRequestFile(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 *  접수 >  첨부파일 수정 처리(의뢰)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateRequestFile.lims")
	public ModelAndView updateRequestFile(HttpServletRequest request, @ModelAttribute("vo") AcceptVO vo, Model model) throws Exception {
		try {
			int result = acceptService.updateRequestFile(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 *  접수 >  첨부파일 삭제 처리(의뢰)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteRequestFile.lims")
	public ModelAndView deleteRequestFile(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			vo.setAtt_seq(request.getParameter("att_seq"));
			model.addAttribute("resultData", acceptService.deleteRequestFile(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 접수 >  첨부파일 다운로드(의뢰)
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/requestFileDown.lims")
	public ModelAndView requestFileDown(HttpServletResponse response, Model model, AcceptVO vo) throws Exception {
		try {
			AcceptVO D = acceptService.requestFileDown(vo);
			if (D != null) {
				model.addAttribute("data", D.getFile_att());
				model.addAttribute("fileName", D.getFile_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}
	
	
	/**
	 * 접수 > 식약처기준 항목 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mfdsStdItemChoice.lims")
	public String mfdsStdItemChoice() {
		return "common/pop/mfdsStdItemChoicePop";
	}	

	
	/**
	 * 접수 > 식약처기준 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopAllMfdsStdItemList.lims")
	public ModelAndView selectPopAllMfdsStdItemList(HttpServletRequest request, Model model, TestPrdStdVO vo) throws Exception {
		try {
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", acceptService.selectPopAllMfdsStdItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 자가기준 항목 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selfStdItemChoice.lims")
	public String selfStdItemChoice() {
		return "common/pop/selfStdItemChoicePop";
	}	

	/**
	 * 접수 > 등급별 품목 항목 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selfGradeChoice.lims")
	public String selfGradeChoice() {
		return "common/pop/selfGradeChoicePop";
	}	
	
	/**
	 * 접수 > 전처리비용 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/pretreatmentPop.lims")
	public String pretreatmentPop() {
		return "common/pop/pretreatmentPop";
	}
	
	/**
	 * 접수 > 전처리비용 저장
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/savePretreatment.lims")
	public ModelAndView savePretreatment(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			
			model.addAttribute("resultData", acceptService.savePretreatment(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 자가기준 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopAllSelfStdItemList.lims")
	public ModelAndView selectPopAllSelfStdItemList(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", acceptService.selectPopAllSelfStdItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	

	/**
	 * 접수 > 등급별 항목 리스트 조회 팝업
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectPopAllSelfGradeItemList.lims")
	public ModelAndView selectPopAllSelfGradeItemList(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", acceptService.selectPopAllSelfGradeItemList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	
	
	/**
	 * 접수 > 항목 수수료 마스터 등록
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/saveItemMasterFee.lims")
	public ModelAndView saveItemMasterFee(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.saveItemMasterFee(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	@RequestMapping("/selectFeeValue.lims")
	public ModelAndView selectFeeValue(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectFeeValue(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	

	@RequestMapping("/selectOrgUnpaid.lims")
	public ModelAndView selectOrgUnpaid(HttpServletRequest request, Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.selectOrgUnpaid(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}

	
	@RequestMapping("/labelView.lims")
	public String labelView(HttpServletRequest request, Model model, CommissionCheckVO vo) throws Exception {
		try {
			model.addAttribute("test_req_seq", request.getParameter("test_req_seq"));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return "accept/accept/labelPrint";
	}
	
	
	@RequestMapping("/labelPrint.lims")
	public ModelAndView labelPrint(HttpServletRequest request, AcceptVO vo, Model model) throws Exception {
		model.addAttribute("resultData", acceptService.labelPrint(vo));
		return new ModelAndView(new JsonTextView());
	}
	
	/**
	 * 접수 > 자가기준 스탠다드 선택 팝업 
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selfStnadPItemChoice.lims")
	public String selfStnadPItemChoice() {
		return "accept/accept/acceptStP01";
	}
	
	//스탠다드 팝업 추가
	@RequestMapping("/insertStdPLItem.lims")
	public ModelAndView insertStdPLItem(HttpServletRequest request, Model model, TestStandardVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.insertStdPLItem(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//스탠다드 팝업 추가
	@RequestMapping("/updateStdItemGrid.lims")
	public ModelAndView updateStdItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.updateStdItemGrid(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//등급별 항목 추가
	@RequestMapping("/insertGradeItemGrid.lims")
	public ModelAndView insertGradeItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.insertGradeItemGrid(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//검체별 첨부 문서 업데이트
	@RequestMapping("/updateFileDivision.lims")
	public ModelAndView updateFileDivision(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.updateFileDivision(vo));
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//메일전송
	@RequestMapping("/mailSend.lims")
	public ModelAndView mailSend(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.mailSend(param, request));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//성적서메일전송
	@RequestMapping("/reportMailSend.lims")
	public ModelAndView reportMailSend(MultipartHttpServletRequest request, Model model, @RequestParam HashMap<String, Object> param) throws Exception {
		try {
			model.addAttribute("resultData", acceptService.reportMailSend(param, request));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@RequestMapping("/acceptMailSendPop.lims")
	public String acceptMailSendPop() throws Exception {
		return "common/pop/acceptMailSendPop";
	}
	/**
	 * 접수 > 선택항목 > 성적서 항목 순서
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateOrder.lims")
	public ModelAndView updateOrder(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			
			model.addAttribute("resultData", acceptService.updateOrder(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	
	//스탠다드 팝업 추가
	@RequestMapping("/insertStdItemGrid.lims")
	public ModelAndView insertStdItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());
			
			model.addAttribute("resultData", acceptService.insertStdItemGrid(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//스탠다드 팝업 추가
	@RequestMapping("/insertGrdItemGrid.lims")
	public ModelAndView insertGrdItemGrid(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			vo.setUser_id(userInfoVO.getUser_id());
			
			model.addAttribute("resultData", acceptService.insertGrdItemGrid(vo));

			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 접수 > 비고 수정
	 * 
	 * @param AcceptVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateReqSampleMessage.lims")
	public ModelAndView updateReqSampleMessage(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			vo.setEtc_desc(request.getParameter("etc_desc"));
			
			model.addAttribute("resultData", acceptService.updateReqSampleMessage(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 접수 > 성적서표시순서 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/reportOrder.lims")
	public String reportOrder() {
		return "common/pop/reportOrderPop";
	}
	
	/**
	 * 접수 > 성적서표시순서 팝업 > 조회 
	 * 
	 * @param DemoSampleVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectReportOrder.lims")
	public ModelAndView selectReportOrder(Model model, AcceptVO vo) {
		try {
			model.addAttribute("resultData", acceptService.selectReportOrder(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 성적서 발행완료 후 접수 복사
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/copyPieceAccept.lims")
	public ModelAndView copyPieceAccept(HttpServletRequest request, Model model, AcceptVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", acceptService.copyPieceAccept(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}
	

	/**
	 * 접수 > 메일팝업 > 메일그룹팝업
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mailGroupChoice.lims")
	public String mailGroupChoice() {
		return "common/pop/mailGroupPop";
	}
}