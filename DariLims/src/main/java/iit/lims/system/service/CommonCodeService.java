package iit.lims.system.service;

import iit.lims.master.vo.OxideMarkVO;
import iit.lims.system.vo.CommonCodeVO;

import java.util.List;

public interface CommonCodeService {
	/**
	 * 공통코드 콤보 조회 - 공통
	 * 
	 * @param code_group
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonCodeCombo(CommonCodeVO vo) throws Exception;
	

	/**
	 * 공통코드 EX1 조회 - 공통
	 * 
	 * @param code_group
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonCodeDepth(CommonCodeVO vo) throws Exception;
	
	/**
	 * 공통코드 콤보 조회 - 부서
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonCodeDept() throws Exception;

	/**
	 * 공통코드 콤보 조회 - 시험기준
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonCodeStd() throws Exception;

	/**
	 * 공통코드 콤보 조회 - 단위업무
	 * 
	 * @param code_group
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonCodeUnitWork(CommonCodeVO vo) throws Exception;

	/**
	 * 공통코드 콤보 조회 - 진행상태
	 * 
	 * @param
	 * @return List
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeState() throws Exception;
	
	/**
	 * 공통코드 콤보 조회 - 진행상태(통계)
	 * 
	 * @param
	 * @return List
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeStatusState() throws Exception;

	/**
	 * 공통코드 콤보 조회 - 성적서
	 * 
	 * @param
	 * @return List
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodeReport() throws Exception;

	/**
	 * 공통코드 콤보 조회 - 보고서
	 * 
	 * @param
	 * @return List
	 * @throws Exception
	 */
	public List<CommonCodeVO> selectCommonCodePaper(CommonCodeVO vo) throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeSample(CommonCodeVO vo) throws Exception;

	public List<CommonCodeVO> selectCommonCodePreDept() throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeCounselPath() throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeCounselDiv() throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeCounselprogressSts() throws Exception;

	public List<CommonCodeVO> selectEstFeeGubun() throws Exception;
	
	/**
	 * 공통코드 콤보 조회 - 양식종류
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonFormType() throws Exception;

	public List<CommonCodeVO> selectCommonFormTypeDetail(CommonCodeVO vo)throws Exception;

	/**
	 * 공통코드 콤보 조회 - 품목대분류(1레벨)
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonCodePrdlst_gubun(CommonCodeVO vo)throws Exception;
	
	/**
	 * 공통코드 콤보 조회 - 항목 대분류 콤보
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonTestItemL() throws Exception;
	
	
	/**
	 * 공통코드 콤보 조회 - 항목 중분류 콤보
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonTestItemM(CommonCodeVO vo) throws Exception;

	/**
	 * 공통코드 콤보 조회 - 업체 리스트 콤보
	 * 
	 * @param
	 * @return List
	 * @exception Exception
	 */
	public List<CommonCodeVO> selectCommonOrgList() throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeEX1Combo(CommonCodeVO vo)throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeEX2Combo(CommonCodeVO vo)throws Exception;
	
	public List<CommonCodeVO> selectCommonCodeUser(CommonCodeVO vo)throws Exception;
	
	public List<CommonCodeVO> selectFormComboList(CommonCodeVO vo)throws Exception;

	//산화물표기 조회
	public List<OxideMarkVO> selectItemOxideMarkList(OxideMarkVO vo) throws Exception;
	
	public List<OxideMarkVO> selectProtocolList(OxideMarkVO vo) throws Exception;

}
