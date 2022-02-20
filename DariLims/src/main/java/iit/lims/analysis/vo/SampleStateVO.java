package iit.lims.analysis.vo;

import iit.lims.accept.vo.AcceptVO;

public class SampleStateVO extends AcceptVO {
	private String sample_his_seq;
	private String test_sample_seq;
	private String dept_cd;
	private String dept_nm;
	private String user_id;
	private String user_nm;
	private String sample_state_cd;
	private String sample_state_nm;
	private String work_date;
	private String test_dept_cd;
	private String test_dept_nm;
	private String colla_flag;
	private String etc;
	
	public String getSample_his_seq() {
		return sample_his_seq;
	}
	public void setSample_his_seq(String sample_his_seq) {
		this.sample_his_seq = sample_his_seq;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getSample_state_cd() {
		return sample_state_cd;
	}
	public void setSample_state_cd(String sample_state_cd) {
		this.sample_state_cd = sample_state_cd;
	}
	public String getSample_state_nm() {
		return sample_state_nm;
	}
	public void setSample_state_nm(String sample_state_nm) {
		this.sample_state_nm = sample_state_nm;
	}
	public String getTest_dept_nm() {
		return test_dept_nm;
	}
	public void setTest_dept_nm(String test_dept_nm) {
		this.test_dept_nm = test_dept_nm;
	}
	public String getTest_sample_seq() {
		return test_sample_seq;
	}
	public void setTest_sample_seq(String test_sample_seq) {
		this.test_sample_seq = test_sample_seq;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public String getTest_dept_cd() {
		return test_dept_cd;
	}
	public void setTest_dept_cd(String test_dept_cd) {
		this.test_dept_cd = test_dept_cd;
	}
	public String getColla_flag() {
		return colla_flag;
	}
	public void setColla_flag(String colla_flag) {
		this.colla_flag = colla_flag;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}

	
	

}