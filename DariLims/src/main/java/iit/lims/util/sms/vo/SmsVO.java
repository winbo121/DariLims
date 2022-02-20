package iit.lims.util.sms.vo;

import iit.lims.system.vo.AuthVO;

public class SmsVO extends AuthVO{

	private String sms_date;
	private String sms_result;
	private String message;
	private String sms_flag, sms_target, sms_type, test_req_seq;
	private String req_nm, req_org_nm, sample_reg_nm, fee_tot;
	private String msg;
	private String send_tel_no;
	private String sms_key;
	private String process;
	private String sms_type_nm;
	private String process_nm;
	private String custom_msg;
	
	public String getSms_date() {
		return sms_date;
	}
	public void setSms_date(String sms_date) {
		this.sms_date = sms_date;
	}

	public String getSms_result() {
		return sms_result;
	}
	public void setSms_result(String sms_result) {
		this.sms_result = sms_result;
	}

	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	

	public String getSms_flag() {
		return sms_flag;
	}
	public void setSms_flag(String sms_flag) {
		this.sms_flag = sms_flag;
	}

	public String getSms_target() {
		return sms_target;
	}
	public void setSms_target(String sms_target) {
		this.sms_target = sms_target;
	}


	public String getSms_type() {
		return sms_type;
	}
	public void setSms_type(String sms_type) {
		this.sms_type = sms_type;
	}

	public String getTest_req_seq() {
		return test_req_seq;
	}
	public void setTest_req_seq(String test_req_seq) {
		this.test_req_seq = test_req_seq;
	}

	public String getReq_nm() {
		return req_nm;
	}
	public void setReq_nm(String req_nm) {
		this.req_nm = req_nm;
	}

	public String getReq_org_nm() {
		return req_org_nm;
	}
	public void setReq_org_nm(String req_org_nm) {
		this.req_org_nm = req_org_nm;
	}

	public String getSample_reg_nm() {
		return sample_reg_nm;
	}
	public void setSample_reg_nm(String sample_reg_nm) {
		this.sample_reg_nm = sample_reg_nm;
	}

	public String getFee_tot() {
		return fee_tot;
	}
	public void setFee_tot(String fee_tot) {
		this.fee_tot = fee_tot;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getSend_tel_no() {
		return send_tel_no;
	}
	public void setSend_tel_no(String send_tel_no) {
		this.send_tel_no = send_tel_no;
	}
	public String getSms_key() {
		return sms_key;
	}
	public void setSms_key(String sms_key) {
		this.sms_key = sms_key;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getSms_type_nm() {
		return sms_type_nm;
	}
	public void setSms_type_nm(String sms_type_nm) {
		this.sms_type_nm = sms_type_nm;
	}
	public String getProcess_nm() {
		return process_nm;
	}
	public void setProcess_nm(String process_nm) {
		this.process_nm = process_nm;
	}
	public String getCustom_msg() {
		return custom_msg;
	}
	public void setCustom_msg(String custom_msg) {
		this.custom_msg = custom_msg;
	}
	
	
	
}
