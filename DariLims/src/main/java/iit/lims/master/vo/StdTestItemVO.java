package iit.lims.master.vo;

public class StdTestItemVO extends TestItemVO {
	private String std_hval, std_lval;
	private String result_type, result_val, jdg_type;
	private String std_fit_val, std_unfit_val;
	private String hval_type, lval_type;
	private String std_total, std_val;
	private String loq_lval, loq_hval;
	//개정이력
	private String rev_date, rev_reason;

	private String std_desc;
	
	private String spec_val, prdlst_cd, prdlst_nm, 
					unit_cd, vald_manli, 
					mxmm_val, mxmm_val_dvs_cd, mimm_val, mimm_val_dvs_cd, 
					vald_begn_dt, self_spec_no, choic_fit, choic_impropt, choic_fit_nm, std_unfit_val_nm, 
					jdgmnt_fom_cd, sortTarget, sortValue;
	
	private String  hrnk_prdlst_cd, hrnk_prdlst_nm,				    
				    prdlst_yn, type, injry_yn,
				    fnprt_itm_incls_yn,
				    ntr_prsec_itm_yn,
				    montrng_testitm_yn,
				    emphs_prsec_testitm_yn,
				    rvlv_else_testitm_yn;
	

	public String getStd_hval() {
		return std_hval;
	}

	public void setStd_hval(String std_hval) {
		this.std_hval = std_hval;
	}

	public String getStd_lval() {
		return std_lval;
	}

	public void setStd_lval(String std_lval) {
		this.std_lval = std_lval;
	}

	public String getResult_type() {
		return result_type;
	}

	public void setResult_type(String result_type) {
		this.result_type = result_type;
	}

	public String getResult_val() {
		return result_val;
	}

	public void setResult_val(String result_val) {
		this.result_val = result_val;
	}

	public String getJdg_type() {
		return jdg_type;
	}

	public void setJdg_type(String jdg_type) {
		this.jdg_type = jdg_type;
	}

	public String getStd_fit_val() {
		return std_fit_val;
	}

	public void setStd_fit_val(String std_fit_val) {
		this.std_fit_val = std_fit_val;
	}

	public String getStd_unfit_val() {
		return std_unfit_val;
	}

	public void setStd_unfit_val(String std_unfit_val) {
		this.std_unfit_val = std_unfit_val;
	}

	public String getHval_type() {
		return hval_type;
	}

	public void setHval_type(String hval_type) {
		this.hval_type = hval_type;
	}

	public String getLval_type() {
		return lval_type;
	}

	public void setLval_type(String lval_type) {
		this.lval_type = lval_type;
	}

	public String getStd_total() {
		return std_total;
	}

	public void setStd_total(String std_total) {
		this.std_total = std_total;
	}

	public String getStd_val() {
		return std_val;
	}

	public void setStd_val(String std_val) {
		this.std_val = std_val;
	}

	public String getLoq_lval() {
		return loq_lval;
	}

	public void setLoq_lval(String loq_lval) {
		this.loq_lval = loq_lval;
	}

	public String getLoq_hval() {
		return loq_hval;
	}

	public void setLoq_hval(String loq_hval) {
		this.loq_hval = loq_hval;
	}

	public String getRev_date() {
		return rev_date;
	}

	public void setRev_date(String rev_date) {
		this.rev_date = rev_date;
	}

	public String getRev_reason() {
		return rev_reason;
	}

	public void setRev_reason(String rev_reason) {
		this.rev_reason = rev_reason;
	}

	public String getStd_desc() {
		return std_desc;
	}

	public void setStd_desc(String std_desc) {
		this.std_desc = std_desc;
	}

	public String getSpec_val() {
		return spec_val;
	}

	public void setSpec_val(String spec_val) {
		this.spec_val = spec_val;
	}

	public String getPrdlst_cd() {
		return prdlst_cd;
	}

	public void setPrdlst_cd(String prdlst_cd) {
		this.prdlst_cd = prdlst_cd;
	}

	public String getPrdlst_nm() {
		return prdlst_nm;
	}

	public void setPrdlst_nm(String prdlst_nm) {
		this.prdlst_nm = prdlst_nm;
	}

	public String getUnit_cd() {
		return unit_cd;
	}

	public void setUnit_cd(String unit_cd) {
		this.unit_cd = unit_cd;
	}

	public String getVald_manli() {
		return vald_manli;
	}

	public void setVald_manli(String vald_manli) {
		this.vald_manli = vald_manli;
	}

	public String getMxmm_val() {
		return mxmm_val;
	}

	public void setMxmm_val(String mxmm_val) {
		this.mxmm_val = mxmm_val;
	}

	public String getMxmm_val_dvs_cd() {
		return mxmm_val_dvs_cd;
	}

	public void setMxmm_val_dvs_cd(String mxmm_val_dvs_cd) {
		this.mxmm_val_dvs_cd = mxmm_val_dvs_cd;
	}

	public String getMimm_val() {
		return mimm_val;
	}

	public void setMimm_val(String mimm_val) {
		this.mimm_val = mimm_val;
	}

	public String getMimm_val_dvs_cd() {
		return mimm_val_dvs_cd;
	}

	public void setMimm_val_dvs_cd(String mimm_val_dvs_cd) {
		this.mimm_val_dvs_cd = mimm_val_dvs_cd;
	}

	public String getVald_begn_dt() {
		return vald_begn_dt;
	}

	public void setVald_begn_dt(String vald_begn_dt) {
		this.vald_begn_dt = vald_begn_dt;
	}

	public String getSelf_spec_no() {
		return self_spec_no;
	}

	public void setSelf_spec_no(String self_spec_no) {
		this.self_spec_no = self_spec_no;
	}

	public String getChoic_fit() {
		return choic_fit;
	}

	public void setChoic_fit(String choic_fit) {
		this.choic_fit = choic_fit;
	}

	public String getChoic_impropt() {
		return choic_impropt;
	}

	public void setChoic_impropt(String choic_impropt) {
		this.choic_impropt = choic_impropt;
	}

	public String getChoic_fit_nm() {
		return choic_fit_nm;
	}

	public void setChoic_fit_nm(String choic_fit_nm) {
		this.choic_fit_nm = choic_fit_nm;
	}

	public String getStd_unfit_val_nm() {
		return std_unfit_val_nm;
	}

	public void setStd_unfit_val_nm(String std_unfit_val_nm) {
		this.std_unfit_val_nm = std_unfit_val_nm;
	}

	public String getJdgmnt_fom_cd() {
		return jdgmnt_fom_cd;
	}

	public void setJdgmnt_fom_cd(String jdgmnt_fom_cd) {
		this.jdgmnt_fom_cd = jdgmnt_fom_cd;
	}

	public String getSortTarget() {
		return sortTarget;
	}

	public void setSortTarget(String sortTarget) {
		this.sortTarget = sortTarget;
	}

	public String getSortValue() {
		return sortValue;
	}

	public void setSortValue(String sortValue) {
		this.sortValue = sortValue;
	}

	public String getHrnk_prdlst_cd() {
		return hrnk_prdlst_cd;
	}

	public void setHrnk_prdlst_cd(String hrnk_prdlst_cd) {
		this.hrnk_prdlst_cd = hrnk_prdlst_cd;
	}

	public String getHrnk_prdlst_nm() {
		return hrnk_prdlst_nm;
	}

	public void setHrnk_prdlst_nm(String hrnk_prdlst_nm) {
		this.hrnk_prdlst_nm = hrnk_prdlst_nm;
	}

	public String getPrdlst_yn() {
		return prdlst_yn;
	}

	public void setPrdlst_yn(String prdlst_yn) {
		this.prdlst_yn = prdlst_yn;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getInjry_yn() {
		return injry_yn;
	}

	public void setInjry_yn(String injry_yn) {
		this.injry_yn = injry_yn;
	}

	public String getFnprt_itm_incls_yn() {
		return fnprt_itm_incls_yn;
	}

	public void setFnprt_itm_incls_yn(String fnprt_itm_incls_yn) {
		this.fnprt_itm_incls_yn = fnprt_itm_incls_yn;
	}

	public String getNtr_prsec_itm_yn() {
		return ntr_prsec_itm_yn;
	}

	public void setNtr_prsec_itm_yn(String ntr_prsec_itm_yn) {
		this.ntr_prsec_itm_yn = ntr_prsec_itm_yn;
	}

	public String getMontrng_testitm_yn() {
		return montrng_testitm_yn;
	}

	public void setMontrng_testitm_yn(String montrng_testitm_yn) {
		this.montrng_testitm_yn = montrng_testitm_yn;
	}

	public String getEmphs_prsec_testitm_yn() {
		return emphs_prsec_testitm_yn;
	}

	public void setEmphs_prsec_testitm_yn(String emphs_prsec_testitm_yn) {
		this.emphs_prsec_testitm_yn = emphs_prsec_testitm_yn;
	}

	public String getRvlv_else_testitm_yn() {
		return rvlv_else_testitm_yn;
	}

	public void setRvlv_else_testitm_yn(String rvlv_else_testitm_yn) {
		this.rvlv_else_testitm_yn = rvlv_else_testitm_yn;
	}
	

}
