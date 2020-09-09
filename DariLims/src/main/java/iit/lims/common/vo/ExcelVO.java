package iit.lims.common.vo;

import java.util.ArrayList;

public class ExcelVO {
	private String gridData;
	private ArrayList<String[]> label;
	private ArrayList<String[]> label_sub;
	private ArrayList<ArrayList<String>> data;
	private ArrayList<String[]> foot;

	public ArrayList<String[]> getFoot() {
		return foot;
	}

	public void setFoot(ArrayList<String[]> foot) {
		this.foot = foot;
	}

	public String getGridData() {
		return gridData;
	}

	public void setGridData(String gridData) {
		this.gridData = gridData;
	}

	public ArrayList<String[]> getLabel() {
		return label;
	}

	public void setLabel(ArrayList<String[]> label) {
		this.label = label;
	}

	public ArrayList<String[]> getLabel_sub() {
		return label_sub;
	}

	public void setLabel_sub(ArrayList<String[]> label_sub) {
		this.label_sub = label_sub;
	}

	public ArrayList<ArrayList<String>> getData() {
		return data;
	}

	public void setData(ArrayList<ArrayList<String>> data) {
		this.data = data;
	}

}
