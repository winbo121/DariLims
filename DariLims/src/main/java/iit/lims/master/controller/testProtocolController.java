package iit.lims.master.controller;

import java.util.HashMap;
import java.util.List;

import iit.lims.common.service.CommonService;
import iit.lims.master.service.PrdLstService;
import iit.lims.master.vo.PrdLstVO;
import iit.lims.util.JsonView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value = "/master/")
@Controller
public class testProtocolController {

	static final Logger log = LogManager.getLogger();
	
	@Resource
	private PrdLstService prdLstService;
	@Resource
	private CommonService commonService;
	
	/*
	 *연습용 페이지
	 */
	@RequestMapping("testProtocol.lims")
	public String testPracticePage(HttpServletRequest request) {
		return "master/testProtocol/testProtocol01";
	}
	
	
	
	/**
	 * 품목 관리 세부페이지 전환 처리
	 * 
	 * @param PrdLstVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectProtcDetail.lims")
	public String selectProtcDetail(HttpServletRequest request, Model model, PrdLstVO prdLstVO) {
		try {
			if (prdLstVO.getPageType() != null && "detail".equals(prdLstVO.getPageType())) {
				model.addAttribute("detail", prdLstService.selectPrdLstListDetail(prdLstVO));
				model.addAttribute("pageType", prdLstVO.getPageType());
			}else{
				model.addAttribute("pageType", prdLstVO.getPageType());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/prdLst/prdLstD01";
	}
	
	/**
	 * 품목 리스트 조회 처리
	 * 
	 * @param CommonCodeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectProtcList.lims")
	public ModelAndView selectPrdLstList(HttpServletRequest request, Model model, @RequestParam PrdLstVO prdLstVO) {
		try {

			List<PrdLstVO> gridList = prdLstService.selectPrdLstList(prdLstVO);
			
//			if(gridList.size() > 0){
//				returnVO.setRows(gridList);
//				PrdLstVO total = (PrdLstVO)gridList.get(0);
//				returnVO.setTotalCount(total.getTotalCount());
//				returnVO.setPageNum(total.getPageNum());
//				returnVO.setTotalPage(total.getTotalPage());
//				returnVO.setTotal(total.getTotalCount());
//			}
			model.addAttribute("resultData", gridList);
			
			
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	
	/**
	 * 프로토콜 > 항목관리 팝업 > 페이지
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/protItemChoice.lims")
	public String stdItemChoice() {
		return "common/pop/protocolPop";
	}
}
