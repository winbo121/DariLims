package iit.lims.kolas.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class KolasDocVO extends WorkVO {
	
	private String doc_type, doc_title, etc, create_dept;
	private String file_no, file_nm, add_file_nm;
	private byte[] att_file;
	private MultipartFile kolas_file;

	public String getCreate_dept() {
		return create_dept;
	}

	public void setCreate_dept(String create_dept) {
		this.create_dept = create_dept;
	}

	public byte[] getAtt_file() {
		return att_file;
	}

	public void setAtt_file(byte[] att_file) {
		this.att_file = att_file;
	}

	public MultipartFile getKolas_file() {
		return kolas_file;
	}

	public void setKolas_file(MultipartFile kolas_file) {
		this.kolas_file = kolas_file;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getFile_nm() {
		return file_nm;
	}

	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}

	public String getAdd_file_nm() {
		return add_file_nm;
	}

	public void setAdd_file_nm(String add_file_nm) {
		this.add_file_nm = add_file_nm;
	}

	public String getDoc_type() {
		return doc_type;
	}

	public void setDoc_type(String doc_type) {
		this.doc_type = doc_type;
	}

	public String getDoc_title() {
		return doc_title;
	}

	public void setDoc_title(String doc_title) {
		this.doc_title = doc_title;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}	

}
