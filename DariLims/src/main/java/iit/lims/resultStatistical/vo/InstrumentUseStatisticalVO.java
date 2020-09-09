package iit.lims.resultStatistical.vo;

import iit.lims.instrument.vo.MachineVO;

public class InstrumentUseStatisticalVO extends MachineVO {
		
	/*연도별*/
	private String m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12;
	/*분기별*/
	private String q01,q02,q03,q04;
	
	private String tot_use_time, manage_time, manage_rate;

	private String type, year;
	
	public String getM01() {
		return m01;
	}

	public void setM01(String m01) {
		this.m01 = m01;
	}

	public String getM02() {
		return m02;
	}

	public void setM02(String m02) {
		this.m02 = m02;
	}

	public String getM03() {
		return m03;
	}

	public void setM03(String m03) {
		this.m03 = m03;
	}

	public String getM04() {
		return m04;
	}

	public void setM04(String m04) {
		this.m04 = m04;
	}

	public String getM05() {
		return m05;
	}

	public void setM05(String m05) {
		this.m05 = m05;
	}

	public String getM06() {
		return m06;
	}

	public void setM06(String m06) {
		this.m06 = m06;
	}

	public String getM07() {
		return m07;
	}

	public void setM07(String m07) {
		this.m07 = m07;
	}

	public String getM08() {
		return m08;
	}

	public void setM08(String m08) {
		this.m08 = m08;
	}

	public String getM09() {
		return m09;
	}

	public void setM09(String m09) {
		this.m09 = m09;
	}

	public String getM10() {
		return m10;
	}

	public void setM10(String m10) {
		this.m10 = m10;
	}

	public String getM11() {
		return m11;
	}

	public void setM11(String m11) {
		this.m11 = m11;
	}

	public String getM12() {
		return m12;
	}

	public void setM12(String m12) {
		this.m12 = m12;
	}

	public String getQ01() {
		return q01;
	}

	public void setQ01(String q01) {
		this.q01 = q01;
	}

	public String getQ02() {
		return q02;
	}

	public void setQ02(String q02) {
		this.q02 = q02;
	}

	public String getQ03() {
		return q03;
	}

	public void setQ03(String q03) {
		this.q03 = q03;
	}

	public String getQ04() {
		return q04;
	}

	public void setQ04(String q04) {
		this.q04 = q04;
	}

	public String getTot_use_time() {
		return tot_use_time;
	}

	public void setTot_use_time(String tot_use_time) {
		this.tot_use_time = tot_use_time;
	}

	public String getManage_time() {
		return manage_time;
	}

	public void setManage_time(String manage_time) {
		this.manage_time = manage_time;
	}

	public String getManage_rate() {
		return manage_rate;
	}

	public void setManage_rate(String manage_rate) {
		this.manage_rate = manage_rate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}
	
	
}
