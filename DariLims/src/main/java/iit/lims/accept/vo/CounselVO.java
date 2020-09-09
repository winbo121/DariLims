package iit.lims.accept.vo;

import iit.lims.master.vo.ReqOrgVO;

public class CounselVO extends ReqOrgVO {
	
	private String total_no;
	private String counsel_client_nm;
	private String counsel_client_email;
	private String counsel_date;
	private String counselor_nm;		

	private String personal_no;
	private String counsel_div;
	private String counsel_path;
	private String counsel_content;
	private String counsel_progress_sts;
	private String counsel_result, counsel_result_content;
	public String getTotal_no() {
		return total_no;
	}
	public void setTotal_no(String total_no) {
		this.total_no = total_no;
	}
	public String getCounsel_client_nm() {
		return counsel_client_nm;
	}
	public void setCounsel_client_nm(String counsel_client_nm) {
		this.counsel_client_nm = counsel_client_nm;
	}
	public String getCounsel_client_email() {
		return counsel_client_email;
	}
	public void setCounsel_client_email(String counsel_client_email) {
		this.counsel_client_email = counsel_client_email;
	}
	public String getCounsel_date() {
		return counsel_date;
	}
	public void setCounsel_date(String counsel_date) {
		this.counsel_date = counsel_date;
	}
	public String getCounselor_nm() {
		return counselor_nm;
	}
	public void setCounselor_nm(String counselor_nm) {
		this.counselor_nm = counselor_nm;
	}
	public String getPersonal_no() {
		return personal_no;
	}
	public void setPersonal_no(String personal_no) {
		this.personal_no = personal_no;
	}
	public String getCounsel_div() {
		return counsel_div;
	}
	public void setCounsel_div(String counsel_div) {
		this.counsel_div = counsel_div;
	}
	public String getCounsel_path() {
		return counsel_path;
	}
	public void setCounsel_path(String counsel_path) {
		this.counsel_path = counsel_path;
	}
	public String getCounsel_content() {
		return counsel_content;
	}
	public void setCounsel_content(String counsel_content) {
		this.counsel_content = counsel_content;
	}
	public String getCounsel_progress_sts() {
		return counsel_progress_sts;
	}
	public void setCounsel_progress_sts(String counsel_progress_sts) {
		this.counsel_progress_sts = counsel_progress_sts;
	}
	public String getCounsel_result() {
		return counsel_result;
	}
	public void setCounsel_result(String counsel_result) {
		this.counsel_result = counsel_result;
	}
	public String getCounsel_result_content() {
		return counsel_result_content;
	}
	public void setCounsel_result_content(String counsel_result_content) {
		this.counsel_result_content = counsel_result_content;
	}
}