package iit.lims.report.vo;

import java.util.List;

import iit.lims.analysis.vo.ResultInputVO;

public class ReportVO extends ResultInputVO {
	private String[] test_sample_arr;
	private String report_seq;
	private String onnara_link_yn;
	private String report_doc_seq;
	private String report_type;
	private String report_make_id;
	private String onnara_appv_state;
	private String onnara_doc_no;
	private String onnara_appv_date;
	private String onnara_link_date;
	private String onnara_file_flag;
	private String onnara_file_nm;
	private String destination_nm;
	private String report_file_nm;
	private String kolas_info;
	private String onnara_title;
	private String onnara_con;
	private String kolas_rpt_use;
	private String kolas_smp_desc;
	private String kolas_test_env;
	private String verify_id;
	private String test_period;
	private String test_sdate, test_edate;
	private String except_flag;
	private String report_no;
	private String report_last_date;
	private String report_start_date, report_end_date;
	private String deadline_start_date, deadline_end_date;
	
	private String pre_tel_num, pre_fax_num, biz_no;

	private int log_cnt = 0;
	private String log_flag = "";

	private String pre_man;
	
	private String detect_jdg_type;
	
	private String test_item_nm2;
	
	private String form_seq, doc_seq;
	
	private String form_title, form_name, doc_revision_seq;
	
	private String publish_gbn;
	
	private String log_no, sec_log_no, log_date;
	
	private String report_publish_no, degree;

	private String separation;
	
	private String report_appr_yn;
	
	private String req_etc;
	
	private List<String> arr_report, arr_req;
	
	private String report_sign_id;
	
	private String cntType;
	
	private String report_class_code;
	
	private String report_exceed_reason; // 기한초과사유
	
	private String plusNum;
	
	public String getReport_sign_id() {
		return report_sign_id;
	}

	public void setReport_sign_id(String report_sign_id) {
		this.report_sign_id = report_sign_id;
	}

	public String getExcept_flag() {
		return except_flag;
	}

	public void setExcept_flag(String except_flag) {
		this.except_flag = except_flag;
	}

	public String getKolas_rpt_use() {
		return kolas_rpt_use;
	}

	public void setKolas_rpt_use(String kolas_rpt_use) {
		this.kolas_rpt_use = kolas_rpt_use;
	}

	public String getKolas_smp_desc() {
		return kolas_smp_desc;
	}

	public void setKolas_smp_desc(String kolas_smp_desc) {
		this.kolas_smp_desc = kolas_smp_desc;
	}

	public String getKolas_test_env() {
		return kolas_test_env;
	}

	public void setKolas_test_env(String kolas_test_env) {
		this.kolas_test_env = kolas_test_env;
	}

	public String getOnnara_title() {
		return onnara_title;
	}

	public void setOnnara_title(String onnara_title) {
		this.onnara_title = onnara_title;
	}

	public String getOnnara_con() {
		return onnara_con;
	}

	public void setOnnara_con(String onnara_con) {
		this.onnara_con = onnara_con;
	}

	public String getKolas_info() {
		return kolas_info;
	}

	public void setKolas_info(String kolas_info) {
		this.kolas_info = kolas_info;
	}

	public String getReport_file_nm() {
		return report_file_nm;
	}

	public void setReport_file_nm(String report_file_nm) {
		this.report_file_nm = report_file_nm;
	}

	public String getDestination_nm() {
		return destination_nm;
	}

	public void setDestination_nm(String destination_nm) {
		this.destination_nm = destination_nm;
	}

	public String getReport_doc_seq() {
		return report_doc_seq;
	}

	public void setReport_doc_seq(String report_doc_seq) {
		this.report_doc_seq = report_doc_seq;
	}

	public String getForm_title() {
		return form_title;
	}

	public void setForm_title(String form_title) {
		this.form_title = form_title;
	}

	public String getForm_name() {
		return form_name;
	}

	public void setForm_name(String form_name) {
		this.form_name = form_name;
	}

	public String getDoc_revision_seq() {
		return doc_revision_seq;
	}

	public void setDoc_revision_seq(String doc_revision_seq) {
		this.doc_revision_seq = doc_revision_seq;
	}

	public String getReport_type() {
		return report_type;
	}

	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}

	public String getReport_make_id() {
		return report_make_id;
	}

	public void setReport_make_id(String report_make_id) {
		this.report_make_id = report_make_id;
	}

	public String getOnnara_appv_state() {
		return onnara_appv_state;
	}

	public void setOnnara_appv_state(String onnara_appv_state) {
		this.onnara_appv_state = onnara_appv_state;
	}

	public String getOnnara_doc_no() {
		return onnara_doc_no;
	}

	public void setOnnara_doc_no(String onnara_doc_no) {
		this.onnara_doc_no = onnara_doc_no;
	}

	public String getOnnara_appv_date() {
		return onnara_appv_date;
	}

	public void setOnnara_appv_date(String onnara_appv_date) {
		this.onnara_appv_date = onnara_appv_date;
	}

	public String getOnnara_link_date() {
		return onnara_link_date;
	}

	public void setOnnara_link_date(String onnara_link_date) {
		this.onnara_link_date = onnara_link_date;
	}

	public String getOnnara_file_flag() {
		return onnara_file_flag;
	}

	public void setOnnara_file_flag(String onnara_file_flag) {
		this.onnara_file_flag = onnara_file_flag;
	}

	public String getOnnara_file_nm() {
		return onnara_file_nm;
	}

	public void setOnnara_file_nm(String onnara_file_nm) {
		this.onnara_file_nm = onnara_file_nm;
	}

	public String getOnnara_link_yn() {
		return onnara_link_yn;
	}

	public void setOnnara_link_yn(String onnara_link_yn) {
		this.onnara_link_yn = onnara_link_yn;
	}

	public String getReport_seq() {
		return report_seq;
	}

	public void setReport_seq(String report_seq) {
		this.report_seq = report_seq;
	}

	public String[] getTest_sample_arr() {
		return test_sample_arr;
	}

	public void setTest_sample_arr(String[] test_sample_arr) {
		this.test_sample_arr = test_sample_arr;
	}
	

	
	public String getVerify_id() {
		return verify_id;
	}

	public void setVerify_id(String verify_id) {
		this.verify_id = verify_id;
	}
	
	
	public int getLog_cnt() {
		return log_cnt;
	}

	public void setLog_cnt(int log_cnt) {
		this.log_cnt = log_cnt;
	}

	public String getLog_flag() {
		return log_flag;
	}

	public void setLog_flag(String log_flag) {
		this.log_flag = log_flag;
	}

	
	public String getTest_period() {
		return test_period;
	}

	public void setTest_period(String test_period) {
		this.test_period = test_period;
	}

	public String getTest_sdate() {
		return test_sdate;
	}

	public void setTest_sdate(String test_sdate) {
		this.test_sdate = test_sdate;
	}

	public String getTest_edate() {
		return test_edate;
	}

	public void setTest_edate(String test_edate) {
		this.test_edate = test_edate;
	}

	public String getPre_tel_num() {
		return pre_tel_num;
	}
	public void setPre_tel_num(String pre_tel_num) {
		this.pre_tel_num = pre_tel_num;
	}
	
	public String getPre_fax_num() {
		return pre_fax_num;
	}
	public void setPre_fax_num(String pre_fax_num) {
		this.pre_fax_num = pre_fax_num;
	}

	public String getBiz_no() {
		return biz_no;
	}
	public void setBiz_no1(String biz_no) {
		this.biz_no = biz_no;
	}

	public String getReport_no() {
		return report_no;
	}

	public void setReport_no(String report_no) {
		this.report_no = report_no;
	}

	public void setBiz_no(String biz_no) {
		this.biz_no = biz_no;
	}

	public String getPre_man() {
		return pre_man;
	}

	public void setPre_man(String pre_man) {
		this.pre_man = pre_man;
	}

	public String getReport_last_date() {
		return report_last_date;
	}

	public void setReport_last_date(String report_last_date) {
		this.report_last_date = report_last_date;
	}

	public String getReport_start_date() {
		return report_start_date;
	}

	public void setReport_start_date(String report_start_date) {
		this.report_start_date = report_start_date;
	}

	public String getReport_end_date() {
		return report_end_date;
	}

	public void setReport_end_date(String report_end_date) {
		this.report_end_date = report_end_date;
	}
	
	public String getDeadline_start_date() {
		return deadline_start_date;
	}

	public void setDeadline_start_date(String deadline_start_date) {
		this.deadline_start_date = deadline_start_date;
	}

	public String getDeadline_end_date() {
		return deadline_end_date;
	}

	public void setDeadline_end_date(String deadline_end_date) {
		this.deadline_end_date = deadline_end_date;
	}

	public String getDetect_jdg_type() {
		return detect_jdg_type;
	}

	public void setDetect_jdg_type(String detect_jdg_type) {
		this.detect_jdg_type = detect_jdg_type;
	}

	public String getTest_item_nm2() {
		return test_item_nm2;
	}

	public void setTest_item_nm2(String test_item_nm2) {
		this.test_item_nm2 = test_item_nm2;
	}

	public String getForm_seq() {
		return form_seq;
	}

	public void setForm_seq(String form_seq) {
		this.form_seq = form_seq;
	}

	public String getDoc_seq() {
		return doc_seq;
	}

	public void setDoc_seq(String doc_seq) {
		this.doc_seq = doc_seq;
	}

	public String getPublish_gbn() {
		return publish_gbn;
	}

	public void setPublish_gbn(String publish_gbn) {
		this.publish_gbn = publish_gbn;
	}

	public String getLog_no() {
		return log_no;
	}

	public void setLog_no(String log_no) {
		this.log_no = log_no;
	}

	public String getSec_log_no() {
		return sec_log_no;
	}

	public void setSec_log_no(String sec_log_no) {
		this.sec_log_no = sec_log_no;
	}

	public String getLog_date() {
		return log_date;
	}

	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}

	public String getReport_publish_no() {
		return report_publish_no;
	}

	public void setReport_publish_no(String report_publish_no) {
		this.report_publish_no = report_publish_no;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getSeparation() {
		return separation;
	}

	public void setSeparation(String separation) {
		this.separation = separation;
	}

	public String getReport_appr_yn() {
		return report_appr_yn;
	}

	public void setReport_appr_yn(String report_appr_yn) {
		this.report_appr_yn = report_appr_yn;
	}

	public List<String> getArr_report() {
		return arr_report;
	}

	public void setArr_report(List<String> arr_report) {
		this.arr_report = arr_report;
	}

	public List<String> getArr_req() {
		return arr_req;
	}

	public void setArr_req(List<String> arr_req) {
		this.arr_req = arr_req;
	}

	public String getReq_etc() {
		return req_etc;
	}

	public void setReq_etc(String req_etc) {
		this.req_etc = req_etc;
	}

	public String getCntType() {
		return cntType;
	}

	public void setCntType(String cntType) {
		this.cntType = cntType;
	}

	public String getReport_class_code() {
		return report_class_code;
	}

	public void setReport_class_code(String report_class_code) {
		this.report_class_code = report_class_code;
	}

	public String getReport_exceed_reason() {
		return report_exceed_reason;
	}

	public void setReport_exceed_reason(String report_exceed_reason) {
		this.report_exceed_reason = report_exceed_reason;
	}

	public String getPlusNum() {
		return plusNum;
	}

	public void setPlusNum(String plusNum) {
		this.plusNum = plusNum;
	}

}