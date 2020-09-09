
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 검사기준(팝업)
	 * 파일명 		: testStdP01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.29
	 * 설  명		: 검사기준 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.29    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml" class="minH170">
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>
<style>
/* 한글우선입력 */
 .imeon input {
 	ime-mode: active;
 }
</style>
<script type="text/javascript">
	$(function() {
		grid(fn_getConTextPath()+'/master/selectTestStdList.lims', 'form', 'grid');
		
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	
	function grid(url, form, grid) {
		var lastRowId = 0;
		var check = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '기준정보코드',
				name : 'test_std_no',
				key : true,				
				hidden : true
			}, {
				label : '검사기준<span class="indispensableGrid"></span>',
				name : 'test_std_nm',
				classes : 'imeon',
				width : '220',				
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '설명<span class="indispensableGrid"></span>',
				name : 'std_desc',
				width : '380',
				classes : 'imeon',
				editable : true,
				editrules : {
					required : true
				}
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();

				var row = $('#'+grid).getRowData(rowId);
				// 식약처 기준은 안뜸
				if(row.test_std_no != 'I01'){
					$('#btn_Delete').show();
				} else {
					$('#btn_Delete').hide();
				}

				if (rowId && rowId != lastRowId) {
// 					if(lastRowId != 0 && check) {
// 						check = false;
// 						if (!confirm('저장하지 목록은 사라집니다. 이동하시겠습니까?')) {
// 							fnSelectRowId(grid, lastRowId);		
// 							return 'stop';
// 						}
// 					}
					//$('#btn_AddLine').show();
					//$('#btn_Insert').hide();
					//$('#btn_Delete').show();
				}
				if(rowId != "0"){
					//$('#' + grid).jqGrid("resetSelection");
					$('#' + grid).jqGrid('restoreRow', rowId);
					$('#' + grid).jqGrid('restoreRow', 0);
					//$("#" + grid).jqGrid("setSelection", rowId, true);
				}				
				lastRowId = rowId;
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {				
				$('#' + grid).jqGrid('editRow', rowId);
				$('#' + grid).css("ime-mode", "active");
				check = true;
				$('#btn_AddLine').hide();
				$('#btn_Insert').show();
				$('#btn_Delete').hide();
			}
		});
	}
	
	// 행추가 클릭 이벤트
	function btn_AddLine_onclick() {
		var grid = 'grid';
		$('#' + grid).jqGrid("resetSelection");
		
		$('#' + grid).jqGrid('addRow', {rowID:0, position:'last'});
		$('#btn_AddLine').hide();
		$('#btn_Insert').show();
		$('#btn_Delete').hide();
	}
	
	// 저장, 수정 버튼 클릭 이벤트
	function btn_Insert_onclick() {
		if (!confirm('저장하시겠습니까?')) {
			return false;
		}
		var grid = 'grid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var url = '';
		
		// 저장
		if(rowId == 0){
			url = fn_getConTextPath()+'/master/insertTestStd.lims';
		} else {
			url = fn_getConTextPath()+'/master/updateTestStd.lims';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, url, null, fn_Success);
	}
	
	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick(){
		if (!confirm('삭제하시겠습니까?')) {
			return false;
		}	
		var grid = 'grid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var url = fn_getConTextPath()+'/master/deleteTestStd.lims';
		var data = '&test_std_no=' +rowId;
		
		var json = fnAjaxAction(url, data);			
		if (json == null) {
			alert('삭제 실패하였습니다.');
		} else {
			btn_Search_onclick();
			alert('삭제 완료되었습니다.');
		}
	}
	
	// 저장 완료
	function fn_Success(json) {
		if (json == null) {
			alert('error');
		} else {
			btn_Search_onclick();
			alert('저장 완료되었습니다.');
		}
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		fnEditRelease('grid');
		$('#grid').trigger('reloadGrid');
	}
	
	// 닫기클릭이벤트
	function btn_Close_onclick() {
		opener.fnBasicEndLoading();
		window.close();
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area">
	<h2>검사기준 </h2>
	<div class="pop_intro">
		<form id="form" name="form" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							검사기준
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
								<button type="button">검사기준추가</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
								<button type="button">저장</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
								<button type="button">삭제</button>
							</span>
							<span class="button white mlargep" id="btn_Close" onclick="btn_Close_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table"  style="padding-left: 3px;">
					<tr>
						<th style="width: 20%">검사기준</th>
						<td style="width: 80%">
							<input name="test_std_nm" type="text" class="inputhan"/>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_main">
				<table id="grid"></table>
			</div>
		</form>
		</div>
	</div>
</div>
</body>
</html>