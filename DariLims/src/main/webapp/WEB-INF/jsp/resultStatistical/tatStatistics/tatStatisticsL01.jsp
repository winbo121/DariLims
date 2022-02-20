
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: tat항목별통계
	 * 파일명 		: tatStatisticsL01.jsp
	 * 작성자 		: 한지연
	 * 작성일 		: 2020.06.22
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

		
		ajaxComboForm("dept_cd", "", "ALL", "ALLNAME", 'tatStatisticsForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'tatStatisticsForm');
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "tatStatisticsForm");
		
		//달력 이미지
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		//날짜 기본설정
		$('#tatStatisticsForm').find('#endDate').val(fnGetToday(0,0));
		$('#tatStatisticsForm').find('#startDate').val(fnGetToday(1,0));

		fn_Enter_Search('tatStatisticsForm', 'tatStatisticsGrid');
		
		$(window).bind('resize', function() {
			$("#tatStatisticsGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		
	});
	function btn_Select_onclick() {
 		//구분일자 최대 한달
 		var startDate = $('#tatStatisticsForm').find('#startDate').val();
 		var endDate = $('#tatStatisticsForm').find('#endDate').val();
 		var gubunDay = Number(new Date(endDate)) - Number(new Date(startDate)); //2678400000

 		//Validation check
 		if(gubunDay > 2678400000){
 			alert("확인 가능한 최대 일자는 31일입니다.");
 			return false;
 		}
 		if(startDate == '' || startDate == null || endDate == '' || endDate == null || (startDate == '' && endDate == '') || (startDate == null && endDate == null)){
 			alert("확인 가능한 최대 일자는 31일입니다.");
 			return false;
 		}

		colModel = new Array();
		groupHeaders = new Array();
		colModel.push({
			label : '시험그룹',
			name : 'REQ_CLASS',
			width : '200',
			frozen : true
		});
		var type = $(":input:radio[name=type]:checked").val();//구분 : 시험완료예정일 : T / 성적서발행예정일 : R
		if (type == 'T'){
			var json = fnAjaxAction('resultStatistical/selectTatStatistics.lims', $('#tatStatisticsForm').serialize());
		} else if (type == 'R') {
			var json = fnAjaxAction('resultStatistical/selectTatReportStatistics.lims', $('#tatStatisticsForm').serialize());
		}

		if (json == null) {
		} else {
			var str = "";
			$(json).each(function(index, entry) {
				$(entry['head']).each(function(idx, etr) {
					colModel.push({
						label : '전체',
						name : 'SUM' + idx,
						width : '55',
						align : 'right'
					});
					colModel.push({
						label : '미완료',
						name : 'IMP' + idx,
						width : '55',
						align : 'right'
						
					});
					colModel.push({
						label : '비율(%)',
						name : 'PER' + idx,
						width : '55',
						align : 'right'
					});
				});
				colModel.push({
					label : '총계',
					name : 'TOTAL',
					width : '55',
					align : 'right'
				});
				colModel.push({
					label : '미완료',
					name : 'TOTAL_IM',
					width : '55',
					align : 'right'
				});
				colModel.push({
					label : '비율(%)',
					name : 'TOTAL_PER',
					width : '55',
					align : 'right'
				});
				$(entry['head']).each(function(idx, etr) {
					groupHeaders.push({
						startColumnName : 'SUM' + idx,
						numberOfColumns : 3,
						titleText : etr
					});
				});
				$('#tatStatisticsGrid').jqGrid('GridUnload');
				tatStatisticsGrid(null, 'tatStatisticsForm', 'tatStatisticsGrid');
				$('#tatStatisticsGrid').clearGridData();
				$('#tatStatisticsGrid')[0].addJSONData(entry['body']);

			});
		}
	}
	function tatStatisticsGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "local",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : colModel,
			gridComplete : function() {

			},
			//셀 선택시 상세내역(팝업창) 보여주기
			onCellSelect : function (rowId, iCol){
				var row = $('#' + grid).getRowData(rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var colNames = $('#' + grid).jqGrid('getGridParam', 'colNames');
				var groupHeadersOptions = $('#' + grid).jqGrid("getGridParam", "groupHeader");
				var col = colArr[iCol].name;
				var headerNum = Math.ceil(((iCol - 1) / 3)-1);  //헤더(날짜) 순서 계산
				var type = $(":input:radio[name=type]:checked").val();//구분 : 시험완료예정일 : T / 성적서발행예정일 : R
				var startDate = $('#tatStatisticsForm').find('#startDate').val();
		 		var endDate = $('#tatStatisticsForm').find('#endDate').val();
				var param = "";
				
				//총계,미완료
				if (col == 'TOTAL' || col == 'TOTAL_IM') {
					//총계
					if (col == 'TOTAL') {
						param = type + "◆★◆" + row.REQ_CLASS + "◆★◆" + col + "◆★◆" + startDate + "◆★◆" + endDate + "◆★◆" + 'SUM' ;
					//미완료
					} else if (col == 'TOTAL_IM'){
						param = type + "◆★◆" + row.REQ_CLASS + "◆★◆" + col + "◆★◆" + startDate + "◆★◆" + endDate + "◆★◆" + 'IMP' ;
					}

					popup_tat(param);
					fnBasicStartLoading(); 
					
					// 날짜별
				} else {
					var titleText = groupHeadersOptions.groupHeaders[headerNum].titleText;
					
					//전체
					if (col.indexOf('SUM') != -1) {
						param = type + "◆★◆" + row.REQ_CLASS + "◆★◆" + titleText + "◆★◆" + startDate + "◆★◆" + endDate + "◆★◆" + 'SUM';
						popup_tat(param);
						fnBasicStartLoading(); 
					}
					//미완료
					if (col.indexOf('IMP') != -1) {
						param = type + "◆★◆" + row.REQ_CLASS + "◆★◆" + titleText + "◆★◆" + startDate + "◆★◆" + endDate + "◆★◆" + 'IMP' ;
						popup_tat(param);
						fnBasicStartLoading(); 
					}
				}
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
		var data = fn_Excel_Data_Make('tatStatisticsGrid');
		fn_Excel_Download(data);
	}
	
	function fnpop_callback(){
		fnBasicEndLoading();
	}

	function popup_tat(param) {
		fnpop_tatPop("tatStatisticsForm", "1000", "867", param);
	} 
		
</script>
<div class="sub_purple_01 w100p">
	<form id="tatStatisticsForm" name="tatStatisticsForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title" nowrap="nowrap">
					<span>■</span>
					TAT 관리
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
					<input name="type" id="type" type="radio" value="T" checked="checked" />
					시험완료예정일
					<input name="type" id="type" type="radio" value="R" />
					성적서발행예정일
				</td>
				<th>구분일자</th>
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
			<table id="tatStatisticsGrid"></table>
		</div>
	</form>
</div>
