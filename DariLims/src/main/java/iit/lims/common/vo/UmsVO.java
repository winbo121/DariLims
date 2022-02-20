package iit.lims.common.vo;

public class UmsVO {
	//제목
	private String subject;
	//내용
	private String send_msg;
	//발신자 회신번호
	private String callback;
	//수신자이름
	private String dest_name;
	//수신자번호
	private String dest_no;

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getSend_msg() {
		return send_msg;
	}

	public void setSend_msg(String send_msg) {
		this.send_msg = send_msg;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getDest_name() {
		return dest_name;
	}

	public void setDest_name(String dest_name) {
		this.dest_name = dest_name;
	}

	public String getDest_no() {
		return dest_no;
	}

	public void setDest_no(String dest_no) {
		this.dest_no = dest_no;
	}

}
