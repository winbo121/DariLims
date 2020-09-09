package iit.lims.resultStatistical.vo;

import iit.lims.common.vo.PagingVO;

public class ResultStatisticalVO extends PagingVO {

	private String req_date, supv_dept_cd, sampling_point_no, sampling_point_nm, result_val, std_val, tester_id;
	private String req_type, state, jdg_type;
	private String reqStartDate, reqEndDate, test_goal;
	private String report_disp_val;
	//시료정보목록
	private String sample_reg_nm, sampling_date, sampling_method, deadline_date, etc_desc, sampling_method_nm;
	private String sampling_id, test_sample_result, return_flag, tot_item_count, dept_appr_flag, sampling_hour, sampling_min;

	private String test_sample_result_nm, title, test_goal_nm, org_nm, req_nm, msrnm, unit;
	private String test_item_mnm, test_item_enm;

	//통계(월별 - 의뢰, 시료 갯수)
	private int a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, a11, a12;
	private int b01, b02, b03, b04, b05, b06, b07, b08, b09, b10, b11, b12, a_total, b_total, c_total;
	private int c01, c02, c03, c04, c05, c06, c07, c08, c09, c10, c11, c12;
	//분기별
	private int qa01, qa02, qa03, qa04, qb01, qb02, qb03, qb04, qc01, qc02, qc03, qc04;
	private String req_type_nm;
	private String type, year;
	
	//최종 수수료
	private String commission_amt_det;
	
	// 사용자별 통계
	private String result_type, req_org_no, team_cd;

	private String prdlst_kind1_cd; // 품목대분류 코드l0
	private String prdlst_kind1_nm;
	private String prdlst_kind2_cd;
	private String prdlst_kind2_nm;
	private String htrk_prdlst_cd;
	private String htrk_prdlst_nm;
	private String sales_user_id, sales_dept_cd;
	private String report_flag;
	private String prdlst_nm;
	private String last_report_date;
	private String exceed_reason;
	
	private String test_comply_yn, report_comply_yn;
	
	private String result_val_his, report_disp_val_his;
	
	private String valid_position;
	
	private String jdg_type_grade;
	
	private String formula_disp;
	
	private String formula_result_disp;
	
	private String inst_kor_nm;
	
	private String test_method_nm;
	
	private String file_nm;
	
	private String real_user_nm;
	
	private String sample_arrival_date;
	
	

	public String getReal_user_nm() {
		return real_user_nm;
	}

	public void setReal_user_nm(String real_user_nm) {
		this.real_user_nm = real_user_nm;
	}

	public String getInst_kor_nm() {
		return inst_kor_nm;
	}

	public void setInst_kor_nm(String inst_kor_nm) {
		this.inst_kor_nm = inst_kor_nm;
	}

	public String getTest_method_nm() {
		return test_method_nm;
	}

	public void setTest_method_nm(String test_method_nm) {
		this.test_method_nm = test_method_nm;
	}

	public String getFile_nm() {
		return file_nm;
	}

	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
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

	public String getJdg_type_grade() {
		return jdg_type_grade;
	}

	public void setJdg_type_grade(String jdg_type_grade) {
		this.jdg_type_grade = jdg_type_grade;
	}

	public String getValid_position() {
		return valid_position;
	}

	public void setValid_position(String valid_position) {
		this.valid_position = valid_position;
	}

	public String getTest_comply_yn() {
		return test_comply_yn;
	}

	public void setTest_comply_yn(String test_comply_yn) {
		this.test_comply_yn = test_comply_yn;
	}

	public String getReport_comply_yn() {
		return report_comply_yn;
	}

	public void setReport_comply_yn(String report_comply_yn) {
		this.report_comply_yn = report_comply_yn;
	}

	public String getExceed_reason() {
		return exceed_reason;
	}

	public void setExceed_reason(String exceed_reason) {
		this.exceed_reason = exceed_reason;
	}

	public String getTeam_cd() {
		return team_cd;
	}

	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}

	public String getReq_org_no() {
		return req_org_no;
	}

	public void setReq_org_no(String req_org_no) {
		this.req_org_no = req_org_no;
	}

	public String getResult_type() {
		return result_type;
	}

	public void setResult_type(String result_type) {
		this.result_type = result_type;
	}

	public String getReport_disp_val() {
		return report_disp_val;
	}

	public void setReport_disp_val(String report_disp_val) {
		this.report_disp_val = report_disp_val;
	}

	public String getSampling_min() {
		return sampling_min;
	}

	public void setSampling_min(String sampling_min) {
		this.sampling_min = sampling_min;
	}

	public int getQc01() {
		return qc01;
	}

	public void setQc01(int qc01) {
		this.qc01 = qc01;
	}

	public int getQc02() {
		return qc02;
	}

	public void setQc02(int qc02) {
		this.qc02 = qc02;
	}

	public int getQc03() {
		return qc03;
	}

	public void setQc03(int qc03) {
		this.qc03 = qc03;
	}

	public int getQc04() {
		return qc04;
	}

	public void setQc04(int qc04) {
		this.qc04 = qc04;
	}

	public int getC_total() {
		return c_total;
	}

	public void setC_total(int c_total) {
		this.c_total = c_total;
	}

	public int getC01() {
		return c01;
	}

	public void setC01(int c01) {
		this.c01 = c01;
	}

	public int getC02() {
		return c02;
	}

	public void setC02(int c02) {
		this.c02 = c02;
	}

	public int getC03() {
		return c03;
	}

	public void setC03(int c03) {
		this.c03 = c03;
	}

	public int getC04() {
		return c04;
	}

	public void setC04(int c04) {
		this.c04 = c04;
	}

	public int getC05() {
		return c05;
	}

	public void setC05(int c05) {
		this.c05 = c05;
	}

	public int getC06() {
		return c06;
	}

	public void setC06(int c06) {
		this.c06 = c06;
	}

	public int getC07() {
		return c07;
	}

	public void setC07(int c07) {
		this.c07 = c07;
	}

	public int getC08() {
		return c08;
	}

	public void setC08(int c08) {
		this.c08 = c08;
	}

	public int getC09() {
		return c09;
	}

	public void setC09(int c09) {
		this.c09 = c09;
	}

	public int getC10() {
		return c10;
	}

	public void setC10(int c10) {
		this.c10 = c10;
	}

	public int getC11() {
		return c11;
	}

	public void setC11(int c11) {
		this.c11 = c11;
	}

	public int getC12() {
		return c12;
	}

	public void setC12(int c12) {
		this.c12 = c12;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public int getQa01() {
		return qa01;
	}

	public void setQa01(int qa01) {
		this.qa01 = qa01;
	}

	public int getQa02() {
		return qa02;
	}

	public void setQa02(int qa02) {
		this.qa02 = qa02;
	}

	public int getQa03() {
		return qa03;
	}

	public void setQa03(int qa03) {
		this.qa03 = qa03;
	}

	public int getQa04() {
		return qa04;
	}

	public void setQa04(int qa04) {
		this.qa04 = qa04;
	}

	public int getQb01() {
		return qb01;
	}

	public void setQb01(int qb01) {
		this.qb01 = qb01;
	}

	public int getQb02() {
		return qb02;
	}

	public void setQb02(int qb02) {
		this.qb02 = qb02;
	}

	public int getQb03() {
		return qb03;
	}

	public void setQb03(int qb03) {
		this.qb03 = qb03;
	}

	public int getQb04() {
		return qb04;
	}

	public void setQb04(int qb04) {
		this.qb04 = qb04;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getA_total() {
		return a_total;
	}

	public void setA_total(int a_total) {
		this.a_total = a_total;
	}

	public int getB_total() {
		return b_total;
	}

	public void setB_total(int b_total) {
		this.b_total = b_total;
	}

	public int getA01() {
		return a01;
	}

	public void setA01(int a01) {
		this.a01 = a01;
	}

	public int getA02() {
		return a02;
	}

	public void setA02(int a02) {
		this.a02 = a02;
	}

	public int getA03() {
		return a03;
	}

	public void setA03(int a03) {
		this.a03 = a03;
	}

	public int getA04() {
		return a04;
	}

	public void setA04(int a04) {
		this.a04 = a04;
	}

	public int getA05() {
		return a05;
	}

	public void setA05(int a05) {
		this.a05 = a05;
	}

	public int getA06() {
		return a06;
	}

	public void setA06(int a06) {
		this.a06 = a06;
	}

	public int getA07() {
		return a07;
	}

	public void setA07(int a07) {
		this.a07 = a07;
	}

	public int getA08() {
		return a08;
	}

	public void setA08(int a08) {
		this.a08 = a08;
	}

	public int getA09() {
		return a09;
	}

	public void setA09(int a09) {
		this.a09 = a09;
	}

	public int getA10() {
		return a10;
	}

	public void setA10(int a10) {
		this.a10 = a10;
	}

	public int getA11() {
		return a11;
	}

	public void setA11(int a11) {
		this.a11 = a11;
	}

	public int getA12() {
		return a12;
	}

	public void setA12(int a12) {
		this.a12 = a12;
	}

	public int getB01() {
		return b01;
	}

	public void setB01(int b01) {
		this.b01 = b01;
	}

	public int getB02() {
		return b02;
	}

	public void setB02(int b02) {
		this.b02 = b02;
	}

	public int getB03() {
		return b03;
	}

	public void setB03(int b03) {
		this.b03 = b03;
	}

	public int getB04() {
		return b04;
	}

	public void setB04(int b04) {
		this.b04 = b04;
	}

	public int getB05() {
		return b05;
	}

	public void setB05(int b05) {
		this.b05 = b05;
	}

	public int getB06() {
		return b06;
	}

	public void setB06(int b06) {
		this.b06 = b06;
	}

	public int getB07() {
		return b07;
	}

	public void setB07(int b07) {
		this.b07 = b07;
	}

	public int getB08() {
		return b08;
	}

	public void setB08(int b08) {
		this.b08 = b08;
	}

	public int getB09() {
		return b09;
	}

	public void setB09(int b09) {
		this.b09 = b09;
	}

	public int getB10() {
		return b10;
	}

	public void setB10(int b10) {
		this.b10 = b10;
	}

	public int getB11() {
		return b11;
	}

	public void setB11(int b11) {
		this.b11 = b11;
	}

	public int getB12() {
		return b12;
	}

	public void setB12(int b12) {
		this.b12 = b12;
	}

	public String getReq_type_nm() {
		return req_type_nm;
	}

	public void setReq_type_nm(String req_type_nm) {
		this.req_type_nm = req_type_nm;
	}

	public String getTest_item_mnm() {
		return test_item_mnm;
	}

	public void setTest_item_mnm(String test_item_mnm) {
		this.test_item_mnm = test_item_mnm;
	}

	public String getTest_item_enm() {
		return test_item_enm;
	}

	public void setTest_item_enm(String test_item_enm) {
		this.test_item_enm = test_item_enm;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getMsrnm() {
		return msrnm;
	}

	public void setMsrnm(String msrnm) {
		this.msrnm = msrnm;
	}

	public String getReq_nm() {
		return req_nm;
	}

	public void setReq_nm(String req_nm) {
		this.req_nm = req_nm;
	}

	public String getOrg_nm() {
		return org_nm;
	}

	public void setOrg_nm(String org_nm) {
		this.org_nm = org_nm;
	}

	public String getTest_goal_nm() {
		return test_goal_nm;
	}

	public void setTest_goal_nm(String test_goal_nm) {
		this.test_goal_nm = test_goal_nm;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTest_goal() {
		return test_goal;
	}

	public void setTest_goal(String test_goal) {
		this.test_goal = test_goal;
	}

	public String getReqStartDate() {
		return reqStartDate;
	}

	public void setReqStartDate(String reqStartDate) {
		this.reqStartDate = reqStartDate;
	}

	public String getReqEndDate() {
		return reqEndDate;
	}

	public void setReqEndDate(String reqEndDate) {
		this.reqEndDate = reqEndDate;
	}

	public String getTest_sample_result_nm() {
		return test_sample_result_nm;
	}

	public void setTest_sample_result_nm(String test_sample_result_nm) {
		this.test_sample_result_nm = test_sample_result_nm;
	}

	public String getSampling_method_nm() {
		return sampling_method_nm;
	}

	public void setSampling_method_nm(String sampling_method_nm) {
		this.sampling_method_nm = sampling_method_nm;
	}

	public String getSample_reg_nm() {
		return sample_reg_nm;
	}

	public void setSample_reg_nm(String sample_reg_nm) {
		this.sample_reg_nm = sample_reg_nm;
	}

	public String getSampling_date() {
		return sampling_date;
	}

	public void setSampling_date(String sampling_date) {
		this.sampling_date = sampling_date;
	}

	public String getSampling_method() {
		return sampling_method;
	}

	public void setSampling_method(String sampling_method) {
		this.sampling_method = sampling_method;
	}

	public String getDeadline_date() {
		return deadline_date;
	}

	public void setDeadline_date(String deadline_date) {
		this.deadline_date = deadline_date;
	}

	public String getEtc_desc() {
		return etc_desc;
	}

	public void setEtc_desc(String etc_desc) {
		this.etc_desc = etc_desc;
	}

	public String getSampling_id() {
		return sampling_id;
	}

	public void setSampling_id(String sampling_id) {
		this.sampling_id = sampling_id;
	}

	public String getTest_sample_result() {
		return test_sample_result;
	}

	public void setTest_sample_result(String test_sample_result) {
		this.test_sample_result = test_sample_result;
	}

	public String getReturn_flag() {
		return return_flag;
	}

	public void setReturn_flag(String return_flag) {
		this.return_flag = return_flag;
	}

	public String getTot_item_count() {
		return tot_item_count;
	}

	public void setTot_item_count(String tot_item_count) {
		this.tot_item_count = tot_item_count;
	}

	public String getDept_appr_flag() {
		return dept_appr_flag;
	}

	public void setDept_appr_flag(String dept_appr_flag) {
		this.dept_appr_flag = dept_appr_flag;
	}

	public String getSampling_hour() {
		return sampling_hour;
	}

	public void setSampling_hour(String sampling_hour) {
		this.sampling_hour = sampling_hour;
	}

	public String getJdg_type() {
		return jdg_type;
	}

	public void setJdg_type(String jdg_type) {
		this.jdg_type = jdg_type;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getReq_type() {
		return req_type;
	}

	public void setReq_type(String req_type) {
		this.req_type = req_type;
	}

	public String getSampling_point_nm() {
		return sampling_point_nm;
	}

	public void setSampling_point_nm(String sampling_point_nm) {
		this.sampling_point_nm = sampling_point_nm;
	}

	public String getTester_id() {
		return tester_id;
	}

	public void setTester_id(String tester_id) {
		this.tester_id = tester_id;
	}

	public String getReq_date() {
		return req_date;
	}

	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}

	public String getSupv_dept_cd() {
		return supv_dept_cd;
	}

	public void setSupv_dept_cd(String supv_dept_cd) {
		this.supv_dept_cd = supv_dept_cd;
	}

	public String getSampling_point_no() {
		return sampling_point_no;
	}

	public void setSampling_point_no(String sampling_point_no) {
		this.sampling_point_no = sampling_point_no;
	}

	public String getResult_val() {
		return result_val;
	}

	public void setResult_val(String result_val) {
		this.result_val = result_val;
	}

	public String getStd_val() {
		return std_val;
	}

	public void setStd_val(String std_val) {
		this.std_val = std_val;
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
	

	public String getSales_user_id() {
		return sales_user_id;
	}
	public void setSales_user_id(String sales_user_id) {
		this.sales_user_id = sales_user_id;
	}

	public String getSales_dept_cd() {
		return sales_dept_cd;
	}
	public void setSales_dept_cd(String sales_dept_cd) {
		this.sales_dept_cd = sales_dept_cd;
	}

	public String getReport_flag() {
		return report_flag;
	}

	public void setReport_flag(String report_flag) {
		this.report_flag = report_flag;
	}

	public String getPrdlst_nm() {
		return prdlst_nm;
	}

	public void setPrdlst_nm(String prdlst_nm) {
		this.prdlst_nm = prdlst_nm;
	}

	public String getLast_report_date() {
		return last_report_date;
	}

	public void setLast_report_date(String last_report_date) {
		this.last_report_date = last_report_date;
	}

	public String getCommission_amt_det() {
		return commission_amt_det;
	}

	public void setCommission_amt_det(String commission_amt_det) {
		this.commission_amt_det = commission_amt_det;
	}

	public String getResult_val_his() {
		return result_val_his;
	}

	public void setResult_val_his(String result_val_his) {
		this.result_val_his = result_val_his;
	}

	public String getReport_disp_val_his() {
		return report_disp_val_his;
	}

	public void setReport_disp_val_his(String report_disp_val_his) {
		this.report_disp_val_his = report_disp_val_his;
	}

	public String getSample_arrival_date() {
		return sample_arrival_date;
	}

	public void setSample_arrival_date(String sample_arrival_date) {
		this.sample_arrival_date = sample_arrival_date;
	}
	
}
