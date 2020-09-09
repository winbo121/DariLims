
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" /> 
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>


<!-- 파일업로드  -->
<link rel="stylesheet" href="<c:url value='/css/fileUpload/uploadfile.css'/>">
<link rel="stylesheet" href="<c:url value='/css/fileUpload/uploadfile.custom.css'/>">
<script src="<c:url value='/script/fileUpload/jquery.uploadfile.fix.js'/>"></script>
<title>파일테스트</title>

<script type="text/javascript">	

var formData = {};
var multiple = true;
var maxFileCount = 10;
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
			 /* sample */
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
	

	 
	
</script>
</head>

<body>
	<div id="fileManageDiv">  <!-- 디자인 작업 필요-->
		<div id="fileuploader">Upload</div>
		<div id="output" style="/* border: solid 2px #2fa1d4; */ overflow-y: auto;height: 500px;"></div>
		<div id="eventMessage" style="/* border: solid 2px #2fa1d4; */overflow-y: auto;height: 50px;  display:none;"></div>
		<div id="btnFileSend" class="ajax-file-upload-green">Start Upload</div> 
	</div>
</body>