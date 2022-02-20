package iit.lims.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.TestMethodDAO;
import iit.lims.master.service.TestMethodService;
import iit.lims.master.vo.TestMethodVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * TestMethodServiceImpl
 * 
 * @author 석은주
 * @since 2015.01.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.22  석은주   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class TestMethodServiceImpl extends EgovAbstractServiceImpl implements TestMethodService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "testMethodDAO")
	private TestMethodDAO testMethodDAO;

	/**
	 * 시험방법 목록 조회
	 * 
	 * @param TestMethodVO
	 * @throws Exception
	 */
	@Override
	public List<TestMethodVO> selectTestMethodList(TestMethodVO vo) throws Exception {
		return testMethodDAO.selectTestMethodList(vo);
	}

	/**
	 * 시험방법 상세정보 조회 / 신규페이지 열기
	 * 
	 * @param TestMethodVO
	 * @throws Exception
	 */
	@Override
	public TestMethodVO selectTestMethodDetail(TestMethodVO vo) throws Exception {
		try {
			if (vo.getPageType().equals("detail")) {
				return testMethodDAO.selectTestMethodDetail(vo);
			} else {
				return new TestMethodVO();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시험방법 신규등록
	 * 
	 * @param TestMethodVO
	 * @throws Exception
	 */
	@Override
	public int insertTestMethod(TestMethodVO vo) throws Exception {
		try {
			if (vo.getM_file() != null && vo.getM_file().getSize() > 0) {
				vo.setAtt_file(vo.getM_file().getBytes());
				vo.setFile_nm(vo.getM_file().getOriginalFilename());
			}
			return testMethodDAO.insertTestMethod(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시험방법 수정
	 * 
	 * @param TestMethodVO
	 * @throws Exception
	 */
	@Override
	public int updateTestMethod(TestMethodVO vo) throws Exception {
		try {
			if (vo.getM_file() != null && vo.getM_file().getSize() > 0) {
				vo.setAtt_file(vo.getM_file().getBytes());
				vo.setFile_nm(vo.getM_file().getOriginalFilename());
			}
			return testMethodDAO.updateTestMethod(vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 시험방법 첨부파일 다운로드
	 * 
	 * @param TestMethodVO
	 * @throws Exception
	 */
	@Override
	public TestMethodVO testMethodDown(TestMethodVO vo) throws Exception {
		try {
			return testMethodDAO.testMethodDown(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
}