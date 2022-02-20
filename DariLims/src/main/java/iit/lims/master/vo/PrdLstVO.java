package iit.lims.master.vo;

import iit.lims.common.vo.PagingVO;

public class PrdLstVO extends PagingVO {
	
	/*식약처품목*/
	private String htrk_prdlst_cd;
	private String htrk_prdlst_nm;
	private String hrnk_prdlst_cd;
	private String prdlst_cd;
	private String prdlst_nm;
	private String kor_nm;
	private String eng_nm;
	private String lv;
	private String piam_kor_nm;
	private String mxtr_prdlst_yn;
	private String use_yn;
	private String vald_end_dt;
	private String vald_begn_dt;
	private String rm;
	private String prdlst_yn;
	private String dfn;
	private String last_updt_dtm;
	private String lf;
	private String ex;
	
	/*자사품목*/
	private String prdlst_kind1_cd; // 품목대분류 코드l0
	private String prdlst_kind1_nm;
	private String prdlst_kind2_cd;
	private String prdlst_kind2_nm;
	
	private String disp_prdlst_cd;
	private String charger_user_id;
	private String charger_user_nm;
	private String charger_dept_cd;
	private String charger_dept_nm;
	private String max_grade;
	
	
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
	public String getHrnk_prdlst_cd() {
		return hrnk_prdlst_cd;
	}
	public void setHrnk_prdlst_cd(String hrnk_prdlst_cd) {
		this.hrnk_prdlst_cd = hrnk_prdlst_cd;
	}
	public String getPrdlst_cd() {
		return prdlst_cd;
	}
	public void setPrdlst_cd(String prdlst_cd) {
		this.prdlst_cd = prdlst_cd;
	}
	public String getPldlst_nm() {
		return prdlst_nm;
	}
	public void setPldlst_nm(String pldlst_nm) {
		this.prdlst_nm = pldlst_nm;
	}
	public String getKor_nm() {
		return kor_nm;
	}
	public void setKor_nm(String kor_nm) {
		this.kor_nm = kor_nm;
	}
	public String getEng_nm() {
		return eng_nm;
	}
	public void setEng_nm(String eng_nm) {
		this.eng_nm = eng_nm;
	}
	
	public String getPrdlst_nm() {
		return prdlst_nm;
	}
	public void setPrdlst_nm(String prdlst_nm) {
		this.prdlst_nm = prdlst_nm;
	}
	public String getLv() {
		return lv;
	}
	public void setLv(String lv) {
		this.lv = lv;
	}
	public String getPiam_kor_nm() {
		return piam_kor_nm;
	}
	public void setPiam_kor_nm(String piam_kor_nm) {
		this.piam_kor_nm = piam_kor_nm;
	}
	public String getMxtr_prdlst_yn() {
		return mxtr_prdlst_yn;
	}
	public void setMxtr_prdlst_yn(String mxtr_prdlst_yn) {
		this.mxtr_prdlst_yn = mxtr_prdlst_yn;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getVald_end_dt() {
		return vald_end_dt;
	}
	public void setVald_end_dt(String vald_end_dt) {
		this.vald_end_dt = vald_end_dt;
	}
	public String getVald_begn_dt() {
		return vald_begn_dt;
	}
	public void setVald_begn_dt(String vald_begn_dt) {
		this.vald_begn_dt = vald_begn_dt;
	}
	public String getRm() {
		return rm;
	}
	public void setRm(String rm) {
		this.rm = rm;
	}
	public String getPrdlst_yn() {
		return prdlst_yn;
	}
	public void setPrdlst_yn(String prdlst_yn) {
		this.prdlst_yn = prdlst_yn;
	}
	public String getDfn() {
		return dfn;
	}
	public void setDfn(String dfn) {
		this.dfn = dfn;
	}
	public String getLast_updt_dtm() {
		return last_updt_dtm;
	}
	public void setLast_updt_dtm(String last_updt_dtm) {
		this.last_updt_dtm = last_updt_dtm;
	}
	public String getLf() {
		return lf;
	}
	public void setLf(String lf) {
		this.lf = lf;
	}
	public String getEx() {
		return ex;
	}
	public void setEx(String ex) {
		this.ex = ex;
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
	public String getDisp_prdlst_cd() {
		return disp_prdlst_cd;
	}
	public void setDisp_prdlst_cd(String disp_prdlst_cd) {
		this.disp_prdlst_cd = disp_prdlst_cd;
	}
	public String getCharger_user_id() {
		return charger_user_id;
	}
	public void setCharger_user_id(String charger_user_id) {
		this.charger_user_id = charger_user_id;
	}
	public String getCharger_user_nm() {
		return charger_user_nm;
	}
	public void setCharger_user_nm(String charger_user_nm) {
		this.charger_user_nm = charger_user_nm;
	}
	public String getCharger_dept_cd() {
		return charger_dept_cd;
	}
	public void setCharger_dept_cd(String charger_dept_cd) {
		this.charger_dept_cd = charger_dept_cd;
	}
	public String getCharger_dept_nm() {
		return charger_dept_nm;
	}
	public void setCharger_dept_nm(String charger_dept_nm) {
		this.charger_dept_nm = charger_dept_nm;
	}
	public String getMax_grade() {
		return max_grade;
	}
	public void setMax_grade(String max_grade) {
		this.max_grade = max_grade;
	}	
	
}