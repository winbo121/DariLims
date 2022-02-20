package iit.lims.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import iit.lims.system.vo.NoticeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class NoticeDAO extends EgovAbstractMapper {

	public int noticeCnt(NoticeVO vo) {
		return (Integer) selectOne("system.noticeCnt", vo);
	}
	
	public List<NoticeVO> selectNoticeList(NoticeVO vo) throws Exception {
        return selectList("system.selectNoticeList", vo);
    }
	

	public void insertNotice(NoticeVO vo) {
		insert("system.insertNotice", vo);
	}

	public void updateNotice(NoticeVO vo) {
		update("system.updateNotice", vo);
	}

	public void deleteNotice(NoticeVO vo) {
		delete("system.deleteNotice", vo);
	}

	public NoticeVO noticeDetail(NoticeVO vo) {
		return (NoticeVO) selectOne("system.noticeDetail", vo);
	}
	
	public List<NoticeVO> mainNoticeList(NoticeVO vo) {
		return selectList("system.mainNoticeList", vo);
	}
}
