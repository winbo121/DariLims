package iit.lims.master.vo;

import iit.lims.common.vo.WorkVO;

public class SampleVO extends WorkVO {
	private String sample_eng_nm, sample_desc, sample_abbr;
	private String making_org_nm;
	private String making_org_no;
	private String making_org_tel;
	private String import_org_nm;
	private String import_org_no;
	private String import_org_tel;
	private String sample_gubun_cd, sample_gubun_nm;

	
	
	public String getSample_gubun_nm() {
		return sample_gubun_nm;
	}

	public void setSample_gubun_nm(String sample_gubun_nm) {
		this.sample_gubun_nm = sample_gubun_nm;
	}

	public String getSample_gubun_cd() {
		return sample_gubun_cd;
	}

	public void setSample_gubun_cd(String sample_gubun_cd) {
		this.sample_gubun_cd = sample_gubun_cd;
	}

	public String getMaking_org_nm() {
		return making_org_nm;
	}

	public void setMaking_org_nm(String making_org_nm) {
		this.making_org_nm = making_org_nm;
	}

	public String getMaking_org_no() {
		return making_org_no;
	}

	public void setMaking_org_no(String making_org_no) {
		this.making_org_no = making_org_no;
	}

	public String getMaking_org_tel() {
		return making_org_tel;
	}

	public void setMaking_org_tel(String making_org_tel) {
		this.making_org_tel = making_org_tel;
	}

	public String getImport_org_nm() {
		return import_org_nm;
	}

	public void setImport_org_nm(String import_org_nm) {
		this.import_org_nm = import_org_nm;
	}

	public String getImport_org_no() {
		return import_org_no;
	}

	public void setImport_org_no(String import_org_no) {
		this.import_org_no = import_org_no;
	}

	public String getImport_org_tel() {
		return import_org_tel;
	}

	public void setImport_org_tel(String import_org_tel) {
		this.import_org_tel = import_org_tel;
	}

	public String getSample_eng_nm() {
		return sample_eng_nm;
	}

	public void setSample_eng_nm(String sample_eng_nm) {
		this.sample_eng_nm = sample_eng_nm;
	}

	public String getSample_desc() {
		return sample_desc;
	}

	public void setSample_desc(String sample_desc) {
		this.sample_desc = sample_desc;
	}

	public String getSample_abbr() {
		return sample_abbr;
	}

	public void setSample_abbr(String sample_abbr) {
		this.sample_abbr = sample_abbr;
	}
}
