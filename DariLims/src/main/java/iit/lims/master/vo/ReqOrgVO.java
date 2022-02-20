package iit.lims.master.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.PagingVO;
import iit.lims.common.vo.WorkVO;

public class ReqOrgVO extends PagingVO {
	private String org_type, pre_tel_num, pre_fax_num, org_type_cd;
	private String charger, charger_tel, zip_code, addr1, addr2, org_desc;
	private String req_nm;
	private String req_tel;
	private String req_org_no, org_nm;
	private String biz_no1, biz_no2, biz_no3, biz_no, email, file_nm, discount_rate, discount_flag, fee_tot;
	private byte[] biz_file_byte;
	private MultipartFile biz_file;
	private String temp_date1, temp_date2;
	private String pre_man;
	private String bsnsc, item, cor_no;
	private List<String> test_req_seq_list;
	private String org_nm_en;
	private String biz_wooden, wooden_type;
	private String pac_tel_num, pac_fax_num;
	private String pac_zip_code, pac_addr1, pac_addr2;//공장주소
	private String pay_nm, pay_tel,pay_email, eng_nm;
	private String new_req_org; //복사 셀렉트키 사용
	
	
	
	public String getNew_req_org() {
		return new_req_org;
	}
	public void setNew_req_org(String new_req_org) {
		this.new_req_org = new_req_org;
	}
	public String getBsnsc() {
		return bsnsc;
	}
	public void setBsnsc(String bsnsc) {
		this.bsnsc = bsnsc;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getCor_no() {
		return cor_no;
	}
	public void setCor_no(String cor_no) {
		this.cor_no = cor_no;
	}
	public String getOrg_type() {
		return org_type;
	}
	public void setOrg_type(String org_type) {
		this.org_type = org_type;
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
	public String getCharger() {
		return charger;
	}
	public void setCharger(String charger) {
		this.charger = charger;
	}
	public String getCharger_tel() {
		return charger_tel;
	}
	public void setCharger_tel(String charger_tel) {
		this.charger_tel = charger_tel;
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
	public String getOrg_desc() {
		return org_desc;
	}
	public void setOrg_desc(String org_desc) {
		this.org_desc = org_desc;
	}
	public String getReq_nm() {
		return req_nm;
	}
	public void setReq_nm(String req_nm) {
		this.req_nm = req_nm;
	}
	public String getReq_tel() {
		return req_tel;
	}
	public void setReq_tel(String req_tel) {
		this.req_tel = req_tel;
	}
	public String getReq_org_no() {
		return req_org_no;
	}
	public void setReq_org_no(String req_org_no) {
		this.req_org_no = req_org_no;
	}
	public String getOrg_nm() {
		return org_nm;
	}
	public void setOrg_nm(String org_nm) {
		this.org_nm = org_nm;
	}
	public String getBiz_no1() {
		return biz_no1;
	}
	public void setBiz_no1(String biz_no1) {
		this.biz_no1 = biz_no1;
	}
	public String getBiz_no2() {
		return biz_no2;
	}
	public void setBiz_no2(String biz_no2) {
		this.biz_no2 = biz_no2;
	}
	public String getBiz_no3() {
		return biz_no3;
	}
	public void setBiz_no3(String biz_no3) {
		this.biz_no3 = biz_no3;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
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
	public String getFee_tot() {
		return fee_tot;
	}
	public void setFee_tot(String fee_tot) {
		this.fee_tot = fee_tot;
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
	public String getOrg_type_cd() {
		return org_type_cd;
	}
	public void setOrg_type_cd(String org_type_cd) {
		this.org_type_cd = org_type_cd;
	}

	
	public String getTemp_date1() {
		return temp_date1;
	}
	public void setTemp_date1(String temp_date1) {
		this.temp_date1 = temp_date1;
	}

	public String getTemp_date2() {
		return temp_date2;
	}
	public void setTemp_date2(String temp_date2) {
		this.temp_date2 = temp_date2;
	}
	public String getBiz_no() {
		return biz_no;
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
	public List<String> getTest_req_seq_list() {
		return test_req_seq_list;
	}
	public void setTest_req_seq_list(List<String> test_req_seq_list) {
		this.test_req_seq_list = test_req_seq_list;
	}
	public String getOrg_nm_en() {
		return org_nm_en;
	}
	public void setOrg_nm_en(String org_nm_en) {
		this.org_nm_en = org_nm_en;
	}

	public String getBiz_wooden() {
		return biz_wooden;
	}
	public void setBiz_wooden(String biz_wooden) {
		this.biz_wooden = biz_wooden;
	}
	public String getPac_tel_num() {
		return pac_tel_num;
	}
	public void setPac_tel_num(String pac_tel_num) {
		this.pac_tel_num = pac_tel_num;
	}
	public String getPac_fax_num() {
		return pac_fax_num;
	}
	public void setPac_fax_num(String pac_fax_num) {
		this.pac_fax_num = pac_fax_num;
	}
	public String getPac_zip_code() {
		return pac_zip_code;
	}
	public void setPac_zip_code(String pac_zip_code) {
		this.pac_zip_code = pac_zip_code;
	}
	public String getPac_addr1() {
		return pac_addr1;
	}
	public void setPac_addr1(String pac_addr1) {
		this.pac_addr1 = pac_addr1;
	}
	public String getPac_addr2() {
		return pac_addr2;
	}
	public void setPac_addr2(String pac_addr2) {
		this.pac_addr2 = pac_addr2;
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
	public String getWooden_type() {
		return wooden_type;
	}
	public void setWooden_type(String wooden_type) {
		this.wooden_type = wooden_type;
	}
	public String getEng_nm() {
		return eng_nm;
	}
	public void setEng_nm(String eng_nm) {
		this.eng_nm = eng_nm;
	}
	
}