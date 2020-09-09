package iit.lims.master.vo;

import iit.lims.common.vo.WorkVO;

public class TestStdRevVO extends WorkVO {

	private String rev_reason, rev_date;
	private String arr_test_item_cd;

	public String getArr_test_item_cd() {
		return arr_test_item_cd;
	}

	public void setArr_test_item_cd(String arr_test_item_cd) {
		this.arr_test_item_cd = arr_test_item_cd;
	}

	public String getRev_reason() {
		return rev_reason;
	}

	public void setRev_reason(String rev_reason) {
		this.rev_reason = rev_reason;
	}

	public String getRev_date() {
		return rev_date;
	}

	public void setRev_date(String rev_date) {
		this.rev_date = rev_date;
	}
}
