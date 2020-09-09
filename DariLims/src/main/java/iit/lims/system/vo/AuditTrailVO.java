package iit.lims.system.vo;

import iit.lims.common.vo.PagingVO;

public class AuditTrailVO extends PagingVO {
	// 리스트 조회
	private String menu_nm, title, sample_reg_nm, at_proc;	
	
	public String getMenu_nm() {
		return menu_nm;
	}

	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSample_reg_nm() {
		return sample_reg_nm;
	}

	public void setSample_reg_nm(String sample_reg_nm) {
		this.sample_reg_nm = sample_reg_nm;
	}

	public String getAt_proc() {
		return at_proc;
	}

	public void setAt_proc(String at_proc) {
		this.at_proc = at_proc;
	}
}
