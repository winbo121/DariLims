package iit.lims.system.service;

import java.util.HashMap;
import java.util.List;

import iit.lims.system.vo.NoticeVO;

public interface NoticeService {
	/**
	 * 공지사항관리 목록 페이징 처리
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public int selectPagingListTotCnt(NoticeVO vo) throws Exception;
	
	/**
	 * 공지사항관리 목록 조회
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<NoticeVO> selectNoticeList(NoticeVO vo) throws Exception;
	
	/**
	 * 공지사항관리 상세 조회
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public NoticeVO noticeDetail(NoticeVO vo);
	
	/**
	 * 공지사항관리 저장
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public HashMap<String, Object> saveNotice(NoticeVO vo) throws Exception;
	
	/**
	 * 메인화면 공지사항 목록
	 * 
	 * @param NoticeVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	public List<NoticeVO> mainNoticeList(NoticeVO vo);

}
