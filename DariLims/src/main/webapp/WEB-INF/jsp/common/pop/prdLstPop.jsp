
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 품목리스트
	 * 파일명 		: prdLstPop.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.12.17
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.17    윤상준		최초 프로그램 작성         
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
	$(function() {
		
	});
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>수수료</h2>
		<div class="sub_purple_01">
			<form id="form" name="form" onsubmit="return false;">
				<table class="select_table">
					<tr>
						<td class="table_title">
							<span>■</span>
							수수료
						</td>
						<td class="table_button" >
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Send" onclick="btn_Send_onclick();">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
								<button type="button">행추가</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Save" onclick="btn_Save_onclick();">
								<button type="button">저장</button>
							</span>
							<span class="button white mlargeb" id="btn_Cancel" onclick="window.close();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table class="list_table" >
					<tr>
						<th>그룹</th>
						<td>
							<input name="fee_group_nm" type="text" class="inputhan w100px" />
						</td>
						<th>수수료</th>
						<td>
							<input name="fee" type="text" class="w100px" />
						</td>
					</tr>
				</table>

				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_main">
					<table id="grid"></table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>