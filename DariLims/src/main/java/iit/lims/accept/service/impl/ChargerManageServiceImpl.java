package iit.lims.accept.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import iit.lims.accept.dao.ChargerManageDAO;
import iit.lims.accept.service.ChargerManageService;
import iit.lims.accept.vo.AcceptVO;
import iit.lims.analysis.vo.ResultInputVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class ChargerManageServiceImpl extends EgovAbstractServiceImpl implements ChargerManageService {

	@Resource(name = "chargerManageDAO")
	private ChargerManageDAO chargerManageDAO;
	
	/**
	 * 시험담당자변경 접수목록 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public List<ResultInputVO> selectChargerManageReqList(ResultInputVO vo) throws Exception {
		
		if(vo.getPageType() != null){
			if(vo.getPageType().equals("chargerManage")){
				String tester_id = chargerManageDAO.selectUserId(vo);
				if(tester_id == null){
					tester_id = "";
				}
				vo.setUser_id(tester_id);
			}
		}
		
		return chargerManageDAO.selectChargerManageReqList(vo);
	}
	
	/**
	 * 시험담당자변경 시료 정보 조회
	 * 
	 * @param ResultInputVO
	 * @return List
	 * @throws Exception
	 */
	public AcceptVO selectChargerManageSampleDetail(AcceptVO vo) throws Exception {
		return chargerManageDAO.selectChargerManageSampleDetail(vo);
	}
	
	/**
	 * 시험담당자변경 항목 조회
	 * 
	 * @param AcceptVO
	 * @return List
	 * @throws Exception
	 */
	public List<AcceptVO> selectChargerManageItemList(AcceptVO vo) throws Exception {
		return chargerManageDAO.selectChargerManageItemList(vo);
	}
	
}
