package iit.lims.analysis.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import iit.lims.instrument.vo.MachineVO;
import iit.lims.master.vo.TestMethodVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * MenuService
 * 
 * @author 조재환
 * @since 2015.01.17
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.17  조재환   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Repository
public class ResultInputSampleDAO extends EgovAbstractMapper {
	public List<ResultInputVO> selectResultReqList(ResultInputVO vo) {
		return selectList("resultInputSample.selectResultReqList", vo);
	}

	public List<ResultInputVO> selectResultSampleList(ResultInputVO vo) {
		return selectList("resultInputSample.selectResultSampleList", vo);
	}

	public List<ResultInputVO> selectResultList(ResultInputVO vo) {
		return selectList("resultInputSample.selectResultList", vo);
	}

	public int updateItemResult(HashMap<String, String> m) throws Exception {
		return update("resultInputSample.updateItemResult", m);
	}

	public List<TestMethodVO> selectTestMethodList(ResultInputVO vo) {
		return selectList("resultInputSample.selectTestMethodList", vo);
	}

	public List<MachineVO> selectTestMachineList(ResultInputVO vo) {
		return selectList("resultInputSample.selectTestMachineList", vo);
	}

	public String showReqmessage(ResultInputVO vo) {
		return selectOne("resultInputSample.showReqmessage", vo);
	}

	public int saveTestComment(ResultInputVO vo) throws Exception {
		return update("resultInputSample.saveTestComment", vo);
	}

	public int saveTestEnvironment(ResultInputVO vo) throws Exception {
		return update("resultInputSample.saveTestEnvironment", vo);
	}
	
	public ResultInputVO selectOriginalSTD(ResultInputVO vo) {
		return selectOne("resultInputSample.selectOriginalSTD", vo);
	}

	public List<ResultInputVO> selectSampleList(ResultInputVO vo) {
		return selectList("resultInputSample.selectSampleList", vo);
	}

	public int updateReturnFlag(ResultInputVO vo) throws Exception {
		return update("resultInputSample.updateReturnFlag", vo);
	}

	public String checkReqInputComplete(AcceptVO vo) {
		return selectOne("resultInputSample.checkReqInputComplete", vo);
	}

	public List<ResultInputVO> selectCheckResultList(ResultInputVO vo) {
		return selectList("resultInputSample.selectCheckResultList", vo);
	}

	public List<ResultInputVO> selectCheckJdgList(ResultInputVO vo) {
		return selectList("resultInputSample.selectCheckJdgList", vo);
	}

	public List<ResultInputVO> checkReqInput(HashMap<String, String> map) {
		return selectList("resultInputSample.checkReqInput", map);
	}

	public void updateSampleJudgment(ResultInputVO vo) throws Exception {
		update("resultInputSample.updateSampleJudgment", vo);
	}

	public String selectSampleJudgment(String s) throws Exception {
		return selectOne("resultInputSample.selectSampleJudgment", s);
	}
	
	public ResultInputVO reportDown(ResultInputVO vo) throws Exception {
		return (ResultInputVO) selectOne("resultInputSample.reportDown", vo);
	}
	
	public ResultInputVO reportFilePop(ResultInputVO vo) {
		return (ResultInputVO) selectOne("resultInputSample.reportFilePop", vo);
	}
	
	public int insertReportFile(ResultInputVO vo) throws Exception {
		return insert("resultInputSample.insertReportFile", vo);
	}

	public int updateReportFlag(ResultInputVO vo) throws Exception {
		return insert("resultInputSample.updateReportFlag", vo);
	}
	
	public int updateSampleReportFlag(ResultInputVO vo) throws Exception {
		return insert("resultInputSample.updateSampleReportFlag", vo);
	}
	
	public int updateReportFile(ResultInputVO vo) throws Exception {
		return update("resultInputSample.updateReportFile", vo);
	}
	
	public int deleteReportFile(ResultInputVO vo) throws Exception {
		return delete("resultInputSample.deleteReportFile", vo);
	}
	
	public int deleteReportUpdate(ResultInputVO vo) throws Exception {
		return update("resultInputSample.deleteReportUpdate", vo);
	}
	
	public int insertItemResultHistory(HashMap<String, String> m) throws Exception {
		return update("resultInputSample.insertItemResultHistory", m);
	}	 
}