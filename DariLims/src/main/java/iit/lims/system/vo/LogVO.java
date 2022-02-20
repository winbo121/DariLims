package iit.lims.system.vo;


public class LogVO extends UserVO {
	private String log_id, user_ip, user_login_date, user_logout_date, rNum;
	
	private int pageNo, lastIndex, firstIndex, recordCountPerPage;

	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	public String getUser_ip() {
		return user_ip;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	public String getUser_login_date() {
		return user_login_date;
	}

	public void setUser_login_date(String user_login_date) {
		this.user_login_date = user_login_date;
	}

	public String getUser_logout_date() {
		return user_logout_date;
	}

	public void setUser_logout_date(String user_logout_date) {
		this.user_logout_date = user_logout_date;
	}

	public String getrNum() {
		return rNum;
	}

	public void setrNum(String rNum) {
		this.rNum = rNum;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	
}
