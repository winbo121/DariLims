package iit.lims.system.vo;

import iit.lims.common.vo.CommonVO;

public class CodeVO extends CommonVO {
	private String code, code_name, pre_code;
	private String ex_code1, ex_code2;
	private String kfda_key, kfda_desc, kfda_code;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public String getPre_code() {
		return pre_code;
	}

	public void setPre_code(String pre_code) {
		this.pre_code = pre_code;
	}

	public String getEx_code1() {
		return ex_code1;
	}

	public void setEx_code1(String ex_code1) {
		this.ex_code1 = ex_code1;
	}

	public String getEx_code2() {
		return ex_code2;
	}

	public void setEx_code2(String ex_code2) {
		this.ex_code2 = ex_code2;
	}
	
}
