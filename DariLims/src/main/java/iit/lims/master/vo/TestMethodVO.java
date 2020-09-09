package iit.lims.master.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class TestMethodVO extends WorkVO {

	private String test_method_nm, quot_std, condition, guide_nm, doc_nm, file_nm, default_flag, test_method_content, test_method_preclean;
	private byte[] att_file;
	private MultipartFile m_file;
	
	
	public String getTest_method_nm() {
		return test_method_nm;
	}
	public void setTest_method_nm(String test_method_nm) {
		this.test_method_nm = test_method_nm;
	}
	public String getQuot_std() {
		return quot_std;
	}
	public void setQuot_std(String quot_std) {
		this.quot_std = quot_std;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getGuide_nm() {
		return guide_nm;
	}
	public void setGuide_nm(String guide_nm) {
		this.guide_nm = guide_nm;
	}
	public String getDoc_nm() {
		return doc_nm;
	}
	public void setDoc_nm(String doc_nm) {
		this.doc_nm = doc_nm;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getDefault_flag() {
		return default_flag;
	}
	public void setDefault_flag(String default_flag) {
		this.default_flag = default_flag;
	}
	public String getTest_method_content() {
		return test_method_content;
	}
	public void setTest_method_content(String test_method_content) {
		this.test_method_content = test_method_content;
	}
	public String getTest_method_preclean() {
		return test_method_preclean;
	}
	public void setTest_method_preclean(String test_method_preclean) {
		this.test_method_preclean = test_method_preclean;
	}
	public byte[] getAtt_file() {
		return att_file;
	}
	public void setAtt_file(byte[] att_file) {
		this.att_file = att_file;
	}
	public MultipartFile getM_file() {
		return m_file;
	}
	public void setM_file(MultipartFile m_file) {
		this.m_file = m_file;
	}
	
	
	
	
	
	
	

}
