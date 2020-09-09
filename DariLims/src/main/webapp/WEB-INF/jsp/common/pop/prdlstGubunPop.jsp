
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 품목리스트
	 * 파일명 		: prdLstPop.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.12.17
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.17    윤상준		최초 프로그램 작성         
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
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var fnGridInit = false;
	
		$(function() {
			/* 세부권한검사 */
			//fn_auth_check();
			
			prdlstLGrid('selectPrdlstLList.lims', 'mainForm', 'prdlstLGrid');
			$('#prdlstLGrid').clearGridData(); // 최초 조회시 데이터 안나옴
			
			//prdlstMGrid('selectPrdlstMListList.lims', 'subForm', 'prdlstMGrid');
			$('#prdlstMGrid').clearGridData(); // 최초 조회시 데이터 안나옴
			
			$(window).bind('resize', function() {
				$("#prdlstLGrid").setGridWidth($('#view_grid_sub_l').width(), false);
			}).trigger('resize');
			$(window).bind('resize', function() {
				$("#prdlstMGrid").setGridWidth($('#view_grid_sub_r').width(), false);
			}).trigger('resize');
			fn_Enter_Search('mainForm', 'prdlstLGrid');
			fn_Enter_Search('subForm', 'prdlstMGrid');
		});

		function prdlstLGrid(url, form, grid) {
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
					label : '품목(대분류)코드',
					name : 'prdlst_cd',
					editable : false,
					key : true,
					hidden : false
				}, {
					label : '품목대분류코드',
					name : 'disp_prdlst_cd',
					width : '100',
					editable : true,
					editrules : {
						required : true
					}
				}, {
					label : '품목대분류명',
					name : 'kor_nm',
					width : '100',
					editable : true,
					editrules : {
						required : true
					}
				}, {
					label : '영문명',
					name : 'eng_nm',
					width : '150',
					editable : true,
					editrules : {
						required : true
					}
				}, {
					label : '사용여부',
					name : 'use_yn',
					editable : true,
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
						
						fnEditRelease('prdlstMGrid');
						
						$("#subForm").find("#pre_code").val(rowId);
						$('#prdlstMGrid').trigger('reloadGrid');
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

		function prdlstMGrid(url, form, grid) {
			var lastRowId;
			$('#' + grid).jqGrid({
				datatype : function(json) {
					fnGridData(url, form, grid);
				},
				height : '230',
				autowidth : true,
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
					editable : true,
					editrules : {
						required : true
					}
				}, {
					label : '코드',
					name : 'code',
					key : true,
					editable : true,
					editrules : {
						required : true
					}
				}, {
					label : '사용여부',
					name : 'use_flag',
					editable : true,
					edittype : "select",
					editoptions : {
						value : 'Y:사용;N:사용안함'
					}
				}, {
					label : '정렬순서',
					name : 'disp_order',
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

		// 품목대분류 조회버튼 클릭 이벤트
		function btn_Search_onclick() {
			$('#prdlstLGrid').trigger('reloadGrid');
			btn_Search_Sub_onclick();
		}  
		
		//품목대분류 행추가버튼 클릭 이벤트
		function btn_AddLine_onclick(){
			var grid = 'prdlstLGrid';
			$('#' + grid).jqGrid('addRow', {rowID : 0, position : 'last'});
			$('#btn_AddLine').hide();
			$('#btn_Save').show();
		}
		
		//품목대분류 저장버튼 클릭 이벤트
		function btn_Save_onclick(){
			var grid = 'prdlstLGrid';
			var rowId = $('#' + grid).getGridParam('selrow');
			var pageType = '';
			if(rowId == '0'){
				pageType = 'insert';
			}else{
				pageType = 'update';
			}
			
			$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'savePrdlstL.lims', {
				pageType : pageType
			}, fn_Success_prdlstL, null, null);
		}
		
		//품목대분류 저장 후 콜백 이벤트
		function fn_Success_prdlstL(json) {
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {type:'insert'});
				$('#prdlstLGrid').trigger('reloadGrid');
			}
		} 	
		
		
		
		//품목중분류 조회버튼 클릭 이벤트
		function btn_Search_Sub_onclick() {
			$('#prdlstMGrid').trigger('reloadGrid');
		}
		
		//품목중분류 행추가버튼 클릭 이벤트
		function btn_AddLine_Sub_onclick(){
			var preCode = $('#subForm').find('#pre_code').val();
			if(preCode != ''){
				var grid = 'prdlstMGrid';
				$('#' + grid).jqGrid('addRow', {rowID : 0, position : 'last'});
				$('#btn_AddLine_Sub').hide();
				$('#btn_Save_Sub').show();
			}else{
				alert("선택된 품목대분류이 없습니다.");
			}
		}
		
		//품목중분류 저장버튼 클릭 이벤트
		function btn_Save_Sub_onclick(){
			var grid = 'prdlstMGrid';
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
		
		//품목중분류 저장 후 콜백 이벤트
		function fn_Success_inserDetail(json) {
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {type:'insert'});
				$('#prdlstMGrid').trigger('reloadGrid');
			}
		}
		
	

</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>품목분류</h2>
		<div class="sub_purple_01 w47p">
		<form id="mainForm" name="mainForm" onsubmit="return false;">
			<table  class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						품목대분류
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
					<th nowrap="nowrap">대분류명</th>
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
				<table id="prdlstLGrid"></table>
			</div>
		</form>	
		</div>
		
		<div class="sub_purple_01 w47p">
		<form id="subForm" name="subForm" onsubmit="return false;">
			<table  class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						품목중분류
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
					<th>중분류명</th>
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
				<table id="prdlstMGrid"></table>
			</div>
		</form>	
		</div>	
	</div>
</div>
</body>
</html>