package iit.lims.accept.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.accept.vo.CommissionCheckVO;
import iit.lims.master.vo.ReqOrgVO;
import iit.lims.master.vo.TestPrdStdVO;
import iit.lims.master.vo.TestStandardVO;
import iit.lims.system.vo.CommonCodeVO;

/**
 * MenuService
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
 *  2015.01.13  진영민   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */
@Repository
public class AcceptDAO extends EgovAbstractMapper {

	public List<CommonCodeVO> selectGridTestStdList() throws Exception {
		return selectList("accept.selectGridTestStdList", null);
	}

	public List<CommonCodeVO> selectGridDeptList() throws Exception {
		return selectList("accept.selectGridDeptList", null);
	}

	public List<CommonCodeVO> selectGridCommonCodeList(CommonCodeVO vo) throws Exception {
		return selectList("accept.selectGridCommonCodeList", vo);
	}

	public List<AcceptVO> selectAcceptList(AcceptVO vo) throws Exception {
		return selectList("accept.selectAcceptList", vo);
	}

	public List<AcceptVO> selectAcceptSampleList(AcceptVO vo) throws Exception {
		return selectList("accept.selectAcceptSampleList", vo);
	}

	public List<AcceptVO> selectAcceptItemList(AcceptVO vo) throws Exception {
		return selectList("accept.selectAcceptItemList", vo);
	}
	
	public String selectReqNo(HashMap<String, String> m) throws Exception {
		return selectOne("accept.selectReqNo", m);
	}

	public String selectReqSeq() throws Exception {
		return selectOne("accept.selectReqSeq", null);
	}
	
	public int insertOrgCommission(AcceptVO vo) throws Exception {
		insert("accept.insertOrgCommission", vo);
		return 1;
	}

	public int updateAccept(AcceptVO vo) throws Exception {
		return update("accept.updateAccept", vo);
	}
	
	public int updateOrgCommission(AcceptVO vo) throws Exception {
		return update("accept.updateOrgCommission", vo);
	}

	public int insertAccept(AcceptVO vo) throws Exception {
		insert("accept.insertAccept", vo);
		return 1;
	}
	
	public int insertAcceptSample(HashMap<String, String> m) throws Exception {
		insert("accept.insertAcceptSample", m);
		return 1;
	}

	public int updateAcceptSample(HashMap<String, String> m) throws Exception {
		return update("accept.updateAcceptSample", m);
	}

	public int deleteAcceptSample(HashMap<String, String> m) throws Exception {
		return delete("accept.deleteAcceptSample", m);
	}

	public int updateAcceptSampleTot(AcceptVO vo) throws Exception {
		return update("accept.updateAcceptSampleTot", vo);
	}

	public int insertAcceptItem(HashMap<String, String> m) throws Exception {
		insert("accept.insertAcceptItem", m);
		return 1;
	}
	
	public int insertEstimateItem(HashMap<String, String> m) throws Exception {
		insert("accept.insertEstimateItem", m);
		return 1;
	}
	
	public int insertInstRentItem(HashMap<String, String> m) throws Exception {
		insert("accept.insertInstRentItem", m);
		return 1;
	}

	public int insertTestStdPrdItem(HashMap<String, String> m) throws Exception {
		insert("accept.insertTestStdPrdItem", m);
		return 1;
	}
	
	public int insertTestStdItem(HashMap<String, String> m) throws Exception {
		insert("accept.insertTestStdItem", m);
		return 1;
	}
	
	public int updateAcceptItem(AcceptVO vo) throws Exception {
		return update("accept.updateAcceptItem", vo);
	}

	public int deleteAcceptItem(HashMap<String, String> m) throws Exception {
		return delete("accept.deleteAcceptItem", m);
	}
	
	public int updateAcceptItem(HashMap<String, String> m) throws Exception {
		return update("accept.updateAcceptItem", m);
	}

	public int deleteAcceptItem(AcceptVO vo) throws Exception {
		return delete("accept.deleteAcceptItem", vo);
	}
	
	public int deleteTestReport(AcceptVO vo) throws Exception {
		return delete("testReport.deleteTestReport", vo);
	}

	public AcceptVO selectAcceptDetail(AcceptVO vo) throws Exception {
		return selectOne("accept.selectAcceptDetail", vo);
	}

	public List<ReqOrgVO> selectReqOrgList(ReqOrgVO vo) throws Exception {
		return selectList("accept.selectReqOrgList", vo);
	}

	public List<AcceptVO> selectSampleItemCount(AcceptVO vo) throws Exception {
		return selectList("accept.selectSampleItemCount", vo);
	}

	public AcceptVO selectFeeTotal(AcceptVO vo) throws Exception {
		return selectOne("accept.selectFeeTotal", vo);
	}

	public int updateAcceptFee(AcceptVO vo) throws Exception {
		return update("accept.updateAcceptFee", vo);
	}

	public int checkSampleCount(AcceptVO vo) throws Exception {
		return selectOne("accept.checkSampleCount", vo);
	}

	public List<String> checkSampleItemCount(AcceptVO vo) throws Exception {
		return selectList("accept.checkSampleItemCount", vo);
	}

	public List<String> checkSampleItemUser(AcceptVO vo) throws Exception {
		return selectList("accept.checkSampleItemUser", vo);
	}

	public int updateAcceptState(AcceptVO vo) throws Exception {
		return update("accept.updateAcceptState", vo);
	}

	public List<AcceptVO> selectAcceptItemState(AcceptVO vo) throws Exception {
		return selectList("accept.selectAcceptItemState", vo);
	}

	public int updateAcceptItemState(AcceptVO vo) throws Exception {
		return update("accept.updateAcceptItemState", vo);
	}

	public int returnAcceptState(AcceptVO vo) throws Exception {
		return update("accept.returnAcceptState", vo);
	}

	public List<AcceptVO> selectTempleteSampleList(AcceptVO vo) throws Exception {
		return selectList("accept.selectTempleteSampleList", vo);
	}

	public List<AcceptVO> selectTempleteItemList(AcceptVO vo) throws Exception {
		return selectList("accept.selectTempleteItemList", vo);
	}

	public String selectTempleteCd() throws Exception {
		return selectOne("accept.selectTempleteCd", null);
	}

	public int insertTemplete(AcceptVO vo) throws Exception {
		return insert("accept.insertTemplete", vo);
	}

	public int updateTemplete(AcceptVO vo) throws Exception {
		return update("accept.updateTemplete", vo);
	}

	public int insertTempleteItem(HashMap<String, String> m) throws Exception {
		return insert("accept.insertTempleteItem", m);
	}

	public int deleteTempleteItem(AcceptVO vo) throws Exception {
		return delete("accept.deleteTempleteItem", vo);
	}

	public int insertAcceptTempleteItem(AcceptVO vo) throws Exception {
		return insert("accept.insertAcceptItem", vo);
	}

	public String selectAcceptSampleSeq(HashMap<String, String> m) throws Exception {
		return selectOne("accept.selectAcceptSampleSeq", m);
	}

	public List<AcceptVO> selectPopAllTestItemList(AcceptVO vo) throws Exception {
		return selectList("accept.selectPopAllTestItemList", vo);
	}
	
	public List<AcceptVO> selectPopStdTestItemList(AcceptVO vo) throws Exception {
		return selectList("accept.selectPopStdTestItemList", vo);
	}

	public int deleteAccept(AcceptVO vo) throws Exception {
		return delete("accept.deleteAccept", vo);
	}

	public int copyAccept(AcceptVO vo) throws Exception {
		return insert("accept.copyAccept", vo);
	}

	public int retestAccept(AcceptVO vo) throws Exception {
		return insert("accept.retestAccept", vo);
	}
	
	public int updateSampleItemCount(AcceptVO vo) throws Exception {
		return update("accept.updateSampleItemCount", vo);
	}
	
	public List<AcceptVO> teamListPop(AcceptVO vo) throws Exception {
		return selectList("accept.teamListPop", vo);
	}
	
	public AcceptVO bizFileDown(AcceptVO vo) throws Exception {
		return (AcceptVO) selectOne("accept.bizFileDown", vo);
	}
	
	public int insertTestReportOrgcommission(AcceptVO vo) throws Exception {
		return insert("accept.insertTestReportOrgcommission", vo);
	}
	
	public int updateAcceptSeq(AcceptVO vo) throws Exception {
		return update("accept.updateAcceptSeq", vo);
	}
	
	public int updateSampleSeq(AcceptVO vo) throws Exception {
		return update("accept.updateSampleSeq", vo);
	}
	
	public int updateItemSeq(AcceptVO vo) throws Exception {
		return update("accept.updateItemSeq", vo);
	}
	public int copyTestSample(HashMap<String, String> m) throws Exception{
		return insert("accept.copyTestSample",m);
	}
	
	
	// 시험일지 작성
	public int insertTestReport(AcceptVO vo){
		return insert("accept.insertTestReport", vo);
	}
	
	// 업체별 수수료에 작성
	public int insertCommissionDeposit(AcceptVO vo){
		return insert("accept.insertCommissionDeposit", vo);
	}
	
	public List<AcceptVO> selectSampleFileList(AcceptVO vo) {
		return selectList("accept.selectSampleFileList", vo);
	}
	
	public List<AcceptVO> selectSampleItemFileList(AcceptVO vo) {
		return selectList("accept.selectSampleItemFileList", vo);
	}
	
	//의뢰별 첨부문서
	public List<AcceptVO> selectRequestFileList(AcceptVO vo) {
		return selectList("accept.selectRequestFileList", vo);
	}
	
	public AcceptVO sampleFilePop(AcceptVO vo) {
		return (AcceptVO) selectOne("accept.sampleFileDetail", vo);
	}	
	
	public int insertSampleFile(AcceptVO vo) throws Exception {
		return insert("accept.insertTestSampleFile", vo);
	}

	public int updateSampleFile(AcceptVO vo) throws Exception {
		return update("accept.updateTestSampleFile", vo);
	}
	
	public int deleteSampleFile(AcceptVO vo) throws Exception {
		return delete("accept.deleteTestSampleFile", vo);
	}
	
	public AcceptVO sampleFileDown(AcceptVO vo) throws Exception {
		return (AcceptVO) selectOne("accept.testSampleFileDown", vo);
	}	
	
	public AcceptVO itemFilePop(AcceptVO vo) {
		return (AcceptVO) selectOne("accept.itemFileDetail", vo);
	}
	
	public int insertItemFile(AcceptVO vo) throws Exception {
		return insert("accept.insertTestSampleItemFile", vo);
	}

	public int updateItemFile(AcceptVO vo) throws Exception {
		return update("accept.updateTestSampleItemFile", vo);
	}
	
	public int deleteItemFile(AcceptVO vo) throws Exception {
		return delete("accept.deleteTestSampleItemFile", vo);
	}
	
	public AcceptVO itemFileDown(AcceptVO vo) throws Exception {
		return (AcceptVO) selectOne("accept.testSampleItemFileDown", vo);
	}	
	
	//의뢰별 첨부문서
	public AcceptVO requestFilePop(AcceptVO vo) {
		return (AcceptVO) selectOne("accept.requestFileDetail", vo);
	}	
	
	public int insertRequestFile(AcceptVO vo) throws Exception {
		return insert("accept.insertTestRequestFile", vo);
	}

	public int updateRequestFile(AcceptVO vo) throws Exception {
		return update("accept.updateTestRequestFile", vo);
	}
	
	public int deleteRequestFile(AcceptVO vo) throws Exception {
		return delete("accept.deleteTestRequestFile", vo);
	}
	
	public AcceptVO requestFileDown(AcceptVO vo) throws Exception {
		return (AcceptVO) selectOne("accept.testRequestFileDown", vo);
	}	
	
	public List<TestPrdStdVO> selectPopAllMfdsStdItemList(TestPrdStdVO vo) throws Exception {
		return selectList("accept.selectPopAllMfdsStdItemList", vo);
	}
	
	public List<AcceptVO> selectPopAllSelfStdItemList(AcceptVO vo) throws Exception {
		return selectList("accept.selectPopAllSelfStdItemList", vo);
	}
	
	public int saveItemMasterFee(AcceptVO vo) throws Exception {
		return update("accept.saveItemMasterFee", vo);
	}
	

	public AcceptVO selectFeeValue(AcceptVO vo) throws Exception {
		return selectOne("accept.selectFeeValue", vo);
	}
	public CommissionCheckVO selectOrgUnpaid(CommissionCheckVO vo) throws Exception {
		return selectOne("accept.selectOrgUnpaid", vo);
	}
	

	//라벨프린트
	public List<AcceptVO> labelPrint(AcceptVO vo) {
		return selectList("accept.labelPrint", vo);
	}
	
	
	/**
	 * 2019-10-01
	 * 의뢰 정보. 채취 방법, 채취 구분 저장
	 */
	public int insertCollect (AcceptVO vo) {
		return insert("accept.insertCollect", vo);
	}
	
	public int deleteCollect (AcceptVO vo) {
		return delete("accept.deleteCollect", vo);
	}
	
	public List<AcceptVO> getCollectCodeList (AcceptVO vo) {
		return selectList("accept.getCollectCodeList", vo);
	}
	
	/**
	 * 팝업창 스탠다드 추가
	 * @param map
	 * @return List
	 * @exception Exception
	 */
	public int insertStdPLItem(TestStandardVO vo) throws Exception {
		insert("accept.insertStdPLItem", vo);
		return 1;
	}
	
	/**
	 * 팝업창 스탠다드 추가
	 * @param map
	 * @return List
	 * @exception Exception
	 */
	public int updateStdItemGrid(HashMap<String,String> map) throws Exception {
		return update("accept.updateStdItemGrid", map);

	}
	
	/**
	 * 팝업창 스탠다드 리셋
	 * @param map
	 * @return List
	 * @exception Exception
	 */
	public int updateStandardResetItem(AcceptVO vo) throws Exception {
		return update("accept.updateStandardResetItem", vo);

	}
	
	public List<TestPrdStdVO> selectPopAllSelfGradeItemList(AcceptVO vo) {
		return selectList("accept.selectPopAllSelfGradeItemList", vo);
	}
	
	public int savePretreatmentSample(AcceptVO vo) throws Exception {
		return update("accept.savePretreatmentSample", vo);
	}
	
	public int savePretreatmentReq(AcceptVO vo) throws Exception {
		return update("accept.savePretreatmentReq", vo);
	}

	public int updateGradeResetItem(AcceptVO vo) {
		return update("accept.updateGradeResetItem", vo);
	}
	
	public int updateGradeItemGrid(HashMap<String,String> map) {
		return update("accept.updateGradeItemGrid", map);
	}
	
	// 검체별 문서 구분 저장 추가
	public int updateFileDivision(AcceptVO vo) throws Exception {
		return update("accept.updateFileDivision", vo);
	}
	
	public int updateSampleMaxGrade(AcceptVO vo) {
		return update("accept.updateSampleMaxGrade", vo);
	}

	//성적서 항목 순서 수정
	public int updateOrder(AcceptVO vo) throws Exception{
		return update("accept.updateOrder", vo);
	}

	public int insertAcceptStdItem(HashMap<String,String> map) throws Exception {
		return insert("accept.insertAcceptStdItem", map);
	}
	
	public int insertAcceptGrdItem(HashMap<String,String> map) throws Exception {
		return insert("accept.insertAcceptGrdItem", map);
	}
	//비고 수정
	public int updateReqSampleMessage(HashMap<String,String> map) throws Exception {
		return update("accept.updateReqSampleMessage", map);
	}
	
	//성적서 표시 순서 팝업 > 조회
	public List<AcceptVO> selectReportOrder(AcceptVO vo) throws Exception {
		return selectList("accept.selectReportOrder", vo);
	}
	
	//성적서 발행완료 후 접수 복사
	public int copyPieceAccept(AcceptVO vo) throws Exception {
		return insert("accept.copyPieceAccept", vo);
	}
}
