
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 성적서 등록(팝업)
	 * 파일명 		: filePop.jsp
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
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
		$("#fileForm").find("#test_req_seq").val(arr[4]);

		if(arr[0] == 'sampleFileGrid'){
			insertURL = 'insertSampleFile.lims';
			updateURL = 'updateSampleFile.lims';
			deleteURL = 'deleteSampleFile.lims';			
		} else if (arr[0] == 'sampleItemFileGrid') {
			insertURL = 'insertItemFile.lims';
			updateURL = 'updateItemFile.lims';
			deleteURL = 'deleteItemFile.lims';
		} else if (arr[0] == 'requestFileGrid') {
			insertURL = 'insertRequestFile.lims';
			updateURL = 'updateRequestFile.lims';
			deleteURL = 'deleteRequestFile.lims';
		} else {
			insertURL = 'insertReportFile.lims';
			updateURL = 'updateReportFile.lims';
			deleteURL = 'deleteReportFile.lims';
		}
		
 		//alert(arr[0]);// 그리드 이름
		//alert(arr[1]);// 항목 no test_item_seq
		//alert(arr[2]);// 시료 no test_sample_seq
		//alert(arr[3]);// rowID 
		//alert(arr[4]);// 의뢰 no test_req_seq	
		if($('#fileForm').find('#att_seq').val()==null || $('#fileForm').find('#att_seq').val()==''){
			$('#fileForm').find('#btn_Del').hide();
		} else {
			$('#fileForm').find('#btn_Del').show();
		}
		
	});	
	
	// 저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		var form = "fileForm" ;
		// 필수 체크
		if(($('#fileForm').find('#mul_file_att').val() == '' && $('#fileForm').find('#mul_file_att').val() == null
		   	|| $('#fileForm').find('#file_name').text() == '' && $('#fileForm').find('#file_name').text() == null)){
			alert("등록 할 문서가 없습니다.");
			return;
		} else {
			var id = $('#'+form).find('#att_seq').val();
			var url;
			if (id == '') {				
				if ($('#'+form).find('#mul_file_att').val() != '') {					
					var json = fnAjaxFileAction(insertURL, form, fn_suc);
				} else {
					var param = $('#'+form).serialize();
					var json = fnAjaxAction(insertURL, param);
					if (json == null) {
						alert('저장 실패하였습니다.');				
					} else {
						//alert('저장이 완료되었습니다.');
						if (arr[0] == 'resultGrid'){
							var name = $('#'+form).find('#mul_file_att').val();
							var fileName = new Array;			
							fileName = name.split("\\");			
							$(opener.document).find('#'+arr[0] + ' #' + arr[3] + ' .file_nm').val(fileName[fileName.length-1]); // 파일 이름
							$(opener.document).find('#'+arr[0] + ' #' + arr[3] + ' .file_nm').text(fileName[fileName.length-1]); // 파일 이름
						}
						opener.callback(arr[0], arr[3], 1);
						window.close();
					}
				}
			// 수정
			} else {				
				if ($('#'+form).find('#mul_file_att').val() != '') {
					var json = fnAjaxFileAction(updateURL, form, fn_suc);
				} else {
					var param = $('#'+form).serialize();
					var json = fnAjaxAction(updateURL, param);
					if (json == null) {
						alert('저장 실패하였습니다.');				
					} else {
						//alert('저장이 완료되었습니다.');
						if (arr[0] == 'resultGrid'){
							var name = $('#'+form).find('#mul_file_att').val();
							var fileName = new Array;			
							fileName = name.split("\\");			
							$(opener.document).find('#'+arr[0] + ' #' + arr[3] + ' .file_nm').val(fileName[fileName.length-1]); // 파일 이름
							$(opener.document).find('#'+arr[0] + ' #' + arr[3] + ' .file_nm').text(fileName[fileName.length-1]); // 파일 이름
						}
						opener.callback(arr[0], arr[3], 1);
						window.close();
					}
				}
			}
		}		
	}	
	
	// 저장 후 콜백
	function fn_suc(json) {
		var form = "fileForm" ;
		if (json == null) {
			alert('저장 실패하였습니다.');				
		} else {
			//alert('저장이 완료되었습니다.');
			if (arr[0] == 'resultGrid'){
				var name = $('#'+form).find('#mul_file_att').val();
				var fileName = new Array;			
				fileName = name.split("\\");			
				$(opener.document).find('#'+arr[0] + ' #' + arr[3] + ' .file_nm').val(fileName[fileName.length-1]); // 파일 이름
				$(opener.document).find('#'+arr[0] + ' #' + arr[3] + ' .file_nm').text(fileName[fileName.length-1]); // 파일 이름
			}
			opener.callback(arr[0], arr[3], 1);
			window.close();
		}
	}
	
	// 삭제
	function btn_Del_onclick() {
		var form = "fileForm" ;		
		
		// 문서번호 없으면
		var id = $('#'+form).find('#att_seq').val();
		if (id != '' && id != null) {
			var param = $('#'+form).serialize();
			var json = fnAjaxAction(deleteURL, param);
			if (json == null) {
				alert('삭제 실패하였습니다.');
			} else {
				alert('삭제가 완료되었습니다.');				
			}
		} else {
			alert("삭제 할 문서가 없습니다.");
			return false;
		}
		window.close();
		opener.callback_del(arr[0], arr[3], 1);
	}
	
	// 닫기 버튼
	function btn_Cancle_onclick() {
		//opener.callback();
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
							<th style="min-width:120px; height:50px;" class="indispensable">성적서 업로드</th>
							<!-- 파일형식 -->
							<td>
								<input type="hidden" id="att_seq" name="att_seq" value="${detail.att_seq}">
								<input type="hidden" id="test_sample_seq" name="test_sample_seq" value="">
								<input type="hidden" id="test_item_cd" name="test_item_cd" value="">
								<input type="hidden" id="test_req_seq" name="test_req_seq" value=""  />
								
								<input type="hidden" id="file_nm" name="file_nm" value="${detail.file_nm }">
								<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
									<label id="file_name">첨부파일이 없습니다.</label>
								</c:if>
								<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
									<label id="file_name"><a href="reportDown.lims?att_seq=${detail.att_seq }">${detail.file_nm }</a></label>
<%-- 									<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("mul_file_att"), fn_TextClear("file_nm")' /> --%>
								</c:if>
								<br/>
								<input name="mul_file_att" id="mul_file_att" type="file" class="inputCheck"/>
								<br/>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>