package iit.lims.accept.vo;

import iit.lims.master.vo.TestItemVO;

public class EstimateVO extends TestItemVO {
	
	/*
	 * 견적번호
	 */
	private String est_no;
	/*
	 * 견적번호
	 */
	private String est_item_no;
	/*
	 * 견적제목
	 */
	private String est_title;
	/*
	 * 견적일
	 */
	private String est_date;
	/*
	 * 비고
	 */
	private String est_desc;
	/*
	 * 견적업체번호
	 */
	private String est_org_no;
	/*
	 * 견적업체명
	 */
	private String est_org_nm;
	/*
	 * 견적신청인(견적담당자)
	 */
	private String est_charger_nm;
	/*
	 * 견적단위업무
	 */
	private String est_unit_work;
	/*
	 * 견적수량
	 */
	private String est_qty;
	/*
	 * 견적단가
	 */
	private int est_price;
	/*
	 * 견적수수료
	 */
	private String est_fee;
	/*
	 * 견적단가합계
	 */
	private String est_price_total;
	/*
	 * 견적수수료합계금액
	 */
	private String est_fee_tot;

	/*
	 * 견적진행상태
	 */
	private String est_state;
	/*
	 * 견적구분
	 */
	private String est_gubun;
	/*
	 * 견적진행상태
	 */
	private String est_state_nm;
	/*
	 * 견적구분
	 */
	private String est_gubun_nm;
	
	/*
	 * 견적수수료번호
	 */
	private String est_fee_no;
	/*
	 * 견적수수료코드
	 */
	private String est_fee_cd;
	/*
	 * 견적수수료명
	 */
	private String est_fee_nm;
	/*
	 * 견적수수료
	 */
	private String est_fee_price;
	/*
	 * 견적수수료비고
	 */
	private String est_fee_desc;
	/*
	 * 견적서에 사용되는 Reference
	 */
	private String est_ref;
	
	
	private String est_exp_nm;
	
	private String est_item_desc;
	
	private String est_item_spec;
	private String est_fee_qty;
	private String est_fee_price_total;
	private String prdlst_cd;
	private String prdlst_nm;
	private String est_temp_no;
	private String est_temp_item_no;
	private String new_est_no;
	
	public String getEst_temp_no() {
		return est_temp_no;
	}
	public void setEst_temp_no(String est_temp_no) {
		this.est_temp_no = est_temp_no;
	}
	public String getEst_temp_item_no() {
		return est_temp_item_no;
	}
	public void setEst_temp_item_no(String est_temp_item_no) {
		this.est_temp_item_no = est_temp_item_no;
	}
	public String getPrdlst_nm() {
		return prdlst_nm;
	}
	public void setPrdlst_nm(String prdlst_nm) {
		this.prdlst_nm = prdlst_nm;
	}
	public String getPrdlst_cd() {
		return prdlst_cd;
	}
	public void setPrdlst_cd(String prdlst_cd) {
		this.prdlst_cd = prdlst_cd;
	}
	public String getEst_fee_qty() {
		return est_fee_qty;
	}
	public void setEst_fee_qty(String est_fee_qty) {
		this.est_fee_qty = est_fee_qty;
	}
	public String getEst_fee_price_total() {
		return est_fee_price_total;
	}
	public void setEst_fee_price_total(String est_fee_price_total) {
		this.est_fee_price_total = est_fee_price_total;
	}
	public String getEst_item_spec() {
		return est_item_spec;
	}
	public void setEst_item_spec(String est_item_spec) {
		this.est_item_spec = est_item_spec;
	}
	public String getEst_item_desc() {
		return est_item_desc;
	}
	public void setEst_item_desc(String est_item_desc) {
		this.est_item_desc = est_item_desc;
	}
	public String getEst_exp_nm() {
		return est_exp_nm;
	}
	public void setEst_exp_nm(String est_exp_nm) {
		this.est_exp_nm = est_exp_nm;
	}
	public String getEst_fee_nm() {
		return est_fee_nm;
	}
	public void setEst_fee_nm(String est_fee_nm) {
		this.est_fee_nm = est_fee_nm;
	}
	public String getEst_fee_no() {
		return est_fee_no;
	}
	public void setEst_fee_no(String est_fee_no) {
		this.est_fee_no = est_fee_no;
	}
	public String getEst_fee_cd() {
		return est_fee_cd;
	}
	public void setEst_fee_cd(String est_fee_cd) {
		this.est_fee_cd = est_fee_cd;
	}
	public String getEst_fee_price() {
		return est_fee_price;
	}
	public void setEst_fee_price(String est_fee_price) {
		this.est_fee_price = est_fee_price;
	}
	public String getEst_fee_desc() {
		return est_fee_desc;
	}
	public void setEst_fee_desc(String est_fee_desc) {
		this.est_fee_desc = est_fee_desc;
	}
	public String getEst_item_no() {
		return est_item_no;
	}
	public void setEst_item_no(String est_item_no) {
		this.est_item_no = est_item_no;
	}
	public String getEst_state_nm() {
		return est_state_nm;
	}
	public void setEst_state_nm(String est_state_nm) {
		this.est_state_nm = est_state_nm;
	}
	public String getEst_gubun_nm() {
		return est_gubun_nm;
	}
	public void setEst_gubun_nm(String est_gubun_nm) {
		this.est_gubun_nm = est_gubun_nm;
	}
	public String getEst_gubun() {
		return est_gubun;
	}
	public void setEst_gubun(String est_gubun) {
		this.est_gubun = est_gubun;
	}
	public String getEst_state() {
		return est_state;
	}
	public void setEst_state(String est_state) {
		this.est_state = est_state;
	}
	public int getEst_price() {
		return est_price;
	}
	public void setEst_price(int est_price) {
		this.est_price = est_price;
	}
	public String getEst_price_total() {
		return est_price_total;
	}
	public void setEst_price_total(String est_price_total) {
		this.est_price_total = est_price_total;
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
	public String getEst_date() {
		return est_date;
	}
	public void setEst_date(String est_date) {
		this.est_date = est_date;
	}
	public String getEst_desc() {
		return est_desc;
	}
	public void setEst_desc(String est_desc) {
		this.est_desc = est_desc;
	}
	public String getEst_org_no() {
		return est_org_no;
	}
	public void setEst_org_no(String est_org_no) {
		this.est_org_no = est_org_no;
	}
	public String getEst_org_nm() {
		return est_org_nm;
	}
	public void setEst_org_nm(String est_org_nm) {
		this.est_org_nm = est_org_nm;
	}
	public String getEst_charger_nm() {
		return est_charger_nm;
	}
	public void setEst_charger_nm(String est_charger_nm) {
		this.est_charger_nm = est_charger_nm;
	}
	public String getEst_unit_work() {
		return est_unit_work;
	}
	public void setEst_unit_work(String est_unit_work) {
		this.est_unit_work = est_unit_work;
	}
	public String getEst_qty() {
		return est_qty;
	}
	public void setEst_qty(String est_qty) {
		this.est_qty = est_qty;
	}
	public String getEst_fee() {
		return est_fee;
	}
	public void setEst_fee(String est_fee) {
		this.est_fee = est_fee;
	}
	public String getEst_fee_tot() {
		return est_fee_tot;
	}
	public void setEst_fee_tot(String est_fee_tot) {
		this.est_fee_tot = est_fee_tot;
	}
	public String getEst_ref() {
		return est_ref;
	}
	public void setEst_ref(String est_ref) {
		this.est_ref = est_ref;
	}
	public String getNew_est_no() {
		return new_est_no;
	}
	public void setNew_est_no(String new_est_no) {
		this.new_est_no = new_est_no;
	}

}