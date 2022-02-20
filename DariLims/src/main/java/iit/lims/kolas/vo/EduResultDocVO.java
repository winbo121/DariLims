package iit.lims.kolas.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class EduResultDocVO extends WorkVO{
	
	private String edu_doc_no, file_nm, doc_nm;
	private byte[] att_file;
	private MultipartFile edu_file;
	public String getEdu_doc_no() {
		return edu_doc_no;
	}
	public void setEdu_doc_no(String edu_doc_no) {
		this.edu_doc_no = edu_doc_no;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getDoc_nm() {
		return doc_nm;
	}
	public void setDoc_nm(String doc_nm) {
		this.doc_nm = doc_nm;
	}
	public byte[] getAtt_file() {
		return att_file;
	}
	public void setAtt_file(byte[] att_file) {
		this.att_file = att_file;
	}
	public MultipartFile getEdu_file() {
		return edu_file;
	}
	public void setEdu_file(MultipartFile edu_file) {
		this.edu_file = edu_file;
	}
}
