package iit.lims.system.service.impl;

import iit.lims.master.vo.OxideMarkVO;
import iit.lims.system.dao.CommonCodeDAO;
import iit.lims.system.service.CommonCodeService;
import iit.lims.system.vo.CommonCodeVO;

import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class CommonCodeServiceImpl extends EgovAbstractServiceImpl implements CommonCodeService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "commonCodeDAO")
	private CommonCodeDAO commonCodeDAO;

	/**
	 * 공통코드 콤보 조회 - 공통
	 * 
	 * @param code_group
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeCombo(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonCodeCombo(vo);
	}

	/**
	 * 공통코드 EX1 조회 - 공통
	 * 
	 * @param code_group
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeDepth(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonCodeDepth(vo);
	}
	
	/**
	 * 공통코드 콤보 조회 - 부서
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeDept() throws Exception {
		return commonCodeDAO.selectCommonCodeDept();
	}
	
	/**
	 * 공통코드 콤보 조회 - 모든부서
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodePreDept() throws Exception {
		return commonCodeDAO.selectCommonCodePreDept();
	}
	
	/**
	 * 공통코드 견적 항목 수수료 
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectEstFeeGubun() throws Exception {
		return commonCodeDAO.selectEstFeeGubun();
	}

	/**
	 * 공통코드 콤보 조회 - 기준
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeStd() throws Exception {
		return commonCodeDAO.selectCommonCodeStd();
	}

	/**
	 * 공통코드 콤보 조회 - 단위업무
	 * 
	 * @param code_group
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeUnitWork(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonCodeUnitWork(vo);
	}

	/**
	 * 공통코드 콤보 조회 - 진행상태
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeState() throws Exception {
		return commonCodeDAO.selectCommonCodeState();
	}
	
	/**
	 * 공통코드 콤보 조회 - 진행상태(통계)
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeStatusState() throws Exception {
		return commonCodeDAO.selectCommonCodeStatusState();
	}

	/**
	 * 공통코드 콤보 조회 - 성적서
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeReport() throws Exception {
		return commonCodeDAO.selectCommonCodeReport();
	}

	/**
	 * 공통코드 콤보 조회 - 보고서
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodePaper(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonCodePaper(vo);
	}

	public List<CommonCodeVO> selectCommonCodeSample(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonCodeSample(vo);
	}
	
	public List<CommonCodeVO> selectCommonCodeCounselPath() throws Exception {
		return commonCodeDAO.selectCommonCodeCounselPath();
	}
	
	public List<CommonCodeVO> selectCommonCodeCounselDiv() throws Exception {
		return commonCodeDAO.selectCommonCodeCounselDiv();
	}
	
	public List<CommonCodeVO> selectCommonCodeCounselprogressSts() throws Exception {
		return commonCodeDAO.selectCommonCodeCounselprogressSts();
	}
	
	public List<CommonCodeVO> selectCommonCodePrdlst_gubun(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonCodePrdlst_gubun(vo);
	}
	
	/**
	 * 공통코드 콤보 조회 - 양식종류
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonFormType() throws Exception {
		return commonCodeDAO.selectCommonFormType();
	}
	
	/**
	 * 공통코드 콤보 조회 - 양식종류리스트
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonFormTypeDetail(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonFormTypeDetail(vo);
	}
	
	/**
	 * 공통코드 콤보 조회 - 항목 대분류 콤보
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonTestItemL() throws Exception {
		return commonCodeDAO.selectCommonTestItemL();
	}
	
	/**
	 * 공통코드 콤보 조회 - 항목 중분류 콤보
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonTestItemM(CommonCodeVO vo) throws Exception {
		return commonCodeDAO.selectCommonTestItemM(vo);
	}
	
	/**
	 * 공통코드 콤보 조회 - 업체 리스트 콤보
	 * 
	 * @param
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonOrgList() throws Exception {
		return commonCodeDAO.selectCommonOrgList();
	}
	
	public List<CommonCodeVO> selectCommonCodeEX1Combo(CommonCodeVO vo)throws Exception{
		return commonCodeDAO.selectCommonCodeEX1Combo(vo);
	}
	
	public List<CommonCodeVO> selectCommonCodeEX2Combo(CommonCodeVO vo)throws Exception{
		return commonCodeDAO.selectCommonCodeEX2Combo(vo);
	}
	
	public List<CommonCodeVO> selectCommonCodeUser(CommonCodeVO vo)throws Exception{
		return commonCodeDAO.selectCommonCodeUser(vo);
	}
	
	public List<CommonCodeVO> selectFormComboList(CommonCodeVO vo)throws Exception{
		return commonCodeDAO.selectFormComboList(vo);
	}
	/**
	 * 항목 관리 > 산화물 표기 선택
	 * 
	 * @param oxideMark
	 * @throws Exception
	 */
	public List<OxideMarkVO> selectItemOxideMarkList(OxideMarkVO vo) throws Exception {
		return commonCodeDAO.selectItemOxideMarkList(vo);
	}
	
	public List<OxideMarkVO> selectProtocolList(OxideMarkVO vo) throws Exception {
		return commonCodeDAO.selectProtocolList(vo);
	}

}
