package iit.lims.system.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import iit.lims.common.dao.CommonDAO;
import iit.lims.system.dao.NoticeDAO;
import iit.lims.system.service.NoticeService;
import iit.lims.system.vo.NoticeVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class NoticeServiceImpl extends EgovAbstractServiceImpl implements NoticeService {
	static final Logger log = LogManager.getLogger();

	@Resource(name = "noticeDAO")
	private NoticeDAO noticeDAO;

	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;

	public int selectPagingListTotCnt(NoticeVO vo) throws Exception {
		return noticeDAO.noticeCnt(vo);
	}

	public List<NoticeVO> selectNoticeList(NoticeVO vo) throws Exception {
		return noticeDAO.selectNoticeList(vo);
	}

	public HashMap<String, Object> saveNotice(NoticeVO vo) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();
		try {
			switch (vo.getMode()) {
			case 1: // 추가
				noticeDAO.insertNotice(vo);
				break;
			case 2: // 수정
				noticeDAO.updateNotice(vo);
				break;
			case 3: // 삭제
				noticeDAO.deleteNotice(vo);
				break;
			}
			m.put("result", 1);
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return m;
	}

	public NoticeVO noticeDetail(NoticeVO vo) {
		try {
			switch (vo.getMode()) {
			case 4: // 신규추가
				return new NoticeVO();
			case 5: // 상세
				return noticeDAO.noticeDetail(vo);
			}
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	public List<NoticeVO> mainNoticeList(NoticeVO vo) {

		return noticeDAO.mainNoticeList(vo);
	}

}
