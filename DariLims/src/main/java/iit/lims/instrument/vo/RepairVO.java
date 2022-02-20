package iit.lims.instrument.vo;

import iit.lims.common.vo.WorkVO;

public class RepairVO extends WorkVO {
	private String rpr_no, rpr_date, brk_reason, rpr_content, rpr_company,	rpr_user_id, rpr_tel, rpr_user_nm;

	public String getRpr_no() {
		return rpr_no;
	}

	public void setRpr_no(String rpr_no) {
		this.rpr_no = rpr_no;
	}

	public String getRpr_date() {
		return rpr_date;
	}

	public void setRpr_date(String rpr_date) {
		this.rpr_date = rpr_date;
	}

	public String getBrk_reason() {
		return brk_reason;
	}

	public void setBrk_reason(String brk_reason) {
		this.brk_reason = brk_reason;
	}

	public String getRpr_content() {
		return rpr_content;
	}

	public void setRpr_content(String rpr_content) {
		this.rpr_content = rpr_content;
	}

	public String getRpr_company() {
		return rpr_company;
	}

	public void setRpr_company(String rpr_company) {
		this.rpr_company = rpr_company;
	}

	public String getRpr_user_id() {
		return rpr_user_id;
	}

	public void setRpr_user_id(String rpr_user_id) {
		this.rpr_user_id = rpr_user_id;
	}

	public String getRpr_tel() {
		return rpr_tel;
	}

	public void setRpr_tel(String rpr_tel) {
		this.rpr_tel = rpr_tel;
	}

	public String getRpr_user_nm() {
		return rpr_user_nm;
	}

	public void setRpr_user_nm(String rpr_user_nm) {
		this.rpr_user_nm = rpr_user_nm;
	}	

}
