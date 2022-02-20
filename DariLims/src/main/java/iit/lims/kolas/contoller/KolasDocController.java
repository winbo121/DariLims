package iit.lims.kolas.contoller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.common.service.CommonService;
import iit.lims.kolas.service.KolasDocService;
import iit.lims.kolas.vo.KolasDocVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * KolasDocController
 * 
 * @author 석은주
 * @since 2015.02.02
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.02.02  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@RequestMapping(value = "/kolas/")
@Controller
public class KolasDocController {

	static final Logger log = LogManager.getLogger();

	@Resource
	private KolasDocService kolasDocService;
	@Resource
	private CommonService commonService;

	/**
	 * KOLAS 문서 등록 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("kolasDocManage.lims")
	public String kolasDocManage(HttpServletRequest request, Model model) {
		return "kolas/kolasDoc/kolasDocL01";
	}

	/**
	 * KOLAS 문서 현황 페이지 전환 처리
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("kolasDocList.lims")
	public String kolasDocList(HttpServletRequest request, Model model) {
		return "kolas/kolasDocList/kolasDocL01";
	}

	/**
	 * KOLAS 문서 등록 목록 조회
	 * 
	 * @param KolasDocVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectKolasDocList.lims")
	public ModelAndView selectKolasDocList(HttpServletRequest request, Model model, KolasDocVO vo) throws Exception {
		try {
			model.addAttribute("resultData", kolasDocService.selectKolasDocList(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 문서등록 상세정보 조회 / 신규 페이지 열기
	 * 
	 * @param TestMethodVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("selectKolasDocDetail.lims")
	public String selectKolasDocDetail(HttpServletRequest request, Model model, KolasDocVO vo) {
		try {
			KolasDocVO s_vo = kolasDocService.selectKolasDocDetail(vo);
			if (vo.getPageType().equals("insert")) {
				UserInfoVO userInfoVO = SessionCheck.getSession(request);
				s_vo.setCreater_id(userInfoVO.getUser_id());
				s_vo.setUser_nm(userInfoVO.getUser_nm());
				s_vo.setCreate_dept(userInfoVO.getDept_cd());
				s_vo.setDept_nm(userInfoVO.getDept_nm());
			}
			model.addAttribute("detail", s_vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "kolas/kolasDoc/kolasDocD01";
	}

	/**
	 * 문서등록 신규등록
	 * 
	 * @param KolasDocVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("insertKolasDoc.lims")
	public ModelAndView insertKolasDoc(HttpServletRequest request, Model model, KolasDocVO vo) throws Exception {
		try {
			model.addAttribute("resultData", kolasDocService.insertKolasDoc(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 문서등록 수정
	 * 
	 * @param KolasDocVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("updateKolasDoc.lims")
	public ModelAndView updateKolasDoc(HttpServletRequest request, Model model, KolasDocVO vo) throws Exception {
		try {
			int result = kolasDocService.updateKolasDoc(vo);
			model.addAttribute("resultData", result);
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new JsonView());
	}

	/**
	 * 문서등록 삭제
	 * 
	 * @param KolasDocVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	/*	@RequestMapping("deleteKolasDoc.lims")
		public ModelAndView deleteKolasDoc(HttpServletRequest request, Model model, KolasDocVO vo) throws Exception {
			try {
				model.addAttribute("resultData", kolasDocService.deleteKolasDoc(vo));
			} catch (Exception e) {
				log.error(vo.toString(), e);
				throw e;
			}
			return new ModelAndView(new JsonView());
		}*/

	/**
	 * 문서등록 첨부파일 다운로드
	 * 
	 * @param KolasDocVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("kolasDocDown.lims")
	public ModelAndView kolasDocDown(HttpServletResponse response, Model model, KolasDocVO vo) throws Exception {
		try {
			KolasDocVO k = kolasDocService.kolasDocDown(vo);

			if (k != null) {
				model.addAttribute("data", k.getAtt_file());
				model.addAttribute("fileName", k.getAdd_file_nm());
			}
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
		return new ModelAndView(new ByteDownloadView());
	}

}
