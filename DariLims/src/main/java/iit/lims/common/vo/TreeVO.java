package iit.lims.common.vo;

import java.util.ArrayList;

public class TreeVO {
	private String key, title;
	private Boolean folder;
	private Boolean expanded;
	private ArrayList<TreeVO> children;
	
	/* 권한 */
	private String auth_select;
	private String auth_save;

	private String refKey;

	public String getRefKey() {
		return refKey;
	}

	public void setRefKey(String refKey) {
		this.refKey = refKey;
	}

	public Boolean getExpanded() {
		return expanded;
	}

	public void setExpanded(Boolean expanded) {
		this.expanded = expanded;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Boolean getFolder() {
		return folder;
	}

	public void setFolder(Boolean folder) {
		this.folder = folder;
	}

	public ArrayList<TreeVO> getChildren() {
		return children;
	}

	public void setChildren(ArrayList<TreeVO> children) {
		this.children = children;
	}

	public String getAuth_select() {
		return auth_select;
	}

	public void setAuth_select(String auth_select) {
		this.auth_select = auth_select;
	}

	public String getAuth_save() {
		return auth_save;
	}

	public void setAuth_save(String auth_save) {
		this.auth_save = auth_save;
	}

	
}
