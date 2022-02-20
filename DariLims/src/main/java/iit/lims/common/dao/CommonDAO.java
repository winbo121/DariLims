package iit.lims.common.dao;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultApprovalVO;
import iit.lims.analysis.vo.SampleStateVO;
import iit.lims.common.vo.CommonVO;
import iit.lims.common.vo.HistoryVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.common.vo.DemoSampleVO;
import iit.lims.common.vo.ZipCodeVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.report.vo.ReportVO;
import iit.lims.system.vo.RoleVO;
import iit.lims.system.vo.UserInfoVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CommonDAO extends EgovAbstractMapper {

	public UserInfoVO selectAccessIpFlag(UserInfoVO vo) {
		return selectOne("common.selectAccessIpFlag", vo);
	}
	
	public UserInfoVO selectUserInfoCheck(UserInfoVO userInfoVO) throws Exception {
		return selectOne("common.selectUserInfoCheck", userInfoVO);
	}
	
	public List<DemoSampleVO> selectSampleList(DemoSampleVO sampleVO) throws Exception{
		return selectList("common.selectSampleList", sampleVO);
		
	}

	public List<Map<String, Object>> selectSampleListMAP(DemoSampleVO sampleVO) throws Exception{
		return selectList("common.selectSampleListMAP", sampleVO);
		
	}
	
	public List<RoleVO> preMenu(HashMap<String, String> map) {
		return selectList("common.preMenu", map);
	}

	public List<RoleVO> menu(HashMap<String, String> map) {
		return selectList("common.menu", map);
	}
	
	public void insertSampleHistory(HistoryVO vo) {
		insert("common.insertSampleHistory", vo);
	}

	public void insertSampleHistoryAll(HistoryVO vo) {
		insert("common.insertSampleHistoryAll", vo);
	}
	
	public Integer selectUserIdCheck(UserInfoVO userInfoVO) {
		return selectOne("common.selectUserIdCheck", userInfoVO);
	}

	public Integer selectUserPwCheck(UserInfoVO userInfoVO) {
		return selectOne("common.selectUserPwCheck", userInfoVO);
	}

	public Integer selectUserIpCheck(UserInfoVO userInfoVO) {
		return selectOne("common.selectUserIpCheck", userInfoVO);
	}
	
	public List<String> selectSampleSeqList(String s) throws Exception {
		return selectList("common.selectSampleSeqList", s);
	}

	public String selectRDViewFile(ReportVO vo) throws Exception {
		return selectOne("common.selectRDViewFile", vo);
	}

	public List<AcceptVO> selectDeadlineSampleList(UserInfoVO vo) throws Exception {
		return selectList("common.selectDeadlineSampleList", vo);
	}

	public List<AcceptVO> selectResultInputList(UserInfoVO vo) throws Exception {
		return selectList("common.selectResultInputList", vo);
	}

	public CommonVO selectResultMainCntList(UserInfoVO vo) throws Exception {
		return selectOne("common.selectResultMainCntList", vo);
	}
	
	public CommonVO selectMachineMainCntList(UserInfoVO vo) throws Exception {
		return selectOne("common.selectMachineMainCntList", vo);
	}

	public List<String> selectRDMSViwer(HashMap<String, String> m) throws Exception {
		return selectList("common.selectRDMSViwer", m);
	}

	public void insertRDMSViewer(HashMap<String, String> m) throws Exception {
		insert("common.insertRDMSViewer", m);
	}

	public List<ZipCodeVO> selectAddrList(ZipCodeVO vo) throws Exception {
		return selectList("common.selectAddrList", vo);
	}

	public void returnToBegining(AcceptVO vo) throws Exception {
		update("common.returnToBegining", vo);
	}

	public AcceptVO selectAcceptInfo(AcceptVO vo) {
		return selectOne("common.selectAcceptInfo", vo);
	}

	public List<AcceptVO> selectTestComment(AcceptVO vo) {
		return selectList("common.selectTestComment", vo);
	}

	public String selectAlert(String user_id) throws Exception {
		return selectOne("common.selectAlert", user_id);
	}

	public List<SampleStateVO> selectStateInfoList(AcceptVO vo) {
		return selectList("common.selectStateInfoList", vo);
	}

	public List<SampleStateVO> selectStateInfo(AcceptVO vo) {
		return selectList("common.selectStateInfo", vo);
	}

	public List<String> selectAcceptResultInfoColumn(MakeGridVO vo) throws Exception {
		return selectList("common.selectAcceptResultInfoColumn", vo);
	}

	public List<HashMap<String, String>> selectAcceptResultInfo(MakeGridVO vo) throws Exception {
		return selectList("common.selectAcceptResultInfo", vo);
	}

	public void updateReturnFlag(AcceptVO vo) throws Exception {
		update("common.updateReturnFlag", vo);
	}

	public List<ResultApprovalVO> selectReturnCommentList(AcceptVO vo) {
		return selectList("common.selectReturnCommentList", vo);
	}

	public void cancelReturnFlag(HashMap<String, String> m) throws Exception {
		update("common.cancelReturnFlag", m);
	}

	public void copyReturnFlag(HashMap<String, String> m) throws Exception {
		update("common.copyReturnFlag", m);
	}

	public void updateReturnComment(AcceptVO vo) throws Exception {
		update("common.updateReturnComment", vo);
	}

	public int updateTestState(AcceptVO vo) throws Exception {
		return update("common.updateTestState", vo);
	}

	public int updateTestStateAll(AcceptVO vo) throws Exception {
		return update("common.updateTestStateAll", vo);
	}
	
	public int deleteApprLine(AcceptVO vo) throws Exception {
		return delete("common.deleteApprLine", vo);
	}
	
	public ReportVO selectReportInfo(ReportVO vo)throws Exception {
		return selectOne("common.selectReportInfo", vo);
	}
	
	public List<ReportVO> selectReportInfoItem(ReportVO vo)throws Exception {
		return selectList("common.selectReportInfoItem", vo);
	}
	
	public List<ReportVO> selectReportInfoItem2(ReportVO vo)throws Exception {
		return selectList("common.selectReportInfoItem2", vo);
	}

	public ReportVO selectReportVerify(ReportVO vo) throws Exception{
		return selectOne("common.selectReportVerify", vo);
	}
	
	public List<UserInfoVO> menuAuthCheck(UserInfoVO vo)throws Exception {
		return selectList("common.menuAuthCheck", vo);
	}
	
	public String selectDocFileInfo(String doc_seq)throws Exception {
		return selectOne("common.selectDocFileInfo", doc_seq);
	}
	
	public String selectMaxDocFileInfo(String doc_seq)throws Exception {
		return selectOne("common.selectMaxDocFileInfo", doc_seq);
	}
	
	public int addrZipCnt(ZipCodeVO vo) {
		return (Integer) selectOne("common.addrZipCnt", vo);
	}

	public ReportVO selectRequestInfo(ReportVO vo)throws Exception {
		return selectOne("common.selectRequestInfo", vo);
	}
	
	public List<ReportVO> selectRequestInfoItem(ReportVO vo)throws Exception {
		return selectList("common.selectRequestInfoItem", vo);
	}
	
	public ReqOrgVO selectOrgInfo(ReqOrgVO vo)throws Exception {
		return selectOne("common.selectOrgInfo", vo);
	}
	
	public List<AcceptVO> selectTransactionDetails(AcceptVO vo)throws Exception {
		return selectList("common.selectTransactionDetails", vo);
	}
	public List<AcceptVO> selectTransactionStatement(AcceptVO vo)throws Exception {
		return selectList("common.selectTransactionStatement", vo);
	}
	
}
