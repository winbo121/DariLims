package iit.lims.resultStatistical.vo;

import iit.lims.common.vo.WorkVO;

public class ReceptionStatusVO extends WorkVO {
	private String accept_count, year_count, req_type;

	public String getReq_type() {
		return req_type;
	}

	public void setReq_type(String req_type) {
		this.req_type = req_type;
	}

	public String getAccept_count() {
		return accept_count;
	}

	public void setAccept_count(String accept_count) {
		this.accept_count = accept_count;
	}

	public String getYear_count() {
		return year_count;
	}

	public void setYear_count(String year_count) {
		this.year_count = year_count;
	}	

}
