package iit.lims.reagentsGlass.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class ReagentsGlassVO extends WorkVO {

	// 구매정보
	private String buy_sts, buy_title, buy_year, buy_q, dmd_date, buy_etc, state, buy_date, 
					msds1, msds2, msds3, msds4, msds5, msds6, msds7, msds8, msds9, msds10, msds11, msds12, msds13, msds14, msds15, msds16, img_file_nm, mtlr_vol;
	private MultipartFile m_img;
	private byte[] add_file;

	// 구매요청
	private String appr_flag, create_dept, buy_grp_cd, max_mtlr_no, office_cd;

	// 구매확정
	private String mtlr_cnfr_no, fix_qty, req_dept, cost, check_date, req_qty_string, modify_flag;

	private int save_count;

	// 구매수량, 정렬순서
	private int req_qty, ord_no;

	// 시약/실험기구 정보
	private String code_name, h_mtlr_info, h_mtlr_info_grid, m_mtlr_info, m_mtlr_info_grid, mtlr_flag, item_eng_nm, item_kor_nm, spec, unit, etc, use, master_yn, item_nm, spec1, spec2, spec_etc, content, unit_code;

	// 시약/실험기구 수불
	private String inout_no, inout_flag, in_date, out_date, price, manager_sign, charger_sign, inout_txt, inout_flag_detail, trs_dept_cd, confirm_nm, trs_dept_nm;
	private int in_qty, out_qty, tot_qty;

	// 구매검수
	private String confirm_date, confirm_etc;

	private MultipartFile m_file;
	
	private String barcode;
	
	public String getImg_file_nm() {
		return img_file_nm;
	}

	public void setImg_file_nm(String img_file_nm) {
		this.img_file_nm = img_file_nm;
	}

	public MultipartFile getM_img() {
		return m_img;
	}

	public void setM_img(MultipartFile m_img) {
		this.m_img = m_img;
	}

	public byte[] getAdd_file() {
		return add_file;
	}

	public void setAdd_file(byte[] add_file) {
		this.add_file = add_file;
	}

	public String getMsds1() {
		return msds1;
	}

	public void setMsds1(String msds1) {
		this.msds1 = msds1;
	}

	public String getMsds2() {
		return msds2;
	}

	public void setMsds2(String msds2) {
		this.msds2 = msds2;
	}

	public String getMsds3() {
		return msds3;
	}

	public void setMsds3(String msds3) {
		this.msds3 = msds3;
	}

	public String getMsds4() {
		return msds4;
	}

	public void setMsds4(String msds4) {
		this.msds4 = msds4;
	}

	public String getMsds5() {
		return msds5;
	}

	public void setMsds5(String msds5) {
		this.msds5 = msds5;
	}

	public String getMsds6() {
		return msds6;
	}

	public void setMsds6(String msds6) {
		this.msds6 = msds6;
	}

	public String getMsds7() {
		return msds7;
	}

	public void setMsds7(String msds7) {
		this.msds7 = msds7;
	}

	public String getMsds8() {
		return msds8;
	}

	public void setMsds8(String msds8) {
		this.msds8 = msds8;
	}

	public String getMsds9() {
		return msds9;
	}

	public void setMsds9(String msds9) {
		this.msds9 = msds9;
	}

	public String getMsds10() {
		return msds10;
	}

	public void setMsds10(String msds10) {
		this.msds10 = msds10;
	}

	public String getMsds11() {
		return msds11;
	}

	public void setMsds11(String msds11) {
		this.msds11 = msds11;
	}

	public String getMsds12() {
		return msds12;
	}

	public void setMsds12(String msds12) {
		this.msds12 = msds12;
	}

	public String getMsds13() {
		return msds13;
	}

	public void setMsds13(String msds13) {
		this.msds13 = msds13;
	}

	public String getMsds14() {
		return msds14;
	}

	public void setMsds14(String msds14) {
		this.msds14 = msds14;
	}

	public String getMsds15() {
		return msds15;
	}

	public void setMsds15(String msds15) {
		this.msds15 = msds15;
	}

	public String getMsds16() {
		return msds16;
	}

	public void setMsds16(String msds16) {
		this.msds16 = msds16;
	}

	
	public MultipartFile getM_file() {
		return m_file;
	}

	public void setM_file(MultipartFile m_file) {
		this.m_file = m_file;
	}

	public String getModify_flag() {
		return modify_flag;
	}

	public void setModify_flag(String modify_flag) {
		this.modify_flag = modify_flag;
	}

	public String getUnit_code() {
		return unit_code;
	}

	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}

	public String getSpec_etc() {
		return spec_etc;
	}

	public void setSpec_etc(String spec_etc) {
		this.spec_etc = spec_etc;
	}

	public String getReq_qty_string() {
		return req_qty_string;
	}

	public void setReq_qty_string(String req_qty_string) {
		this.req_qty_string = req_qty_string;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public String getH_mtlr_info() {
		return h_mtlr_info;
	}

	public void setH_mtlr_info(String h_mtlr_info) {
		this.h_mtlr_info = h_mtlr_info;
	}

	public String getM_mtlr_info() {
		return m_mtlr_info;
	}

	public void setM_mtlr_info(String m_mtlr_info) {
		this.m_mtlr_info = m_mtlr_info;
	}

	public String getH_mtlr_info_grid() {
		return h_mtlr_info_grid;
	}

	public void setH_mtlr_info_grid(String h_mtlr_info_grid) {
		this.h_mtlr_info_grid = h_mtlr_info_grid;
	}

	public String getM_mtlr_info_grid() {
		return m_mtlr_info_grid;
	}

	public void setM_mtlr_info_grid(String m_mtlr_info_grid) {
		this.m_mtlr_info_grid = m_mtlr_info_grid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getBuy_date() {
		return buy_date;
	}

	public void setBuy_date(String buy_date) {
		this.buy_date = buy_date;
	}

	public String getMax_mtlr_no() {
		return max_mtlr_no;
	}

	public void setMax_mtlr_no(String max_mtlr_no) {
		this.max_mtlr_no = max_mtlr_no;
	}
	
	public String getOffice_cd() {
		return office_cd;
	}

	public void setOffice_cd(String office_cd) {
		this.office_cd = office_cd;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public int getSave_count() {
		return save_count;
	}

	public void setSave_count(int save_count) {
		this.save_count = save_count;
	}

	public String getInout_flag_detail() {
		return inout_flag_detail;
	}

	public void setInout_flag_detail(String inout_flag_detail) {
		this.inout_flag_detail = inout_flag_detail;
	}

	public String getTrs_dept_cd() {
		return trs_dept_cd;
	}

	public void setTrs_dept_cd(String trs_dept_cd) {
		this.trs_dept_cd = trs_dept_cd;
	}

	public String getConfirm_nm() {
		return confirm_nm;
	}

	public void setConfirm_nm(String confirm_nm) {
		this.confirm_nm = confirm_nm;
	}

	public String getTrs_dept_nm() {
		return trs_dept_nm;
	}

	public void setTrs_dept_nm(String trs_dept_nm) {
		this.trs_dept_nm = trs_dept_nm;
	}

	public int getIn_qty() {
		return in_qty;
	}

	public void setIn_qty(int in_qty) {
		this.in_qty = in_qty;
	}

	public int getOut_qty() {
		return out_qty;
	}

	public void setOut_qty(int out_qty) {
		this.out_qty = out_qty;
	}

	public int getTot_qty() {
		return tot_qty;
	}

	public void setTot_qty(int tot_qty) {
		this.tot_qty = tot_qty;
	}

	public String getCreate_dept() {
		return create_dept;
	}

	public String getBuy_sts() {
		return buy_sts;
	}

	public void setBuy_sts(String buy_sts) {
		this.buy_sts = buy_sts;
	}

	public String getBuy_title() {
		return buy_title;
	}

	public void setBuy_title(String buy_title) {
		this.buy_title = buy_title;
	}

	public String getBuy_year() {
		return buy_year;
	}

	public void setBuy_year(String buy_year) {
		this.buy_year = buy_year;
	}

	public String getBuy_q() {
		return buy_q;
	}

	public void setBuy_q(String buy_q) {
		this.buy_q = buy_q;
	}

	public String getDmd_date() {
		return dmd_date;
	}

	public void setDmd_date(String dmd_date) {
		this.dmd_date = dmd_date;
	}

	public String getBuy_etc() {
		return buy_etc;
	}

	public void setBuy_etc(String buy_etc) {
		this.buy_etc = buy_etc;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public void setCreate_dept(String create_dept) {
		this.create_dept = create_dept;
	}

	public int getOrd_no() {
		return ord_no;
	}

	public void setOrd_no(int ord_no) {
		this.ord_no = ord_no;
	}

	public int getReq_qty() {
		return req_qty;
	}

	public void setReq_qty(int req_qty) {
		this.req_qty = req_qty;
	}

	public String getAppr_flag() {
		return appr_flag;
	}

	public void setAppr_flag(String appr_flag) {
		this.appr_flag = appr_flag;
	}

	public String getBuy_grp_cd() {
		return buy_grp_cd;
	}

	public void setBuy_grp_cd(String buy_grp_cd) {
		this.buy_grp_cd = buy_grp_cd;
	}

	public String getMtlr_cnfr_no() {
		return mtlr_cnfr_no;
	}

	public void setMtlr_cnfr_no(String mtlr_cnfr_no) {
		this.mtlr_cnfr_no = mtlr_cnfr_no;
	}

	public String getFix_qty() {
		return fix_qty;
	}

	public void setFix_qty(String fix_qty) {
		this.fix_qty = fix_qty;
	}

	public String getReq_dept() {
		return req_dept;
	}

	public void setReq_dept(String req_dept) {
		this.req_dept = req_dept;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getCheck_date() {
		return check_date;
	}

	public void setCheck_date(String check_date) {
		this.check_date = check_date;
	}

	public String getMtlr_flag() {
		return mtlr_flag;
	}

	public void setMtlr_flag(String mtlr_flag) {
		this.mtlr_flag = mtlr_flag;
	}

	public String getItem_eng_nm() {
		return item_eng_nm;
	}

	public void setItem_eng_nm(String item_eng_nm) {
		this.item_eng_nm = item_eng_nm;
	}

	public String getItem_kor_nm() {
		return item_kor_nm;
	}

	public void setItem_kor_nm(String item_kor_nm) {
		this.item_kor_nm = item_kor_nm;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getSpec1() {
		return spec1;
	}

	public void setSpec1(String spec1) {
		this.spec1 = spec1;
	}

	public String getSpec2() {
		return spec2;
	}

	public void setSpec2(String spec2) {
		this.spec2 = spec2;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getUse() {
		return use;
	}

	public void setUse(String use) {
		this.use = use;
	}

	public String getMaster_yn() {
		return master_yn;
	}

	public void setMaster_yn(String master_yn) {
		this.master_yn = master_yn;
	}

	public String getItem_nm() {
		return item_nm;
	}

	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}

	public String getInout_no() {
		return inout_no;
	}

	public void setInout_no(String inout_no) {
		this.inout_no = inout_no;
	}

	public String getInout_flag() {
		return inout_flag;
	}

	public void setInout_flag(String inout_flag) {
		this.inout_flag = inout_flag;
	}

	public String getIn_date() {
		return in_date;
	}

	public void setIn_date(String in_date) {
		this.in_date = in_date;
	}

	public String getOut_date() {
		return out_date;
	}

	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}

	public String getManager_sign() {
		return manager_sign;
	}

	public void setManager_sign(String manager_sign) {
		this.manager_sign = manager_sign;
	}

	public String getCharger_sign() {
		return charger_sign;
	}

	public void setCharger_sign(String charger_sign) {
		this.charger_sign = charger_sign;
	}

	public String getInout_txt() {
		return inout_txt;
	}

	public void setInout_txt(String inout_txt) {
		this.inout_txt = inout_txt;
	}

	public String getConfirm_date() {
		return confirm_date;
	}

	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}

	public String getConfirm_etc() {
		return confirm_etc;
	}

	public void setConfirm_etc(String confirm_etc) {
		this.confirm_etc = confirm_etc;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public String getMtlr_vol() {
		return mtlr_vol;
	}

	public void setMtlr_vol(String mtlr_vol) {
		this.mtlr_vol = mtlr_vol;
	}
}
