package iit.lims.common.service;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.common.vo.DemoSampleVO;
import iit.lims.common.vo.ExcelVO;
import iit.lims.common.vo.TreeVO;
import iit.lims.common.vo.CommonVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.SamplingPointVO;
import iit.lims.report.vo.ReportVO;
import iit.lims.system.vo.UserInfoVO;
import iit.lims.analysis.vo.SampleStateVO;
import iit.lims.common.vo.ZipCodeVO;
import iit.lims.common.vo.MakeGridVO;
import iit.lims.analysis.vo.ResultApprovalVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CommonService {

	public UserInfoVO loginCheck(UserInfoVO userInfoVO);
	
	public ArrayList<TreeVO> selectMenuList(HashMap<String, String> vo);

	public List<DemoSampleVO> selectSampleList(DemoSampleVO vo) throws Exception;

	public List<Map<String, Object>> selectSampleListMAP(DemoSampleVO sampleVO) throws Exception;
	
	public AcceptVO selectAcceptInfo(AcceptVO vo) throws Exception;

	public List<AcceptVO> selectTestComment(AcceptVO vo) throws Exception;
	
	public List<SampleStateVO> selectStateInfoList(AcceptVO vo) throws Exception;

	public List<SampleStateVO> selectStateInfo(AcceptVO vo) throws Exception;

	public MakeGridVO selectAcceptResultInfo(MakeGridVO vo) throws Exception;
	
	public int returnToBegining(AcceptVO vo) throws Exception;
	
	public List<ZipCodeVO> selectAddrList(ZipCodeVO vo) throws Exception;
	
	public int updateReturnFlag(AcceptVO vo) throws Exception;

	public List<ResultApprovalVO> selectReturnCommentList(AcceptVO vo) throws Exception;

	public int cancelReturnFlag(AcceptVO vo) throws Exception;

	public int updateReturnComment(AcceptVO vo) throws Exception;

	public int copyReturnFlag(AcceptVO vo) throws Exception;
	
	public int rdmsViewer(HashMap<String, String> m) throws Exception;

	public ReportVO selectReportInfo(ReportVO reportVO)throws Exception;

	public List<ReportVO> selectReportInfoItem(ReportVO reportVO)throws Exception;
	public List<ReportVO> selectReportInfoItem2(ReportVO reportVO)throws Exception;

	public ReportVO selectReportVerify(ReportVO vo) throws Exception;
	
	public ArrayList<AcceptVO> selectDeadlineSampleList(UserInfoVO vo) throws Exception;

	public ArrayList<AcceptVO> selectResultInputList(UserInfoVO vo) throws Exception;

	public CommonVO selectResultMainCntList(UserInfoVO vo) throws Exception;
	
	public CommonVO selectMachineMainCntList(UserInfoVO vo) throws Exception;
	
	public ArrayList<ExcelVO> excelDownload(ExcelVO vo) throws Exception;

	public List<UserInfoVO> menuAuthCheck(UserInfoVO vo)throws Exception;

	public String selectDocFileInfo(String doc_seq)throws Exception;
	
	public String selectMaxDocFileInfo(String doc_seq)throws Exception;
	
	public void logout(UserInfoVO userInfoVO) throws Exception;

	public int selectAddrPagingListTotCnt(ZipCodeVO vo) throws Exception;



	public ReportVO selectRequestInfo(ReportVO vo)throws Exception;

	public List<ReportVO> selectRequestInfoItem(ReportVO vo)throws Exception;
	
	public ReqOrgVO selectOrgInfo(ReqOrgVO vo)throws Exception;
	
	public List<AcceptVO> selectTransactionDetails(AcceptVO acceptVO)throws Exception;

	public List<AcceptVO> selectTransactionStatement(AcceptVO acceptVO)throws Exception;
	
}
