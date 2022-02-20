package iit.lims.master.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class DocumentVO extends WorkVO {
	private String form_seq, form_title, form_type, doc_seq, doc_revision_seq, doc_revision_date, file_nm, etc, form_name;
	private MultipartFile mul_file_att;
	private byte[] file_att;
	
	public String getForm_name() {
		return form_name;
	}
	public void setForm_name(String form_name) {
		this.form_name = form_name;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getForm_seq() {
		return form_seq;
	}
	public void setForm_seq(String form_seq) {
		this.form_seq = form_seq;
	}
	public String getForm_title() {
		return form_title;
	}
	public void setForm_title(String form_title) {
		this.form_title = form_title;
	}
	public String getForm_type() {
		return form_type;
	}
	public void setForm_type(String form_type) {
		this.form_type = form_type;
	}
	public String getDoc_seq() {
		return doc_seq;
	}
	public void setDoc_seq(String doc_seq) {
		this.doc_seq = doc_seq;
	}
	public String getDoc_revision_seq() {
		return doc_revision_seq;
	}
	public void setDoc_revision_seq(String doc_revision_seq) {
		this.doc_revision_seq = doc_revision_seq;
	}
	public String getDoc_revision_date() {
		return doc_revision_date;
	}
	public void setDoc_revision_date(String doc_revision_date) {
		this.doc_revision_date = doc_revision_date;
	}
	public byte[] getFile_att() {
		return file_att;
	}
	public void setFile_att(byte[] file_att) {
		this.file_att = file_att;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public MultipartFile getMul_file_att() {
		return mul_file_att;
	}
	public void setMul_file_att(MultipartFile mul_file_att) {
		this.mul_file_att = mul_file_att;
	}
}