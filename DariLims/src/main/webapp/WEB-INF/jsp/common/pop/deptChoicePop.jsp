
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부서정보(팝업)
	 * 파일명 		: deptChoicePop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.09.14
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.14    최은향		최초 프로그램 작성         
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
	var obj;
	var popupName = window.name; // 팝업창 이름 가져오기
	var grid = '';
	var arr = new Array;
	$(function() {
		arr = popupName.split("★●★");
		obj = window.dialogArguments;
		deptGrid('../commonCode/selectCommonCodeDept.lims', 'deptForm', 'deptGrid');
		fn_Enter_Search('deptForm', 'deptGrid');
	});


	function deptGrid(url, form, grid) {
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
				index : 'req_org_no',
				label : 'code',
				name : 'code',
				key : true,
				hidden : true
			}, {
				index : 'req_org_nm',
				label : '부서',
				name : 'code_Name'
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

	// 조회시 이벤트
	function btn_Select_onclick() {
		$('#deptGrid').trigger('reloadGrid');
	}
	
	// 해당 row 선택시 이벤트
	function btn_Choice_Onclick(grid) {
		//alert(popupName);
		var rowId = $('#' + grid).getGridParam('selrow');
		var data;
		var formNm = 'reqItemForm';
		
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);	
			
			// 부모창에 던져주기
			$(opener.document).find("#"+arr[1]+" .dept_nm").text(row.code_Name); // 부서명
			$(opener.document).find("#"+arr[1]+" .dept_cd").text(row.code); // 부서코드
			$(opener.document).find("#"+arr[1]+" .team_cd").text(""); // 팀CD
			$(opener.document).find("#"+arr[1]+" .team_nm").text(""); // 팀이름
			$(opener.document).find("#"+arr[1]+" .user_id").text(""); // 시험자 ID
			$(opener.document).find("#"+arr[1]+" .user_nm").text(""); // 시험자이름
			
			window.close();
			
			var data = 'test_sample_seq=' + arr[2] + '&test_item_seq=' + arr[3] + '&dept_cd=' + row.code;
			var json = fnAjaxAction('../accept/updateItemGrid.lims', data);
			if (json == null) {
				$.showAlert('변경을 실패하였습니다.');
			} else {
				$.showAlert('변경을 완료하였습니다.');
			}
			
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>부서 목록</h2>		
			<div id="tabDiv3">
				<form id="deptForm" name="deptForm" onsubmit="return false;">
					<div class="sub_purple_01">
						<table width="100%" border="0" class="select_table" >
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									부서 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Choice_Onclick('deptGrid');">
										<button type="button">선택</button>
									</span>
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub2">
						<table id="deptGrid"></table>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>