package iit.lims.accept.vo;

import iit.lims.master.vo.ReqOrgVO;

public class CommissionCheckVO extends ReqOrgVO {

	private String commission_amt_tot;
	private String commission_amt_det;
	private String commission_amt_flag;	
	private String title;
	private String req_date;
	private String state;
	private String deposit_amt;
	private String deposit_date;
	private String default_amt;

	private String tax_invoice_flag;
	private String tax_invoice_date;
	
	private int item_cnt = 0;
	private String req_class, express_flag;
	private String sales_user_id, sales_dept_cd;
	private String prdlst_fee, dept_fee, bonus_fee;
	private String taxSdate, taxEdate;
	private String depositSdate, depositEdate;
	
	private String tax_req_org_nm;
	private String tax_pre_tel_num;
	private String deposit_amt_tot;
	private String default_amt_tot;
	private String org_cls;
	private String req_biz_no;
	private String tax_biz_no;
	
	private String sample_reg_nm, prdlst_nm;
	private String req_org_no3;
	
	private String last_report_date;
	
	private String addr;
	private String biz_type;
	private String biz_class;
	
	private String tax_invoice_num;
	private String tax_invoice_amt;
	
	private String payment_method;
	
	private String fee_tot_est,fee_tot_item;
	
	private String tax_invoice_seq;
	
	private String sample_arrival_date;
	
	private String paid;
	
	public String getCommission_amt_tot() {
		return commission_amt_tot;
	}
	public void setCommission_amt_tot(String commission_amt_tot) {
		this.commission_amt_tot = commission_amt_tot;
	}
	public String getCommission_amt_det() {
		return commission_amt_det;
	}
	public void setCommission_amt_det(String commission_amt_det) {
		this.commission_amt_det = commission_amt_det;
	}
	public String getCommission_amt_flag() {
		return commission_amt_flag;
	}
	public void setCommission_amt_flag(String commission_amt_flag) {
		this.commission_amt_flag = commission_amt_flag;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getReq_date() {
		return req_date;
	}
	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDeposit_amt() {
		return deposit_amt;
	}
	public void setDeposit_amt(String deposit_amt) {
		this.deposit_amt = deposit_amt;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getDefault_amt() {
		return default_amt;
	}
	public void setDefault_amt(String default_amt) {
		this.default_amt = default_amt;
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
	

	public String getPrdlst_fee() {
		return prdlst_fee;
	}
	public void setPrdlst_fee(String prdlst_fee) {
		this.prdlst_fee = prdlst_fee;
	}

	public String getDept_fee() {
		return dept_fee;
	}
	public void setDept_fee(String dept_fee) {
		this.dept_fee = dept_fee;
	}

	public String getBonus_fee() {
		return bonus_fee;
	}
	public void setBonus_fee(String bonus_fee) {
		this.bonus_fee = bonus_fee;
	}
	
	public int getItem_cnt() {
		return item_cnt;
	}
	public void setItem_cnt(int item_cnt) {
		this.item_cnt = item_cnt;
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
	

	public String getdepositSdate() {
		return depositSdate;
	}
	public void setdepositSdate(String depositSdate) {
		this.depositSdate = depositSdate;
	}

	public String getdepositEdate() {
		return depositEdate;
	}
	public void setdepositEdate(String depositEdate) {
		this.depositEdate = depositEdate;
	}
	public String getTax_req_org_nm() {
		return tax_req_org_nm;
	}
	public void setTax_req_org_nm(String tax_req_org_nm) {
		this.tax_req_org_nm = tax_req_org_nm;
	}
	public String getDeposit_amt_tot() {
		return deposit_amt_tot;
	}
	public void setDeposit_amt_tot(String deposit_amt_tot) {
		this.deposit_amt_tot = deposit_amt_tot;
	}
	public String getDefault_amt_tot() {
		return default_amt_tot;
	}
	public void setDefault_amt_tot(String default_amt_tot) {
		this.default_amt_tot = default_amt_tot;
	}
	public String getOrg_cls() {
		return org_cls;
	}
	public void setOrg_cls(String org_cls) {
		this.org_cls = org_cls;
	}
	public String getSample_reg_nm() {
		return sample_reg_nm;
	}
	public void setSample_reg_nm(String sample_reg_nm) {
		this.sample_reg_nm = sample_reg_nm;
	}
	public String getPrdlst_nm() {
		return prdlst_nm;
	}
	public void setPrdlst_nm(String prdlst_nm) {
		this.prdlst_nm = prdlst_nm;
	}
	public String getReq_org_no3() {
		return req_org_no3;
	}
	public void setReq_org_no3(String req_org_no3) {
		this.req_org_no3 = req_org_no3;
	}
	public String getReq_biz_no() {
		return req_biz_no;
	}
	public void setReq_biz_no(String req_biz_no) {
		this.req_biz_no = req_biz_no;
	}
	public String getTax_biz_no() {
		return tax_biz_no;
	}
	public void setTax_biz_no(String tax_biz_no) {
		this.tax_biz_no = tax_biz_no;
	}
	public String getTax_pre_tel_num() {
		return tax_pre_tel_num;
	}
	public void setTax_pre_tel_num(String tax_pre_tel_num) {
		this.tax_pre_tel_num = tax_pre_tel_num;
	}
	public String getLast_report_date() {
		return last_report_date;
	}
	public void setLast_report_date(String last_report_date) {
		this.last_report_date = last_report_date;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getBiz_type() {
		return biz_type;
	}
	public void setBiz_type(String biz_type) {
		this.biz_type = biz_type;
	}
	public String getBiz_class() {
		return biz_class;
	}
	public void setBiz_class(String biz_class) {
		this.biz_class = biz_class;
	}
	public String getTax_invoice_num() {
		return tax_invoice_num;
	}
	public void setTax_invoice_num(String tax_invoice_num) {
		this.tax_invoice_num = tax_invoice_num;
	}
	public String getTax_invoice_amt() {
		return tax_invoice_amt;
	}
	public void setTax_invoice_amt(String tax_invoice_amt) {
		this.tax_invoice_amt = tax_invoice_amt;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public String getFee_tot_est() {
		return fee_tot_est;
	}
	public void setFee_tot_est(String fee_tot_est) {
		this.fee_tot_est = fee_tot_est;
	}
	public String getFee_tot_item() {
		return fee_tot_item;
	}
	public void setFee_tot_item(String fee_tot_item) {
		this.fee_tot_item = fee_tot_item;
	}
	public String getTax_invoice_seq() {
		return tax_invoice_seq;
	}
	public void setTax_invoice_seq(String tax_invoice_seq) {
		this.tax_invoice_seq = tax_invoice_seq;
	}
	public String getSample_arrival_date() {
		return sample_arrival_date;
	}
	public void setSample_arrival_date(String sample_arrival_date) {
		this.sample_arrival_date = sample_arrival_date;
	}
	public String getPaid() {
		return paid;
	}
	public void setPaid(String paid) {
		this.paid = paid;
	}
}