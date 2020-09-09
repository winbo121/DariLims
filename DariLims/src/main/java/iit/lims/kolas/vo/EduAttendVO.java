package iit.lims.kolas.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.WorkVO;

public class EduAttendVO extends WorkVO{
	
	private String dept_no, user_no;
	private String file_nm, doc_nm;
	private byte[] att_file;
	private MultipartFile edu_attend_file;

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

	public MultipartFile getEdu_attend_file() {
		return edu_attend_file;
	}

	public void setEdu_attend_file(MultipartFile edu_attend_file) {
		this.edu_attend_file = edu_attend_file;
	}

	public String getDept_no() {
		return dept_no;
	}

	public void setDept_no(String dept_no) {
		this.dept_no = dept_no;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

}
