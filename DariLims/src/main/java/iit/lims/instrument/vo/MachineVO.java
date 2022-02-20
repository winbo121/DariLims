package iit.lims.instrument.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class MachineVO extends WorkVO {
	private String end_year, inst_mng_no, inst_kor_nm, inst_eng_nm, inst_buy_date, inst_vnd_nm, inst_vnd_tel, make_nation, main_part, sub_inst, las_yn, kolas_yn, fld_use, manual, software, cali_period, pwr, instl_date, instl_plc, buy_cost, cmt, img_file_nm, ast_no, admin_user, admin_user_id, inst_jd_nm, inst_jd_no, cali_period_state, end_year_state, cali_period_flag, buy_cost_start, buy_cost_end;
	private String default_flag, use_his_flag;
	private MultipartFile m_img;
	private byte[] add_file;
	private String mng_no, mng_id, mng_nm, mng_start, mng_end, use_price, mng_sub_id, mng_sub_dept_cd, mng_sub_nm, mng_sub_dept_nm, ntis_no, etube_no, manage_flag;	
	private String model_nm, serial_number, cali_io_flag, cali_io;
	private String mng_gbn;
	
	private String mng_nm2, dept_nm2, mng_sub_nm2, mng_sub_dept_nm2;
	private String cali;
	/*교정주기 내부외부 구별할수 있는 cali*/
	
	private String intchk_date;
	private String crt_date;
	private String cntType;
	
	
	
	
	
	public String getIntchk_date() {
		return intchk_date;
	}

	public void setIntchk_date(String intchk_date) {
		this.intchk_date = intchk_date;
	}

	public String getCrt_date() {
		return crt_date;
	}

	public void setCrt_date(String crt_date) {
		this.crt_date = crt_date;
	}

	public String getMng_nm() {
		return mng_nm;
	}

	public String getCali() {
		return cali;
	}

	public void setCali(String cali) {
		this.cali = cali;
	}

	public void setMng_nm(String mng_nm) {
		this.mng_nm = mng_nm;
	}

	public String getMng_sub_id() {
		return mng_sub_id;
	}

	public void setMng_sub_id(String mng_sub_id) {
		this.mng_sub_id = mng_sub_id;
	}

	public String getMng_sub_dept_cd() {
		return mng_sub_dept_cd;
	}

	public void setMng_sub_dept_cd(String mng_sub_dept_cd) {
		this.mng_sub_dept_cd = mng_sub_dept_cd;
	}

	public String getMng_sub_nm() {
		return mng_sub_nm;
	}

	public void setMng_sub_nm(String mng_sub_nm) {
		this.mng_sub_nm = mng_sub_nm;
	}

	public String getMng_sub_dept_nm() {
		return mng_sub_dept_nm;
	}

	public void setMng_sub_dept_nm(String mng_sub_dept_nm) {
		this.mng_sub_dept_nm = mng_sub_dept_nm;
	}

	public String getUse_price() {
		return use_price;
	}

	public void setUse_price(String use_price) {
		this.use_price = use_price;
	}

	public String getMng_no() {
		return mng_no;
	}

	public void setMng_no(String mng_no) {
		this.mng_no = mng_no;
	}

	public String getMng_id() {
		return mng_id;
	}

	public void setMng_id(String mng_id) {
		this.mng_id = mng_id;
	}

	public String getMng_start() {
		return mng_start;
	}

	public void setMng_start(String mng_start) {
		this.mng_start = mng_start;
	}

	public String getMng_end() {
		return mng_end;
	}

	public void setMng_end(String mng_end) {
		this.mng_end = mng_end;
	}

	public String getDefault_flag() {
		return default_flag;
	}

	public void setDefault_flag(String default_flag) {
		this.default_flag = default_flag;
	}

	public String getUse_his_flag() {
		return use_his_flag;
	}

	public void setUse_his_flag(String use_his_flag) {
		this.use_his_flag = use_his_flag;
	}

	private String crt_no, nxt_crt_date;

	public String getCrt_no() {
		return crt_no;
	}

	public void setCrt_no(String crt_no) {
		this.crt_no = crt_no;
	}

	public String getNxt_crt_date() {
		return nxt_crt_date;
	}

	public void setNxt_crt_date(String nxt_crt_date) {
		this.nxt_crt_date = nxt_crt_date;
	}

	public MultipartFile getM_img() {
		return m_img;
	}

	public void setm_img(MultipartFile m_img) {
		this.m_img = m_img;
	}

	public byte[] getAdd_file() {
		return add_file;
	}

	public void setAdd_file(byte[] add_file) {
		this.add_file = add_file;
	}

	public String getEnd_year() {
		return end_year;
	}

	public void setEnd_year(String end_year) {
		this.end_year = end_year;
	}

	public String getInst_mng_no() {
		return inst_mng_no;
	}

	public void setInst_mng_no(String inst_mng_no) {
		this.inst_mng_no = inst_mng_no;
	}

	public String getInst_kor_nm() {
		return inst_kor_nm;
	}

	public void setInst_kor_nm(String inst_kor_nm) {
		this.inst_kor_nm = inst_kor_nm;
	}

	public String getInst_eng_nm() {
		return inst_eng_nm;
	}

	public void setInst_eng_nm(String inst_eng_nm) {
		this.inst_eng_nm = inst_eng_nm;
	}

	public String getInst_buy_date() {
		return inst_buy_date;
	}

	public void setInst_buy_date(String inst_buy_date) {
		this.inst_buy_date = inst_buy_date;
	}

	public String getInst_vnd_nm() {
		return inst_vnd_nm;
	}

	public void setInst_vnd_nm(String inst_vnd_nm) {
		this.inst_vnd_nm = inst_vnd_nm;
	}

	public String getInst_vnd_tel() {
		return inst_vnd_tel;
	}

	public void setInst_vnd_tel(String inst_vnd_tel) {
		this.inst_vnd_tel = inst_vnd_tel;
	}

	public String getMake_nation() {
		return make_nation;
	}

	public void setMake_nation(String make_nation) {
		this.make_nation = make_nation;
	}

	public String getMain_part() {
		return main_part;
	}

	public void setMain_part(String main_part) {
		this.main_part = main_part;
	}

	public String getSub_inst() {
		return sub_inst;
	}

	public void setSub_inst(String sub_inst) {
		this.sub_inst = sub_inst;
	}

	public String getLas_yn() {
		return las_yn;
	}

	public void setLas_yn(String las_yn) {
		this.las_yn = las_yn;
	}

	public String getKolas_yn() {
		return kolas_yn;
	}

	public void setKolas_yn(String kolas_yn) {
		this.kolas_yn = kolas_yn;
	}

	public String getFld_use() {
		return fld_use;
	}

	public void setFld_use(String fld_use) {
		this.fld_use = fld_use;
	}

	public String getManual() {
		return manual;
	}

	public void setManual(String manual) {
		this.manual = manual;
	}

	public String getSoftware() {
		return software;
	}

	public void setSoftware(String software) {
		this.software = software;
	}

	public String getCali_period() {
		return cali_period;
	}

	public void setCali_period(String cali_period) {
		this.cali_period = cali_period;
	}

	public String getPwr() {
		return pwr;
	}

	public void setPwr(String pwr) {
		this.pwr = pwr;
	}

	public String getInstl_date() {
		return instl_date;
	}

	public void setInstl_date(String instl_date) {
		this.instl_date = instl_date;
	}

	public String getInstl_plc() {
		return instl_plc;
	}

	public void setInstl_plc(String instl_plc) {
		this.instl_plc = instl_plc;
	}

	public String getBuy_cost() {
		return buy_cost;
	}

	public void setBuy_cost(String buy_cost) {
		this.buy_cost = buy_cost;
	}

	public String getCmt() {
		return cmt;
	}

	public void setCmt(String cmt) {
		this.cmt = cmt;
	}

	public String getImg_file_nm() {
		return img_file_nm;
	}

	public void setImg_file_nm(String img_file_nm) {
		this.img_file_nm = img_file_nm;
	}

	public String getAst_no() {
		return ast_no;
	}

	public void setAst_no(String ast_no) {
		this.ast_no = ast_no;
	}

	public String getAdmin_user() {
		return admin_user;
	}

	public void setAdmin_user(String admin_user) {
		this.admin_user = admin_user;
	}

	public String getAdmin_user_id() {
		return admin_user_id;
	}

	public void setAdmin_user_id(String admin_user_id) {
		this.admin_user_id = admin_user_id;
	}

	public String getInst_jd_nm() {
		return inst_jd_nm;
	}

	public void setInst_jd_nm(String inst_jd_nm) {
		this.inst_jd_nm = inst_jd_nm;
	}

	public String getInst_jd_no() {
		return inst_jd_no;
	}

	public void setInst_jd_no(String inst_jd_no) {
		this.inst_jd_no = inst_jd_no;
	}

	public void setM_img(MultipartFile m_img) {
		this.m_img = m_img;
	}

	public String getCali_period_state() {
		return cali_period_state;
	}

	public void setCali_period_state(String cali_period_state) {
		this.cali_period_state = cali_period_state;
	}

	public String getEnd_year_state() {
		return end_year_state;
	}

	public void setEnd_year_state(String end_year_state) {
		this.end_year_state = end_year_state;
	}

	public String getCali_period_flag() {
		return cali_period_flag;
	}

	public void setCali_period_flag(String cali_period_flag) {
		this.cali_period_flag = cali_period_flag;
	}

	public String getBuy_cost_start() {
		return buy_cost_start;
	}

	public void setBuy_cost_start(String buy_cost_start) {
		this.buy_cost_start = buy_cost_start;
	}

	public String getBuy_cost_end() {
		return buy_cost_end;
	}

	public void setBuy_cost_end(String buy_cost_end) {
		this.buy_cost_end = buy_cost_end;
	}

	public String getNtis_no() {
		return ntis_no;
	}

	public void setNtis_no(String ntis_no) {
		this.ntis_no = ntis_no;
	}

	public String getEtube_no() {
		return etube_no;
	}

	public void setEtube_no(String etube_no) {
		this.etube_no = etube_no;
	}

	public String getManage_flag() {
		return manage_flag;
	}

	public void setManage_flag(String manage_flag) {
		this.manage_flag = manage_flag;
	}

	public String getModel_nm() {
		return model_nm;
	}

	public void setModel_nm(String model_nm) {
		this.model_nm = model_nm;
	}

	public String getSerial_number() {
		return serial_number;
	}

	public void setSerial_number(String serial_number) {
		this.serial_number = serial_number;
	}

	public String getCali_io_flag() {
		return cali_io_flag;
	}

	public void setCali_io_flag(String cali_io_flag) {
		this.cali_io_flag = cali_io_flag;
	}

	public String getMng_gbn() {
		return mng_gbn;
	}

	public void setMng_gbn(String mng_gbn) {
		this.mng_gbn = mng_gbn;
	}

	public String getMng_nm2() {
		return mng_nm2;
	}

	public void setMng_nm2(String mng_nm2) {
		this.mng_nm2 = mng_nm2;
	}

	public String getDept_nm2() {
		return dept_nm2;
	}

	public void setDept_nm2(String dept_nm2) {
		this.dept_nm2 = dept_nm2;
	}

	public String getMng_sub_nm2() {
		return mng_sub_nm2;
	}

	public void setMng_sub_nm2(String mng_sub_nm2) {
		this.mng_sub_nm2 = mng_sub_nm2;
	}

	public String getMng_sub_dept_nm2() {
		return mng_sub_dept_nm2;
	}

	public void setMng_sub_dept_nm2(String mng_sub_dept_nm2) {
		this.mng_sub_dept_nm2 = mng_sub_dept_nm2;
	}

	public String getCali_io() {
		return cali_io;
	}

	public void setCali_io(String cali_io) {
		this.cali_io = cali_io;
	}

	public String getCntType() {
		return cntType;
	}

	public void setCntType(String cntType) {
		this.cntType = cntType;
	}
}
