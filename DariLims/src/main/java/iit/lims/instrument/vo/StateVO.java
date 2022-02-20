package iit.lims.instrument.vo;

import iit.lims.common.vo.WorkVO;

public class StateVO extends WorkVO {
	private String use_no, use_sdate, use_edate, use_purpose, his_user, use_etc, his_user_nm;

	public String getUse_no() {
		return use_no;
	}

	public void setUse_no(String use_no) {
		this.use_no = use_no;
	}

	public String getUse_sdate() {
		return use_sdate;
	}

	public void setUse_sdate(String use_sdate) {
		this.use_sdate = use_sdate;
	}

	public String getUse_edate() {
		return use_edate;
	}

	public void setUse_edate(String use_edate) {
		this.use_edate = use_edate;
	}

	public String getUse_purpose() {
		return use_purpose;
	}

	public void setUse_purpose(String use_purpose) {
		this.use_purpose = use_purpose;
	}

	public String getHis_user() {
		return his_user;
	}

	public void setHis_user(String his_user) {
		this.his_user = his_user;
	}

	public String getUse_etc() {
		return use_etc;
	}

	public void setUse_etc(String use_etc) {
		this.use_etc = use_etc;
	}

	public String getHis_user_nm() {
		return his_user_nm;
	}

	public void setHis_user_nm(String his_user_nm) {
		this.his_user_nm = his_user_nm;
	}
}
