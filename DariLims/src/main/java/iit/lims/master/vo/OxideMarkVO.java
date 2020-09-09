package iit.lims.master.vo;

import iit.lims.common.vo.PagingVO;

public class OxideMarkVO extends PagingVO {
	private String oxide_cd, oxide_content, used_flag;

	public String getOxide_cd() {
		return oxide_cd;
	}

	public void setOxide_cd(String oxide_cd) {
		this.oxide_cd = oxide_cd;
	}

	public String getOxide_content() {
		return oxide_content;
	}

	public void setOxide_content(String oxide_content) {
		this.oxide_content = oxide_content;
	}

	public String getUsed_flag() {
		return used_flag;
	}

	public void setUsed_flag(String used_flag) {
		this.used_flag = used_flag;
	}

		

}
