
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 팀선택(팝업)
	 * 파일명 		: teamChoicePop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.23
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.23    최은향		최초 프로그램 작성         
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
		teamGrid('../accept/teamListPop.lims', 'teamForm', 'teamGrid');
	});	
	
	// 팀
	function teamGrid(url, form, grid) {
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
				index : 'dept_cd',
				label : '부서코드',
				name : 'dept_cd',
				key : true,
				hidden : true
			}, {
				label : '부서',
				width : '130',
				name : 'dept_nm'
			}, {
				label : '팀',
				width : '150',
				name : 'team_nm'
			}, {
				label : '팀코드',
				name : 'team_cd',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Team_Choice_Onclick(grid);
			}
		});
	}
	
	// 조회시 이벤트
	function btn_Select_onclick() {
		$('#teamGrid').trigger('reloadGrid');
	}
	
	// 팀 선택시 이벤트
	function btn_Team_Choice_Onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		var data;
		var formNm = 'teamForm';
		
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);	
			
			// 부모창에 던져주기
			$(opener.document).find("#"+arr[0]+" #team_nm").val(row.team_nm); // 팀
			$(opener.document).find("#"+arr[0]+" #team_cd").val(row.team_cd); // 팀코드
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
		<h2>시험담당</h2>		
			<div>
				<form id="teamForm" name="teamForm" onsubmit="return false;">
					<div class="sub_purple_01">
						<table width="100%" border="0" class="select_table" >
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									팀 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Team_Choice_Onclick('teamGrid');">
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
					<div id="view_grid_sub">
						<table id="teamGrid"></table>
					</div>
				</form>
			</div>		
		</div>
	</div>
</div>
</body>
</html>