package iit.lims.master.controller;

import java.util.List;








import iit.lims.master.service.PretreatmentService;
import iit.lims.master.service.SampleGradeService;
import iit.lims.master.vo.PretreatmentVO;
import iit.lims.master.vo.SampleGradeVO;
import iit.lims.master.vo.StdTestItemVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@RequestMapping(value = "/master/")
@Controller
public class PretreatmentController{
	static final Logger log = LogManager.getLogger();
	
	@Resource
	private PretreatmentService pretreatmentService;
	
	/**
	 * 전처리비용 페이지 전환 처리
	 * 
	 * @param SampleGradeVO
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("pretreatmentManage.lims")
	public String pretreatmentManage(HttpServletRequest request, Model model) {
		return "master/pretreatment/pretreatmentL01";
	}
	
	
	/**
	 * 품목별 전처리 목록 조회
	 * 
	 * @param StdTestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */	
	@RequestMapping("selectPretMList.lims")
	public ModelAndView selectPretMList(HttpServletRequest request, Model model, PretreatmentVO vo, StdTestItemVO svo) {
		try {
			model.addAttribute("resultData", pretreatmentService.selectPretMList(vo));
		} catch (Exception e) {
			
		}
		return new ModelAndView(new JsonView());
	}
	
	/**
	 * 전처리비용 등록
	 * 
	 * 
	 * @param TestStandardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertPretreatment.lims")
	public ModelAndView insertPretreatment(HttpServletRequest request, Model model, PretreatmentVO vo) throws Exception {
		try {
			/*UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", testItemService.insertTestItem(vo));*/
			model.addAttribute("resultData", pretreatmentService.insertPretreatment(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	
	/* 
	 * 전처리 삭제
	*/
	@RequestMapping("/deletePretreatment.lims")
	public ModelAndView deletePretreatment(HttpServletRequest request, Model model, PretreatmentVO vo) throws Exception {
		try {
			model.addAttribute("resultData", pretreatmentService.deletePretreatment(vo));
			
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
	

}