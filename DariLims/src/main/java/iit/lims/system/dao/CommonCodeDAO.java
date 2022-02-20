package iit.lims.system.dao;

import iit.lims.master.vo.OxideMarkVO;
import iit.lims.system.vo.CommonCodeVO;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CommonCodeDAO extends EgovAbstractMapper {
	public List<CommonCodeVO> selectCommonCodeCombo(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonCodeCombo", vo);
	}

	public List<CommonCodeVO> selectCommonCodeDepth(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonCodeDepth", vo);
	}
	
	public List<CommonCodeVO> selectCommonCodeDept() throws Exception {
		return selectList("commonCode.selectCommonCodeDept", null);
	}

	public List<CommonCodeVO> selectCommonCodePreDept() throws Exception {
		return selectList("commonCode.selectCommonCodePreDept", null);
	}
	
	public List<CommonCodeVO> selectEstFeeGubun() throws Exception {
		return selectList("commonCode.selectEstFeeGubun", null);
	}
	
	public List<CommonCodeVO> selectCommonCodeStd() throws Exception {
		return selectList("commonCode.selectCommonCodeStd", null);
	}

	public List<CommonCodeVO> selectCommonCodeUnitWork(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonCodeUnitWork", vo);
	}

	public List<CommonCodeVO> selectCommonCodeState() throws Exception {
		return selectList("commonCode.selectCommonCodeState", null);
	}
	
	public List<CommonCodeVO> selectCommonCodeStatusState() throws Exception {
		return selectList("commonCode.selectCommonCodeStatusState", null);
	}

	public List<CommonCodeVO> selectCommonCodeReport() throws Exception {
		return selectList("commonCode.selectCommonCodeReport", null);
	}

	public List<CommonCodeVO> selectCommonCodePaper(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonCodePaper", vo);
	}

	public List<CommonCodeVO> selectCommonCodeSample(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonCodeSample", vo); 
	}

	public List<CommonCodeVO> selectCommonCodeCounselPath() throws Exception {
		return selectList("commonCode.selectCommonCodeCounselPath", null);
	}
	
	public List<CommonCodeVO> selectCommonCodeCounselDiv() throws Exception {
		return selectList("commonCode.selectCommonCodeCounselDiv", null);
	}
	
	public List<CommonCodeVO> selectCommonCodeCounselprogressSts() throws Exception {
		return selectList("commonCode.selectCommonCodeCounselprogressSts", null);
	}
	
	public List<CommonCodeVO> selectCommonFormType() throws Exception {
		return selectList("commonCode.selectCommonFormType", null);
	}
	
	public List<CommonCodeVO> selectCommonFormTypeDetail(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonFormTypeDetail", vo);
	}

	public List<CommonCodeVO> selectCommonCodePrdlst_gubun(CommonCodeVO vo) {
		return selectList("commonCode.selectCommonCodePrdlst_gubun", vo);
	}
	
	public List<CommonCodeVO> selectCommonTestItemL() throws Exception {
		return selectList("commonCode.selectCommonTestItemL", null);
	}
	
	public List<CommonCodeVO> selectCommonTestItemM(CommonCodeVO vo) throws Exception {
		return selectList("commonCode.selectCommonTestItemM", vo);
	}

	public List<CommonCodeVO> selectReqType(CommonCodeVO vo)throws Exception {
		return selectList("commonCode.selectReqType", vo);
	}
	
	public List<CommonCodeVO> selectCommonOrgList() throws Exception {
		return selectList("commonCode.selectCommonOrgList", null);
	}

	public List<CommonCodeVO> selectCommonCodeEX1Combo(CommonCodeVO vo) throws Exception{
		return selectList("commonCode.selectCommonCodeEX1Combo", vo);
	}

	public List<CommonCodeVO> selectCommonCodeEX2Combo(CommonCodeVO vo) throws Exception{
		return selectList("commonCode.selectCommonCodeEX2Combo", vo);
	}
	
	public List<CommonCodeVO> selectCommonCodeUser(CommonCodeVO vo) throws Exception{
		return selectList("commonCode.selectCommonCodeUser", vo);
	}
	
	public List<CommonCodeVO> selectFormComboList(CommonCodeVO vo) throws Exception{
		return selectList("commonCode.selectFormComboList", vo);
	}
	
	//항목관리 > 산화물표기 조회 
	public List<OxideMarkVO> selectItemOxideMarkList(OxideMarkVO vo) throws Exception {
		return selectList("commonCode.selectItemOxideMarkList", vo);
	}
	
	public List<OxideMarkVO> selectProtocolList(OxideMarkVO vo) throws Exception {
		return selectList("commonCode.selectProtocolList", vo);
	}
	
}
