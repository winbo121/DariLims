
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료유형 선택
	 * 파일명 		: acceptP01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
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
	var arr = new Array;
	arr = popupName.split("★●★");
	$(function() {
		acceptSampleGrid('selectSampleList.lims', 'acceptSampleForm', 'acceptSampleGrid');
		$(window).bind('resize', function() {
			$("#acceptSampleGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		
		fn_Enter_Search('acceptSampleForm', 'acceptSampleGrid');
	});
	
	function acceptSampleGrid(url, form, grid) {
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
			colModel : [ {
				label : '시료유형',
				name : 'sample_nm'
			}, {
				label : 'sample_cd',
				name : 'sample_cd',
				key : true,
				hidden : true
			}, {
				label : '영문명',
				name : 'sample_eng_nm'
			}, {
				label : '약어',
				name : 'sample_abbr'
			}, {
				label : '설명',
				name : 'sample_desc',
				width : '195'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_Onclick(grid);
			}
		});
	}
	
	function btn_Select_onclick() {
		$('#acceptSampleGrid').trigger('reloadGrid');
	}
	
	// 해당 row 선택시 이벤트
	function btn_Choice_Onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		var data;
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);
			
			if(!arr[1]){
				var rowNum = Number(arr[0])+1;				
				//alert(rowNum);
				$(opener.document).find("#templeteGrid #"+rowNum+" .sample_nm").text(row.sample_nm);
				$(opener.document).find("#templeteGrid #"+rowNum+" .sample_cd").text(row.sample_cd);
			} else {
				$(opener.document).find("#"+arr[0]+" .sample_nm").text(row.sample_nm);
				$(opener.document).find("#"+arr[0]+" .sample_cd").text(row.sample_cd);
			}
			
			if(arr[2] == 'sampleStatistics'){
				$(opener.document).find("#"+arr[0]+" #sample_nm").val(row.sample_nm);
				$(opener.document).find("#"+arr[0]+" #sample_cd").val(row.sample_cd);
			}
			
			opener.fnpop_callback();
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
			<form id="acceptSampleForm" name="acceptSampleForm" onsubmit="return false;">
				<div class="sub_purple_01" style="margin-top: 0px;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시료유형 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Choice_Onclick('acceptSampleGrid');">
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
						<th>시료명</th>
						<td>
							<input name="sample_nm" type="text" class="inputhan w100px" />
						</td>
						<th>시료약어</th>
						<td>
							<input name="sample_abbr" type="text" class="inputhan w100px" />
						</td>
						<th>시료영문명</th>
						<td>
							<input name="sample_eng_nm" type="text" class="inputhan w100px" />
						</td>
					</tr>
				</table>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_main">
					<table id="acceptSampleGrid"></table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
