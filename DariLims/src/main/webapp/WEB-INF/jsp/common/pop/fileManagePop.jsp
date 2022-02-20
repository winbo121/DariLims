
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 파일관리(팝업)
	 * 파일명 		: fileManagePop.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.12.11
	 * 설  명		: 성적서 등록 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.11    윤상준		최초 프로그램 작성         
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
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!-- 파일업로드  -->
<link rel="stylesheet" href="<c:url value='/css/fileUpload/uploadfile.css'/>">
<link rel="stylesheet" href="<c:url value='/css/fileUpload/uploadfile.custom.css'/>">
<script src="<c:url value='/script/fileUpload/jquery.uploadfile.fix.js'/>"></script>

<title>LIMS</title>
<style>
	/* .ui-jqgrid .ui-search-toolbar .ui-search-table {height: 24px;}
	.ui-jqgrid .ui-search-toolbar .ui-search-input input,
	.ui-jqgrid .ui-search-toolbar .ui-search-input select,
	.ui-jqgrid .ui-search-toolbar .ui-search-input textarea {height: 18px;} */
</style>
<script type="text/javascript">	
var popupName = window.name; // 팝업창 이름 가져오기
var formData = {};
var multiple = true;
var maxFileCount = 3;
var extraObj;

var fileOptions = {
		url:"fileUpload.lims",
		 returnType: "json",
		 showDelete: true,
		 showDownload:true,
		 formData: formData,
		 fileName: "myfile",
		 maxFileCount: maxFileCount,
		 multiple: multiple,
		 autoSubmit: false,
		 showProgress : true,
		 showQueueDiv: "output",
		 statusBarWidth:  "90%",
		 dragdropWidth:  "96%",
		 onLoad:function(obj)
		 {
			  var json = fnAjaxAction('/lims/selectFileList.lims', null);
				if(json != null) {
				  	$(json).each(function(index, entry) {
					  fn_createProgress(entry["name"],entry["path"],entry["size"], obj);
					  ++ objfileCount;
					  $("#fileCount").text(objfileCount);
					});  
				}
		 },
		 deleteCallback: function (name, path) {
			 var json = fnAjaxAction('/lims/deleteFile.lims', "name="+name);
				if(json != null) {
					  -- objfileCount;
					  $("#fileCount").text(objfileCount);
				}
		 },
		 downloadCallback:function(filename,filepath)
		 {
			 location.href="system/boardDown.lims?board_no="+filepath;
		 }
};

$(function () {
	
	 /* 파일업로드 초기화 */
	 extraObj = fn_initFileUpload(fileOptions);
	 
	 $("#btnFileSend").click(function(){
		 extraObj.startUpload();
	 }); 
	 
});	 
	
 	/* // 저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		var form = "fileForm" ;

				
		var json = fnAjaxFileAction(insertURL, form, fn_fileCallBack);

		if (json == null) {
			alert('저장 실패하였습니다.');				
		} else {
			//alert('저장이 완료되었습니다.');
			opener.callback(arr[0], arr[3], 1);
			window.close();
		}
	}	
	
	// 저장 후 콜백
	function fn_fileCallBack(json) {
		
	} */
	
	
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
			<h2>파일관리</h2>
			<div class="sub_purple_01">
				<form name="fileForm" id="fileForm" enctype="multipart/form-data" onsubmit="return false;">
					<table  class="select_table" >
						<tr>
							<td class="table_title">
								<span>■</span> 파일업로드     
							</td>
							<td class="table_button" >
								<!-- <span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
									<button type="button">저장</button>
								</span>
								<span class="button white mlargep auth_save" id="btn_Del" onclick="btn_Del_onclick();">
									<button type="button">삭제</button>
								</span> -->
								<span class="button white mlargep" id="btn_Cancle" onclick="btn_Cancle_onclick();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<div id="fileManageDiv">  <!-- 파일업로드 디자인 작업 필요-->
						<div id="fileuploader">Upload</div>
						<div id="output" style="/* border: solid 2px #2fa1d4; */ overflow-y: auto;height: 140px;"></div>
						<div id="eventMessage" style="/* border: solid 2px #2fa1d4; */overflow-y: auto;height: 50px; /* display:none; */"></div>
					</div>
				</form>
				<!-- 파일업로드 시작버튼-->
				<div id="btnFileSend" class="ajax-file-upload-green">Start Upload</div> 
			</div>
		</div>
		
	</div>
</body>