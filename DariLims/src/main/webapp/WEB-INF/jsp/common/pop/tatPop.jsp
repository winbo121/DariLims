
<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 통계 > tat관리 상세내용 팝업
	 * 파일명 	: tatPop.jsp
	 * 작성자 	: 한지연
	 * 작성일 	: 2020.06.24
	 * 설  명	: tat(시험관리예정일 및 성적서 발행예정일)에 따른 통계 내역 상세 보기
	 * 사용 페이지	: 실적 및 통계
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.27    최은향		최초 프로그램 작성         
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
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>

<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var type; //시험완료예정일 : T / 성적서발행예정일 : R
	var req_class; // 시험그룹(의뢰구분)
	var tat_date; // 컬럼 이름
	var startDate; // 구분일자 시작일
	var endDate; //구분일자 종료일
	var isImp;
	var fnGridInit = false;
	var fnGridInitSub = false;
	
	$(function() {		
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");
		
		type = stringList[0];
		req_class = stringList[1];
		tat_date = stringList[2];
		//날짜별인가 총계인가
		if(tat_date == "TOTAL" || tat_date == "TOTAL_IM" ){
			startDate = stringList[3];
			endDate = stringList[4];
		}
		//전체인가 미완료인가
		if(stringList[5] == 'IMP'){
			isImp = stringList[5];
		}
	
		$('#tatDetailForm').find('#req_class').val(req_class);
		$('#tatDetailForm').find('#tat_date').val(tat_date);
		$('#tatDetailForm').find('#startDate').val(startDate);
		$('#tatDetailForm').find('#endDate').val(endDate);
		$('#tatDetailForm').find('#isImp').val(isImp);

		// 시험완료예정일
		if (type == "T"){ 
			tatDetailGrid('../resultStatistical/selectTatDetailList.lims', 'tatDetailForm', 'tatDetailGrid');
			tatReasonGrid('../resultStatistical/selectTatReason.lims', 'tatReasonForm', 'tatReasonGrid');
		//성적서발행예정일
		}else if (type == "R") {
			tatDetailGrid('../resultStatistical/selectTatReportDetailList.lims', 'tatDetailForm', 'tatDetailGrid');
			tatReasonGrid('../resultStatistical/selectTatReportReason.lims', 'tatReasonForm', 'tatReasonGrid');			
		}
		
		$('#tatReasonGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		fn_Enter_Search('tatDetailForm', 'tatDetailGrid');
	});

	// 품목 그리드
	function tatDetailGrid(url, form, grid) {	
		$('#' + grid).jqGrid({
			datatype : function(json) {
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
			colModel : [
				{label : 'test_req_seq', name : 'test_req_seq', hidden: true, key : true},
				{label : 'tat_log_no', name : 'tat_log_no', hidden: true, key : true},
				{label : '접수번호', name : 'test_req_no', width : '150'},
			 	{label : '접수일자', name : 'sample_arrival_date', width : '150'},
			 	{label : '시험 완료예정일', name : 'test_end', width : '150'},
			 	{label : '성적서 발행예정일', name : 'deadline_date', width : '150'},
			 	{label : '의뢰자', name : 'req_nm', width : '150'},
			 	{label : '완료구분', name : 'state', width : '150'}
			],
			gridComplete : function(data) {
				gridTatPopComplete();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
			},			
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$("#").find("#test_req_seq").val(row.test_req_seq);
				$("#tatReasonForm").find("#test_req_seq").val(row.test_req_seq);
				$("#tatReasonForm").find("#log_no").val(row.tat_log_no);
				
				btn_Search_onclick(1);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {	
			}
		});
	}
	
	// 항목 그리드
	var sel = false;
	function tatReasonGrid(url, form, grid) {	
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '220',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [
				{label : 'test_req_seq', name : 'test_req_seq',	hidden : true}, 
				{label : '접수번호',name : 'test_req_no'}, 
				{label : '검체명',name : 'sample_reg_nm'}, 
				{label : '항목명',name : 'testitm_nm'}, 
				{label : '접수일자',name : 'sample_arrival_date'}, 
				{label : '미완료사유',name : 'exceed_reason'}, 
				{label : '처리일시',name : 'test_end_date'}
			],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectAll : function(aRowids, status) {
			},
			onSelectRow : function(rowId, status, e) {
				var nowRow = $('#' + grid).getRowData(rowId);

			}
		});
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick(type) {
		fnEditRelease('tatReasonGrid');
		$('#tatReasonGrid').trigger('reloadGrid');
	}
	// 그리드 사이즈 
	function gridTatPopComplete(){	
		$(window).bind('resize', function() {
			$("#tatDetailGrid").setGridWidth($('#view_grid_prd').width(), false);
		}).trigger('resize');
	}

	// 품목 조회
	function btn_Select_Sub_onclick() {
		$('#tatDetailGrid').trigger('reloadGrid');
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>TAT관리 </h2>
			<div id="">
				<div id="tabDiv0">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="tatDetailForm" name="tatDetailForm" onsubmit="return false;">
							<table class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										 TAT관리내역 리스트
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<input type="hidden" id="tat_date" name="tat_date" >
							<input type="hidden" id="req_class" name="req_class" >
							<input type="hidden" id="startDate" name="startDate" >
							<input type="hidden" id="endDate" name="endDate" >
							<input type="hidden" id="isImp" name="isImp" >
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<div id="view_grid_prd">
								<table id="tatDetailGrid"></table>
							</div>
						</form>
					</div>
				</div>
				<div style="margin-top:50px">
				</div>
				<div class="sub_blue_01" style="margin-top:0px;">
					<div class="sub_blue_01">
						<form id="tatReasonForm" name="tatReasonForm" onsubmit="return false;">
						<table  class="select_table" >
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									미완료사유 리스트
								</td>
							</tr>
						</table>
						<div id="view_grid_rev">
							<table id="tatReasonGrid"></table>
						</div>
						<input type="hidden" id="sortName" name="sortName">
						<input type="hidden" id="sortType" name="sortType">
						<input type="hidden" id="test_req_seq" name="test_req_seq">
						<input type="hidden" id="log_no" name="log_no">
						</form>
					</div>	
				</div>
			</div>
		</div>
	</div>
</body>
</html>