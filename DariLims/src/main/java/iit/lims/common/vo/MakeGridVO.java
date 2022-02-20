package iit.lims.common.vo;

import java.util.HashMap;
import java.util.List;

import iit.lims.common.vo.WorkVO;

public class MakeGridVO extends WorkVO {
	private String type;
	private List<String> head;
	private List<HashMap<String, String>> body;

	private String prdlst_kind1_cd; // 품목대분류 코드l0
	private String prdlst_kind1_nm;
	private String prdlst_kind2_cd;
	private String prdlst_kind2_nm;
	private String htrk_prdlst_cd;
	private String htrk_prdlst_nm;
	
	private String startYear;
	private String endYear;
	private String req_class;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<HashMap<String, String>> getBody() {
		return body;
	}

	public void setBody(List<HashMap<String, String>> body) {
		this.body = body;
	}

	public List<String> getHead() {
		return head;
	}

	public void setHead(List<String> head) {
		this.head = head;
	}

	public String getStartYear() {
		return startYear;
	}

	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}

	public String getEndYear() {
		return endYear;
	}

	public void setEndYear(String endYear) {
		this.endYear = endYear;
	}


	public String getPrdlst_kind1_cd() {
		return prdlst_kind1_cd;
	}
	public void setPrdlst_kind1_cd(String prdlst_kind1_cd) {
		this.prdlst_kind1_cd = prdlst_kind1_cd;
	}
	public String getPrdlst_kind1_nm() {
		return prdlst_kind1_nm;
	}
	public void setPrdlst_kind1_nm(String prdlst_kind1_nm) {
		this.prdlst_kind1_nm = prdlst_kind1_nm;
	}
	public String getPrdlst_kind2_cd() {
		return prdlst_kind2_cd;
	}
	public void setPrdlst_kind2_cd(String prdlst_kind2_cd) {
		this.prdlst_kind2_cd = prdlst_kind2_cd;
	}
	public String getPrdlst_kind2_nm() {
		return prdlst_kind2_nm;
	}
	public void setPrdlst_kind2_nm(String prdlst_kind2_nm) {
		this.prdlst_kind2_nm = prdlst_kind2_nm;
	}

	public String getHtrk_prdlst_nm() {
		return htrk_prdlst_nm;
	}
	public void setHtrk_prdlst_nm(String htrk_prdlst_nm) {
		this.htrk_prdlst_nm = htrk_prdlst_nm;
	}
	public String getHtrk_prdlst_cd() {
		return htrk_prdlst_cd;
	}
	public void setHtrk_prdlst_cd(String htrk_prdlst_cd) {
		this.htrk_prdlst_cd = htrk_prdlst_cd;
	}

	public String getReq_class() {
		return req_class;
	}

	public void setReq_class(String req_class) {
		this.req_class = req_class;
	}

}