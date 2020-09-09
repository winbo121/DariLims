
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험항목 선택
	 * 파일명 		: testResultBP03.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.03.23
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.23    석은주		최초 프로그램 작성         
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
		
		rsTestItemSearchGrid('resultStatistical/selectTestItemSearchList.lims', 'rsTestItemSearchForm', 'rsTestItemSearchGrid');
		
		$(window).bind('resize', function() {
			$("#rsTestItemSearchGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		
		fn_Enter_Search('rsTestItemSearchForm', 'rsTestItemSearchGrid');
	});
	function rsTestItemSearchGrid(url, form, grid) {
		var count = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if(count)
					fnGridData(url, form, grid);
				else
					count = true;
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {				
				label : '시험항목코드',
				name : 'test_item_cd',
				width : '100',
				key : true,
				hidden : true
			}, {
				label : '시험항목약어',
				name : 'test_item_mnm'
			}, {
				label : '시험항목한글명',
				name : 'test_item_nm'
			}, {
				label : '시험항목영문명',
				name : 'test_item_enm'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Save_onclick(grid);
			}
		});
	}
	function btn_Select_onclick() {
		$('#rsTestItemSearchGrid').trigger('reloadGrid');
	}
	function btn_Save_onclick() {
		var rowId = $('#rsTestItemSearchGrid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#rsTestItemSearchGrid').getRowData(rowId);
			window.returnValue = row.test_item_nm + '◆★◆' + rowId;
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
<div class="popUp">
	<div class="pop_area pop_intro">
	<h2>시험항목 </h2>
	<form id="rsTestItemSearchForm" name="rsTestItemSearchForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시험항목 목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeb auth_save" id="btn_Save" onclick="btn_Save_onclick();">
							<button type="button">선택</button>
						</span>
						<span class="button white mlargeb" id="btn_Cancel" onclick="window.close();">
							<button type="button">닫기</button>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<table class="list_table"  style="width: 700px;">
			<tr>
				<th style="width: 100px;">시험항목명</th>
				<td>
					<input name="test_item_nm" type="text" class="inputhan w300px" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="rsTestItemSearchGrid"></table>
		</div>
	</form>
</div>
</div>



