package iit.lims.system.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.common.vo.PagingVO;

public class BoardVO extends PagingVO {
	
	private String board_no, title, contents, pre_board_no, file_nm, pre_board_no_flag, board_type, pre_file_nm;	
	private byte[] add_file;
	private MultipartFile m_file;
	
	
	public String getPre_file_nm() {
		return pre_file_nm;
	}
	
	public void setPre_file_nm(String pre_file_nm) {
		this.pre_file_nm = pre_file_nm;
	}
	
	public String getBoard_no() {
		return board_no;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getPre_board_no() {
		return pre_board_no;
	}

	public void setPre_board_no(String pre_board_no) {
		this.pre_board_no = pre_board_no;
	}

	public String getFile_nm() {
		return file_nm;
	}

	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
		
	public String getPre_board_no_flag() {
		return pre_board_no_flag;
	}

	public void setPre_board_no_flag(String pre_board_no_flag) {
		this.pre_board_no_flag = pre_board_no_flag;
	}

	public byte[] getAdd_file() {
		return add_file;
	}

	public void setAdd_file(byte[] add_file) {
		this.add_file = add_file;
	}

	public MultipartFile getM_file() {
		return m_file;
	}

	public void setM_file(MultipartFile m_file) {
		this.m_file = m_file;
	}	

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}	
}
