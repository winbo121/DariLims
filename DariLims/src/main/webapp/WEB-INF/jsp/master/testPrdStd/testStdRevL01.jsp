
<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 프로토콜
	 * 파일명 	: testStdRevL01.jsp
	 * 작성자 	: 최은향
	 * 작성일 	: 2015.12.22
	 * 설  명	: 검사기준관리 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.22    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.not-editable-cell {
	background-color: gray;
}

/* 한글우선입력 */
.imeon input {
	ime-mode: active;
}
</style>
<script type="text/javascript">
var fnGridInit = false;
var unit_cd;
var oxide_cd;

$(function() {
	/* 세부권한검사 */
	fn_auth_check();
	
	ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "allPrdForm");
	ajaxCombo('result_type', 'C31', 'ALL', '');
	ajaxCombo('unit_cd', 'C08', 'ALL', '');
	ajaxComboForm('unit_cd', 'C08', 'ALL', 'resultDetailForm');
	

	unit_cd = fnGridCommonCombo('C08', null);
	oxide_cd = fnGridCommonCombo('oxide_cd', null);

	prdGrid('master/selectStdTestPrdList.lims', 'allPrdForm', 'allPrdGrid');
	itemGrid('master/selectStdTestPrdItemList.lims', 'testPrdStdRevGridForm', 'testPrdStdRevGrid');

	//그리드 사이즈 
	$(window).bind('resize', function() {
		$("#allPrdGrid").setGridWidth($('#sub_purple_01').width(), false);
	}).trigger('resize');
	$(window).bind('resize', function() {
		$("#testPrdStdRevGrid").setGridWidth($('#sub_blue_01').width(), false);
	}).trigger('resize');
	
	//엔터이벤트
	fn_Enter_Search('allPrdForm', 'allPrdGrid');
	$('#testPrdStdRevGrid').clearGridData(); // 최초 조회시 데이터 안나옴
});

// 품목 그리드
function prdGrid(url, form, grid) {	
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fn_GridData(url, form, grid);
		},
		height : '540',
		rowNum : -1,
		rownumbers : true,
		autowidth : false,
		gridview : false,
		shrinkToFit : true,
		viewrecords : true,
		scroll : true,
		colModel : [ {
			type : 'not',
			label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
			name : 'chk',
			width : '40',
			sortable : false,
			align : 'center',
			formatter : "checkbox",
			formatoptions : {
				disabled : false
			},
			frozen : true
		}, {
			label : '품목코드',
			name : 'prdlst_cd',
			key : true,
			hidden : true
		}, {
			label : '품목분류',
			width : '150',
			align : 'center',
			name : 'htrk_prdlst_nm'
		}, {
			label : '품목한글명',
			width : '150',
			name : 'kor_nm'
		}, {
			label : '품목영문명',
			width : '200',
			name : 'eng_nm'
		}],
		gridComplete : function(data) {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
		},			
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			$("#testPrdStdRevGridForm").find("#prdlst_cd").val(row.prdlst_cd);
			$("#testPrdStdRevGridForm").find("#prdlst_nm").val(row.kor_nm);
			btn_Search_onclick(1);
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
		}
	});
}

function itemGrid(url, form, grid) {
	var lastRowId = 0;
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridData(url, form, grid);
		},
		height : '490',
		autowidth : false,
		loadonce : true,
		mtype : "POST",
		gridview : true,
		shrinkToFit : false,
		rowNum : -1,
		rownumbers : true,
		colModel : [{
			type : 'not',
			label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
			name : 'chk',
			width : '40',
			sortable : false,
			align : 'center',
			formatter : "checkbox",
			formatoptions : {
				disabled : false
			},
			frozen : true
		}, {
			type : 'not',
			label : ' ',
			name : 'icon',
			width : '20',
			align : 'center',
			frozen : true
		}, {
			label : 'crud',
			name : 'crud',
			hidden : true,
			frozen : true
		}, {
			label : 'indv_spec_seq',
			name : 'indv_spec_seq',
			hidden : true
		}, {
			label : 'prdlst_cd',
			name : 'prdlst_cd',
			hidden : true,
			width : '250'
		}, {
			label : '시험항목코드',
			name : 'test_item_cd',
			width : '100'
		}, {
			label : '대분류',
			name : 'testitm_lclas_nm',
			width : '100'
		}, {
			label : '중분류',
			name : 'testitm_mlsfc_nm',
			width : '100'
		}, {
			label : '항목명',
			name : 'test_item_nm',
			width : '150'
		}, {
			label : 'indv_spec_seq',
			name : 'indv_spec_seq',
			hidden : true
		}, {
			label : '정렬순서',
			name : 'item_order',
			width : '70',
			editable : true
		}, {
			label : '단위',
			classes : 'unit',
			name : 'unit_cd',
			sortable : false,
			width : '100',
			editable : true,
			edittype : "select",
			editoptions : {
				value : unit_cd
			},
			formatter : 'select'
		}, {
			label : 'test_method_no',
			name : 'test_method_no',
			classes : 'test_method_no',
			hidden : true
		}, {
			type : 'not',
			label : '시험방법',
			name : 'test_method_nm',
			classes : 'test_method_nm'
		}, {
			type : 'not',
			label : ' ',
			name : 'test_method_pop',
			sortable : false,
			width : '20',
			align : 'center',
			formatter : imageFormat
		}, {
			type : 'not',
			label : ' ',
			name : 'test_method_del',
			sortable : false,
			width : '20',
			align : 'center',
			formatter : deleteImageFormat
		}, {
			label : '산화물측정방법',
			name : 'oxide_cd',
			editable : true,
			edittype : "select",
			width : '300',
			hidden : true,
			editoptions : {
				value : oxide_cd
			},
			formatter : 'select'
		} ],
		emptyrecords : '데이터가 존재하지 않습니다.',
		gridComplete : function() {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
				return 'stop';
			}
		},
		beforeSelectRow : function(rowId, e) {
			if (rowId && rowId != lastRowId) {
				if (!valiCheck(lastRowId))
					return 'stop';
			}
			return true;
		},
		onCellSelect : function(rowId, iCol, cellcontent, e) {
			var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
			var col = colArr[iCol].name;
			var row = $('#' + grid).getRowData(rowId);
			
			if (col == 'test_method_pop') {
				fnpop_testMethodPop(grid, '900', '500', rowId);
				
			} else if (col == 'test_method_del') {
				$('#' + grid).jqGrid('setCell', rowId, 'test_method_nm', null);
				$('#' + grid).jqGrid('setCell', rowId, 'test_method_no', null);
			}
		},
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			$("#fnprtItemGridForm").find("#prdlst_cd").val(row.prdlst_cd);
			$("#fnprtItemGridForm").find("#prdlst_nm").val(row.prdlst_nm);
			$("#fnprtItemGridForm").find("#indv_spec_seq").val(row.indv_spec_seq);
			
			if (rowId && rowId != lastRowId) {
				fnEditRelease(grid);
				lastRowId = rowId;
			}
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
			fnEditRelease(grid);
			fnGridEdit(grid, rowId, fnRowClick);
			testPrdStdRevGridEdit(grid, rowId);
			
			var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
			$('#' + rowId + '_' + colArr[iCol].name).focus();
		}
	});
}

//품목 조회
function btn_Select_Sub_onclick() {
	$('#allPrdGrid').setGridParam({page: 1});
	$('#allPrdGrid').trigger('reloadGrid');
}

function fnRowClick(rowId) {
	var grid = 'testPrdStdRevGrid';
	$('#' + grid).setCell(rowId, 'chk', 'Yes');
}

// 시험방법 선택 팝업 콜백
function fnpop_methodCallback(rowId){
	fnBasicEndLoading();
	var grid = 'testPrdStdRevGrid';
	fnEditRelease(grid);
	testPrdStdRevGridEdit(grid, rowId);
}

//에디트모드
function testPrdStdRevGridEdit(grid, rowId) {
	var row = $('#' + grid).getRowData(rowId);
	if (row.crud != 'n') {
		$('#' + grid).setCell(rowId, 'icon', gridU);
		$('#' + grid).setCell(rowId, 'crud', 'u');
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
	}
}

//업데이트 아이콘 생성
function testPrdStdRevGridEditCell(grid, rowId) {
	var row = $('#' + grid).getRowData(rowId);
	if (row.crud != 'n') {
		$('#' + grid).setCell(rowId, 'icon', gridU);
		$('#' + grid).setCell(rowId, 'crud', 'u');
	}
}

// 셀 수정 여부
function editable(grid, e) {
	var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
	var arr = new Array();
	
	// 결과값형태
	var row = $("#" + grid).jqGrid('getRowData', rowId);
	if (e != '') {
		fnEditRelease(grid);
	}
	
	for ( var column in row) {
		if ($.inArray(column, arr) !== -1) {
			$("#" + grid).jqGrid('setColProp', column, {
				editable : true
			});
		} else {
			$("#" + grid).jqGrid('setColProp', column, {
				editable : false
			});
		}
	}
	if (e != '') {
		for ( var column in row) {
			if (column != 'prdlst_cd' && column != 'prdlst_nm' && column != 'test_item_nm' 
				&& column != 'test_item_cd' && column != 'crud' && column != 'icon' && column != 'indv_spec_seq')
				$("#" + grid).jqGrid('setCell', rowId, column, null);
		}
	}
	$("#" + grid).jqGrid('editRow', rowId);
}

// 조회버튼 클릭 이벤트
function btn_Search_onclick(type) {
	fnEditRelease('testPrdStdRevGrid');
	$('#testPrdStdRevGrid').trigger('reloadGrid');
	$("#fnprtItemGridForm").find("#prdlst_cd").val("");
	$("#fnprtItemGridForm").find("#prdlst_nm").val("");
	$("#fnprtItemGridForm").find("#indv_spec_seq").val("");
	btn_Search2_onclick(1);
}

function btn_Search2_onclick(type) {
	$('#testPrdStdRevGrid').trigger('reloadGrid');
}		

// 저장버튼 클릭이벤트
function btn_Update_onclick(grid) {
	var ids = $('#' + grid).jqGrid("getDataIDs");		
	for ( var i in ids ) {
		var row = $('#' + grid).getRowData(ids[i]);
		if (!valiCheck(ids[i]))
			return;
		fnEditRelease(grid);
	}
	
	if (ids.length < 1) {
		$.showAlert("시험항목 목록이 존재하지 않습니다.");
		return;
	}

	if (!editCount(grid)) {
		alert("변경된 시험항목 목록이 없습니다.");
		return;
	}
	
	var data = fnGetGridAllData(grid);
	var json = fnAjaxAction('master/insertStdPrdTestItem.lims', data);
	if (json == null) {
		$.showAlert("저장 실패하였습니다.");
	} else {
		$.showAlert("", {
			type : 'insert'
		});
		btn_Search2_onclick(2);
	}
}

// 복사버튼 클릭이벤트
function btn_copy_onclick() {
	var cnt = 0;
	var ids = $('#allPrdGrid').jqGrid("getDataIDs");
	var prdlst_cd;
	for ( var i in ids ) {
		var row = $('#allPrdGrid').getRowData(ids[i]);
		if (row.chk == 'Yes'){
			prdlst_cd = row.prdlst_cd;
			cnt++;
		}
	}
	
	if(cnt == 0){
		$.showAlert("복사대상 품목을 체크해주세요.");
		return;
	}else if(cnt > 1){
		$.showAlert("복사대상 품목을 하나만 체크해주세요.");
		return;
	}
	
	var rowId = $('#allPrdGrid').jqGrid('getGridParam', "selrow");
	var row = $('#allPrdGrid').getRowData(rowId);
	
	if(rowId == null){
		$.showAlert("복사되는 품목을 선택해주세요.");
		return;
	}
	
	if(prdlst_cd == row.prdlst_cd){
		$.showAlert("동일 품목은 복사가 안됩니다.");
		return;
	}
	
	if (!confirm("복사되는 품목 프로토콜에 있는 항목은 사라집니다. 복사하시겠습니까?")) {
		return;
	}
	
	var data = 'prdlst_cd='+prdlst_cd + '&copy_prdlst_cd='+row.prdlst_cd;
	
	var json = fnAjaxAction('master/copyStdTestPrdItem.lims', data);
	if (json == null) {
		$.showAlert("복사 실패하였습니다.");
	} else {
		$.showAlert("", {
			type : 'insert'
		});
		btn_Search_onclick(2);
	}	
}

// 시험항목추가 팝업
function btn_Add_onclick(form) {
	var prdlst_cd = $("#"+form).find("#prdlst_cd").val();
	var prdlst_nm = $("#"+form).find("#prdlst_nm").val();
	var indv_spec_seq = $("#"+form).find("#indv_spec_seq").val();
	
	if(form == "testPrdStdRevGridForm"){
		if(prdlst_cd == "" || prdlst_nm == ""){
			alert("품목을 선택해야 합니다.");
			return;
		}
	}else{
		if(prdlst_cd == "" || prdlst_nm == "" || indv_spec_seq == ""){
			alert("기준규격을 선택해야 합니다.");
			return;
		}
	}
	param =  prdlst_cd + "◆★◆" + prdlst_nm + "◆★◆" + indv_spec_seq;

	var url = "master/testPrdStdItemChoice.lims";
	var height = "867";
	var width = "1000";
	var option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, top=50%, left=50%, width=" + width + 'px, height=' + height +'px' ;
	openPopup = window.open(url, param, option);

	fnBasicStartLoading();
}

// 자식 -> 부모창 함수 호출
function fnpop_callback(returnParam){
	btn_Search_onclick(1);
	fnBasicEndLoading();
}

// 시험 항목 삭제 버튼 클릭
function btn_Delete_onclick(grid) {
	var rows = $('#testPrdStdRevGrid').jqGrid('getDataIDs');
	if (rows == null) {
		alert('항목을 체크해주세요.');
	}
	else if (!confirm("삭제하시겠습니까?")) {
		return false;
	}
	else {
		for (var i=0; i<rows.length; i++) {
			var rowId = rows[i];
		    var rowData = jQuery('#testPrdStdRevGrid').jqGrid ('getRowData', rowId);
		    
		    if(rowData.chk == "Yes") {
		    	var url = "/master/deleteProtocolItem.lims";
				var result = fnAjaxAction(url,rowData);
		    }
		}
		alert("삭제되었습니다.");
		fnEditRelease('testPrdStdRevGrid');
		$('#testPrdStdRevGrid').trigger('reloadGrid');
		
	}
}

// 삭제실행
function GridDeleteMultiLine(grid) {		
	var ids = $('#' + grid).jqGrid("getDataIDs");
	if (ids.length > 0) {
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				if (row.crud != 'n') {
					$('#' + grid).setCell(ids[i], 'icon', gridD);
					$('#' + grid).setCell(ids[i], 'crud', 'd');
					$('#' + grid).setCell(ids[i], 'chk', 'No');
				} else {
					$('#' + grid).jqGrid('delRowData', ids[i]);
				}
			}
		}
	}
}

// 기준값 validation체크
function valiCheck(rowId) {
	var check = true;
	return check;
}

//시험방법
function btn_search_onclick(div){
	var grid = 'resultDetailForm';
	fnpop_methodPop('', '900', '500', '', '', grid);
	fnBasicStartLoading();		
} 

//시험방법 삭제
function fn_TextClear(textId) {
	if ($("#" + textId) != null) {
		$("#" + textId).val('');
	}
}

//일괄입력
function btn_testMethodVal_onclick() {
	var grid = 'testPrdStdRevGrid';
	var ids = $('#' + grid).jqGrid("getDataIDs");
	var rowCnt = 0;
	
	for ( var i in ids) {
		var row = $('#' + grid).getRowData(ids[i]);
		if (row.chk == 'Yes') {
			rowCnt++;
		}
	}
	
	if (rowCnt == 0) {
		alert("선택된 항목이 없습니다.");
		return;
	} else {
		var unit_cd = $('#resultDetailForm').find('#unit_cd').val();
		var test_method_nm = $('#resultDetailForm').find('#test_method_nm').val();
		var test_method_no = $('#resultDetailForm').find('#test_method_no').val();
		
		if(unit_cd == '' && test_method_no == ''){
			alert("일괄입력 정보를 선택하여주세요.");
			return;	
		}
		
		var nids = $('#' + grid).jqGrid("getDataIDs");
		for ( var j in nids) {
			var nrow = $('#' + grid).getRowData(nids[j]);
			if (nrow.chk == 'Yes') {
				$('#' + grid).jqGrid('setCell', ids[j], 'unit_cd', unit_cd);
				$('#' + grid).jqGrid('setCell', ids[j], 'test_method_nm', test_method_nm);
				$('#' + grid).jqGrid('setCell', ids[j], 'test_method_no', test_method_no);
				$('#' + grid).jqGrid('setCell', ids[j], 'icon', gridU);
				$('#' + grid).jqGrid('setCell', ids[j], 'crud', 'u');
			}
		}
		
	}
}

//기준별 시험항목 목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
function editCount(grid) {
	var check = false;
	var ids = $('#' + grid).jqGrid("getDataIDs");
	for ( var i in ids) {
		var row = $('#' + grid).getRowData(ids[i]);
		if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
			check = true;
	}
	return check;
}

</script>
<div class="sub_purple_01 w35p">
<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
	<table width="100%" border="0" class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				품목 목록
			</td>
			<td class="table_button" style="text-align: right;">
				<span class="button white mlargeg auth_save" id="btn_copy" onclick="btn_copy_onclick();">
					<button type="button">복사</button>
				</span>
				<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub_onclick();">
					<button type="button">조회</button>
				</span>
			</td>
		</tr>
	</table>
	<!-- 조회 테이블 -->
	<table  class="list_table" >
		<tr>
			<th>품목구분</th>
			<td>
				<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
			</td>
		</tr>
		<tr>
			<th>품목명</th>
			<td>
				<input type="text" name="kor_nm"/>
			</td>
		</tr>
		<tr style='display:none;'>
			<th>식약처기준 여부</th>
			<td>
				<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px" />예</label>
				<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
			</td>
		</tr>
	</table>
	<input type="hidden" id="prdlst_yn" name="prdlst_yn" value='Y'>
	<input type="hidden" id="use_yn" name="use_yn" value='Y'>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type='hidden' id='pageNum' name='pageNum'/>
	<input type='hidden' id='pageSize' name='pageSize'/>
	<input type='hidden' id='sortTarget' name='sortTarget'/>
	<input type='hidden' id='sortValue' name='sortValue'/>
	<div id="view_grid_prd">
		<table id="allPrdGrid"></table>
		<div id="gridPrdLstPopPager"></div>
	</div>
</form>
</div>

<div class="w5p"></div>

<div class="sub_blue_01 w60p" style="margin-top:0px; height: 300px;">
	<div class="sub_blue_01" >
		<form id="testPrdStdRevGridForm" name="testPrdStdRevGridForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시험항목 목록
				</td>
				<td class="table_button" style="text-align: right;">
					<span class="button white mlargep auth_save" id="btn_Add1" onclick="btn_Add_onclick('testPrdStdRevGridForm');">
						<button type="button">시험항목추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Del1" onclick="btn_Delete_onclick('testPrdStdRevGrid');">
						<button type="button">시험항목삭제</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Ins1" onclick="btn_Update_onclick('testPrdStdRevGrid');">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	
		<div id="view_grid_rev">
			<table id="testPrdStdRevGrid"></table>
		</div>
		<input type="hidden" id="prdlst_cd" name="prdlst_cd">
		<input type="hidden" id="prdlst_nm" name="prdlst_nm">
		<input type="hidden" id="indv_spec_seq" name="indv_spec_seq">
		<input type="hidden" id="sort_name" name="sort_name">
		<input type="hidden" id="sort_type" name="sort_type">
		</form>
	</div>

	<div style="clear:both; padding-top:10px; text-align:center;">
	</div>
	<div class="sub_purple_01 ">
	<form id="resultDetailForm" name="resultDetailForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					일괄입력
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_select" id="btn_insertItemVal" onclick="btn_testMethodVal_onclick();">
						<button type="button">일괄입력</button>
					</span>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table">
			<tr>
				<th>단위</th>
				<td>
					<select name="unit_cd" id="unit_cd" class="w100px"></select>
				</td>
 				<th id="test_method">시험방법</th>
				<td>
					<input name="test_method_no" id="test_method_no" type="hidden" />
					<input name="test_method_nm" id="test_method_nm" type="text" class="w120px inputhan" " />
					<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_method_serach" onclick="btn_search_onclick('method');"/>
					<img src="<c:url value='images/common/icon_stop.png'/>" id="test_method_del" style="cursor: pointer;" onClick='fn_TextClear("test_method_nm")' />
				</td> 

			</tr>
		</table>
	</form>
	</div>
</div>
