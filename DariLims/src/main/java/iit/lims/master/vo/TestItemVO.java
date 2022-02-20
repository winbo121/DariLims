package iit.lims.master.vo;

import java.util.ArrayList;
import java.util.List;

import iit.lims.common.vo.PagingVO;

public class TestItemVO extends PagingVO {
	private String test_item_eng_nm, fee_group_no, test_item_type, kolas_flag;
	private String formula, detail_test_item_yn, repre_test_item_cd;
	private String test_item_group_no, test_item_group_nm, group_desc, fee_group_nm;
	private String dept_user_item_no;
	private String sample_temp_nm, etc, sample_temp_cd, temp_seq;
	private String std_flag;
	private String unit;
	private String valid_position;
	private String test_inst_no;
	private String testitm_lclas_cd;
	private String testitm_mlsfc_cd;
	private String testitm_lclas_nm;
	private String testitm_mlsfc_nm;
	private String ncknm;
	private String abrv;
	private String assignment_flag;
	private String fee, dept_fee, prdlst_fee, sample_fee, fee_tot_item, fee_tot_est, fee_tot_precost;
	private String disp_testitm_cd;
	private String last_updt_dtm;
	private String tester_user_id;
	private String tester_user_nm;
	private String tester_dept_cd;
	private String tester_dept_nm;
	private String kor_nm;
	private String eng_nm;
	private String l_kor_nm;
	private String testitm_cd;
	private String testitm_nm;
	private String testitm_wave;//원소의 파장
	private String oxide_cd; //산화물 표시 번호
	private String oxide_content; //산화물 표시 내용
	private String arr_test_item;
	private int test_item_cnt;
	private String popUp;
	
	public String getKor_nm() {
		return kor_nm;
	}

	public String getEng_nm() {
		return eng_nm;
	}

	public String getL_kor_nm() {
		return l_kor_nm;
	}

	public String getTestitm_cd() {
		return testitm_cd;
	}

	public String getTestitm_nm() {
		return testitm_nm;
	}

	public void setKor_nm(String kor_nm) {
		this.kor_nm = kor_nm;
	}

	public void setEng_nm(String eng_nm) {
		this.eng_nm = eng_nm;
	}

	public void setL_kor_nm(String l_kor_nm) {
		this.l_kor_nm = l_kor_nm;
	}

	public void setTestitm_cd(String testitm_cd) {
		this.testitm_cd = testitm_cd;
	}

	public void setTestitm_nm(String testitm_nm) {
		this.testitm_nm = testitm_nm;
	}

	public String getNcknm() {
		return ncknm;
	}

	public void setNcknm(String ncknm) {
		this.ncknm = ncknm;
	}

	public String getAbrv() {
		return abrv;
	}

	public void setAbrv(String abrv) {
		this.abrv = abrv;
	}

	public String getTestitm_lclas_cd() {
		return testitm_lclas_cd;
	}

	public void setTestitm_lclas_cd(String testitm_lclas_cd) {
		this.testitm_lclas_cd = testitm_lclas_cd;
	}

	public String getTest_inst_no() {
		return test_inst_no;
	}

	public void setTest_inst_no(String test_inst_no) {
		this.test_inst_no = test_inst_no;
	}

	public String getValid_position() {
		return valid_position;
	}

	public void setValid_position(String valid_position) {
		this.valid_position = valid_position;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getTest_item_eng_nm() {
		return test_item_eng_nm;
	}

	public void setTest_item_eng_nm(String test_item_eng_nm) {
		this.test_item_eng_nm = test_item_eng_nm;
	}

	public String getFee_group_no() {
		return fee_group_no;
	}

	public void setFee_group_no(String fee_group_no) {
		this.fee_group_no = fee_group_no;
	}

	public String getTest_item_type() {
		return test_item_type;
	}

	public void setTest_item_type(String test_item_type) {
		this.test_item_type = test_item_type;
	}

	public String getKolas_flag() {
		return kolas_flag;
	}

	public void setKolas_flag(String kolas_flag) {
		this.kolas_flag = kolas_flag;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getFormula() {
		return formula;
	}

	public void setFormula(String formula) {
		this.formula = formula;
	}

	public String getDetail_test_item_yn() {
		return detail_test_item_yn;
	}

	public void setDetail_test_item_yn(String detail_test_item_yn) {
		this.detail_test_item_yn = detail_test_item_yn;
	}

	public String getRepre_test_item_cd() {
		return repre_test_item_cd;
	}

	public void setRepre_test_item_cd(String repre_test_item_cd) {
		this.repre_test_item_cd = repre_test_item_cd;
	}

	public String getTest_item_group_no() {
		return test_item_group_no;
	}

	public void setTest_item_group_no(String test_item_group_no) {
		this.test_item_group_no = test_item_group_no;
	}

	public String getTest_item_group_nm() {
		return test_item_group_nm;
	}

	public void setTest_item_group_nm(String test_item_group_nm) {
		this.test_item_group_nm = test_item_group_nm;
	}

	public String getGroup_desc() {
		return group_desc;
	}

	public void setGroup_desc(String group_desc) {
		this.group_desc = group_desc;
	}

	public String getFee_group_nm() {
		return fee_group_nm;
	}

	public void setFee_group_nm(String fee_group_nm) {
		this.fee_group_nm = fee_group_nm;
	}

	public String getDept_user_item_no() {
		return dept_user_item_no;
	}

	public void setDept_user_item_no(String dept_user_item_no) {
		this.dept_user_item_no = dept_user_item_no;
	}

	public String getSample_temp_nm() {
		return sample_temp_nm;
	}

	public void setSample_temp_nm(String sample_temp_nm) {
		this.sample_temp_nm = sample_temp_nm;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getSample_temp_cd() {
		return sample_temp_cd;
	}

	public void setSample_temp_cd(String sample_temp_cd) {
		this.sample_temp_cd = sample_temp_cd;
	}

	public String getTemp_seq() {
		return temp_seq;
	}

	public void setTemp_seq(String temp_seq) {
		this.temp_seq = temp_seq;
	}

	public String getStd_flag() {
		return std_flag;
	}

	public void setStd_flag(String std_flag) {
		this.std_flag = std_flag;
	}

	public String getAssignment_flag() {
		return assignment_flag;
	}

	public void setAssignment_flag(String assignment_flag) {
		this.assignment_flag = assignment_flag;
	}

	public String getDept_fee() {
		return dept_fee;
	}

	public void setDept_fee(String dept_fee) {
		this.dept_fee = dept_fee;
	}

	public String getPrdlst_fee() {
		return prdlst_fee;
	}

	public void setPrdlst_fee(String prdlst_fee) {
		this.prdlst_fee = prdlst_fee;
	}

	public String getSample_fee() {
		return sample_fee;
	}

	public void setSample_fee(String sample_fee) {
		this.sample_fee = sample_fee;
	}

	public String getFee_tot_item() {
		return fee_tot_item;
	}

	public void setFee_tot_item(String fee_tot_item) {
		this.fee_tot_item = fee_tot_item;
	}

	public String getFee_tot_est() {
		return fee_tot_est;
	}

	public void setFee_tot_est(String fee_tot_est) {
		this.fee_tot_est = fee_tot_est;
	}
	
	public String getFee_tot_precost() {
		return fee_tot_precost;
	}

	public void setFee_tot_precost(String fee_tot_precost) {
		this.fee_tot_precost = fee_tot_precost;
	}

	public String getDisp_testitm_cd() {
		return disp_testitm_cd;
	}

	public void setDisp_testitm_cd(String disp_testitm_cd) {
		this.disp_testitm_cd = disp_testitm_cd;
	}

	public String getTestitm_lclas_nm() {
		return testitm_lclas_nm;
	}

	public void setTestitm_lclas_nm(String testitm_lclas_nm) {
		this.testitm_lclas_nm = testitm_lclas_nm;
	}

	public String getTestitm_mlsfc_cd() {
		return testitm_mlsfc_cd;
	}

	public void setTestitm_mlsfc_cd(String testitm_mlsfc_cd) {
		this.testitm_mlsfc_cd = testitm_mlsfc_cd;
	}

	public String getTestitm_mlsfc_nm() {
		return testitm_mlsfc_nm;
	}

	public void setTestitm_mlsfc_nm(String testitm_mlsfc_nm) {
		this.testitm_mlsfc_nm = testitm_mlsfc_nm;
	}

	public String getLast_updt_dtm() {
		return last_updt_dtm;
	}
	public void setLast_updt_dtm(String last_updt_dtm) {
		this.last_updt_dtm = last_updt_dtm;
	}

	public String getTester_user_id() {
		return tester_user_id;
	}

	public void setTester_user_id(String tester_user_id) {
		this.tester_user_id = tester_user_id;
	}

	public String getTester_user_nm() {
		return tester_user_nm;
	}

	public void setTester_user_nm(String tester_user_nm) {
		this.tester_user_nm = tester_user_nm;
	}

	public String getTester_dept_cd() {
		return tester_dept_cd;
	}

	public void setTester_dept_cd(String tester_dept_cd) {
		this.tester_dept_cd = tester_dept_cd;
	}

	public String getTester_dept_nm() {
		return tester_dept_nm;
	}

	public void setTester_dept_nm(String tester_dept_nm) {
		this.tester_dept_nm = tester_dept_nm;
	}

	public String getTestitm_wave() {
		return testitm_wave;
	}

	public void setTestitm_wave(String testitm_wave) {
		this.testitm_wave = testitm_wave;
	}

	public String getOxide_content() {
		return oxide_content;
	}

	public void setOxide_content(String oxide_content) {
		this.oxide_content = oxide_content;
	}

	public String getOxide_cd() {
		return oxide_cd;
	}

	public void setOxide_cd(String oxide_cd) {
		this.oxide_cd = oxide_cd;
	}

	public String getArr_test_item() {
		return arr_test_item;
	}

	public void setArr_test_item(String arr_test_item) {
		this.arr_test_item = arr_test_item;
	}

	public int getTest_item_cnt() {
		return test_item_cnt;
	}

	public void setTest_item_cnt(int test_item_cnt) {
		this.test_item_cnt = test_item_cnt;
	}

	public String getPopUp() {
		return popUp;
	}

	public void setPopUp(String popUp) {
		this.popUp = popUp;
	}
}