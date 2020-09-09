
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료유형 선택
	 * 파일명 		: testResultBP02.jsp
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
		rsSampleChoiceGrid('resultStatistical/selectSampleChoiceList.lims', 'rsSampleChoiceForm', 'rsSampleChoiceGrid');
		$(window).bind('resize', function() {
			$("#rsSampleChoiceGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		
		fn_Enter_Search('rsSampleChoiceForm', 'rsSampleChoiceGrid');
	});
	function rsSampleChoiceGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
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
				label : '시료번호',
				name : 'sample_cd',
				width : '100',
				key : true
			}, {
				label : '시료명',
				name : 'sample_nm'
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
		$('#rsSampleChoiceGrid').trigger('reloadGrid');
	}
	function btn_Save_onclick() {
		var rowId = $('#rsSampleChoiceGrid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#rsSampleChoiceGrid').getRowData(rowId);
			window.returnValue = row.sample_nm + '◆★◆' + rowId;
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
<div class="popUp">
	<div class="pop_area pop_intro">
	<h2>시료유형 </h2>
	<form id="rsSampleChoiceForm" name="rsSampleChoiceForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시료유형 목록
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
				<th>시료명</th>
				<td>
					<input name="sample_nm" type="text" class="inputhan w100px" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="rsSampleChoiceGrid"></table>
		</div>
	</form>
</div>
</div>



