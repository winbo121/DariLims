
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 성적서 등록(팝업)
	 * 파일명 		: userSign.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.06
	 * 설  명		: 성적서 등록 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.06    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html id="popHtml" class="minH170">
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
<script type="text/javascript" src="<c:url value='/script/resultInputCommon.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>
<style>
	.ui-jqgrid .ui-search-toolbar .ui-search-table {height: 24px;}
	.ui-jqgrid .ui-search-toolbar .ui-search-input input,
	.ui-jqgrid .ui-search-toolbar .ui-search-input select,
	.ui-jqgrid .ui-search-toolbar .ui-search-input textarea {height: 18px;}
</style>
<script type="text/javascript">	
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	var insertURL;
	var updateURL;
	var deleteURL;
	
	$(function() {
		arr = popupName.split("★●★");
		$("#fileForm").find("#test_item_cd").val(arr[1]);
		$("#fileForm").find("#test_sample_seq").val(arr[2]);

		//deleteURL = 'deleteSampleFile.lims';			
		
		//alert(arr[0]);// 그리드 이름
		//alert(arr[1]);// 항목 no test_item_seq
		//alert(arr[2]);// 시료 no test_sample_seq
		//alert(arr[3]);// rowID
		if($('#fileForm').find('#user_id').val()==null || $('#fileForm').find('#user_id').val()==''){
			$('#fileForm').find('#btn_Del').hide();
		} else {
			$('#fileForm').find('#btn_Del').show();
		}
		
	});	
	
	// 사인 파일 저장
	function btn_Insert_onclick() {
		if($('#fileForm').find('#sign_file').val() == ''){
			alert("등록 할 문서가 없습니다.");
			return;
		} else {
			var id = $('#fileForm').find('#user_id').val();
			if( id && id != '' ){
				var formData = new FormData();
				var file = document.getElementById('sign_file').files[0];
				formData.append('user_id', id);
				formData.append('sign_file', file);
				fnAjaxFileActionNone$('putUserSignFile.lims', formData, fn_suc.bind(this, file.name));
			}
		}		
	}	
	
	// 사인 파일 삭제
	function btn_Del_onclick() {
		if( !confirm('사인 파일을 제거하시겠습니까?') ) return false;
		
		var id = $('#fileForm').find('#user_id').val();
		if( id && id != '' ){
			var formData = new FormData();
			formData.append('user_id', id);
			fnAjaxFileActionNone$('deleteUserSignFile.lims', formData, fn_suc.bind(this, ''));
		}
	}
	
	// 저장 후 콜백
	function fn_suc(fileName, json) {
		var form = "fileForm" ;
		if (json == null) {
			alert('작업이 실패하였습니다.');				
		} else {
			opener.document.getElementById('userSignFileName').innerHTML = fileName;
			alert('완료되었습니다.');
			window.close();
		}
	}
	
	// 닫기 버튼
	function btn_Cancle_onclick() {
		window.close();
		fnBasicEndLoading();
	}
</script>
</head>

<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>첨부파일</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form name="fileForm" id="fileForm" enctype="multipart/form-data" onsubmit="return false;">
					<table  class="select_table" >
						<tr>
							<td width="40%" class="table_title">
								<span>■</span>
								첨부문서
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;" width="60%">
								<span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
									<button type="button">저장</button>
								</span>
								<span class="button white mlargep auth_save" id="btn_Del" onclick="btn_Del_onclick();">
									<button type="button">삭제</button>
								</span>
								<span class="button white mlargep" id="btn_Cancle" onclick="btn_Cancle_onclick();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<table  class="list_table" >
						<tr>
							<th style="min-width:120px; height:50px;" class="indispensable">사인 업로드</th>
							<td>
								<input type="hidden" id="user_id" name="user_id" value="${detail.user_id}">
								<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
									<label id="file_name">첨부파일이 없습니다.</label>
								</c:if>
								<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
									<label id="file_name"><a href="reportDown.lims?user_id=${detail.user_id}">${detail.file_nm}</a></label>
								</c:if>
								<br/>
								<input name="sign_file" id="sign_file" type="file" class="inputCheck"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>