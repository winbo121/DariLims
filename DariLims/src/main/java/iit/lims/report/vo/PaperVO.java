package iit.lims.report.vo;

import iit.lims.common.vo.WorkVO;

public class PaperVO extends WorkVO {
	private String qreport_no;
	private String qreport_id;
	private String year;
	private String quart;
	private String mon;
	private String day;
	private String write_date;
	private String qreport_nm;
	private String qreport_file_nm;
	private String qreport_type;
	private String week_start;
	private String week_end;
	private String onnara_link_yn;
	private String onnara_appv_state;
	private String onnara_title;
	private String onnara_con;
	private String state;

	public String getOnnara_link_yn() {
		return onnara_link_yn;
	}

	public void setOnnara_link_yn(String onnara_link_yn) {
		this.onnara_link_yn = onnara_link_yn;
	}

	public String getOnnara_appv_state() {
		return onnara_appv_state;
	}

	public void setOnnara_appv_state(String onnara_appv_state) {
		this.onnara_appv_state = onnara_appv_state;
	}

	public String getOnnara_title() {
		return onnara_title;
	}

	public void setOnnara_title(String onnara_title) {
		this.onnara_title = onnara_title;
	}

	public String getOnnara_con() {
		return onnara_con;
	}

	public void setOnnara_con(String onnara_con) {
		this.onnara_con = onnara_con;
	}

	public String getWeek_start() {
		return week_start;
	}

	public void setWeek_start(String week_start) {
		this.week_start = week_start;
	}

	public String getWeek_end() {
		return week_end;
	}

	public void setWeek_end(String week_end) {
		this.week_end = week_end;
	}

	public String getQreport_type() {
		return qreport_type;
	}

	public void setQreport_type(String qreport_type) {
		this.qreport_type = qreport_type;
	}

	public String getQreport_file_nm() {
		return qreport_file_nm;
	}

	public void setQreport_file_nm(String qreport_file_nm) {
		this.qreport_file_nm = qreport_file_nm;
	}

	public String getQreport_id() {
		return qreport_id;
	}

	public void setQreport_id(String qreport_id) {
		this.qreport_id = qreport_id;
	}

	public String getQreport_no() {
		return qreport_no;
	}

	public void setQreport_no(String qreport_no) {
		this.qreport_no = qreport_no;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getQuart() {
		return quart;
	}

	public void setQuart(String quart) {
		this.quart = quart;
	}

	public String getMon() {
		return mon;
	}

	public void setMon(String mon) {
		this.mon = mon;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getQreport_nm() {
		return qreport_nm;
	}

	public void setQreport_nm(String qreport_nm) {
		this.qreport_nm = qreport_nm;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	

}