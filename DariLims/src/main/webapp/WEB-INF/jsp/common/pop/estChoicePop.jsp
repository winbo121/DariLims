
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 견적조회(팝업)
	 * 파일명 		: estChoicePop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.09.30
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.30    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>

<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;

	/* var est_fee_gubun; */
	
	var est_state;
	var est_gubun;
	var mtlr_mst_no;
	
	var user_id;
	var user_dept;
	var deptNm;
	var userNm;
	var deptcd;
	var state;
	
	$(function() {
		/* 달력 셋팅 */
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		arr = popupName.split("★●★");
		est_state = fnGridCommonCombo('C39', null);
/* 		est_fee_gubun = fnGridCombo('est_fee', null); */
		ajaxComboForm("est_gubun", "C57", "", "", "estimateForm");
		ajaxComboForm("est_state", "C58", "", "", "estimateForm");
		ajaxComboForm("orgType", "C24", "ALL", "", "estimateOrgForm");

		user_id = '${session.user_id}';
		user_dept = '${session.dept_cd}';
		deptNm = '${session.dept_nm}';
		userNm = '${session.user_nm}';
		fnDatePickerImg('batchDate');
		
		// 업체 목록
		estimateOrgGrid('selectReqOrgList.lims', 'estimateOrgForm', 'estimateOrgGrid');		
		// 견적 목록
		estimateGrid('selectEstimateList.lims', 'estimateForm', 'estimateGrid');				
		// 견적 항목 목록
		estimateItemGrid('selectEstimateItemList.lims', 'estimateItemForm', 'estimateItemGrid');
		// 견적 항목 수수료 목록		
		estimateItemFeeGrid('selectEstimateItemFeeList.lims', 'estimateItemForm', 'estimateItemFeeGrid');
		
	 	//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#estimateOrgGrid").setGridWidth($('#view_grid_top').width(), true); 
		    $("#estimateGrid").setGridWidth($('#view_grid_main').width(), true); 
			$("#estimateItemGrid").setGridWidth($('#view_grid_sub').width(), true);
			$("#estimateItemFeeGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('estimateOrgForm', 'estimateOrgGrid');
		fn_Enter_Search('estimateForm', 'estimateGrid');
		
	});
	
	// 업체 목록
	function estimateOrgGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '565',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'req_org_no',
				name : 'req_org_no',
				hidden : true,
				key : true
			}, {
				label : '업체명',
				name : 'org_nm',
				width : '150'
			}, {
				label : '업체구분',
				name : 'org_type',
				align : 'center',
				width : '100'
			}, {
				label : '대표전화',
				name : 'pre_tel_num',
				hidden : true,
				width : '100'
			}, {
				label : '담당자',
				name : 'req_nm',
				align : 'center',
				width : '80'
			}, {
				label : '담당자전화번호',
				name : 'charger_tel',
				hidden : true,
				width : '100'
			}, {
				label : '설명',
				name : 'org_desc',
				hidden : true,
				width : '300'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#estimateForm").find("#est_org_no").val(rowId);
				$("#estimateGrid").trigger('reloadGrid');
				btn_Search_sub_onclick();
			}
		});
	}
	
	// 견적서 목록
	function estimateGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '200',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '견적번호',
				name : 'est_no',
				align : 'center',
				width : '80',
				hidden : true,
				key : true
			}, {
				label : '진행상태',
				name : 'est_state_nm',
				align : 'center',
				width : '80'
			}, {
				label : '견적구분',
				name : 'est_gubun',
				align : 'center',
				hidden : true,
				width : '80'
			}, {
				label : '견적구분',
				name : 'est_gubun_nm',
				align : 'center',
				width : '80'
			}, {
				label : '견적업체',
				name : 'est_org_nm',
				hidden : true,
				align : 'center',
				width : '100'
			}, {
				label : '견적제목',
				name : 'est_title',
				width : '200'
			}, {				
				label : '견적일',
				name : 'est_date',
				align : 'center',
				width : '80'
			}, {
				label : '견적신청인',
				name : 'est_charger_nm',
				align : 'center',
				hidden : true,
				width : '80'
			}, {
				label : '견적작성자',
				name : 'creater_id',
				align : 'center',
				hidden : true,
				width : '80'
			}, {
				label : 'est_fee_tot',
				name : 'est_fee_tot',
				hidden : true
			}],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
// 				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {	
					lastRowId = rowId;
					var est_gubun = $('#estimateGrid').jqGrid('getCell', rowId, 'est_gubun');
					//var param = 'est_no=' + rowId+ "&est_gubun="+est_gubun;
					$("#estimateItemForm").find("#est_no").val(rowId);
					$("#estimateItemForm").find("#est_gubun").val(est_gubun);
					$("#estimateItemGrid").trigger('reloadGrid');
					$("#estimateItemFeeGrid").trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				// 선택
				btn_Est_Choice_Onclick(grid);
			}
		});
	}
	
	// 견적서별 항목 목록
	function estimateItemGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '100',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : '견적번호',
				name : 'est_no',
				width : '100',
				hidden : true
			}, {
				label : '견적항목번호',
				name : 'est_item_no',
				hidden : true,
				width : '80',
				key : true
			}, {
				label : '견적항목명',
				name : 'test_item_nm',
				width : '160'
			}, {
				label : '견적항목코드',
				name : 'test_item_cd',
				align : 'center',
				hidden : true
			}, {
				label : '규격',
				name : 'est_item_spec',
				editable : true,
				width : '100'
			}, {
				label : '수량',
				width : '80',
				editable : true,
				align : 'right',
				formatter: 'number',
				formatoptions: { thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' }, 
				name : 'est_qty'
			}, {
				label : '단가(원)',
				width : '80',
				align : 'right',
				editable : true,
				formatter: 'currency', 
				formatoptions: { thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_price'
			}, {
				label : '합계(원)',
				width : '100',
				editable : true,
				align : 'right',
				formatter: 'currency', 
				formatoptions: { prefix: '\\', suffix: '', thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_price_total'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}			
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}
	
	// 항목수수료목록
	function estimateItemFeeGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '100',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : '견적번호',
				name : 'est_no',
				width : '100',
				hidden : true
			}, {
				label : '견적항목번호',
				name : 'est_fee_no',
				hidden : true,
				width : '80',
				key : true
			}, {
				label : '견적항목명',
				name : 'est_fee_nm',
				width : '160'
/* 				editable : true,
				edittype : "select",
				editoptions : {
					value : est_fee_gubun
				},
				formatter : 'select' */
			}, {
				label : '단가(원)',
				width : '80',
				align : 'right',
				editable : true,
				formatter: 'currency', 
				formatoptions: { thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_fee_price'
			}, {
				label : '비고',
				name : 'est_fee_desc',
				editable : true,
				width : '200'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}			
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease(grid);
				/*fnGridEdit(grid, rowId, ""); */
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease('estimateItemFeeGrid');
				var grid = 'estimateItemFeeGrid';
				fnGridEdit(grid, rowId, null);
			}
		});
	}
	
	// 업체 조회버튼 클릭 이벤트
	function btn_Search_onclick() {		
		$('#estimateOrgGrid').trigger('reloadGrid');
		$("#estimateForm").find("#est_org_no").val("");
		$("#estimateItemForm").find("#dept_cd").val("");
		$("#estimateItemForm").find("#est_no").val("");
		$("#estimateItemForm").find("#est_gubun").val("");
		$('#estimateGrid').trigger('reloadGrid');
		$("#estimateItemGrid").trigger('reloadGrid');
		$("#estimateItemFeeGrid").trigger('reloadGrid');
	}
	
	// 서브 조회버튼 클릭 이벤트
	function btn_Search_sub_onclick() {	
		$('#estimateGrid').trigger('reloadGrid');
		$("#estimateItemForm").find("#dept_cd").val("");
		$("#estimateItemForm").find("#est_no").val("");
		$("#estimateItemForm").find("#est_gubun").val("");		
		$("#estimateItemGrid").trigger('reloadGrid');
		$("#estimateItemFeeGrid").trigger('reloadGrid');
	}

	// 선택시 이벤트
	function btn_Est_Choice_Onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);			
			// 부모창에 던져주기
			$(opener.document).find("#"+arr[0]+" #est_no").text(row.est_no); // 
			$(opener.document).find("#"+arr[0]+" #est_no").val(row.est_no); // 
			$(opener.document).find("#"+arr[0]+" #est_title").val(row.est_title); // 
			$(opener.document).find("#"+arr[0]+" #fee_tot").val(row.est_fee_tot); // 총 수수료
			$(opener.document).find("#"+arr[0]+" #tot").text(row.est_fee_tot); // 총 수수료
		
			opener.fnpop_estcallback();
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>견적조회</h2>		
			<div class="w35p">
				<form id="estimateOrgForm" name="estimateOrgForm" onsubmit="return false;">
					<div class="sub_purple_01">
					<table class="select_table" >
						<tr>
							<td class="table_title">
								<span>■</span>
								업체목록
							</td>
							<td class="table_button">
								<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
									<button type="button">조회</button>
								</span>
							</td>
						</tr>
					</table>
					<table class="list_table" >
						<tr>
							<th>업체구분</th>
							<td>
								<select id="orgType" name="org_type" class='w150px'></select>
							</td>
						</tr>
						<tr>
							<th>업체명</th>
							<td>
								<input name="org_nm" type="text" class="inputhan" class='w150px' />
							</td>
						</tr>
					</table>
					</div>	
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_top">
						<table id="estimateOrgGrid"></table>
					</div>
				</form>
			</div>
			
			<div class="w60p" style="float:right;">
				<form id="estimateForm" name="estimateForm" onsubmit="return false;">
					<div class="sub_purple_01">
						<table  class="select_table" >
							<tr>
								<td class="table_title">
									<span>■</span>
									견적목록
								</td>
								<td class="table_button">
									<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_sub_onclick();">
										<button type="button">조회</button>
									</span>
									<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Est_Choice_Onclick('estimateGrid');">
										<button type="button">선택</button>
									</span>
									<span class="button white mlargep" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
								</td>
							</tr>
						</table>
						<table  class="list_table" >
							<tr>
								<th>진행상태</th>
								<td>
									<select name="est_state" id="est_state" class='w120px'></select>
								</td>
								<th>견적구분</th>
								<td>
									<select name="est_gubun" id="est_gubun" class='w120px'></select>
								</td>
							</tr>
							<tr>
								<th>견적제목</th>
								<td>
									<input name="est_title" type="text"  />
								</td>	
								<th>견적일자</th>
								<td>
									<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
									<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
									<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
									<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
								</td>
							</tr>
						</table>
					</div>	
					<input type="hidden" id="est_org_no" name="est_org_no">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_main">
						<table id="estimateGrid"></table>
					</div>
				</form>
				
				<form id="estimateItemForm" name="estimateItemForm" onsubmit="return false;">
					<div>
						<div class="sub_blue_01">
							<table  class="select_table" >
								<tr>
									<td class="table_title">
										<span>■</span>
										견적항목목록
									</td>
								</tr>
							</table>
						</div>				
						<input type="hidden" id="sortName" name="sortName">
						<input type="hidden" id="sortType" name="sortType">
						<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}">
						<input type="hidden" id="est_no" name="est_no" value="${detail.est_no}">
						<input type="hidden" id="est_gubun" name="est_gubun" value="${detail.est_gubun}">
						<div id="view_grid_sub1">
							<table id="estimateItemGrid"></table>
						</div>
					</div>
					
					<div>
						<div class="sub_blue_01">
							<table  class="select_table" >
								<tr>
									<td class="table_title">
										<span>■</span>
										항목수수료목록
									</td>
								</tr>
							</table>
						</div>
						<div id="view_grid_sub2">
							<table id="estimateItemFeeGrid"></table>
						</div>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</body>
</html>