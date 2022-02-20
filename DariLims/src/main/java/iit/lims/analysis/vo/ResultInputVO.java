package iit.lims.analysis.vo;

public class ResultInputVO extends ResultApprovalVO {
	private String sample_req_nm;
	private String report_disp_val;
	private String result_cd;
	private String inst_kor_nm;
	private String recipient_id;
	private String sender_id;
	private String recipient_nm;
	private String sender_nm;
	private String disuse_date;
	private String sample_flag;
	private String stop_reason, test_sample_result_reason,test_sample_result_cd,test_sample_result_nm;
	private String account_tot_cal_disp;
	private String account_val_desc_tot;
	private String exceed_reason;
	private int sample_cnt = 0;
	private String oxide_nm;
	private String oxide_remark;
	private String inst_vnd_nm;
	private String base;
	private String quot_std, condition, guide_nm; //시험방법 팝업창 검색조건 
	private String real_tester_id, real_tester_nm;
	//등급 판정
	private String jdg_type_grade;
	// 항목 결과 기록 팝업
	private String std_fit, std_unfit, test_inst, test_method, item_his_seq;

	//시험자구분
	private String view_gbn;
	
	private String result_type_gbn;

	//항목입력완료일
	private String test_end_date;
	
	private String create_ip;
	
	private String update_ip;
	
	private String base1;
	
	public String getExceed_reason() {
		return exceed_reason;
	}

	public void setExceed_reason(String exceed_reason) {
		this.exceed_reason = exceed_reason;
	}

	public String getStd_fit() {
		return std_fit;
	}

	public void setStd_fit(String std_fit) {
		this.std_fit = std_fit;
	}

	public String getStd_unfit() {
		return std_unfit;
	}

	public void setStd_unfit(String std_unfit) {
		this.std_unfit = std_unfit;
	}

	public String getTest_inst() {
		return test_inst;
	}

	public void setTest_inst(String test_inst) {
		this.test_inst = test_inst;
	}

	public String getTest_method() {
		return test_method;
	}

	public void setTest_method(String test_method) {
		this.test_method = test_method;
	}

	public String getItem_his_seq() {
		return item_his_seq;
	}

	public void setItem_his_seq(String item_his_seq) {
		this.item_his_seq = item_his_seq;
	}

	public String getAccount_val_desc_tot() {
		return account_val_desc_tot;
	}

	public void setAccount_val_desc_tot(String account_val_desc_tot) {
		this.account_val_desc_tot = account_val_desc_tot;
	}

	public String getAccount_tot_cal_disp() {
		return account_tot_cal_disp;
	}

	public void setAccount_tot_cal_disp(String account_tot_cal_disp) {
		this.account_tot_cal_disp = account_tot_cal_disp;
	}

	public String getTest_sample_result_cd() {
		return test_sample_result_cd;
	}

	public void setTest_sample_result_cd(String test_sample_result_cd) {
		this.test_sample_result_cd = test_sample_result_cd;
	}

	public String getTest_sample_result_nm() {
		return test_sample_result_nm;
	}

	public void setTest_sample_result_nm(String test_sample_result_nm) {
		this.test_sample_result_nm = test_sample_result_nm;
	}
	
	public String getTest_sample_result_reason() {
		return test_sample_result_reason;
	}

	public void setTest_sample_result_reason(String test_sample_result_reason) {
		this.test_sample_result_reason = test_sample_result_reason;
	}

	public String getSample_req_nm() {
		return sample_req_nm;
	}

	public String getStop_reason() {
		return stop_reason;
	}

	public void setStop_reason(String stop_reason) {
		this.stop_reason = stop_reason;
	}

	public void setSample_req_nm(String sample_req_nm) {
		this.sample_req_nm = sample_req_nm;
	}

	public String getSample_flag() {
		return sample_flag;
	}

	public void setSample_flag(String sample_flag) {
		this.sample_flag = sample_flag;
	}

	public String getResult_cd() {
		return result_cd;
	}

	public void setResult_cd(String result_cd) {
		this.result_cd = result_cd;
	}

	public String getInst_kor_nm() {
		return inst_kor_nm;
	}

	public void setInst_kor_nm(String inst_kor_nm) {
		this.inst_kor_nm = inst_kor_nm;
	}

	public String getReport_disp_val() {
		return report_disp_val;
	}

	public void setReport_disp_val(String report_disp_val) {
		this.report_disp_val = report_disp_val;
	}

	public String getDisuse_date() {
		return disuse_date;
	}

	public void setDisuse_date(String disuse_date) {
		this.disuse_date = disuse_date;
	}

	public String getRecipient_id() {
		return recipient_id;
	}

	public void setRecipient_id(String recipient_id) {
		this.recipient_id = recipient_id;
	}

	public String getSender_id() {
		return sender_id;
	}

	public void setSender_id(String sender_id) {
		this.sender_id = sender_id;
	}

	public String getRecipient_nm() {
		return recipient_nm;
	}

	public void setRecipient_nm(String recipient_nm) {
		this.recipient_nm = recipient_nm;
	}

	public String getSender_nm() {
		return sender_nm;
	}

	public void setSender_nm(String sender_nm) {
		this.sender_nm = sender_nm;
	}

	public int getSample_cnt() {
		return sample_cnt;
	}

	public void setSample_cnt(int sample_cnt) {
		this.sample_cnt = sample_cnt;
	}

	public String getOxide_nm() {
		return oxide_nm;
	}

	public void setOxide_nm(String oxide_nm) {
		this.oxide_nm = oxide_nm;
	}

	public String getOxide_remark() {
		return oxide_remark;
	}

	public void setOxide_remark(String oxide_remark) {
		this.oxide_remark = oxide_remark;
	}

	public String getInst_vnd_nm() {
		return inst_vnd_nm;
	}

	public void setInst_vnd_nm(String inst_vnd_nm) {
		this.inst_vnd_nm = inst_vnd_nm;
	}

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getView_gbn() {
		return view_gbn;
	}

	public void setView_gbn(String view_gbn) {
		this.view_gbn = view_gbn;
	}

	public String getResult_type_gbn() {
		return result_type_gbn;
	}

	public void setResult_type_gbn(String result_type_gbn) {
		this.result_type_gbn = result_type_gbn;
	}

	public String getQuot_std() {
		return quot_std;
	}

	public void setQuot_std(String quot_std) {
		this.quot_std = quot_std;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getGuide_nm() {
		return guide_nm;
	}

	public void setGuide_nm(String guide_nm) {
		this.guide_nm = guide_nm;
	}

	public String getReal_tester_id() {
		return real_tester_id;
	}

	public void setReal_tester_id(String real_tester_id) {
		this.real_tester_id = real_tester_id;
	}

	public String getReal_tester_nm() {
		return real_tester_nm;
	}

	public void setReal_tester_nm(String real_tester_nm) {
		this.real_tester_nm = real_tester_nm;
	}

	public String getJdg_type_grade() {
		return jdg_type_grade;
	}

	public void setJdg_type_grade(String jdg_type_grade) {
		this.jdg_type_grade = jdg_type_grade;
	}

	public String getTest_end_date() {
		return test_end_date;
	}

	public void setTest_end_date(String test_end_date) {
		this.test_end_date = test_end_date;
	}

	public String getCreate_ip() {
		return create_ip;
	}

	public void setCreate_ip(String create_ip) {
		this.create_ip = create_ip;
	}

	public String getUpdate_ip() {
		return update_ip;
	}

	public void setUpdate_ip(String update_ip) {
		this.update_ip = update_ip;
	}

	public String getBase1() {
		return base1;
	}

	public void setBase1(String base1) {
		this.base1 = base1;
	}
}