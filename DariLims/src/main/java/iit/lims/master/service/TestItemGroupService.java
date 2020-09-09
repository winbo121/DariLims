package iit.lims.master.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import iit.lims.master.vo.TestItemVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.util.JsonView;
import iit.lims.util.SessionCheck;

/**
 * TestItemGroupService
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
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
public interface TestItemGroupService {
	/**
	 * 항목그룹 목록 조회
	 * 
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectItemGroupList(TestItemVO vo) throws Exception;

	/**
	 * 시험 항목그룹 목록 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectTestItemInGroupList(TestItemVO vo) throws Exception;

	/**
	 * 모든 항목 조회
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<TestItemVO> selectAllTestItemList(TestItemVO vo) throws Exception;

	/**
	 * 그룹항목 저장
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int saveTestItemInGroup(TestItemVO vo) throws Exception;

	/**
	 * 항목그룹 등록
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int insertTestItemGroup(TestItemVO vo) throws Exception;

	/**
	 * 항목그룹 수정
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int updateTestItemGroup(TestItemVO vo) throws Exception;

	/**
	 * 항목그룹 삭제
	 * 
	 * @param TestItemVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int deleteTestItemGroup(TestItemVO vo) throws Exception;

	/**
	 * 그룹항목 복사
	 * 
	 * @param TestItemVO
	 * @return int
	 * @throws Exception
	 */
	public int copyTestItemGroup(TestItemVO vo) throws Exception;
		
	
}
