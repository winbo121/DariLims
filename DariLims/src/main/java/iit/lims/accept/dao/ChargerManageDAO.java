package iit.lims.accept.dao;

import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class ChargerManageDAO extends EgovAbstractMapper{

	//사용자 이름 찾기
	public String selectUserId(ResultInputVO vo) throws Exception {
		return selectOne("chargerManage.selectUserId", vo);
	}
	
	//시험담당자변경 접수목록 조회
	public List<ResultInputVO> selectChargerManageReqList(ResultInputVO vo) {
		return selectList("chargerManage.selectChargerManageReqList", vo);
	}
	
	//시험담당자변경 시료 정보 조회
	public AcceptVO selectChargerManageSampleDetail(AcceptVO vo) {
		return selectOne("chargerManage.selectChargerManageSampleDetail", vo);
	}
	
	//시험담당자변경 항목 조회
	public List<AcceptVO> selectChargerManageItemList(AcceptVO vo) throws Exception {
		return selectList("chargerManage.selectChargerManageItemList", vo);
	}
}
