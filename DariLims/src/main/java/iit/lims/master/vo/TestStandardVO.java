package iit.lims.master.vo;

public class TestStandardVO extends TestPrdStdVO  {
	private String sm_code;
	private String sm_code_n;
	private String sm_name;
	private String sm_name_e;
	private String standard_spec_seq;
	private String del_st_spec;
	private String protocol;
	
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
	public String getSm_name_e() {
		return sm_name_e;
	}
	public void setSm_name_e(String sm_name_e) {
		this.sm_name_e = sm_name_e;
	}
	public String getStandard_spec_seq() {
		return standard_spec_seq;
	}
	public void setStandard_spec_seq(String standard_spec_seq) {
		this.standard_spec_seq = standard_spec_seq;
	}
	public String getDel_st_spec() {
		return del_st_spec;
	}
	public void setDel_st_spec(String del_st_spec) {
		this.del_st_spec = del_st_spec;
	}
	public String getProtocol() {
		return protocol;
	}
	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}
	public String getSm_code_n() {
		return sm_code_n;
	}
	public void setSm_code_n(String sm_code_n) {
		this.sm_code_n = sm_code_n;
	}
}