package iit.lims.common.vo;
import iit.lims.common.vo.WorkVO;

public class HistoryVO extends WorkVO {
	private String test_sample_seq;
	private String sample_his_seq;
	private String dept_cd;
	private String user_id;
	private String sample_state;
	private String work_date;
	private String test_dept_cd;
	private String colla_flag;
	private String etc;
	private String return_flag;

	public String getReturn_flag() {
		return return_flag;
	}

	public void setReturn_flag(String return_flag) {
		this.return_flag = return_flag;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getTest_sample_seq() {
		return test_sample_seq;
	}

	public void setTest_sample_seq(String test_sample_seq) {
		this.test_sample_seq = test_sample_seq;
	}

	public String getSample_his_seq() {
		return sample_his_seq;
	}

	public void setSample_his_seq(String sample_his_seq) {
		this.sample_his_seq = sample_his_seq;
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

	public String getSample_state() {
		return sample_state;
	}

	public void setSample_state(String sample_state) {
		this.sample_state = sample_state;
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

}
