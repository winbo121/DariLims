package iit.lims.accept.dao;

import java.util.HashMap;
import java.util.List;

import iit.lims.accept.vo.InstRentVO;
import iit.lims.analysis.vo.ResultInputVO;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class InstRentDAO extends EgovAbstractMapper {

	//장비대여 업체목록 조회
	public List<InstRentVO> selectInstRentList(InstRentVO instRentVO) throws DataAccessException {
		return selectList("instRent.selectInstRentList", instRentVO);
	}
	
	//장비대여 업체 등록
	public int insertInstRentOrg(InstRentVO instRentVO) throws DataAccessException {
		return insert("instRent.insertInstRentOrg", instRentVO);
	}
	
	//장비대여 업체 수정
	public int updateInstRentOrg(InstRentVO instRentVO) throws DataAccessException {
		return insert("instRent.updateInstRentOrg", instRentVO);
	}
	
	//장비대여 업체 삭제
	public int deleteInstRent(InstRentVO instRentVO) throws DataAccessException {
		return update("instRent.deleteInstRent", instRentVO);
	}
	
	//장비대여 업체 상세 데이터 조회
	public InstRentVO selectInstRentDetail(InstRentVO instRentVO) {
		return (InstRentVO) selectOne("instRent.selectInstRentDetail", instRentVO);
	}	
		
	//장비대여 장비목록 조회
	public List<InstRentVO> selectInstRentDetailList(InstRentVO instRentVO) throws DataAccessException {
		return selectList("instRent.selectInstRentDetailList", instRentVO);
	}
	
	/*장비 대여 장비목록 등록*/
	public int insertInstRent_inst(HashMap<String, String> map) throws Exception {
		insert("instRent.insertInstRent_inst", map);
		return 1;
	}
	/*장비 대여 장비목록 수정*/
	public int updateInstRent_inst(HashMap<String, String> map) throws Exception {
		insert("instRent.updateInstRent_inst", map);
		return 1;
	}
	
	//장비 목록 삭제 처리
		public int deleteInstRent_inst(HashMap<String, String> map) throws Exception {
			return delete("instRent.deleteInstRent_inst", map);
	}
	
	//장비대여 사용결과 시료목록 일괄삭제
	public int deleteInstRent_sample_all(InstRentVO instRentVO) throws Exception {
		return delete("instRent.deleteInstRent_sample_all", instRentVO);
	}
	
	/*장비대여 사용결과 시료목록 입력*/
	public int insertInstRent_sample(HashMap<String, String> map) throws Exception {
		insert("instRent.insertInstRent_sample", map);
		return 1;
	}
	
	/*장비대여 사용결과 시료목록 수정*/
	public int updateInstRent_sample(HashMap<String, String> map) throws Exception {
		update("instRent.updateInstRent_sample", map);
		return 1;
	}
	
	//장비대여 사용결과 시료목록 조회
	public List<InstRentVO> selectInstRent_sampleList(InstRentVO instRentVO) throws DataAccessException {
		return selectList("instRent.selectInstRent_sampleList", instRentVO);
	}
	
	//장비대여 사용결과 항목 일괄삭제
	public int deleteInstRent_item_all(InstRentVO instRentVO) throws Exception {
		return delete("instRent.deleteInstRent_item_all", instRentVO);
	}
	
	/*장비대여 사용결과 항목 입력,수정*/
	public int insertInstRent_item(HashMap<String, String> map) throws Exception {
		insert("instRent.insertInstRent_item", map);
		return 1;
	}
	
	//장비대여 사용결과 항목 조회
	public List<InstRentVO> selectInstRent_itemList(InstRentVO instRentVO) throws DataAccessException {
		return selectList("instRent.selectInstRent_itemList", instRentVO);
	}
	
	//장비대여 시료 삭제 처리
	public int deleteInstRent_sample(InstRentVO instRentVO) throws DataAccessException {
		return update("instRent.deleteInstRent_sample", instRentVO);
	}
	
	//장비대여 항목 삭제 처리
	public int deleteInstRent_item(InstRentVO instRentVO) throws DataAccessException {
		return update("instRent.deleteInstRent_item", instRentVO);
	}
	
	/*장비대여 사용결과 항목 비고 저장*/
	public int saveSampleEtc(InstRentVO instRentVO) throws Exception {
		return update("instRent.saveSampleEtc", instRentVO);		
	}
	
	/*장비대여 사용결과 항목 비고 조회*/
	public InstRentVO selectSampleEtc(InstRentVO instRentVO) throws Exception {
		return selectOne("instRent.selectSampleEtc", instRentVO);
	}
}
