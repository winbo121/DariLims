package iit.lims.master.vo;

import iit.lims.common.vo.WorkVO;

public class UnitWorkVO extends WorkVO {
	private String unit_work_desc, dept_unit_work_cd;
	private String pre_dept_cd, charger_cd, dept_desc;
	private String pre_dept_nm;
	private String arr_unit_work_cd;
	private String h_unit_work,	m_unit_work;

	public String getUnit_work_desc() {
		return unit_work_desc;
	}

	public void setUnit_work_desc(String unit_work_desc) {
		this.unit_work_desc = unit_work_desc;
	}

	public String getDept_unit_work_cd() {
		return dept_unit_work_cd;
	}

	public void setDept_unit_work_cd(String dept_unit_work_cd) {
		this.dept_unit_work_cd = dept_unit_work_cd;
	}

	public String getPre_dept_cd() {
		return pre_dept_cd;
	}

	public void setPre_dept_cd(String pre_dept_cd) {
		this.pre_dept_cd = pre_dept_cd;
	}

	public String getCharger_cd() {
		return charger_cd;
	}

	public void setCharger_cd(String charger_cd) {
		this.charger_cd = charger_cd;
	}

	public String getDept_desc() {
		return dept_desc;
	}

	public void setDept_desc(String dept_desc) {
		this.dept_desc = dept_desc;
	}

	public String getPre_dept_nm() {
		return pre_dept_nm;
	}

	public void setPre_dept_nm(String pre_dept_nm) {
		this.pre_dept_nm = pre_dept_nm;
	}

	public String getArr_unit_work_cd() {
		return arr_unit_work_cd;
	}

	public void setArr_unit_work_cd(String arr_unit_work_cd) {
		this.arr_unit_work_cd = arr_unit_work_cd;
	}
	
	public String getH_unit_work() {
		return h_unit_work;
	}

	public void setH_unit_work(String h_unit_work) {
		this.h_unit_work = h_unit_work;
	}

	public String getM_unit_work() {
		return m_unit_work;
	}

	public void setM_unit_work(String m_unit_work) {
		this.m_unit_work = m_unit_work;
	}

}
