
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 공통코드관리
	 * 파일명 		: codeL01.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 *     
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		codeGroupGrid('system/selectCodeGroupList.lims', 'mainForm', 'codeGroupGrid');
		$('#codeGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		codeDetailGrid('system/selectCodeDetailList.lims', 'subForm', 'codeDetailGrid');
		$('#codeDetailGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$(window).bind('resize', function() {
			$("#codeGroupGrid").setGridWidth($('#sub_purple_01 w34p').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#codeDetailGrid").setGridWidth($('#sub_purple_01 w60p').width(), false);
		}).trigger('resize');
		fn_Enter_Search('mainForm', 'codeGroupGrid');
		fn_Enter_Search('subForm', 'codeDetailGrid');
	});

	function codeGroupGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			rowNum : -1,			
			rownumbers : true,
			sortname : 'code_name',
			sortorder : 'asc',
			colModel : [ {
				label : '그룹코드명',
				name : 'code_name',
				width : '200',
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '그룹코드',
				name : 'code',
				width : '120',
				editable : true,
				key : true,
				editrules : {
					required : true
				}
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				width : '120',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:미사용'
				},
				editrules : {
					required : true
				}
			} ],
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Save').hide();
				
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					
					fnEditRelease('codeDetailGrid');
					
					$("#subForm").find("#pre_code").val(rowId);
					$('#codeDetailGrid').trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				$('#' + grid).jqGrid('editRow', rowId);
				$('#btn_AddLine').hide();
				$('#btn_Save').show();
			}
		});
	}

	function codeDetailGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			rowNum : -1,			
			rownumbers : true,
			sortname : 'disp_order',
			sortorder : 'asc',
			colModel : [ {
				label : '코드명',
				name : 'code_name',
				width : '200',
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '코드',
				name : 'code',
				width : '150',
				key : true,
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '여분코드1',
				name : 'ex_code1',
				width : '130',
				editable : true
			}, {
				label : '여분코드2',
				name : 'ex_code2',
				width : '130',
				editable : true
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				align : 'center',
				width : '120',
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:사용안함'
				}
			}, {
				label : '정렬순서',
				name : 'disp_order',
				width : '70',
				editable : true,
				editrules : {
					number : true
				}
			} ],
			gridComplete : function() {
				$('#btn_AddLine_Sub').show();
				$('#btn_Save_Sub').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_AddLine_Sub').show();
					$('#btn_Save_Sub').hide();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				$('#' + grid).jqGrid('editRow', rowId);
				$('#btn_AddLine_Sub').hide();
				$('#btn_Save_Sub').show();
			}
		});
	}

	// 코드그룹 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#codeGroupGrid').trigger('reloadGrid');
		btn_Search_Sub_onclick();
	}  
	
	//코드그룹 행추가버튼 클릭 이벤트
	function btn_AddLine_onclick(){
		var grid = 'codeGroupGrid';
		$('#' + grid).jqGrid('addRow', {rowID : 0, position : 'last'});
		$('#btn_AddLine').hide();
		$('#btn_Save').show();
	}
	
	//코드그룹 저장버튼 클릭 이벤트
	function btn_Save_onclick(){
		var grid = 'codeGroupGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		if(rowId == '0'){
			pageType = 'insert';
		}else{
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/saveCodeGroup.lims', {
			pageType : pageType
		}, fn_Success_insertGroup, null, null);
	}
	
	//코드그룹 저장 후 콜백 이벤트
	function fn_Success_insertGroup(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {type:'insert'});
			$('#codeGroupGrid').trigger('reloadGrid');
		}
	} 	
	
	
	
	//코드상세 조회버튼 클릭 이벤트
	function btn_Search_Sub_onclick() {
		$('#codeDetailGrid').trigger('reloadGrid');
	}
	
	//코드상세 행추가버튼 클릭 이벤트
	function btn_AddLine_Sub_onclick(){
		var preCode = $('#subForm').find('#pre_code').val();
		if(preCode != ''){
			var grid = 'codeDetailGrid';
			$('#' + grid).jqGrid('addRow', {rowID : 0, position : 'last'});
			$('#btn_AddLine_Sub').hide();
			$('#btn_Save_Sub').show();
		}else{
			alert("선택된 코드그룹이 없습니다.");
		}
	}
	
	//코드상세 저장버튼 클릭 이벤트
	function btn_Save_Sub_onclick(){
		var grid = 'codeDetailGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		var pre_code = $('#subForm').find('#pre_code').val();
		if(rowId == '0'){
			pageType = 'insert';
		}else{
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/saveCodeDetail.lims', {
			pageType : pageType
			,pre_code : pre_code
		}, fn_Success_inserDetail, null, null);
	}
	
	//코드상세 저장 후 콜백 이벤트
	function fn_Success_inserDetail(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {type:'insert'});
			$('#codeDetailGrid').trigger('reloadGrid');
		}
	}
	
	
</script>

<div class="sub_purple_01 w34p">
<form id="mainForm" name="mainForm" onsubmit="return false;">
	<table  class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				그룹코드
			</td>
			<td class="table_button">
				<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
					<button type="button">조회</button>
				</span>
				<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
					<button type="button">행추가</button>
				</span>
				<span class="button white mlargep auth_save" id="btn_Save" onclick="btn_Save_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
	<table  class="list_table" >
		<tr>
			<th nowrap="nowrap">그룹코드명</th>
			<td>
				<input type="text" id="code_name" name="code_name" class="inputhan" />
			</td>
			
			<th>사용여부</th>
			<td>
				<label><input type='radio' name='use_flag' value='' style="width:20px" checked="checked"/>전체</label>
				<label><input type='radio' name='use_flag' value='Y' style="width:20px"/>사용</label>
				<label><input type='radio' name='use_flag' value='N' style="width:20px"/>미사용</label>
			</td>
		</tr>
	</table>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_sub_l">
		<table id="codeGroupGrid"></table>
	</div>
</form>	
</div>

<div class="sub_purple_01 w60p" style="float:right;">
<form id="subForm" name="subForm" onsubmit="return false;">
	<table  class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				상세코드
			</td>
			<td class="table_button">
				<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_Sub_onclick();">
					<button type="button">조회</button>
				</span>
				<span class="button white mlargep auth_save" id="btn_AddLine_Sub" onclick="btn_AddLine_Sub_onclick();">
					<button type="button">행추가</button>
				</span>
				<span class="button white mlargep auth_save" id="btn_Save_Sub" onclick="btn_Save_Sub_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
	<table  class="list_table" >
		<tr>
			<th>코드명</th>
			<td>
				<input type="text" id="code_name" name="code_name" class="inputhan" />
			</td>
			
			<th>사용여부</th>
			<td>
				<label><input type='radio' name='use_flag' value='' style="width:20px" checked="checked"/>전체</label>
				<label><input type='radio' name='use_flag' value='Y' style="width:20px"/>사용</label>
				<label><input type='radio' name='use_flag' value='N' style="width:20px"/>미사용</label>
			</td>
		</tr>
	</table>
	<input type="hidden" id="pre_code" name="pre_code">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_sub_r">
		<table id="codeDetailGrid"></table>
	</div>
</form>	
</div>

