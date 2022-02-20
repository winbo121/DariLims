package iit.lims.system.vo;

import iit.lims.common.vo.CommonVO;

public class UserInfoVO extends CommonVO {
	
	private String potal_id;				/*포털 아이디*/
	private String user_id;					/*사용자 아이디*/
	private String user_nm;					/*사용자명*/
	private String user_ip;					/*사용자 아이피*/
	private String user_pw;					/*사용자 패스워드*/
 	private String dept_cd;					/*부서명*/
	private String dept_nm;					/*부서코드*/
	private String rank_nm;					/*직급명*/
	private String rank_cd;					/*직급코드*/
	private String access_ip_flag;			/*접근IP사용여부*/
	
	private String role_no;					/*권한코드*/	
	private String role_group_nm;			/*권한명*/
	
	private String total_role_no;
	private String total_role_nm;
	
	private String sms_flag;				/*sms수신 여부*/
	private String mobile_phone;			/*사용자 핸드폰*/
	private String email_addr;				/*이메일*/
	private String mandator_flag;			/**/
	private String mandator_user_no;		/**/
	private String mandator_start_date;		/**/
	private String mandator_end_date;		/**/
	
	private String message;

	public String getPotal_id() {
		return potal_id;
	}

	public void setPotal_id(String potal_id) {
		this.potal_id = potal_id;
	}
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_nm() {
		return user_nm;
	}

	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	public String getUser_ip() {
		return user_ip;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
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

	public String getRole_no() {
		return role_no;
	}

	public void setRole_no(String role_no) {
		this.role_no = role_no;
	}

	public String getRole_group_nm() {
		return role_group_nm;
	}

	public void setRole_group_nm(String role_group_nm) {
		this.role_group_nm = role_group_nm;
	}

	public String getSms_flag() {
		return sms_flag;
	}

	public void setSms_flag(String sms_flag) {
		this.sms_flag = sms_flag;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTotal_role_no() {
		return total_role_no;
	}

	public void setTotal_role_no(String total_role_no) {
		this.total_role_no = total_role_no;
	}

	public String getTotal_role_nm() {
		return total_role_nm;
	}

	public void setTotal_role_nm(String total_role_nm) {
		this.total_role_nm = total_role_nm;
	}

	public String getAccess_ip_flag() {
		return access_ip_flag;
	}

	public void setAccess_ip_flag(String access_ip_flag) {
		this.access_ip_flag = access_ip_flag;
	}
	
}
