package iit.lims.common.vo;


public class CommonVO {

	private String startDate, endDate;
	private String key;
	private String disp_order;
	private String use_flag;
	private String gridData;
	private String pageType;
	private String creater_id, create_date, updater_id, update_date;
	private String creater_nm;
	private String commission_flag;
	private String name, path, size;
	private String rtnVal;
	private String seqno, ip_address;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	

	private String cnt1, cnt2, cnt3, cnt4, cnt5, cnt6, cnt7, cnt11, cnt12, cnt13, cnt14, cnt15, cnt16;


	/*감사추적*/
	private String at_seq;
	private String menu_cd;
	private String at_state;
	private String at_cont;
	private String worker_id;
	
	/* GRID */
	private String sortName;
	private String sortType;
	
	/* 권한 */
	private String auth_select;
	private String auth_save;
	
	/* AUDIT */
	private String at_ip;
	
	
	/**
	 * <pre>
	 * 조회된 전체  정보에 대한 선언입니다.
	 * </pre>
	 */
	private Object rows ;
	/**
	 * <pre>
	 * 보여질 페이지   정보에 대한 선언입니다.
	 * </pre>
	 */
	private int pageNum;
	
	/**
	 * <pre>
	 * 보여질 페이지의 건수   정보에 대한 선언입니다.
	 * </pre>
	 */
	//private int pageSize;
	
	/**
	 * <pre>
	 * 조회된 row의 갯수  정보에 대한 선언입니다.
	 * </pre>
	 */
	private int row_num;
	
	/**
	 * <pre>
	 * 조회된 전체 갯수  정보에 대한 선언입니다.
	 * </pre>
	 */
	//private int totalCount;	
	
	/**
	 * <pre>
	 * 조회된 전체 페이지   정보에 대한 선언입니다.
	 * </pre>
	 */
	private int totalPage;
	
	/**
	 * <pre>
	 * 조회된 전체 갯수   정보에 대한 선언입니다.
	 * </pre>
	 */
	private int total;
	
	

	
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	public Object getRows() {
		return rows;
	}

	public void setRows(Object rows) {
		this.rows = rows;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	/*public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}*/

	public int getRow_num() {
		return row_num;
	}

	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}

	/*public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}*/

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getCreater_nm() {
		return creater_nm;
	}

	public void setCreater_nm(String creater_nm) {
		this.creater_nm = creater_nm;
	}

	public String getCnt1() {
		return cnt1;
	}

	public void setCnt1(String cnt1) {
		this.cnt1 = cnt1;
	}

	public String getCnt2() {
		return cnt2;
	}

	public void setCnt2(String cnt2) {
		this.cnt2 = cnt2;
	}

	public String getCnt3() {
		return cnt3;
	}

	public void setCnt3(String cnt3) {
		this.cnt3 = cnt3;
	}

	public String getCnt4() {
		return cnt4;
	}

	public void setCnt4(String cnt4) {
		this.cnt4 = cnt4;
	}

	public String getCnt5() {
		return cnt5;
	}

	public void setCnt5(String cnt5) {
		this.cnt5 = cnt5;
	}

	public String getCnt6() {
		return cnt6;
	}

	public void setCnt6(String cnt6) {
		this.cnt6 = cnt6;
	}

	public String getCnt7() {
		return cnt7;
	}

	public void setCnt7(String cnt7) {
		this.cnt7 = cnt7;
	}

	public String getCnt11() {
		return cnt11;
	}

	public void setCnt11(String cnt11) {
		this.cnt11 = cnt11;
	}

	public String getCnt12() {
		return cnt12;
	}

	public void setCnt12(String cnt12) {
		this.cnt12 = cnt12;
	}
	
	public String getCnt13() {
		return cnt13;
	}

	public void setCnt13(String cnt13) {
		this.cnt13 = cnt13;
	}

	public String getCnt14() {
		return cnt14;
	}

	public void setCnt14(String cnt14) {
		this.cnt14 = cnt14;
	}
	
	public String getCnt15() {
		return cnt15;
	}

	public void setCnt15(String cnt15) {
		this.cnt15 = cnt15;
	}

	public String getCnt16() {
		return cnt16;
	}

	public void setCnt16(String cnt16) {
		this.cnt16 = cnt16;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getDisp_order() {
		return disp_order;
	}

	public void setDisp_order(String disp_order) {
		this.disp_order = disp_order;
	}

	public String getUse_flag() {
		return use_flag;
	}

	public void setUse_flag(String use_flag) {
		this.use_flag = use_flag;
	}

	public String getGridData() {
		return gridData;
	}

	public void setGridData(String gridData) {
		this.gridData = gridData;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	public String getCreater_id() {
		return creater_id;
	}

	public void setCreater_id(String creater_id) {
		this.creater_id = creater_id;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getUpdater_id() {
		return updater_id;
	}

	public void setUpdater_id(String updater_id) {
		this.updater_id = updater_id;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public String getAt_seq() {
		return at_seq;
	}

	public void setAt_seq(String at_seq) {
		this.at_seq = at_seq;
	}

	public String getMenu_cd() {
		return menu_cd;
	}

	public void setMenu_cd(String menu_cd) {
		this.menu_cd = menu_cd;
	}

	public String getAt_state() {
		return at_state;
	}

	public void setAt_state(String at_state) {
		this.at_state = at_state;
	}

	public String getAt_cont() {
		return at_cont;
	}

	public void setAt_cont(String at_cont) {
		this.at_cont = at_cont;
	}

	public String getWorker_id() {
		return worker_id;
	}

	public void setWorker_id(String worker_id) {
		this.worker_id = worker_id;
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

	public String getAt_ip() {
		return at_ip;
	}

	public void setAt_ip(String at_ip) {
		this.at_ip = at_ip;
	}

	public String getCommission_flag() {
		return commission_flag;
	}

	public void setCommission_flag(String commission_flag) {
		this.commission_flag = commission_flag;
	}

	public String getRtnVal() {
		return rtnVal;
	}

	public void setRtnVal(String rtnVal) {
		this.rtnVal = rtnVal;
	}

	public String getSeqno() {
		return seqno;
	}

	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

	public String getIp_address() {
		return ip_address;
	}

	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}
}