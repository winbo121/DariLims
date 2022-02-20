package iit.lims.master.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.master.service.DocumentService;
import iit.lims.master.vo.DocumentVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.ByteDownloadView;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * Document
 * 
 * @author 최은향
 * @since 2015.10.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.10.01  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Controller
@RequestMapping(value = "/master/")
public class DocumentController {
	static final Logger log = LogManager.getLogger();

	@Resource
	private DocumentService documentService;

	/**
	 * 양식 관리 페이지
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/documentManage.lims")
	public String sampleInput(HttpServletRequest request, Model model) {
		return "master/document/documentL01";
	}

	/**
	 * 양식 관리 목록 조회
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectFormList.lims")
	public ModelAndView selectFormList(HttpServletRequest request, Model model, DocumentVO vo) {
		try {
			model.addAttribute("resultData", documentService.selectFormList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	


	/**
	 * 양식 관리 저장
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertForm.lims")
	public ModelAndView insertForm(HttpServletRequest request, Model model, DocumentVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			model.addAttribute("resultData", documentService.insertForm(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
		

	/**
	 * 양식 관리 수정 처리
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateForm.lims")
	public ModelAndView updateForm(HttpServletRequest request, @ModelAttribute("vo") DocumentVO vo, Model model) throws Exception {
		try {
			//vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			int result = documentService.updateForm(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 양식 관리 삭제 처리
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteForm.lims")
	public ModelAndView deleteForm(HttpServletRequest request, @ModelAttribute("vo") DocumentVO vo, Model model) throws Exception {
		try {
			int result = documentService.deleteForm(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 문서 관리 목록 조회
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/selectDocumentList.lims")
	public ModelAndView selectDocumentList(HttpServletRequest request, Model model, DocumentVO vo) {
		try {
			model.addAttribute("resultData", documentService.selectDocumentList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(new JsonView());
	}	
	
	/**
	 * 문서 관리 상세 페이지
	 * 
	 * @param HttpServletRequest
	 *            , Model, ReagentsGlassVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/documentDetail.lims")
	public String documentDetail(HttpServletRequest request, Model model, DocumentVO vo) {
		try {
			if( request.getParameter("key") != "" && request.getParameter("key") != null ) {		
				model.addAttribute("detail", documentService.documentDetail(request, vo));
			} else {
				model.addAttribute("detail", new DocumentVO());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "master/document/documentD01";
	}

	/**
	 * 문서 관리 저장
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/insertDocument.lims")
	public ModelAndView insertDocument(HttpServletRequest request, Model model, DocumentVO vo) throws Exception {
		try {
			UserInfoVO userInfoVO = SessionCheck.getSession(request);
			vo.setUser_id(userInfoVO.getUser_id());
			//vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			model.addAttribute("resultData", documentService.insertDocument(vo));
		} catch (Exception e) {
			log.error(vo.toString(), e);
		}
		return new ModelAndView(new JsonView());
	}
		

	/**
	 * 문서 관리 수정 처리
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/updateDocument.lims")
	public ModelAndView updateDocument(HttpServletRequest request, @ModelAttribute("vo") DocumentVO vo, Model model) throws Exception {
		try {
			//UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("session");
			//vo.setUser_id(userInfoVO.getUser_id());
			//vo.setTest_sample_seq(request.getParameter("test_sample_seq"));
			int result = documentService.updateDocument(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}

	/**
	 * 문서 관리 삭제 처리
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/deleteDocument.lims")
	public ModelAndView deleteDocument(HttpServletRequest request, @ModelAttribute("vo") DocumentVO vo, Model model) throws Exception {
		try {
			int result = documentService.deleteDocument(vo);
			model.addAttribute("resultData", result);
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}
	
	/**
	 * 문서 관리 첨부파일 다운로드
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/formDocDown.lims")
	public ModelAndView formDocDown(HttpServletResponse response, Model model, DocumentVO vo) throws Exception {
		try {
			DocumentVO D = documentService.formDocDown(vo);
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
	 * 다음 양식 번호 조회
	 * 
	 * @param DocumentVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	
	@RequestMapping("/selectFormNo.lims")
	public ModelAndView selectFormNo(HttpServletRequest request, @ModelAttribute("vo") DocumentVO vo, Model model) throws Exception {
		try {
			DocumentVO doc = documentService.selectFormNo(vo);
			//String result = doc.getForm_seq();
			//System.out.println(doc.getForm_seq());
			model.addAttribute("resultData", doc.getForm_seq());
			return new ModelAndView(new JsonView());
		} catch (Exception e) {
			log.error(vo.toString(), e);
			throw e;
		}
	}	
}
