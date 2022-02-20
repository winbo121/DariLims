package iit.lims.system.vo;

import org.springframework.web.multipart.MultipartFile;

public class UserVO extends AuthVO {
	private String user_nm, potal_id, dept_cd, dept_nm, dept_id, office_cd;
	private String mobile_phone, email_addr, rank_nm, rank_cd, sms_flag, mandator_flag, mandator_user_no, mandator_start_date, mandator_end_date, tel_num, office_tel_num;
	private String substitute_id;
	private String substitute_nm;
	private String substitute_dept_nm;
	private String etc;
	private String user_pw;
	private String user_id;
	private MultipartFile sign_file;
	private byte[] byte_file;
	private String file_name;
	private String user_eng_nm;
	private String user_eng_id;
	private String report_class_code;
	
	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public byte[] getByte_file() {
		return byte_file;
	}

	public void setByte_file(byte[] byte_file) {
		this.byte_file = byte_file;
	}

	public MultipartFile getSign_file() {
		return sign_file;
	}

	public void setSign_file(MultipartFile sign_file) {
		this.sign_file = sign_file;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getSubstitute_nm() {
		return substitute_nm;
	}

	public void setSubstitute_nm(String substitute_nm) {
		this.substitute_nm = substitute_nm;
	}

	public String getSubstitute_dept_nm() {
		return substitute_dept_nm;
	}

	public void setSubstitute_dept_nm(String substitute_dept_nm) {
		this.substitute_dept_nm = substitute_dept_nm;
	}

	public String getSubstitute_id() {
		return substitute_id;
	}

	public void setSubstitute_id(String substitute_id) {
		this.substitute_id = substitute_id;
	}

	public String getUser_nm() {
		return user_nm;
	}

	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	public String getPotal_id() {
		return potal_id;
	}

	public void setPotal_id(String potal_id) {
		this.potal_id = potal_id;
	}

	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}

	public String getDept_nm() {
		return dept_nm;
	}

	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}

	public String getDept_id() {
		return dept_id;
	}

	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	
	public String getOffice_cd() {
		return office_cd;
	}

	public void setOffice_cd(String office_cd) {
		this.office_cd = office_cd;
	}

	public String getMobile_phone() {
		return mobile_phone;
	}

	public void setMobile_phone(String mobile_phone) {
		this.mobile_phone = mobile_phone;
	}

	public String getEmail_addr() {
		return email_addr;
	}

	public void setEmail_addr(String email_addr) {
		this.email_addr = email_addr;
	}

	public String getRank_nm() {
		return rank_nm;
	}

	public void setRank_nm(String rank_nm) {
		this.rank_nm = rank_nm;
	}

	public String getRank_cd() {
		return rank_cd;
	}

	public void setRank_cd(String rank_cd) {
		this.rank_cd = rank_cd;
	}

	public String getSms_flag() {
		return sms_flag;
	}

	public void setSms_flag(String sms_flag) {
		this.sms_flag = sms_flag;
	}

	public String getMandator_flag() {
		return mandator_flag;
	}

	public void setMandator_flag(String mandator_flag) {
		this.mandator_flag = mandator_flag;
	}

	public String getMandator_user_no() {
		return mandator_user_no;
	}

	public void setMandator_user_no(String mandator_user_no) {
		this.mandator_user_no = mandator_user_no;
	}

	public String getMandator_start_date() {
		return mandator_start_date;
	}

	public void setMandator_start_date(String mandator_start_date) {
		this.mandator_start_date = mandator_start_date;
	}

	public String getMandator_end_date() {
		return mandator_end_date;
	}

	public void setMandator_end_date(String mandator_end_date) {
		this.mandator_end_date = mandator_end_date;
	}

	public String getTel_num() {
		return tel_num;
	}

	public void setTel_num(String tel_num) {
		this.tel_num = tel_num;
	}

	public String getOffice_tel_num() {
		return office_tel_num;
	}

	public void setOffice_tel_num(String office_tel_num) {
		this.office_tel_num = office_tel_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_eng_nm() {
		return user_eng_nm;
	}

	public void setUser_eng_nm(String user_eng_nm) {
		this.user_eng_nm = user_eng_nm;
	}

	public String getUser_eng_id() {
		return user_eng_id;
	}

	public void setUser_eng_id(String user_eng_id) {
		this.user_eng_id = user_eng_id;
	}

	public String getReport_class_code() {
		return report_class_code;
	}

	public void setReport_class_code(String report_class_code) {
		this.report_class_code = report_class_code;
	}
}
