package iit.lims.master.vo;

import iit.lims.common.vo.WorkVO;

public class TestStdVO extends WorkVO {

	private String std_desc;
	
	private String indv_spec_seq;

	public String getStd_desc() {
		return std_desc;
	}

	public void setStd_desc(String std_desc) {
		this.std_desc = std_desc;
	}

	public String getIndv_spec_seq() {
		return indv_spec_seq;
	}

	public void setIndv_spec_seq(String indv_spec_seq) {
		this.indv_spec_seq = indv_spec_seq;
	}
	
}
