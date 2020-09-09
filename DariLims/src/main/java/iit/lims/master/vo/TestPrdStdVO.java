package iit.lims.master.vo;

import iit.lims.master.vo.TestItemVO;

public class TestPrdStdVO extends TestItemVO {

	private String std_desc;
	
	private String spec_val, prdlst_cd, prdlst_nm, 
					base_cd, unit_cd, test_method_nm, vald_manli, 
					account_no, account_nm, formula_no, formula_nm, formula_disp, formula_result_disp,
					std_fit_val, std_unfit_val,
					loq_lval, loq_hval, loq_lval_mark, loq_hval_mark,
					mxmm_val, mxmm_val_dvs_cd, mimm_val, mimm_val_dvs_cd, 
					vald_begn_dt, self_spec_no, choic_fit, choic_impropt, choic_fit_nm, std_unfit_val_nm, result_type, 
					jdgmnt_fom_cd, indv_spec_seq, sortTarget, sortValue;
	
	private String  hrnk_prdlst_cd, hrnk_prdlst_nm,				    
				    prdlst_yn, type, injry_yn,
				    fnprt_itm_incls_yn, fnprt_itm_nm,
				    ntr_prsec_itm_yn,
				    montrng_testitm_yn,
				    emphs_prsec_testitm_yn,
				    rvlv_else_testitm_yn;
	
	private String result_val, jdg_type, jdg_etc;
	private String spec_dvs;
	private String spec_nm;
	private String prdlst_cd_origin;
	private String item_order;
	
	// 개정이력
	private String rev_date, rev_reason;

	private String represent_cd, represent_nm;
	
	private String spec_type;

	private String htrk_prdlst_cd;
	private String htrk_prdlst_nm;
	
	
	private String grade1;
	private String grade2;
	private String grade3;
	private String grade4;
	
	private String grade1_range;
	private String grade2_range;
	private String grade3_range;
	private String grade4_range;
	
	private String grade1_nm;
	private String grade2_nm;
	private String grade3_nm;
	private String grade4_nm;
	
	private String copy_prdlst_cd;

	private String base_nm, jdgmnt_fom_nm, choic_impropt_nm, mimm_val_dvs_nm, mxmm_val_dvs_nm, unit_nm;
	
	private String grade_at;
	
	private String report_flag;//성적서 표시 순서
	
	public String getJdg_etc() {
		return jdg_etc;
	}

	public void setJdg_etc(String jdg_etc) {
		this.jdg_etc = jdg_etc;
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
	
	public String getLoq_lval_mark() {
		return loq_lval_mark;
	}

	public void setLoq_lval_mark(String loq_lval_mark) {
		this.loq_lval_mark = loq_lval_mark;
	}

	public String getLoq_hval_mark() {
		return loq_hval_mark;
	}

	public void setLoq_hval_mark(String loq_hval_mark) {
		this.loq_hval_mark = loq_hval_mark;
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

	public String getResult_type() {
		return result_type;
	}

	public void setResult_type(String result_type) {
		this.result_type = result_type;
	}

	public String getJdgmnt_fom_cd() {
		return jdgmnt_fom_cd;
	}

	public void setJdgmnt_fom_cd(String jdgmnt_fom_cd) {
		this.jdgmnt_fom_cd = jdgmnt_fom_cd;
	}

	public String getIndv_spec_seq() {
		return indv_spec_seq;
	}

	public void setIndv_spec_seq(String indv_spec_seq) {
		this.indv_spec_seq = indv_spec_seq;
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

	public String getFnprt_itm_nm() {
		return fnprt_itm_nm;
	}

	public void setFnprt_itm_nm(String fnprt_itm_nm) {
		this.fnprt_itm_nm = fnprt_itm_nm;
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
	
	

	public String getRepresent_cd() {
		return represent_cd;
	}

	public void setRepresent_cd(String represent_cd) {
		this.represent_cd = represent_cd;
	}
	

	public String getRepresent_nm() {
		return represent_nm;
	}

	public void setRepresent_nm(String represent_nm) {
		this.represent_nm = represent_nm;
	}


	public String getSpec_type() {
		return spec_type;
	}
	public void setSpec_type(String spec_type) {
		this.spec_type = spec_type;
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
	
	public String getSpec_dvs() {
		return spec_dvs;
	}

	public void setSpec_dvs(String spec_dvs) {
		this.spec_dvs = spec_dvs;
	}

	public String getSpec_nm() {
		return spec_nm;
	}

	public void setSpec_nm(String spec_nm) {
		this.spec_nm = spec_nm;
	}

	public String getPrdlst_cd_origin() {
		return prdlst_cd_origin;
	}

	public void setPrdlst_cd_origin(String prdlst_cd_origin) {
		this.prdlst_cd_origin = prdlst_cd_origin;
	}

	public String getGrade1() {
		return grade1;
	}

	public void setGrade1(String grade1) {
		this.grade1 = grade1;
	}

	public String getGrade2() {
		return grade2;
	}

	public void setGrade2(String grade2) {
		this.grade2 = grade2;
	}

	public String getGrade3() {
		return grade3;
	}

	public void setGrade3(String grade3) {
		this.grade3 = grade3;
	}

	public String getGrade4() {
		return grade4;
	}

	public void setGrade4(String grade4) {
		this.grade4 = grade4;
	}

	public String getGrade1_range() {
		return grade1_range;
	}

	public void setGrade1_range(String grade1_range) {
		this.grade1_range = grade1_range;
	}

	public String getGrade2_range() {
		return grade2_range;
	}

	public void setGrade2_range(String grade2_range) {
		this.grade2_range = grade2_range;
	}

	public String getGrade3_range() {
		return grade3_range;
	}

	public void setGrade3_range(String grade3_range) {
		this.grade3_range = grade3_range;
	}

	public String getGrade4_range() {
		return grade4_range;
	}

	public void setGrade4_range(String grade4_range) {
		this.grade4_range = grade4_range;
	}

	public String getGrade1_nm() {
		return grade1_nm;
	}

	public void setGrade1_nm(String grade1_nm) {
		this.grade1_nm = grade1_nm;
	}

	public String getGrade2_nm() {
		return grade2_nm;
	}

	public void setGrade2_nm(String grade2_nm) {
		this.grade2_nm = grade2_nm;
	}

	public String getGrade3_nm() {
		return grade3_nm;
	}

	public void setGrade3_nm(String grade3_nm) {
		this.grade3_nm = grade3_nm;
	}

	public String getGrade4_nm() {
		return grade4_nm;
	}

	public void setGrade4_nm(String grade4_nm) {
		this.grade4_nm = grade4_nm;
	}

	public String getTest_method_nm() {
		return test_method_nm;
	}

	public void setTest_method_nm(String test_method_nm) {
		this.test_method_nm = test_method_nm;
	}

	public String getBase_cd() {
		return base_cd;
	}

	public void setBase_cd(String base_cd) {
		this.base_cd = base_cd;
	}

	public String getAccount_no() {
		return account_no;
	}

	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}

	public String getAccount_nm() {
		return account_nm;
	}

	public void setAccount_nm(String account_nm) {
		this.account_nm = account_nm;
	}

	public String getFormula_no() {
		return formula_no;
	}

	public void setFormula_no(String formula_no) {
		this.formula_no = formula_no;
	}

	public String getFormula_nm() {
		return formula_nm;
	}

	public void setFormula_nm(String formula_nm) {
		this.formula_nm = formula_nm;
	}

	public String getFormula_disp() {
		return formula_disp;
	}

	public void setFormula_disp(String formula_disp) {
		this.formula_disp = formula_disp;
	}

	public String getFormula_result_disp() {
		return formula_result_disp;
	}

	public void setFormula_result_disp(String formula_result_disp) {
		this.formula_result_disp = formula_result_disp;
	}

	public String getCopy_prdlst_cd() {
		return copy_prdlst_cd;
	}

	public void setCopy_prdlst_cd(String copy_prdlst_cd) {
		this.copy_prdlst_cd = copy_prdlst_cd;
	}

	public String getBase_nm() {
		return base_nm;
	}

	public void setBase_nm(String base_nm) {
		this.base_nm = base_nm;
	}

	public String getJdgmnt_fom_nm() {
		return jdgmnt_fom_nm;
	}

	public void setJdgmnt_fom_nm(String jdgmnt_fom_nm) {
		this.jdgmnt_fom_nm = jdgmnt_fom_nm;
	}

	public String getChoic_impropt_nm() {
		return choic_impropt_nm;
	}

	public void setChoic_impropt_nm(String choic_impropt_nm) {
		this.choic_impropt_nm = choic_impropt_nm;
	}

	public String getMimm_val_dvs_nm() {
		return mimm_val_dvs_nm;
	}

	public void setMimm_val_dvs_nm(String mimm_val_dvs_nm) {
		this.mimm_val_dvs_nm = mimm_val_dvs_nm;
	}

	public String getMxmm_val_dvs_nm() {
		return mxmm_val_dvs_nm;
	}

	public void setMxmm_val_dvs_nm(String mxmm_val_dvs_nm) {
		this.mxmm_val_dvs_nm = mxmm_val_dvs_nm;
	}

	public String getUnit_nm() {
		return unit_nm;
	}

	public void setUnit_nm(String unit_nm) {
		this.unit_nm = unit_nm;
	}

	public String getGrade_at() {
		return grade_at;
	}

	public void setGrade_at(String grade_at) {
		this.grade_at = grade_at;
	}

	public String getItem_order() {
		return item_order;
	}

	public void setItem_order(String item_order) {
		this.item_order = item_order;
	}

	public String getReport_flag() {
		return report_flag;
	}

	public void setReport_flag(String report_flag) {
		this.report_flag = report_flag;
	}
}
