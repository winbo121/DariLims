package iit.lims.system.vo;

import iit.lims.common.vo.WorkVO;

public class DeptVO extends WorkVO {
	private String dept_desc, pre_dept_cd, pre_dept_nm, charger_cd, lvl_dept_nm, dept_type;
	private String team_cd, team_nm, team_desc, dept_label_cd;
	
	public String getTeam_desc() {
		return team_desc;
	}

	public void setTeam_desc(String team_desc) {
		this.team_desc = team_desc;
	}

	public String getTeam_cd() {
		return team_cd;
	}

	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}

	public String getTeam_nm() {
		return team_nm;
	}

	public void setTeam_nm(String team_nm) {
		this.team_nm = team_nm;
	}

	public String getDept_desc() {
		return dept_desc;
	}

	public void setDept_desc(String dept_desc) {
		this.dept_desc = dept_desc;
	}

	public String getPre_dept_cd() {
		return pre_dept_cd;
	}

	public void setPre_dept_cd(String pre_dept_cd) {
		this.pre_dept_cd = pre_dept_cd;
	}

	public String getPre_dept_nm() {
		return pre_dept_nm;
	}

	public void setPre_dept_nm(String pre_dept_nm) {
		this.pre_dept_nm = pre_dept_nm;
	}

	public String getCharger_cd() {
		return charger_cd;
	}

	public void setCharger_cd(String charger_cd) {
		this.charger_cd = charger_cd;
	}

	public String getLvl_dept_nm() {
		return lvl_dept_nm;
	}

	public void setLvl_dept_nm(String lvl_dept_nm) {
		this.lvl_dept_nm = lvl_dept_nm;
	}

	public String getDept_type() {
		return dept_type;
	}

	public void setDept_type(String dept_type) {
		this.dept_type = dept_type;
	}

	public String getDept_label_cd() {
		return dept_label_cd;
	}

	public void setDept_label_cd(String dept_label_cd) {
		this.dept_label_cd = dept_label_cd;
	}

	@Override
	public String toString() {
		return "DeptVO [dept_desc=" + dept_desc + ", pre_dept_cd=" + pre_dept_cd + ", pre_dept_nm=" + pre_dept_nm
				+ ", charger_cd=" + charger_cd + ", lvl_dept_nm=" + lvl_dept_nm + ", dept_type=" + dept_type
				+ ", team_cd=" + team_cd + ", team_nm=" + team_nm + ", team_desc=" + team_desc + ", dept_label_cd="
				+ dept_label_cd + "]";
	}
}
