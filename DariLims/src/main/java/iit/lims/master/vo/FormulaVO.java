package iit.lims.master.vo;

import iit.lims.common.vo.WorkVO;

public class FormulaVO extends WorkVO {
	
	/*FORMULA*/
	private String formula_no;/*계산식번호*/
	private String formula_nm;/*계산식이름*/
	private String formula_desc;/*계산식설명*/
	private String formula_disp;/*계산식*/
	
	/*FORMULA_DETAIL*/
	private String variable_no;/*변수번호*/
	private String variable_nm;/*변수명*/
	private String variable_desc;/*변수설명*/
	
	private String formula_yn;
	private String sm_code;
	private String testitm_cd;
	private int formulaDtailYorN;
	private String input_val;
	
	
	
	
	
	public String getInput_val() {
		return input_val;
	}
	public void setInput_val(String input_val) {
		this.input_val = input_val;
	}
	public int getFormulaDtailYorN() {
		return formulaDtailYorN;
	}
	public void setFormulaDtailYorN(int formulaDtailYorN) {
		this.formulaDtailYorN = formulaDtailYorN;
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
	public String getFormula_desc() {
		return formula_desc;
	}
	public void setFormula_desc(String formula_desc) {
		this.formula_desc = formula_desc;
	}
	public String getFormula_disp() {
		return formula_disp;
	}
	public void setFormula_disp(String formula_disp) {
		this.formula_disp = formula_disp;
	}
	public String getVariable_no() {
		return variable_no;
	}
	public void setVariable_no(String variable_no) {
		this.variable_no = variable_no;
	}
	public String getVariable_nm() {
		return variable_nm;
	}
	public void setVariable_nm(String variable_nm) {
		this.variable_nm = variable_nm;
	}
	public String getVariable_desc() {
		return variable_desc;
	}
	public void setVariable_desc(String variable_desc) {
		this.variable_desc = variable_desc;
	}
	public String getFormula_yn() {
		return formula_yn;
	}
	public void setFormula_yn(String formula_yn) {
		this.formula_yn = formula_yn;
	}
	public String getSm_code() {
		return sm_code;
	}
	public void setSm_code(String sm_code) {
		this.sm_code = sm_code;
	}
	public String getTestitm_cd() {
		return testitm_cd;
	}
	public void setTestitm_cd(String testitm_cd) {
		this.testitm_cd = testitm_cd;
	}
}