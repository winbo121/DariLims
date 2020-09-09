package iit.lims.system.vo;

import iit.lims.common.vo.WorkVO;

public class CommonCodeVO extends WorkVO {
	private String code, code_Name;
	private String ex_code1, ex_code2;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCode_Name() {
		return code_Name;
	}

	public void setCode_Name(String code_Name) {
		this.code_Name = code_Name;
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
