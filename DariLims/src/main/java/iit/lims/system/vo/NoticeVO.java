package iit.lims.system.vo;

import iit.lims.common.vo.PagingVO;

public class NoticeVO extends PagingVO {
	private String notice_title;
	private String notice_desc;
	private String writer;
	private String write_date;
	private String notice_start;
	private String notice_end;
	private String notice_no;
	private String role_no;					/*권한코드*/
	private int notice_cnt;
	private int mode;
	
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_desc() {
		return notice_desc;
	}
	public void setNotice_desc(String notice_desc) {
		this.notice_desc = notice_desc;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getNotice_start() {
		return notice_start;
	}
	public void setNotice_start(String notice_start) {
		this.notice_start = notice_start;
	}
	public String getNotice_end() {
		return notice_end;
	}
	public void setNotice_end(String notice_end) {
		this.notice_end = notice_end;
	}
	public String getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(String notice_no) {
		this.notice_no = notice_no;
	}
	public int getNotice_cnt() {
		return notice_cnt;
	}
	public void setNotice_cnt(int notice_cnt) {
		this.notice_cnt = notice_cnt;
	}
	public int getMode() {
		return mode;
	}
	public void setMode(int mode) {
		this.mode = mode;
	}
	public String getRole_no() {
		return role_no;
	}
	public void setRole_no(String role_no) {
		this.role_no = role_no;
	}
	
}
