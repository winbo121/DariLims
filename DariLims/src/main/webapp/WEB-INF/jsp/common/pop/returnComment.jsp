
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 반려사유
	 * 파일명 		: returnComment.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.05.13
	 * 설  명		: 반려사유 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 *          
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
<style>
input[type=text] {
	ime-mode: auto;
}
</style>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	$(function() {
		arr = popupName.split("★●★");
		$('#form').find('#test_req_seq').val(arr[1]);
		$('#form').find('#type').val(arr[2]);
		$('#form').find('#state').val(arr[3]);
		if(arr[4] != 'undefined'){
			$('#form').find('#return_comment').val(arr[4]);	
		}

		if (arr[2] == 'show') {
			$('#form').find('#btn_Return').hide();
			$('#form').find('#user_id').val('${session.user_id}');
		} else if (arr[2] == 'sect') {
			$('#form').find('#test_dept_cd').val('${session.dept_cd}');
		} else if (arr[2] == 'callback') {
			$('#form').find('#user_id').val('${session.user_id}');
		}
	});

	
	function btn_Save_onclick() {
		if (!confirm('반려하시겠습니까?')) {
			return false;
		}
		
		if ($('#form').find('#return_comment').val() == "") {
			alert("반려의견을 입력하세요.");
			return false;
		}
		
		if(arr[2] == "callback"){
			opener.fnpop_return_callback($('#form').find('#return_comment').val());
			window.close();
		}else{
			var json = fnAjaxAction('updateReturnComment.lims', $('#form').serialize());
			if (json == null) {
				alert('error');
			} else {
				alert('반려 완료되었습니다.');
				opener.fnpop_callback();
				window.close();
			}
		}
	}

	
	// 닫기 버튼
	function btn_close_onclick(){
		window.close();
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>반려 사유</h2>
		<div>
		<form id="form" name="form" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
							반려 항목 목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlarger auth_save" id="btn_Return" onclick="btn_Save_onclick();">
								<button type="button">반려</button>
							</span>
							<span class="button white mlargep" id="btn_Cancel" onclick="btn_close_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table" >
					<tr>
						<th>반려의견</th>
						<td style="padding:5px;">
							<textarea id="return_comment" name="return_comment" rows="8" class="w100p"></textarea>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="state" name="state">
			<input type="hidden" id="type" name="type">
			<input type="hidden" id="test_dept_cd" name="test_dept_cd">
			<input type="hidden" id="user_id" name="user_id">
			<input type="hidden" id="test_req_seq" name="test_req_seq">
		</form>
		</div>
	</div>
</div>
</body>
</html>