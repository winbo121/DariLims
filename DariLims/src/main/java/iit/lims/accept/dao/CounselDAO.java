package iit.lims.accept.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import iit.lims.accept.vo.CounselVO;
import iit.lims.instrument.vo.MachineVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CounselDAO extends EgovAbstractMapper {

	//통합상담 목록 조회
	public List<CounselVO> selectCounselTotalList(CounselVO counselVO) throws DataAccessException {
		return selectList("counsel.selectCounselTotalList", counselVO);
	}

	//개별상담 목록 조회
	public List<CounselVO> selectCounselPersonalList(CounselVO counselVO) throws DataAccessException {
		return selectList("counsel.selectCounselPersonalList", counselVO);
	}	
	
	//통합상담 등록 처리
	public int insertCounselTotal(CounselVO counselVO) throws DataAccessException {
		insert("counsel.insertCounselTotal", counselVO);
		return 1;
	}
	
	//개별상담 등록 처리
	public int insertCounselPersonal(CounselVO counselVO) throws DataAccessException {
		insert("counsel.insertCounselPersonal", counselVO);
		return 1;
	}
	
	//통합상담 상세 데이터 조회
	public CounselVO selectCounselTotalDetail(CounselVO counselVO) {
		return (CounselVO) selectOne("counsel.selectCounselTotalDetail", counselVO);
	}
	
	//개별상담 상세 데이터 조회
	public CounselVO selectCounselPersonalDetail(CounselVO counselVO) {
		return (CounselVO) selectOne("counsel.selectCounselPersonalDetail", counselVO);
	}
	
	//통합상담 수정 처리
	public int updateCounselTotal(CounselVO counselVO) throws DataAccessException {
		return update("counsel.updateCounselTotal", counselVO);
	}
	
	//개별상담 수정 처리
	public int updateCounselPersonal(CounselVO counselVO) throws DataAccessException {
		return update("counsel.updateCounselPersonal", counselVO);
	}
		
	//통합상담 삭제 처리
	public int deleteCounselTotal(CounselVO counselVO) throws DataAccessException {
		return update("counsel.deleteCounselTotal", counselVO);
	}
	
	//통합상담 삭제 시 개별상담 삭제 처리
	public int deleteCounselTotal2(CounselVO counselVO) throws DataAccessException {
		return update("counsel.deleteCounselTotal2", counselVO);
	}
	
	//개별상담 삭제 처리
	public int deleteCounselPersonal(CounselVO counselVO) throws DataAccessException {
		return update("counsel.deleteCounselPersonal", counselVO);
	}
}
