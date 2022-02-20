
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험배정
	 * 파일명 		: resultAssignmentL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2016.01.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2016.01.26    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
input[type=text] {
	ime-mode: auto;
}
</style>
<script type="text/javascript">
	var bSubGridLoad = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");	
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", "ALLNAME", 'reqListForm');
		$("#dept_cd option").not(":selected").attr("disabled", "disabled");	
		
		acceptCmptGrid('analysis/selectAcceptCompleteList.lims', 'reqListForm', 'reqListGrid');
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		testSampleGrid('analysis/selectSampleAssignmentList.lims', 'assignmentForm', 'inputItemGrid');
		
		assignmentListGrid('analysis/selectResultAssignmentList.lims', 'assignmentForm', 'assignmentListGrid');
		$('#assignmentListGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		bSubGridLoad = true;
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('assignmentForm', 'assignmentListGrid');

		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#assignmentListGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');

		$("#dept_cd").change( function(){
			btn_Search_onclick();
		});
		
		
	});

	var lastRowId;
	
	// 접수 리스트
	function acceptCmptGrid(url, form, grid) {
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
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : 'process',
				name : 'process',
				hidden : true
			}, {
				label : '진행상태',
				name : 'state',
				width : '80',
				align : 'center'
			}, {
				label : '총/배정/미배정',
				name : 'accept_item_info',
				width : '120',
				align : 'center'
			}, {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : '관능검사',
				name : 'sensory_test',
				align : 'center',
				width : '80'
			}, {
				label : '의뢰일련번호(HIDDEN)',
				name : 'test_req_seq',
				align : 'center',
				width : '150',
				hidden : true,
				key : true
			}, {
				label : '의뢰번호',
				name : 'test_req_no',
				align : 'center',
				width : '80',
			}, {
				label : '제목',
				name : 'title',
				width : '300'
			}, {
				label : '의뢰일자',
				name : 'req_date',
				width : '100',
				align : 'center'
			}, {
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '100',
				align : 'center'
			}, {
				label : '의뢰업체명',
				name : 'req_org_nm'
			}, {
				label : '의뢰자',
 				name : 'req_nm',
				width : '60',
				align : 'center'
			}, {
				label : '접수부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : '단위업무',
				name : 'unit_work_cd'
			}, {
				label : '검사목적',
				name : 'test_goal'
			}, {
				label : '접수자',
				name : 'user_nm',
				width : '60',
				align : 'center'
			}, {
				label : '생성자',
				name : 'creater_nm',
				width : '60',
				align : 'center'
			}, {
				label : 'creater_id',
				name : 'creater_id',
				hidden : true
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : 'rec_req_no',
				name : 'rec_req_no',
				hidden : true
			}, {
				label : 'commission_type',
				name : 'commission_type',
				hidden : true
			}, {
				label : 'commission_amt_flag',
				name : 'commission_amt_flag',
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#assignmentForm').find('#test_req_seq').val(row.test_req_seq);				
				$('#assignmentForm').find('#dept_cd').val($('#reqListForm').find('#dept_cd').val());
				$('#inputItemGrid').trigger('reloadGrid');
				$('#assignmentListGrid').clearGridData();
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'req_type',
				numberOfColumns : 9,
				titleText : '의뢰정보'
			}, {
				startColumnName : 'dept_nm',
				numberOfColumns : 3,
				titleText : '검사정보'
			}, {
				startColumnName : 'accept_item_info',
				numberOfColumns : 1,
				titleText : '배정항목수'
			} ]
		});
	}


	// 의뢰/접수리스트 조회
	function btn_Search_onclick() {
		$('#reqListGrid').trigger('reloadGrid');
		$('#reqListGrid').clearGridData();
		$('#inputItemGrid').clearGridData(); 
		$('#assignmentListGrid').clearGridData();
	}

	
	function testSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if(bSubGridLoad)
					fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료번호',
				name : 'test_sample_seq',
				align : 'center',
				width : '80',
				hidden : false
			}, {
				label : '시료명',
				name : 'sample_reg_nm',
				width : '150'
			} , {
				label : '시험결과',
				name : 'test_sample_result_nm',
				align : 'center',
				width : '100'
			}, {
				label : '시료유형',
				name : 'sample_nm',
				width : '100'
			}, {
				label : '검사기준',
				name : 'test_std_nm',
				width : '150'
			}, {
				label : '비고',
				name : 'etc_desc',
				width : '300'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#assignmentForm').find('#test_sample_seq').val(row.test_sample_seq);
				$('#assignmentListGrid').trigger('reloadGrid');
			},
		});
	}
	
	
	function assignmentListGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if(bSubGridLoad)
					fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
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
				}
			}, {
				label : '의뢰번호',
				name : 'test_req_no',
				align : 'center',
				width : '80',
				hidden : true
			}, {
				label : '제목',
				name : 'title',
				width : '250',
				hidden : true
			}, {
				label : '의뢰SEQ',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : '검체번호',
				name : 'test_sample_no',
				width : '120'
			}, {
				label : '검체SEQ',
				name : 'test_sample_seq',
				width : '80',
				hidden : true
			}, {
				label : '검체명',
				name : 'sample_reg_nm',
				width : '160'
			}, {
				label : 'prdlst_cd',
				name : 'prdlst_cd',
				hidden : true
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				classes : 'prdlst_nm'
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : '시험항목',
				name : 'test_item_nm',
				width : '200'
			}, {
				label : '시험항목SEQ',
				name : 'test_item_seq',
				hidden : true
			}, {
				label : '시험부서',
				name : 'dept_nm',
				align : 'center',
				width : '80'
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				align : 'center',
				width : '80',
				hidden : true
			}, {
				label : '시험자',
				name : 'user_nm',
				width : '80',
				classes : 'user_nm'
			}, {
				label : '시험자ID',
				name : 'tester_id',
				classes : 'tester_id',
				hidden : true
			}, {
				type : 'not',
				label : ' ',
				name : 'tester_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'tester_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : 'state',
				name : 'state',
				hidden : true
			}, {
				type : 'not',
				label : 'assignment_flag',
				name : 'assignment_flag',
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				
				if (col == 'tester_pop') {
					$('#' + grid).jqGrid('setCell', rowId, 'chk', 'Yes');
					fnpop_UserInfoPop(grid, "500", "500", 'assignmentChoice', rowId);
				} else if (col == 'tester_del'){
					$('#' + grid).jqGrid('setCell', rowId, 'tester_id', null);
					$('#' + grid).jqGrid('setCell', rowId, 'user_nm', null);
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
				}
// 				var row = $('#' + grid).getRowData(rowId);
// 				if (row.chk == 'Yes'){
// 					$('#' + grid).jqGrid('setCell', rowId, 'chk', 'No');
// 				} else {
// 					$('#' + grid).jqGrid('setCell', rowId, 'chk', 'Yes');
// 				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
			}
		});

		$('#' + grid).bind("jqGridInlineAfterRestoreRow", function(e, rowId, orgClickEvent) {
			var row = $('#' + grid).getRowData(rowId);
			$('#' + grid).jqGrid('setCell', rowId, 'result_cd', row.result_val);
			return e.result === undefined ? true : e.result;
		});
	}
	
	// 조회
	function btn_Select_onclick() {	
		$('#assignmentListGrid').trigger('reloadGrid');
	}

	// 배정자 일괄 지정
	function fnpop_assignment() {
		var grid = 'assignmentListGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);			
			if (row.chk == 'Yes') {
				c++;
			}		
		}
		
		if (c == 0) {
			alert('선택된 항목이 없습니다.');
			return false;
		} else {
			fnBasicStartLoading();
			fnpop_UserInfoPop("assignmentGrid", "500", "500", 'assignmentALL', '');
		}
	}
	
	// 시험자 선택후 콜백함수
	function fnpop_testerCallback(id, name, choice, rowId) {		
		var grid = 'assignmentListGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		
		if (choice == 'assignmentALL') {
			for (var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {				
					$('#' + grid).jqGrid('setCell', ids[i], 'tester_id', id);
					$('#' + grid).jqGrid('setCell', ids[i], 'user_nm', name);
				}		
			}
		} else {
			$('#' + grid).jqGrid('setCell', rowId, 'tester_id', id);
			$('#' + grid).jqGrid('setCell', rowId, 'user_nm', name);
		}
		fnBasicEndLoading();
	}


	// 시험의뢰 배정완료
	function btn_Save_req() {
		var grid = 'reqListGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		var reqList = "";

		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				reqList += ids[i] + ",";
				c++;
			}
		}
		reqList = reqList.substr(0, reqList.length - 1);

		if (c == 0) {
			alert('선택된 항목이 없습니다.');
			return false;
		} else {
			if( confirm( '선택된 의뢰의 시험자를 배정완료하시겠습니까?')){
				var json = fnAjaxAction('analysis/updateAssignmentComplete.lims', "reqList="+reqList);
				if (json == null) {
					alert('error');
				} else {
					var jsonParse = JSON.parse(json);
					if(jsonParse.result=="Y"){
						alert('선택된 의뢰의 시험자가 배정완료되었습니다.');
					}else if(jsonParse.result=="N"){
						alert("시험자가 모두 배정되지 않았습니다. \n\n의뢰번호("+jsonParse.msg+')');
					}else{
						alert('선택된 의뢰가 정확하지 않습니다.');
					}
					btn_Search_onclick();
				}
			}
		}
	}
	
	// 시험자 저장
	function btn_Save_assignment() {
		var grid = 'assignmentListGrid';
		//fnEditRelease(grid);
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				fn_editable(grid, ids[i]);
				if ($.trim(row.tester_id) == '') {
					alert('의뢰번호 : '+row.test_req_no + ' , 검체번호 : ' + row.test_sample_no + ' 항목의 \n시험자를 선택해주세요.');
					fnGridEdit(grid, ids[i], fn_Result_Tester_Row_Click);
					//$("#" + ids[i] + "_test_item_nm").focus();
					return false;
				}
				c++;
			}
		}
		
		if (c == 0) {
			alert('선택된 항목이 없습니다.');
			return false;
		} else {
			if( confirm( '선택된 항목의 시험자를 저장하시겠습니까?')){
				var data = fnGetGridCheckData(grid);
				var json = fnAjaxAction('analysis/updateResultTester.lims', data);
				if (json == null) {
					alert('error');
				} else {
					alert('선택된 항목의 시험자가 저장되었습니다.');
					btn_Select_onclick();
					//$('#inputSampleForm').find('#test_sample_result').text(json);
				}
			}
			
		}			
	}
	
	function fn_Result_Tester_Row_Click(rowId) {
		editChange = true;
		var grid = 'assignmentListGrid';
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
		//fn_editable(grid, rowId);
		//fnGridEdit(grid, rowId, fn_Result_Row_Click);
		
// 		//기준 변경
// 		$('#' + rowId + '_std_type').change(function() {
// 			if ($(this).val() == 'C38001') {
// 				stdChange = true;
// 			} else {
// 				stdChange = false;
// 			}
// 			if (stdChange) {
// 				fn_selectOriginalSTD(grid, rowId);
// 				stdChange = false;
// 			}
// 			fn_editable(grid, rowId);
// 			fnGridEdit(grid, rowId, fn_Result_Row_Click);
// 		});
	}
	
	// 의뢰처 팝업
	function fnpop_reqOrgChoice(name, width, hight, text){		
		fnpop_reqOrgChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}
	
	// 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}
</script>

<div class="sub_purple_01 w100p" style="margin-top: 0px;">
<form id="reqListForm" name="reqListForm" onsubmit="return false;">
	<table class="select_table">
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				접수완료 목록
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
					<button type="button">조회</button>
				</span>
				<span class="button white mlargeg auth_save" id="resultViewBtn" onclick="btn_Save_req();">
					<button type="button">전체배정완료</button>
				</span>
			</td>
		</tr>
	</table>
	<table class="list_table">
		<tr>
			<th>의뢰번호</th>
			<td>
				<input name="test_req_no" id="test_req_no" type="text" class="w100px" />
			</td>
			<th>의뢰구분</th>
			<td>
				<select name="req_type" id="req_type" class="w100px"></select>
			</td>
			<th>제목</th>
			<td>
				<input name="title" id="title" type="text" class="w300px" />
			</td>
		</tr>
		<tr>
			<th>의뢰업체명</th>
			<td>
				<input name="req_org_nm" id="req_org_nm" type="text" class="w100px" />
				<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "조회의뢰")'/>
			</td>
			<th>의뢰자</th>
			<td>
				<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
			</td>
			<th>의뢰일자</th>
			<td>
				<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
				<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
			</td>
		</tr>
		<tr>
			<th>접수부서</th>
			<td>
				<select name="dept_cd" id="dept_cd" class="w200px"></select>
			</td>
			<th>단위업무</th>
			<td>
				<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
			</td>
			<th><!-- 전체배정대기 --></th>
			<td>
				<!-- <label><input type='radio' name='accept_wait_yn' value='' style="width: 20px"/>전체</label>
				<label><input type='radio' name='accept_wait_yn' value='Y' style="width: 20px"/>예</label>
				<label><input type='radio' name='accept_wait_yn' value='N' style="width: 20px" checked="checked"/>아니오</label> -->
			</td>
		</tr>
	</table>
	<input type="hidden" id="type" name="type" value="${type}">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="reqListGrid"></table>
	</div>
</form>
</div>

<div class="sub_purple_01" style="width: 25%; float: left;">
	<table width="100%" border="0" class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				시료 목록
			</td>
		</tr>
	</table>
	<div id="view_grid_sub1">
		<table id="inputItemGrid"></table>
	</div>
</div>
<div class="sub_purple_01" style="margin-left: 3%; width: 72%; float: left;">
<form id="assignmentForm" name="assignmentForm" onsubmit="return false;">
	<table class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				접수 항목 목록
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeb auth_select" id="reqViewBtn" onclick="fnpop_assignment();">
					<button type="button">시험자일괄지정</button>
				</span>
				<span class="button white mlargeb auth_save" id="stateViewBtn" onclick="btn_Save_assignment();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
	<input type="hidden" id="test_req_seq" name="test_req_seq">
	<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
	<input type="hidden" id="dept_cd" name="dept_cd" />
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_sub2">
		<table id="assignmentListGrid"></table>
	</div>
</form>
</div>
