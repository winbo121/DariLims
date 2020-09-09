
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목 선택
	 * 파일명 		: selectTestItemPop.jsp
	 * 작성자 		: 정언구
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.09.26   정언구		결과식 등록 페이지의 항목 선택 팝업 개발
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
/**
* 2019-09-26 정언구
* 계산식 관리 페이지에 항목 선택 버튼 기능(팝얼)을 개발
* 항목 마스터의 전체 목록을 조회하는 팝업입니다.
*/

	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	arr = popupName.split("★●★");
	$(function() {
		masterItemGrid('/master/selectMasterList.lims', 'testItemForm', 'testItemGrid');
		$(window).bind('resize', function() {
			$("#testItemGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		
		fn_Enter_Search('testItemForm', 'testItemGrid');
	});
	
	function masterItemGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '330',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : 'testitm_cd',
				name : 'testitm_cd',
				key : true,
				hidden : true
			}, {
				label : '항목명',
				name : 'testitm_nm'
			},{
				label : '영문명',
				name : 'eng_nm'
			}, {
				label : '별칭',
				name : 'ncknm'
			}, {
				label : ' ',
				name : 'kor_nm',
				width : '195'
			} ],
			onSortCol : function(index, iCol, sortorder) {
				if( !com_auth_select ){
					return 'stop';
				} else {
					fnSortCol(form, index, sortorder);
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_Onclick(grid);
			}
		});
	}
	
	function btn_Select_onclick() {
		$('#testItemGrid').trigger('reloadGrid');
	}
	
	// 해당 row 선택시 이벤트
	function btn_Choice_Onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		var data;
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);
			opener.test_item_pop_onSelect(row, window);
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>시료유형 </h2>
		<div>
			<form id="testItemForm" name="testItemForm" onsubmit="return false;">
				<div class="sub_purple_01" style="margin-top: 0px;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								항목 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Choice_Onclick('testItemGrid');">
									<button type="button">선택</button>
								</span>
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
				</div>
				<table border="0" class="list_table" style="width: 700px;">
					<tr>
						<th>항목명</th>
						<td>
							<input name="testitm_nm" type="text" class="inputhan w100px" />
						</td>
						<th>별칭</th>
						<td>
							<input name="ncknm" type="text" class="inputhan w100px" />
						</td>
						<th>영문명</th>
						<td>
							<input name="eng_nm" type="text" class="inputhan w100px" />
						</td>
					</tr>
				</table>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_main">
					<table id="testItemGrid"></table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
