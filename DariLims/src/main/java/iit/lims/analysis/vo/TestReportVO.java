
package iit.lims.analysis.vo;

import iit.lims.accept.vo.AcceptVO;

public class TestReportVO extends AcceptVO {

	private String test_report_content;
	private String test_method_preclean;
	private String test_method_content;
	private String inst_kor_nm;
	private String inst_eng_nm;
	private String account_tot_disp;
	private String account_tot_cal_disp;
	private String account_val_desc;
	private String account_val_desc_tot;	
	private String appr_nm;
	private String item_nm;
	
	
	public String getAccount_tot_disp() {
		return account_tot_disp;
	}
	public void setAccount_tot_disp(String account_tot_disp) {
		this.account_tot_disp = account_tot_disp;
	}
	public String getAccount_val_desc() {
		return account_val_desc;
	}
	public void setAccount_val_desc(String account_val_desc) {
		this.account_val_desc = account_val_desc;
	}
	public String getAccount_tot_cal_disp() {
		return account_tot_cal_disp;
	}
	public void setAccount_tot_cal_disp(String account_tot_cal_disp) {
		this.account_tot_cal_disp = account_tot_cal_disp;
	}
	public String getAccount_val_desc_tot() {
		return account_val_desc_tot;
	}
	public void setAccount_val_desc_tot(String account_val_desc_tot) {
		this.account_val_desc_tot = account_val_desc_tot;
	}
	public String getTest_report_content() {
		return test_report_content;
	}
	public void setTest_report_content(String test_report_content) {
		this.test_report_content = test_report_content;
	}

	public String getTest_method_preclean() {
		return test_method_preclean;
	}
	public void setTest_method_preclean(String test_method_preclean) {
		this.test_method_preclean = test_method_preclean;
	}
	public String getTest_method_content() {
		return test_method_content;
	}
	public void setTest_method_content(String test_method_content) {
		this.test_method_content = test_method_content;
	}
	public String getInst_kor_nm() {
		return inst_kor_nm;
	}
	public void setInst_kor_nm(String inst_kor_nm) {
		this.inst_kor_nm = inst_kor_nm;
	}
	public String getInst_eng_nm() {
		return inst_eng_nm;
	}
	public void setInst_eng_nm(String inst_eng_nm) {
		this.inst_eng_nm = inst_eng_nm;
	}
	public String getAppr_nm() {
		return appr_nm;
	}
	public void setAppr_nm(String appr_nm) {
		this.appr_nm = appr_nm;
	}
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	
}
