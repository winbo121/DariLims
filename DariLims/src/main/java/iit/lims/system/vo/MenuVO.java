package iit.lims.system.vo;

import iit.lims.common.vo.CommonVO;

public class MenuVO extends CommonVO {

	private String menu_nm, menu_desc, menu_url, pre_menu_cd, pre_menu_nm;

	public String getMenu_nm() {
		return menu_nm;
	}

	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}

	public String getMenu_desc() {
		return menu_desc;
	}

	public void setMenu_desc(String menu_desc) {
		this.menu_desc = menu_desc;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getPre_menu_cd() {
		return pre_menu_cd;
	}

	public void setPre_menu_cd(String pre_menu_cd) {
		this.pre_menu_cd = pre_menu_cd;
	}

	public String getPre_menu_nm() {
		return pre_menu_nm;
	}

	public void setPre_menu_nm(String pre_menu_nm) {
		this.pre_menu_nm = pre_menu_nm;
	}
	
}