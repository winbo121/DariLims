package iit.lims.accept.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.master.vo.TestPrdStdVO;

public class AcceptVO extends TestPrdStdVO {
	private String req_receipt_id, supv_dept_cd;
	private String zip_code, addr1, addr2, addr1_eng, addr2_eng;
	private String zip_code2, zip_code3, zip_code4;
	private String title, req_id, req_date, test_goal;
	private String req_tel, req_nm, deadline_date, req_message;
	private String fee_tot, travel_exp;
	private String req_type, req_basis, state, backup_state, sample_state;
	private String test_item_seq;
	private String sampling_date, sampling_hour, sampling_min;
	private String sampling_point_no, sampling_method;
	private String sampling_id, sampling_point_nm, etc_desc, tot_item_count, tot_sample_count;
	private String tester_id, tester_nm;
	private String std_hval, std_lval;
	private String sample_reg_nm;
	private String req_org_no, req_org_nm, req_org_no2, req_org_nm2, req_org_no3, req_org_nm3, req_org_no4, req_org_nm4;
	private String pay_nm, pay_tel, pay_email;
	private String process;
	private String hval_type, lval_type, std_val;
	private String colla_flag;
	private String test_cmt;
	private String dept_appr_date;
	private String accept_dept_cd;
	private String act_user_id, act_date;
	private String act_user_nm;
	private String req_act_user_id;
	private String req_act_user_nm;
	private String ums_flag;
	private String test_dept_cd;
	private String new_test_req_no;
	private String new_test_req_seq;
	private String rawdata;
	private String return_flag, return_comment, disuse_flag, stop_flag;
	private String absence_flag;
	private String test_sample_result;
	private String discount_rate;
	private String discount_flag, req_org_addr, req_org_email, req_org_addr2, req_org_addr3, req_org_addr4, req_org_tel, req_org_tel2, req_org_tel3, req_org_tel4, fee_auto_flag, email;
	private String team_cd, team_nm, file_nm;
	private String est_no, est_title, commission_type, commission_amt_flag,
					sample_arrival_date, rec_req_no, deposit_amt, deposit_no;	
	private String att_seq;
	private MultipartFile mul_file_att;
	private byte[] file_att;
	private byte[] biz_file_byte;
	private MultipartFile biz_file;
	private String user_pop;
	private String accept_item_info;
	private String accept_wait_yn;
	
	private String sensory_test;
	private String member_flag;
	private String rawdata_flag;
	
	private String pre_test_req_no;
	private String std_dept_cd, std_dept_nm;

	private String temp_min, temp_max, hum_min, hum_max;

	private String sales_user_id, sales_dept_cd, req_class, express_flag;

	private String produce_date, produce_no, producer_nm, produce_place, sample_etc_nm, expiry_date, sample_weight, keep_method, orderer_nm, builder_nm, joiner_nm, collector_nm, collect_date, collect_place;

	private List<String> test_req_seq_list;
	private String tax_invoice_flag;
	private String tax_invoice_date;
	
	private int item_cnt = 0;
	private int commission_amt_det = 0;
	private int prdlst_amt_det = 0;
	private String receipt_no;
	private String sample_nms;
	
	private String sms_flag, sms_target, sms_type;
	
	private String last_approval_date;
	private String last_report_date;
	private String last_result_date;
	private int commission_amt_det_tax;
	
	private String tax_req_org_nm;
	private String deposit_date;
	private String taxSdate, taxEdate;
	private String org_cls;
	
	private String collect_pre_code;
	private String collect_code;
	private String collect_code_etc;
	private String collect_method; // 채취방법
	private String collect_method_etc; // 채취방법
	private String collect_div; // 채취구분
	private String collect_div_etc; // 채취구분
	
	private String test_count;
	private String test_place;
	private String ware_clerk;
	private String ware_tel;
	private String ship_port;
	private String unship_port;
	private String origin;
	private String manufacturer;
	private String container;
	private String bill_of_lading;
	private String vessel;
	
	private String report_order;
	
	private String sm_code;
	private String sm_name;
	
	private String std_type;

	private String accept_method;
	
	private String pre_cost,pretreatment_cd;

	private String pick_no;
	
	private String sample_att_gbn; // 검체별 첨부 문서 문서 구분
	
	private String max_grade;
	
	private String result_grade;

	private String sample_num;
	private String sampling_no;
	private String supplier;
	
	private String quality_dept_cd1, quality_dept_cd2, quality_user_id1, quality_user_id2;//품질검사원
	
	private String result_input_type;
	
	private String barcode_desc;

	private String req_plant_nm, req_plant_addr, req_plant_tel;
	
	private String charger_tel, charger_tel2, charger_tel3, charger_tel4; //의뢰처 담당자 연락처
	
	private String startTest, endTest; //성적서발행예정일 조회
	
	private String test_end; //시험완료예정일 조회
	
	private String QR_nm; //QR코드 이미지 
	
	private byte[] QR_file; //QR코드 이미지 
	private MultipartFile QR_file_upload;
	
	private String est_check;//견적서 메일 전송 여부 체크

	
	private String calculation;//분석의뢰서 산출내역
	
	private String admin_message;

	private String std_type_nm, result_type_nm;

	private String sel_dept_cd;
	/*SETTER GETTER에 셀렉트한 부서 새로 추가*/
	
	private String position_desc;
	
	private String test_method_code;//성적서 표시 순서 일괄 변경 데이터
	private String unit_code;
	private String numrow;
	
	private String req_att_gbn; //의뢰별첨부문서 구분
	private String addr_report; //성적서 출력용 주소
	private String tel_report; //성적서 출력용 번호
	private String fax_report; //성적서 출력용 팩스
		
	private String test_zip_code;
	private String test_addr1;
	private String test_addr2;
	
	private String tat_date;//tat팝업 end_date
	private String isImp;//tat팝업 전체 및 일자별 구분값
	private String tat_log_no;//tat팝업 - 레포트 파라미터
	
	public String getAdmin_message() {
		return admin_message;
	}
	public void setAdmin_message(String admin_message) {
		this.admin_message = admin_message;
	}
	public String getReport_order() {
		return report_order;
	}
	public void setReport_order(String report_order) {
		this.report_order = report_order;
	}
	public String getTest_count() {
		return test_count;
	}
	public String getTest_place() {
		return test_place;
	}
	public String getWare_clerk() {
		return ware_clerk;
	}
	public String getWare_tel() {
		return ware_tel;
	}
	public String getShip_port() {
		return ship_port;
	}
	public String getUnship_port() {
		return unship_port;
	}
	public void setTest_count(String test_count) {
		this.test_count = test_count;
	}
	public void setTest_place(String test_place) {
		this.test_place = test_place;
	}
	public void setWare_clerk(String ware_clerk) {
		this.ware_clerk = ware_clerk;
	}
	public void setWare_tel(String ware_tel) {
		this.ware_tel = ware_tel;
	}
	public void setShip_port(String ship_port) {
		this.ship_port = ship_port;
	}
	public void setUnship_port(String unship_port) {
		this.unship_port = unship_port;
	}
	public String getCollect_code() {
		return collect_code;
	}
	public String getCollect_code_etc() {
		return collect_code_etc;
	}
	public void setCollect_code(String collect_code) {
		this.collect_code = collect_code;
	}
	public void setCollect_code_etc(String collect_code_etc) {
		this.collect_code_etc = collect_code_etc;
	}
	public String getCollect_pre_code() {
		return collect_pre_code;
	}
	public void setCollect_pre_code(String collect_pre_code) {
		this.collect_pre_code = collect_pre_code;
	}
	public String getCollect_method_etc() {
		return collect_method_etc;
	}
	public String getCollect_div_etc() {
		return collect_div_etc;
	}
	public void setCollect_method_etc(String collect_method_etc) {
		this.collect_method_etc = collect_method_etc;
	}
	public void setCollect_div_etc(String collect_div_etc) {
		this.collect_div_etc = collect_div_etc;
	}
	public String getCollect_method() {
		return collect_method;
	}
	public String getCollect_div() {
		return collect_div;
	}
	public void setCollect_method(String collect_method) {
		this.collect_method = collect_method;
	}
	public void setCollect_div(String collect_div) {
		this.collect_div = collect_div;
	}
	public String getStd_dept_cd() {
		return std_dept_cd;
	}
	public void setStd_dept_cd(String std_dept_cd) {
		this.std_dept_cd = std_dept_cd;
	}
	public String getStd_dept_nm() {
		return std_dept_nm;
	}
	public void setStd_dept_nm(String std_dept_nm) {
		this.std_dept_nm = std_dept_nm;
	}
	public String getReq_receipt_id() {
		return req_receipt_id;
	}
	public void setReq_receipt_id(String req_receipt_id) {
		this.req_receipt_id = req_receipt_id;
	}
	public String getSupv_dept_cd() {
		return supv_dept_cd;
	}
	public void setSupv_dept_cd(String supv_dept_cd) {
		this.supv_dept_cd = supv_dept_cd;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getAddr1_eng() {
		return addr1_eng;
	}
	public void setAddr1_eng(String addr1_eng) {
		this.addr1_eng = addr1_eng;
	}
	public String getAddr2_eng() {
		return addr2_eng;
	}
	public void setAddr2_eng(String addr2_eng) {
		this.addr2_eng = addr2_eng;
	}
	public String getZip_code2() {
		return zip_code2;
	}
	public void setZip_code2(String zip_code2) {
		this.zip_code2 = zip_code2;
	}
	public String getZip_code3() {
		return zip_code3;
	}
	public void setZip_code3(String zip_code3) {
		this.zip_code3 = zip_code3;
	}
	public String getZip_code4() {
		return zip_code4;
	}
	public void setZip_code4(String zip_code4) {
		this.zip_code4 = zip_code4;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getReq_date() {
		return req_date;
	}
	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}
	public String getTest_goal() {
		return test_goal;
	}
	public void setTest_goal(String test_goal) {
		this.test_goal = test_goal;
	}
	public String getReq_tel() {
		return req_tel;
	}
	public void setReq_tel(String req_tel) {
		this.req_tel = req_tel;
	}
	public String getReq_nm() {
		return req_nm;
	}
	public void setReq_nm(String req_nm) {
		this.req_nm = req_nm;
	}
	public String getDeadline_date() {
		return deadline_date;
	}
	public void setDeadline_date(String deadline_date) {
		this.deadline_date = deadline_date;
	}
	public String getReq_message() {
		return req_message;
	}
	public void setReq_message(String req_message) {
		this.req_message = req_message;
	}
	public String getFee_tot() {
		return fee_tot;
	}
	public void setFee_tot(String fee_tot) {
		this.fee_tot = fee_tot;
	}
	public String getTravel_exp() {
		return travel_exp;
	}
	public void setTravel_exp(String travel_exp) {
		this.travel_exp = travel_exp;
	}
	public String getReq_type() {
		return req_type;
	}
	public void setReq_type(String req_type) {
		this.req_type = req_type;
	}
	public String getReq_basis() {
		return req_basis;
	}
	public void setReq_basis(String req_basis) {
		this.req_basis = req_basis;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getBackup_state() {
		return backup_state;
	}
	public void setBackup_state(String backup_state) {
		this.backup_state = backup_state;
	}
	public String getSample_state() {
		return sample_state;
	}
	public void setSample_state(String sample_state) {
		this.sample_state = sample_state;
	}
	public String getTest_item_seq() {
		return test_item_seq;
	}
	public void setTest_item_seq(String test_item_seq) {
		this.test_item_seq = test_item_seq;
	}
	public String getSampling_date() {
		return sampling_date;
	}
	public void setSampling_date(String sampling_date) {
		this.sampling_date = sampling_date;
	}
	public String getSampling_hour() {
		return sampling_hour;
	}
	public void setSampling_hour(String sampling_hour) {
		this.sampling_hour = sampling_hour;
	}
	public String getSampling_min() {
		return sampling_min;
	}
	public void setSampling_min(String sampling_min) {
		this.sampling_min = sampling_min;
	}
	public String getSampling_point_no() {
		return sampling_point_no;
	}
	public void setSampling_point_no(String sampling_point_no) {
		this.sampling_point_no = sampling_point_no;
	}
	public String getSampling_method() {
		return sampling_method;
	}
	public void setSampling_method(String sampling_method) {
		this.sampling_method = sampling_method;
	}
	public String getSampling_id() {
		return sampling_id;
	}
	public void setSampling_id(String sampling_id) {
		this.sampling_id = sampling_id;
	}
	public String getSampling_point_nm() {
		return sampling_point_nm;
	}
	public void setSampling_point_nm(String sampling_point_nm) {
		this.sampling_point_nm = sampling_point_nm;
	}
	public String getEtc_desc() {
		return etc_desc;
	}
	public void setEtc_desc(String etc_desc) {
		this.etc_desc = etc_desc;
	}
	public String getTot_item_count() {
		return tot_item_count;
	}
	public void setTot_item_count(String tot_item_count) {
		this.tot_item_count = tot_item_count;
	}
	public String getTot_sample_count() {
		return tot_sample_count;
	}
	public void setTot_sample_count(String tot_sample_count) {
		this.tot_sample_count = tot_sample_count;
	}
	public String getTester_id() {
		return tester_id;
	}
	public void setTester_id(String tester_id) {
		this.tester_id = tester_id;
	}
	public String getTester_nm() {
		return tester_nm;
	}
	public void setTester_nm(String tester_nm) {
		this.tester_nm = tester_nm;
	}
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
	public String getSample_reg_nm() {
		return sample_reg_nm;
	}
	public void setSample_reg_nm(String sample_reg_nm) {
		this.sample_reg_nm = sample_reg_nm;
	}
	public String getReq_org_no() {
		return req_org_no;
	}
	public void setReq_org_no(String req_org_no) {
		this.req_org_no = req_org_no;
	}
	public String getReq_org_nm() {
		return req_org_nm;
	}
	public void setReq_org_nm(String req_org_nm) {
		this.req_org_nm = req_org_nm;
	}
	public String getReq_org_no2() {
		return req_org_no2;
	}
	public void setReq_org_no2(String req_org_no2) {
		this.req_org_no2 = req_org_no2;
	}
	public String getReq_org_nm2() {
		return req_org_nm2;
	}
	public void setReq_org_nm2(String req_org_nm2) {
		this.req_org_nm2 = req_org_nm2;
	}
	public String getReq_org_no3() {
		return req_org_no3;
	}
	public void setReq_org_no3(String req_org_no3) {
		this.req_org_no3 = req_org_no3;
	}
	public String getReq_org_nm3() {
		return req_org_nm3;
	}
	public void setReq_org_nm3(String req_org_nm3) {
		this.req_org_nm3 = req_org_nm3;
	}
	public String getReq_org_no4() {
		return req_org_no4;
	}
	public void setReq_org_no4(String req_org_no4) {
		this.req_org_no4 = req_org_no4;
	}
	public String getReq_org_nm4() {
		return req_org_nm4;
	}
	public void setReq_org_nm4(String req_org_nm4) {
		this.req_org_nm4 = req_org_nm4;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
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
	public String getStd_val() {
		return std_val;
	}
	public void setStd_val(String std_val) {
		this.std_val = std_val;
	}
	public String getColla_flag() {
		return colla_flag;
	}
	public void setColla_flag(String colla_flag) {
		this.colla_flag = colla_flag;
	}
	public String getTest_cmt() {
		return test_cmt;
	}
	public void setTest_cmt(String test_cmt) {
		this.test_cmt = test_cmt;
	}
	public String getDept_appr_date() {
		return dept_appr_date;
	}
	public void setDept_appr_date(String dept_appr_date) {
		this.dept_appr_date = dept_appr_date;
	}
	public String getAccept_dept_cd() {
		return accept_dept_cd;
	}
	public void setAccept_dept_cd(String accept_dept_cd) {
		this.accept_dept_cd = accept_dept_cd;
	}
	public String getAct_user_id() {
		return act_user_id;
	}
	public void setAct_user_id(String act_user_id) {
		this.act_user_id = act_user_id;
	}
	public String getAct_date() {
		return act_date;
	}
	public void setAct_date(String act_date) {
		this.act_date = act_date;
	}
	public String getUms_flag() {
		return ums_flag;
	}
	public void setUms_flag(String ums_flag) {
		this.ums_flag = ums_flag;
	}
	public String getTest_dept_cd() {
		return test_dept_cd;
	}
	public void setTest_dept_cd(String test_dept_cd) {
		this.test_dept_cd = test_dept_cd;
	}
	public String getNew_test_req_no() {
		return new_test_req_no;
	}
	public void setNew_test_req_no(String new_test_req_no) {
		this.new_test_req_no = new_test_req_no;
	}
	public String getNew_test_req_seq() {
		return new_test_req_seq;
	}
	public void setNew_test_req_seq(String new_test_req_seq) {
		this.new_test_req_seq = new_test_req_seq;
	}
	public String getRawdata() {
		return rawdata;
	}
	public void setRawdata(String rawdata) {
		this.rawdata = rawdata;
	}
	public String getReturn_flag() {
		return return_flag;
	}
	public void setReturn_flag(String return_flag) {
		this.return_flag = return_flag;
	}


	public String getReturn_comment() {
		return return_comment;
	}

	public void setReturn_comment(String return_comment) {
		this.return_comment = return_comment;
	}
	
	public String getDisuse_flag() {
		return disuse_flag;
	}
	public void setDisuse_flag(String disuse_flag) {
		this.disuse_flag = disuse_flag;
	}
	public String getStop_flag() {
		return stop_flag;
	}
	public void setStop_flag(String stop_flag) {
		this.stop_flag = stop_flag;
	}
	public String getAbsence_flag() {
		return absence_flag;
	}
	public void setAbsence_flag(String absence_flag) {
		this.absence_flag = absence_flag;
	}
	public String getTest_sample_result() {
		return test_sample_result;
	}
	public void setTest_sample_result(String test_sample_result) {
		this.test_sample_result = test_sample_result;
	}
	public String getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(String discount_rate) {
		this.discount_rate = discount_rate;
	}
	public String getDiscount_flag() {
		return discount_flag;
	}
	public void setDiscount_flag(String discount_flag) {
		this.discount_flag = discount_flag;
	}
	public String getReq_org_addr() {
		return req_org_addr;
	}
	public void setReq_org_addr(String req_org_addr) {
		this.req_org_addr = req_org_addr;
	}
	public String getReq_org_addr2() {
		return req_org_addr2;
	}
	public void setReq_org_addr2(String req_org_addr2) {
		this.req_org_addr2 = req_org_addr2;
	}
	public String getReq_org_addr3() {
		return req_org_addr3;
	}
	public void setReq_org_addr3(String req_org_addr3) {
		this.req_org_addr3 = req_org_addr3;
	}
	public String getReq_org_addr4() {
		return req_org_addr4;
	}
	public void setReq_org_addr4(String req_org_addr4) {
		this.req_org_addr4 = req_org_addr4;
	}
	public String getReq_org_tel() {
		return req_org_tel;
	}
	public void setReq_org_tel(String req_org_tel) {
		this.req_org_tel = req_org_tel;
	}
	public String getReq_org_tel2() {
		return req_org_tel2;
	}
	public void setReq_org_tel2(String req_org_tel2) {
		this.req_org_tel2 = req_org_tel2;
	}
	public String getReq_org_tel3() {
		return req_org_tel3;
	}
	public void setReq_org_tel3(String req_org_tel3) {
		this.req_org_tel3 = req_org_tel3;
	}
	public String getReq_org_tel4() {
		return req_org_tel4;
	}
	public void setReq_org_tel4(String req_org_tel4) {
		this.req_org_tel4 = req_org_tel4;
	}
	public String getFee_auto_flag() {
		return fee_auto_flag;
	}
	public void setFee_auto_flag(String fee_auto_flag) {
		this.fee_auto_flag = fee_auto_flag;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getEst_no() {
		return est_no;
	}
	public void setEst_no(String est_no) {
		this.est_no = est_no;
	}
	public String getEst_title() {
		return est_title;
	}
	public void setEst_title(String est_title) {
		this.est_title = est_title;
	}
	public String getCommission_type() {
		return commission_type;
	}
	public void setCommission_type(String commission_type) {
		this.commission_type = commission_type;
	}
	public String getCommission_amt_flag() {
		return commission_amt_flag;
	}
	public void setCommission_amt_flag(String commission_amt_flag) {
		this.commission_amt_flag = commission_amt_flag;
	}
	public String getSample_arrival_date() {
		return sample_arrival_date;
	}
	public void setSample_arrival_date(String sample_arrival_date) {
		this.sample_arrival_date = sample_arrival_date;
	}
	public String getRec_req_no() {
		return rec_req_no;
	}
	public void setRec_req_no(String rec_req_no) {
		this.rec_req_no = rec_req_no;
	}
	public String getDeposit_amt() {
		return deposit_amt;
	}
	public void setDeposit_amt(String deposit_amt) {
		this.deposit_amt = deposit_amt;
	}
	public String getDeposit_no() {
		return deposit_no;
	}
	public void setDeposit_no(String deposit_no) {
		this.deposit_no = deposit_no;
	}
	public String getAtt_seq() {
		return att_seq;
	}
	public void setAtt_seq(String att_seq) {
		this.att_seq = att_seq;
	}
	public MultipartFile getMul_file_att() {
		return mul_file_att;
	}
	public void setMul_file_att(MultipartFile mul_file_att) {
		this.mul_file_att = mul_file_att;
	}
	public byte[] getFile_att() {
		return file_att;
	}
	public void setFile_att(byte[] file_att) {
		this.file_att = file_att;
	}
	public byte[] getBiz_file_byte() {
		return biz_file_byte;
	}
	public void setBiz_file_byte(byte[] biz_file_byte) {
		this.biz_file_byte = biz_file_byte;
	}
	public MultipartFile getBiz_file() {
		return biz_file;
	}
	public void setBiz_file(MultipartFile biz_file) {
		this.biz_file = biz_file;
	}
	public String getUser_pop() {
		return user_pop;
	}
	public void setUser_pop(String user_pop) {
		this.user_pop = user_pop;
	}
	public String getSensory_test() {
		return sensory_test;
	}
	public void setSensory_test(String sensory_test) {
		this.sensory_test = sensory_test;
	}
	public String getMember_flag() {
		return member_flag;
	}
	public void setMember_flag(String member_flag) {
		this.member_flag = member_flag;
	}
	public String getAct_user_nm() {
		return act_user_nm;
	}
	public void setAct_user_nm(String act_user_nm) {
		this.act_user_nm = act_user_nm;
	}
	public String getReq_act_user_id() {
		return req_act_user_id;
	}
	public void setReq_act_user_id(String req_act_user_id) {
		this.req_act_user_id = req_act_user_id;
	}
	public String getReq_act_user_nm() {
		return req_act_user_nm;
	}
	public void setReq_act_user_nm(String req_act_user_nm) {
		this.req_act_user_nm = req_act_user_nm;
	}
	public String getRawdata_flag() {
		return rawdata_flag;
	}
	public void setRawdata_flag(String rawdata_flag) {
		this.rawdata_flag = rawdata_flag;
	}
	

	public String getPre_test_req_no() {
		return pre_test_req_no;
	}
	public void setPre_test_req_no(String pre_test_req_no) {
		this.pre_test_req_no = pre_test_req_no;
	}


	
	public String getTemp_min() {
		return temp_min;
	}

	public void setTemp_min(String temp_min) {
		this.temp_min = temp_min;
	}
	

	public String getTemp_max() {
		return temp_max;
	}

	public void setTemp_max(String temp_max) {
		this.temp_max = temp_max;
	}
	

	public String getHum_min() {
		return hum_min;
	}

	public void setHum_min(String hum_min) {
		this.hum_min = hum_min;
	}
	

	public String getHum_max() {
		return hum_max;
	}

	public void setHum_max(String hum_max) {
		this.hum_max = hum_max;
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

	public String getReq_class() {
		return req_class;
	}
	public void setReq_class(String req_class) {
		this.req_class = req_class;
	}

	public String getExpress_flag() {
		return express_flag;
	}
	public void setExpress_flag(String express_flag) {
		this.express_flag = express_flag;
	}
	

	public String getProduce_date() {
		return produce_date;
	}
	public void setProduce_date(String produce_date) {
		this.produce_date = produce_date;
	}

	public String getProduce_no() {
		return produce_no;
	}
	public void setProduce_no(String produce_no) {
		this.produce_no = produce_no;
	}

	public String getProducer_nm() {
		return producer_nm;
	}
	public void setProducer_nm(String producer_nm) {
		this.producer_nm = producer_nm;
	}

	public String getProduce_place() {
		return produce_place;
	}
	public void setProduce_place(String produce_place) {
		this.produce_place = produce_place;
	}

	public String getSample_etc_nm() {
		return sample_etc_nm;
	}
	public void setSample_etc_nm(String sample_etc_nm) {
		this.sample_etc_nm = sample_etc_nm;
	}

	public String getExpiry_date() {
		return expiry_date;
	}
	public void setExpiry_date(String expiry_date) {
		this.expiry_date = expiry_date;
	}

	public String getSample_weight() {
		return sample_weight;
	}
	public void setSample_weight(String sample_weight) {
		this.sample_weight = sample_weight;
	}

	public String getKeep_method() {
		return keep_method;
	}
	public void setKeep_method(String keep_method) {
		this.keep_method = keep_method;
	}
	

	public String getOrderer_nm() {
		return orderer_nm;
	}
	public void setOrderer_nm(String orderer_nm) {
		this.orderer_nm = orderer_nm;
	}

	public String getBuilder_nm() {
		return builder_nm;
	}
	public void setBuilder_nm(String builder_nm) {
		this.builder_nm = builder_nm;
	}

	public String getJoiner_nm() {
		return joiner_nm;
	}
	public void setJoiner_nm(String joiner_nm) {
		this.joiner_nm = joiner_nm;
	}

	public String getCollector_nm() {
		return collector_nm;
	}
	public void setCollector_nm(String collector_nm) {
		this.collector_nm = collector_nm;
	}

	public String getCollect_date() {
		return collect_date;
	}
	public void setCollect_date(String collect_date) {
		this.collect_date = collect_date;
	}

	public String getCollect_place() {
		return collect_place;
	}
	public void setCollect_place(String collect_place) {
		this.collect_place = collect_place;
	}


	public List<String> getTest_req_seq_list() {
		return test_req_seq_list;
	}
	public void setTest_req_seq_list(List<String> test_req_seq_list) {
		this.test_req_seq_list = test_req_seq_list;
	}

	public String getTax_invoice_flag() {
		return tax_invoice_flag;
	}
	public void setTax_invoice_flag(String tax_invoice_flag) {
		this.tax_invoice_flag = tax_invoice_flag;
	}
	

	public String getTax_invoice_date() {
		return tax_invoice_date;
	}
	public void setTax_invoice_date(String tax_invoice_date) {
		this.tax_invoice_date = tax_invoice_date;
	}

	public int getItem_cnt() {
		return item_cnt;
	}
	public void setItem_cnt(int item_cnt) {
		this.item_cnt = item_cnt;
	}
	public int getCommission_amt_det() {
		return commission_amt_det;
	}
	public void setCommission_amt_det(int commission_amt_det) {
		this.commission_amt_det = commission_amt_det;
	}
	public int getPrdlst_amt_det() {
		return prdlst_amt_det;
	}
	public void setPrdlst_amt_det(int prdlst_amt_det) {
		this.prdlst_amt_det = prdlst_amt_det;
	}
	

	public String getReceipt_no() {
		return receipt_no;
	}
	public void setReceipt_no(String receipt_no) {
		this.receipt_no = receipt_no;
	}

	public String getSms_flag() {
		return sms_flag;
	}
	public void setSms_flag(String sms_flag) {
		this.sms_flag = sms_flag;
	}

	public String getSms_target() {
		return sms_target;
	}
	public void setSms_target(String sms_target) {
		this.sms_target = sms_target;
	}


	public String getSms_type() {
		return sms_type;
	}
	public void setSms_type(String sms_type) {
		this.sms_type = sms_type;
	}
	public String getAccept_item_info() {
		return accept_item_info;
	}
	public void setAccept_item_info(String accept_item_info) {
		this.accept_item_info = accept_item_info;
	}
	public String getAccept_wait_yn() {
		return accept_wait_yn;
	}
	public void setAccept_wait_yn(String accept_wait_yn) {
		this.accept_wait_yn = accept_wait_yn;
	}
	public String getSample_nms() {
		return sample_nms;
	}
	public void setSample_nms(String sample_nms) {
		this.sample_nms = sample_nms;
	}
	public String getLast_approval_date() {
		return last_approval_date;
	}
	public void setLast_approval_date(String last_approval_date) {
		this.last_approval_date = last_approval_date;
	}
	public String getLast_report_date() {
		return last_report_date;
	}
	public void setLast_report_date(String last_report_date) {
		this.last_report_date = last_report_date;
	}
	public String getLast_result_date() {
		return last_result_date;
	}
	public void setLast_result_date(String last_result_date) {
		this.last_result_date = last_result_date;
	}
	public int getCommission_amt_det_tax() {
		return commission_amt_det_tax;
	}
	public void setCommission_amt_det_tax(int commission_amt_det_tax) {
		this.commission_amt_det_tax = commission_amt_det_tax;
	}
	public String getTax_req_org_nm() {
		return tax_req_org_nm;
	}
	public void setTax_req_org_nm(String tax_req_org_nm) {
		this.tax_req_org_nm = tax_req_org_nm;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getTaxSdate() {
		return taxSdate;
	}
	public void setTaxSdate(String taxSdate) {
		this.taxSdate = taxSdate;
	}
	public String getTaxEdate() {
		return taxEdate;
	}
	public void setTaxEdate(String taxEdate) {
		this.taxEdate = taxEdate;
	}
	public String getOrg_cls() {
		return org_cls;
	}
	public void setOrg_cls(String org_cls) {
		this.org_cls = org_cls;
	}
	public String getSm_code() {
		return sm_code;
	}
	public void setSm_code(String sm_code) {
		this.sm_code = sm_code;
	}
	public String getSm_name() {
		return sm_name;
	}
	public void setSm_name(String sm_name) {
		this.sm_name = sm_name;
	}
	public String getStd_type() {
		return std_type;
	}
	public void setStd_type(String std_type) {
		this.std_type = std_type;
	}
	public String getPre_cost() {
		return pre_cost;
	}
	public void setPre_cost(String pre_cost) {
		this.pre_cost = pre_cost;
	}
	public String getPretreatment_cd() {
		return pretreatment_cd;
	}
	public void setPretreatment_cd(String pretreatment_cd) {
		this.pretreatment_cd = pretreatment_cd;
	}
	public String getAccept_method() {
		return accept_method;
	}
	public void setAccept_method(String accept_method) {
		this.accept_method = accept_method;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getContainer() {
		return container;
	}
	public void setContainer(String container) {
		this.container = container;
	}
	public String getVessel() {
		return vessel;
	}
	public void setVessel(String vessel) {
		this.vessel = vessel;
	}
	public String getBill_of_lading() {
		return bill_of_lading;
	}
	public void setBill_of_lading(String bill_of_lading) {
		this.bill_of_lading = bill_of_lading;
	}
	public String getPick_no() {
		return pick_no;
	}
	public void setPick_no(String pick_no) {
		this.pick_no = pick_no;
	}
	public String getSample_att_gbn() {
		return sample_att_gbn;
	}
	public void setSample_att_gbn(String sample_att_gbn) {
		this.sample_att_gbn = sample_att_gbn;
	}
	public String getMax_grade() {
		return max_grade;
	}
	public void setMax_grade(String max_grade) {
		this.max_grade = max_grade;
	}
	public String getResult_grade() {
		return result_grade;
	}
	public void setResult_grade(String result_grade) {
		this.result_grade = result_grade;
	}
	public String getReq_org_email() {
		return req_org_email;
	}
	public void setReq_org_email(String req_org_email) {
		this.req_org_email = req_org_email;
	}
	public String getSample_num() {
		return sample_num;
	}
	public void setSample_num(String sample_num) {
		this.sample_num = sample_num;
	}
	public String getSampling_no() {
		return sampling_no;
	}
	public void setSampling_no(String sampling_no) {
		this.sampling_no = sampling_no;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getQuality_dept_cd1() {
		return quality_dept_cd1;
	}
	public void setQuality_dept_cd1(String quality_dept_cd1) {
		this.quality_dept_cd1 = quality_dept_cd1;
	}
	public String getQuality_dept_cd2() {
		return quality_dept_cd2;
	}
	public void setQuality_dept_cd2(String quality_dept_cd2) {
		this.quality_dept_cd2 = quality_dept_cd2;
	}
	public String getQuality_user_id1() {
		return quality_user_id1;
	}
	public void setQuality_user_id1(String quality_user_id1) {
		this.quality_user_id1 = quality_user_id1;
	}
	public String getQuality_user_id2() {
		return quality_user_id2;
	}
	public void setQuality_user_id2(String quality_user_id2) {
		this.quality_user_id2 = quality_user_id2;
	}
	public String getResult_input_type() {
		return result_input_type;
	}
	public void setResult_input_type(String result_input_type) {
		this.result_input_type = result_input_type;
	}
	public String getBarcode_desc() {
		return barcode_desc;
	}
	public void setBarcode_desc(String barcode_desc) {
		this.barcode_desc = barcode_desc;
	}

	public String getPay_nm() {
		return pay_nm;
	}
	public void setPay_nm(String pay_nm) {
		this.pay_nm = pay_nm;
	}
	public String getPay_tel() {
		return pay_tel;
	}
	public void setPay_tel(String pay_tel) {
		this.pay_tel = pay_tel;
	}
	public String getPay_email() {
		return pay_email;
	}
	public void setPay_email(String pay_email) {
		this.pay_email = pay_email;
	}
	public String getReq_plant_nm() {
		return req_plant_nm;
	}
	public void setReq_plant_nm(String req_plant_nm) {
		this.req_plant_nm = req_plant_nm;
	}
	public String getReq_plant_addr() {
		return req_plant_addr;
	}
	public void setReq_plant_addr(String req_plant_addr) {
		this.req_plant_addr = req_plant_addr;
	}
	public String getReq_plant_tel() {
		return req_plant_tel;
	}
	public void setReq_plant_tel(String req_plant_tel) {
		this.req_plant_tel = req_plant_tel;
	}
	public String getCharger_tel() {
		return charger_tel;
	}
	public void setCharger_tel(String charger_tel) {
		this.charger_tel = charger_tel;
	}
	public String getCharger_tel2() {
		return charger_tel2;
	}
	public void setCharger_tel2(String charger_tel2) {
		this.charger_tel2 = charger_tel2;
	}
	public String getCharger_tel3() {
		return charger_tel3;
	}
	public void setCharger_tel3(String charger_tel3) {
		this.charger_tel3 = charger_tel3;
	}
	public String getCharger_tel4() {
		return charger_tel4;
	}
	public void setCharger_tel4(String charger_tel4) {
		this.charger_tel4 = charger_tel4;
	}
	public String getStartTest() {
		return startTest;
	}
	public void setStartTest(String startTest) {
		this.startTest = startTest;
	}
	public String getEndTest() {
		return endTest;
	}
	public void setEndTest(String endTest) {
		this.endTest = endTest;
	}
	public String getTest_end() {
		return test_end;
	}
	public void setTest_end(String test_end) {
		this.test_end = test_end;
	}
	public String getQR_nm() {
		return QR_nm;
	}
	public void setQR_nm(String qR_nm) {
		QR_nm = qR_nm;
	}
	public byte[] getQR_file() {
		return QR_file;
	}
	public void setQR_file(byte[] qR_file) {
		QR_file = qR_file;
	}
	public MultipartFile getQR_file_upload() {
		return QR_file_upload;
	}
	public void setQR_file_upload(MultipartFile qR_file_upload) {
		QR_file_upload = qR_file_upload;
	}
	public String getEst_check() {
		return est_check;
	}
	public void setEst_check(String est_check) {
		this.est_check = est_check;
	}
	public String getCalculation() {
		return calculation;
	}
	public void setCalculation(String calculation) {
		this.calculation = calculation;
	}
	public String getStd_type_nm() {
		return std_type_nm;
	}
	public void setStd_type_nm(String std_type_nm) {
		this.std_type_nm = std_type_nm;
	}
	public String getResult_type_nm() {
		return result_type_nm;
	}
	public void setResult_type_nm(String result_type_nm) {
		this.result_type_nm = result_type_nm;
	}
	public String getSel_dept_cd() {
		return sel_dept_cd;
	}
	public void setSel_dept_cd(String sel_dept_cd) {
		this.sel_dept_cd = sel_dept_cd;
	}
	public String getUnit_code() {
		return unit_code;
	}
	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}
	public String getTest_method_code() {
		return test_method_code;
	}
	public void setTest_method_code(String test_method_code) {
		this.test_method_code = test_method_code;
	}
	public String getNumrow() {
		return numrow;
	}
	public void setNumrow(String numrow) {
		this.numrow = numrow;
	}
	public String getReq_att_gbn() {
		return req_att_gbn;
	}
	public void setReq_att_gbn(String req_att_gbn) {
		this.req_att_gbn = req_att_gbn;
	}
	public String getAddr_report() {
		return addr_report;
	}
	public void setAddr_report(String addr_report) {
		this.addr_report = addr_report;
	}
	public String getTel_report() {
		return tel_report;
	}
	public void setTel_report(String tel_report) {
		this.tel_report = tel_report;
	}
	public String getFax_report() {
		return fax_report;
	}
	public void setFax_report(String fax_report) {
		this.fax_report = fax_report;
	}
	public String getTest_zip_code() {
		return test_zip_code;
	}
	public void setTest_zip_code(String test_zip_code) {
		this.test_zip_code = test_zip_code;
	}
	public String getTest_addr1() {
		return test_addr1;
	}
	public void setTest_addr1(String test_addr1) {
		this.test_addr1 = test_addr1;
	}
	public String getIsImp() {
		return isImp;
	}
	public void setIsImp(String isImp) {
		this.isImp = isImp;
	}
	public String getTat_date() {
		return tat_date;
	}
	public void setTat_date(String tat_date) {
		this.tat_date = tat_date;
	}
	public String getTat_log_no() {
		return tat_log_no;
	}
	public void setTat_log_no(String tat_log_no) {
		this.tat_log_no = tat_log_no;
	}
	public String getTest_addr2() {
		return test_addr2;
	}
	public void setTest_addr2(String test_addr2) {
		this.test_addr2 = test_addr2;
	}
	public String getPosition_desc() {
		return position_desc;
	}
	public void setPosition_desc(String position_desc) {
		this.position_desc = position_desc;
	}


}