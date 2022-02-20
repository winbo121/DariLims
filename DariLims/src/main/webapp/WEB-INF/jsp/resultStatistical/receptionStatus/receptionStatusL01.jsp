
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 검사접수현황(통계)
	 * 파일명 		: receptionStatusL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.04.08
	 * 설  명		: 검사접수현황(통계) 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.04.08    석은주		최초 프로그램 작성         
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
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		$('#receptionStatusForm').find('#endDate').val(fnGetToday(0,0));
		$('#receptionStatusForm').find('#startDate').val(fnGetToday(1,0));

		receptionStatusGrid('resultStatistical/selectReceptionStatusList.lims?pageType=sample', 'receptionStatusForm', 'receptionStatusGrid');
		$('#receptionStatusGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		receptionStatusUnitGrid('resultStatistical/selectReceptionStatusList.lims?pageType=unitWork', 'receptionStatusForm', 'receptionStatusUnitGrid');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('receptionStatusForm', 'receptionStatusGrid');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#receptionStatusGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#receptionStatusUnitGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
	});
	function receptionStatusGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '229',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			footerrow : true,
			userDataOnFooter : true,
			colModel : [ {
				label : '시료유형코드',
				name : 'sample_cd',
				hidden : true
			}, {
				label : '시료유형구분',
				name : 'sample_nm',
				width : '300'
			}, {
				label : '접수',
				name : 'accept_count',
				align : 'right',
				width : '80',
				formatoptions : {
					summaryType : 'sum',
					summaryTpl : 'Totals:'
				}
			}, {
				label : '누계(년)',
				name : 'year_count',
				align : 'right',
				width : '80',
				formatoptions : {
					summaryType : 'sum',
					summaryTpl : 'Totals:'
				}
			}, {
				label : '비고',
				name : 'etc',
				width : '300'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				// 하단 합계 부분
				var sum = $("#" + grid).jqGrid('getCol', 'accept_count', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'year_count', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {
					sample_nm : '합&nbsp;&nbsp;계',
					accept_count : sum,
					year_count : sum2
				});

				// 스타일 주기 
				$('#view_grid_main table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc'); // 배경색
				$('#view_grid_main table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'bold'); // 폰트 스타일
				// td 병합
				$("#view_grid_main table.ui-jqgrid-ftable td:eq(0)").hide();
				// 합계 width
				$('#view_grid_main table.ui-jqgrid-ftable tr:first td:eq(2)').css('width', '330px');
				//합계 정렬
				$('#view_grid_main table.ui-jqgrid-ftable tr:first td:eq(2)').css("text-align", "center");
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}
	function receptionStatusUnitGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '229',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			footerrow : true,
			userDataOnFooter : true,
			colModel : [ {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '100'
			}, {
				label : '단위업무코드',
				name : 'unit_work_cd',
				hidden : true
			}, {
				label : '단위업무구분',
				name : 'unit_work_nm',
				width : '200'
			}, {
				label : '접수',
				name : 'accept_count',
				align : 'right',
				width : '80',
				formatoptions : {
					summaryType : 'sum',
					summaryTpl : 'Totals:'
				}
			}, {
				label : '누계(년)',
				name : 'year_count',
				align : 'right',
				width : '80',
				formatoptions : {
					summaryType : 'sum',
					summaryTpl : 'Totals:'
				}
			}, {
				label : '비고',
				name : 'etc',
				width : '300'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				// 하단 합계 부분
				var sum = $("#" + grid).jqGrid('getCol', 'accept_count', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'year_count', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {
					unit_work_nm : '합&nbsp;&nbsp;계',
					accept_count : sum,
					year_count : sum2
				});

				// 스타일 주기 
				$('#view_grid_sub table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc'); // 배경색
				$('#view_grid_sub table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'bold'); // 폰트 스타일

				// td 병합
				$("#view_grid_sub table.ui-jqgrid-ftable td:eq(0)").hide();
				$("#view_grid_sub table.ui-jqgrid-ftable td:eq(1)").hide();

				// 합계 width
				$('#view_grid_sub table.ui-jqgrid-ftable tr:first td:eq(3)').css('width', '335px');

				//합계 정렬
				$('#view_grid_sub table.ui-jqgrid-ftable tr:first td:eq(3)').css("text-align", "center");
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}
	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#receptionStatusGrid').trigger('reloadGrid');
		$('#receptionStatusUnitGrid').trigger('reloadGrid');
	}
	//시료유형 검색 팝업
	function btn_Pop_SampleChoice() {
		var obj = new Object();
		obj.msg1 = 'accept/sampleChoice.lims';
		var popup = fnShowModalWindow("popMain.lims", obj, 715, 380);
		if (popup != null && popup != '') {
			var arr = popup.split('◆★◆');
			$('#receptionStatusForm').find('#sample_nm').val(arr[0]);
			$('#receptionStatusForm').find('#sample_cd').val(arr[1]);
		}
	}
	// 엑셀다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('receptionStatusGrid');
		var data2 = fn_Excel_Data_Make('receptionStatusUnitGrid');
		fn_Excel_Download(data +'◆■●'+ data2);
	}
</script>
<div id="receptionStatusDiv">
	<form id="receptionStatusForm" name="receptionStatusForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						검사접수현황
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeb auth_select" id="excelDownBtn" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>시료유형</th>
					<td>
						<input name="sample_cd" id="sample_cd" type="hidden" />
						<input name="sample_nm" id="sample_nm" type="text" class="inputhan" readonly="readonly" style="width: 108px;" />
						<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="sampleAdd" style="cursor: pointer;" onClick='btn_Pop_SampleChoice()' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="sampleDel" style="cursor: pointer;" onClick='fn_TextClear("sample_cd"), fn_TextClear("sample_nm")' />
					</td>
					<th>처리기한</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName" />
		<input type="hidden" id="sortType" name="sortType" />
		<div class="sub_blue_01" style="margin-top: 5px;">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시료유형별
					</td>
				</tr>
			</table>
		</div>
		<div id="view_grid_main">
			<table id="receptionStatusGrid"></table>
		</div>

		<div class="sub_blue_01">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						단위업무별
					</td>
				</tr>
			</table>
		</div>
		<div id="view_grid_sub">
			<table id="receptionStatusUnitGrid"></table>
		</div>
	</form>
</div>



