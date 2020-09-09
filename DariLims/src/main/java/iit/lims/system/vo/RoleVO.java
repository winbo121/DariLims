package iit.lims.system.vo;

import iit.lims.common.vo.WorkVO;

public class RoleVO extends WorkVO {
	private String role_group_name;
	private String role_desc;
	private String menu_cd;
	private String menu_nm;
	private String menu_url;
	private String pre_menu_name;
	private String role_no;
	private int menu_Level;
	
	public String getRole_group_name() {
		return role_group_name;
	}
	public void setRole_group_name(String role_group_name) {
		this.role_group_name = role_group_name;
	}
	public String getRole_desc() {
		return role_desc;
	}
	public void setRole_desc(String role_desc) {
		this.role_desc = role_desc;
	}
	public String getMenu_cd() {
		return menu_cd;
	}
	public void setMenu_cd(String menu_cd) {
		this.menu_cd = menu_cd;
	}
	public String getMenu_nm() {
		return menu_nm;
	}
	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}
	public String getMenu_url() {
		return menu_url;
	}
	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}
	public String getPre_menu_name() {
		return pre_menu_name;
	}
	public void setPre_menu_name(String pre_menu_name) {
		this.pre_menu_name = pre_menu_name;
	}
	public String getRole_no() {
		return role_no;
	}
	public void setRole_no(String role_no) {
		this.role_no = role_no;
	}
	public int getMenu_Level() {
		return menu_Level;
	}
	public void setMenu_Level(int menu_Level) {
		this.menu_Level = menu_Level;
	}

}
