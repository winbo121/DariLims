package iit.lims.master.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.master.dao.UnitWorkDAO;
import iit.lims.master.service.UnitWorkService;
import iit.lims.master.vo.UnitWorkVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * UnitWorkServiceImpl
 * 
 * @author 최은향
 * @since 2015.01.21
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  Modification Information
 *  수정일      수정자   수정내용
 *  ---------- -------- ---------------------------
 *  2015.01.21  최은향   최초 생성
 * </pre>
 * 
 *      Copyright (C) 2015 by interfaceIT., All right reserved.
 */

@Service
public class UnitWorkServiceImpl extends EgovAbstractServiceImpl implements UnitWorkService {

	static final Logger log = LogManager.getLogger();

	@Resource(name = "unitWorkDAO")
	private UnitWorkDAO unitWorkDAO;

	/**
	 * 단위업무 목록 조회
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public List<UnitWorkVO> unitWork(UnitWorkVO unitWorkVO) throws Exception {
		return unitWorkDAO.unitWork(unitWorkVO);
	}

	/**
	 * 단위업무 상세정보 조회
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public UnitWorkVO unitWorkDetail(UnitWorkVO unitWorkVO) {
		try {
			return unitWorkDAO.unitWorkDetail(unitWorkVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	
	/**
	 * 단위업무 저장(등록/수정) 처리
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public int insertUnitWork(UnitWorkVO unitWorkVO) throws Exception {
		int result = -1;
		try {
			if(unitWorkVO.getPageType().equals("insert")){
				result = unitWorkDAO.insertUnitWork(unitWorkVO);
			}else{
				result = unitWorkDAO.updateUnitWork(unitWorkVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	
	/**
	 * 단위업무 삭제 처리
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public int deleteUnitWork(UnitWorkVO unitWorkVO) throws Exception {
		try {
			return unitWorkDAO.deleteUnitWork(unitWorkVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 부서 목록 조회
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public List<UnitWorkVO> deptList(UnitWorkVO unitWorkVO) throws Exception {
		return unitWorkDAO.deptList(unitWorkVO);
	}
	
	
	/**
	 * 부서별 단위업무 목록 조회(모든 부서 조회)
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public List<UnitWorkVO> deptUnitWork(UnitWorkVO unitWorkVO) throws Exception {
		return unitWorkDAO.deptUnitWork(unitWorkVO);
	}

	/**
	 * 부서별 단위업무 목록 조회(해당 부서의 단위 업무 조회)
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public List<UnitWorkVO> selectDeptUnitWork(UnitWorkVO unitWorkVO) throws Exception {
		return unitWorkDAO.selectDeptUnitWork(unitWorkVO);
	}

	/**
	 * 부서별 단위업무 저장 처리(저장, 삭제)
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	
	public int saveDeptUnitWork(UnitWorkVO unitWorkVO) throws Exception {
		try {
			String[] rowArr = unitWorkVO.getGridData().split("◆★◆");
			if (rowArr != null && rowArr.length > 0) {
				unitWorkDAO.deleteDeptUnitWork(unitWorkVO);
				
				for (String row : rowArr) {
					String[] columnArr = row.split("■★■");
					if (columnArr != null && columnArr.length > 0) {
						HashMap<String, String> map = new HashMap<String, String>();
						
						for (String column : columnArr) {
							String[] valueArr = column.split("●★●");
							if (valueArr != null) {
								String value = "";
								if (valueArr.length != 1) {
									value = valueArr[1];
								}
								map.put(valueArr[0], value);
							}
						}
						map.put("user_id", unitWorkVO.getUser_id()); // 등록 아이디(session)
						map.put("dept_cd", unitWorkVO.getDept_cd()); // 등록부서
						map.put("user_id", unitWorkVO.getUser_id());
						unitWorkDAO.insertDeptUnitWork(map);
					}
				}				
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 단위업무 삭제 여부 조회
	 * 
	 * @param UnitWorkVO
	 * @throws Exception
	 */
	public UnitWorkVO deptUnitWorkDeleteFlag(UnitWorkVO unitWorkVO) {
		try {
			return unitWorkDAO.deptUnitWorkDeleteFlag(unitWorkVO);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

}