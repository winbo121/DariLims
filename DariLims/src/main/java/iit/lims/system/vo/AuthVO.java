package iit.lims.system.vo;

public class AuthVO extends MenuVO {
	private String role_no, role_group_nm, role_desc;

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

	public String getRole_desc() {
		return role_desc;
	}

	public void setRole_desc(String role_desc) {
		this.role_desc = role_desc;
	}
	
}
