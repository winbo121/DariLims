
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험항목별통계
	 * 파일명 		: itemStatisticsL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.03.31
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.31    진영민		최초 프로그램 작성         
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
	var colModel;
	var groupHeaders;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("dept_cd", "", "ALL", "ALLNAME", 'itemStatisticsForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'itemStatisticsForm');
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "itemStatisticsForm");

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		fn_Enter_Search('itemStatisticsForm', 'itemStatisticsGrid');
		
		$(window).bind('resize', function() {
			$("#itemStatisticsGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		
// 		$('form[name=itemStatisticsForm] input , form[name=itemStatisticsForm] select').keypress(function(e) {
// 			if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
// 				btn_Select_onclick();
// 			}
// 		});
	});
	function btn_Select_onclick() {
		colModel = new Array();
		groupHeaders = new Array();
		colModel.push({
			label : '항목대분류',
			name : 'TESTITM_LCLAS_NM',
			width : '200',
			frozen : true
		},{
			label : '항목중분류',
			name : 'TESTITM_MLSFC_NM',
			width : '200',
			frozen : true
		},{
			label : '항목',
			name : 'TEST_ITEM_NM',
			width : '200',
			frozen : true
		});
		var json = fnAjaxAction('resultStatistical/selectItemStatistics.lims', $('#itemStatisticsForm').serialize());
		if (json == null) {
		} else {
			var str = "";
			$(json).each(function(index, entry) {
				$(entry['head']).each(function(idx, etr) {
					colModel.push({
						label : '적합',
						name : 'SUC' + idx,
						width : '40',
						align : 'center'
					});
					colModel.push({
						label : '부적합',
						name : 'FAL' + idx,
						width : '40',
						align : 'center'
					});
					colModel.push({
						label : '소계',
						name : 'SUM' + idx,
						width : '40',
						align : 'center'
					});
				});
				colModel.push({
					label : '총계',
					name : 'TOTAL',
					width : '40',
					align : 'center'
				});
				$(entry['head']).each(function(idx, etr) {
					groupHeaders.push({
						startColumnName : 'SUC' + idx,
						numberOfColumns : 3,
						titleText : etr
					});
				});
				$('#itemStatisticsGrid').jqGrid('GridUnload');
				itemStatisticsGrid(null, 'itemStatisticsForm', 'itemStatisticsGrid');
				$('#itemStatisticsGrid').clearGridData();
				$('#itemStatisticsGrid')[0].addJSONData(entry['body']);
				/* 
				$(entry['body']).each(function(idx, etr) {
					alert(etr['TEST_ITEM_NM']);
					alert('SUC' + idx + '/' + etr['SUC' + idx]);
					alert('FAL' + idx + '/' + etr['FAL' + idx]);
					alert('SUM' + idx + '/' + etr['SUM' + idx]);
					alert(etr['TOTAL']);
				}); */

			});
		}
	}
	function itemStatisticsGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "local",
			/* mtype : "POST", */
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : colModel,
			gridComplete : function() {

			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : groupHeaders
		});
		$('#' + grid).jqGrid('setFrozenColumns');
	}
	
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('itemStatisticsGrid');
		fn_Excel_Download(data);
	}
	
	function fnpop_callback(){
		fnBasicEndLoading();
	}
		
</script>
<div class="sub_purple_01 w100p">
	<form id="itemStatisticsForm" name="itemStatisticsForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title" nowrap="nowrap">
					<span>■</span>
					시험항목별통계
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>구분</th>
				<td>
					<input name="type" id="type" type="radio" value="Y" checked="checked" />
					연간
					<input name="type" id="type" type="radio" value="N" />
					월간
				</td>
				<th>시험과</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w100px"></select>
				</td>
				<th>단위업무</th>
				<td>
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>
			</tr>
			<tr>
				<th>품목구분</th>
				<td>
					<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
				</td>
				<th>시험항목</th>
				<td>
					<input name="test_item_nm" id="test_item_nm" type="text" class="inputhan w100px" value="" />
				</td>
				<th>접수일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="itemStatisticsGrid"></table>
		</div>
	</form>
</div>
