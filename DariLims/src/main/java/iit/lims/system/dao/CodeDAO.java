package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.CodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CodeDAO extends EgovAbstractMapper {

	public List<CodeVO> selectCodeGroupList(CodeVO codeVO) throws Exception {
        return selectList("system.selectCodeGroupList", codeVO);
    }
	
	public int insertCodeGroup(CodeVO codeVO) throws Exception {
		 insert("system.insertCodeGroup", codeVO);
		 return 1;
	}
	
	public int updateCodeGroup(CodeVO codeVO) throws Exception {
		return update("system.updateCodeGroup", codeVO);
	}
	
	public List<CodeVO> selectCodeDetailList(CodeVO codeVO) throws Exception {
        return selectList("system.selectCodeDetailList", codeVO);
    }
	
	public int insertCodeDetail(CodeVO codeVO) throws Exception {
		 insert("system.insertCodeDetail", codeVO);
		 return 1;
	}
	
	public int updateCodeDetail(CodeVO codeVO) throws Exception {
		return update("system.updateCodeDetail", codeVO);
	}
}
