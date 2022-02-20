
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 계산식 팝업
	 * 파일명 		: accountSelPop.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.11    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

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
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>
<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	$(function() {
		
		arr = popupName.split("★●★");
		
		gridPopMain('master/selectAccountList.lims', 'mainForm', 'gridPopMain');
		//accountPopGrid('master/selectAccountPopList.lims', 'accountPopForm', 'accountPopGrid');
		
		//엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('mainForm', 'gridPopMain');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#gridPopMain").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	
	// 계산식조회목록
	function gridPopMain(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
					fnGridData(url, form, grid);
			},
			height : '100',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '계산식번호',
				name : 'account_no',
				key : true,
				hidden : true
			}, {
				label : '계산식명',
				width : '110',
				name : 'account_nm'
			}, {
				label : '계산식결과',
				width : '350',
				name : 'account_tot_disp'
			}, {
				label : '결과단위',
				width : '80',
				align : 'center',
				name : 'unit'
			}, {
				label : '사용여부',
				width : '80',
				name : 'use_flag',
				align : 'center'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				if(!fnIsEmpty(arr[5])){
					fnSelectRowId(grid, arr[5]);
				}else{
					fnSelectFirst(grid);
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Select_Account();
			}
		});
	}
	
	// 닫기
	function fn_close(){
		opener.fnpop_callback();
		window.close();
	}
	
	// 계산식 선택
	function btn_Select_Account() {
		var rowId = $('#gridPopMain').getGridParam('selrow');
		var row = $('#gridPopMain').getRowData(rowId);
		
		if (rowId == null) {
			alert("계산식을 선택해 주세요.");
		}
		else {
			$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .account_no").val(row.account_no); 
			$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .account_nm").val(row.account_nm); 
			
			$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .account_no").text(row.account_no); 
			$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .account_nm").text(row.account_nm);
			window.close();
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area">
		<h2>계산식선택</h2>
		<div class="pop_intro">
		
		<form id="mainForm" name="mainForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table  class="select_table" >
					<tr>
						<td class="table_title">
							<span>■</span>
							계산식목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_save" id="btn_Save_Sub2" onclick="btn_Select_Account();">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="test_method_no" name="test_method_no">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_main">
				<table id="gridPopMain"></table>
			</div>
		</form>
	</div>
</div>
</body>
</html>