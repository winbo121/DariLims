
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 결과조회
	 * 파일명 		: acceptResultInfo.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.03.31
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.31    진영민		최초 프로그램 작성         
	 * 2016.02.02    윤상준       수정
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
	var colModel;
	var groupHeaders;
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	
	$(function() {
		arr = popupName.split("★●★");
		//var obj = window.dialogArguments;
		$('#acceptResultForm').find('#test_req_seq').val(arr[0]);
		$('#acceptResultForm').find('#test_req_no').val(arr[1]);
		btn_Select_onclick();
		$(window).bind('resize', function() {
			$("#acceptResultGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	
	function btn_Select_onclick() {
		colModel = new Array();
		groupHeaders = new Array();
		colModel.push({
			label : '항목',
			name : 'TEST_ITEM_NM',
			width : '200',
			frozen : true
		});
// 		colModel.push({
// 			label : '단위',
// 			name : 'UNIT',
// 			width : '80',
// 			frozen : true
// 		});		
		var json = fnAjaxAction('selectAcceptResultInfo.lims', $('#acceptResultForm').serialize());		
		if (json == null) {
		} else {
			var str = "";
			$(json).each(function(index, entry) {
				$(entry['head']).each(function(idx, etr) {
					var e = etr.split('♥■◆');
					var aa = e[0].substring(3, e[0].length);
					colModel.push({
						label : e[1],
						name : 'R' + idx,
						width : '150',
						align : 'center'
					});
				});
				$(entry['head']).each(function(idx, etr) {
					var e = etr.split('♥■◆');
					var aa = e[0].substring(3, e[0].length);
					groupHeaders.push({
						startColumnName : 'R' + idx,
						numberOfColumns : 1,
						titleText : e[0]
					});
				});
				$('#acceptResultGrid').jqGrid('GridUnload');
				acceptResultGrid(null, 'acceptResultForm', 'acceptResultGrid');
				$('#acceptResultGrid').clearGridData();
				$('#acceptResultGrid')[0].addJSONData(entry['body']);
				/* $(entry['body']).each(function(idx, etr) {
					alert(etr['TEST_ITEM_NM']);
					alert('SUC' + idx + '/' + etr['SUC' + idx]);
					alert('FAL' + idx + '/' + etr['FAL' + idx]);
					alert('SUM' + idx + '/' + etr['SUM' + idx]);
					alert(etr['TOTAL']);
				}); */

			});
		}
	}
	
	function acceptResultGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
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
	
	// 엑셀다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('acceptResultGrid');
		fn_Excel_Download(data);
	}	
</script>
</head>

<body id="popBody" onunload="opener.fnBasicEndLoading();">

<form id="frmBinder" name="frmBinder" onsubmit="return false;">
	<input type="hidden" name="gridData" id="gridData" value="">
</form>

<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>결과보기</h2>
		<div>
		<form id="acceptResultForm" name="acceptResultForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title" nowrap="nowrap">
							<span>■</span>
							시험결과조회
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
	<!-- 						<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">조회</button>
							</span> -->
							<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
								<button type="button">EXCEL</button>
							</span>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table">
					<tr>
						<th>의뢰번호</th>
						<td>
							<input name="test_req_seq" id="test_req_seq" type="hidden" class="w100px"  />
							<input name="test_req_no" id="test_req_no" type="text" class="w100px" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_main">
					<table id="acceptResultGrid"></table>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>
</body>
</html>