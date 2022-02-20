
<%
	/***************************************************************************************
	 * 업무명 	: 품목 별 전처리비용
	 * 파일명 	: pretreatmentPop.jsp
	 * 작성자 	: 허태원
	 * 작성일 	: 2019.11.29
	 * 설  명	: 품목 별 전처리 비용 선택
	 * 사용 페이지	: 접수등록
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.29   허태원		최초 프로그램 작성         
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
var arr = new Array(); 
var popupName = window.name; // 팝업창 이름 가져오기
var test_req_seq;
var test_sample_seq;
var prdlst_cd;
var parentGridId;

$(function() {		
	arr = popupName.split("◆★◆");
	
	test_req_seq = arr[0];
	test_sample_seq = arr[1];
	prdlst_cd = arr[2];
	parentGridId = arr[3];
	
	$("#pretreatmentPopForm").find("#prdlst_cd").val(prdlst_cd);
	
	grid('../master/selectPretMList.lims', 'pretreatmentPopForm', 'pretreatmentPopgrid');

	$(window).bind('resize', function() {
		$("#pretreatmentPopgrid").setGridWidth($('#view_grid_pop').width(), false);
	}).trigger('resize');
	
	fn_Enter_Search('pretreatmentPopForm', 'pretreatmentPopgrid');
});
	
function grid(url, form, grid) {
	var lastRowId = 0;
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fn_GridData(url, form, grid);
		},
		height : '330px',
		rowNum : -1,
		rownumbers : true,
		autowidth : false,
		gridview : false,
		shrinkToFit : false,
		viewrecords : true,
		scroll : true,
		colModel : [ {
			label : 'pretreatment_cd',
			name : 'pretreatment_cd',
			hidden : true,
			key : true
		}, {
			label : 'prdlst_cd',
			name : 'prdlst_cd',
			hidden : true
		}, {
			label : '전처리명',
			name : 'pretreatment_nm',
			width : '150'
		}, { 
			label : '전처리방법',
			name : 'pre_method',
			width : '375'
		}, {
			label : '비용',
			name : 'pre_cost',
			width : '110'
		}],
		emptyrecords : '데이터가 존재하지 않습니다.',
		gridComplete : function() {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
			btn_Choice_Onclick();
		}
	});
}
	
// 조회
function btn_Select_onclick() {
	$('#pretreatmentPopgrid').trigger('reloadGrid');
}

function btn_Choice_Onclick() {
	var rowId = $('#pretreatmentPopgrid').getGridParam('selrow');
	
	if(rowId == null){
		alert('항목을 선택하여 주세요.');
		return;
	}else{
		var row = $('#pretreatmentPopgrid').getRowData(rowId);
		
		var rtnParam = {
			pretreatment_cd : rowId,
			pre_cost : row.pre_cost,
			grid : parentGridId,
			test_sample_seq : test_sample_seq,
			test_req_seq : test_req_seq
		};
		
		opener.fnpop_PretreatmentCallback(rtnParam);
		window.close(); // 닫기
	}
}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>전처리비용</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="pretreatmentPopForm" name="pretreatmentPopForm" onsubmit="return false;">
					<table class="select_table" >
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								전처리비용 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeg auth_select" id="btn_Prd_Select" onclick="btn_Choice_Onclick();">
									<button type="button">선택</button>
								</span>
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
									<button type="button">조회</button>
								</span>
							</td>
						</tr>
					</table>
					<!-- 조회 테이블 -->
					<table  class="list_table" >
						<tr>
							<th>전처리명</th>
							<td>
								<input type="text" name="pretreatment_nm"/>
							</td>
						</tr>
					</table>
					<input type="hidden" id="prdlst_cd" name="prdlst_cd">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_pop">
						<table id="pretreatmentPopgrid"></table>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>