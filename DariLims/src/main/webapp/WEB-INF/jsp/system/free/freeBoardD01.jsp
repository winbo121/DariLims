
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 자유공유 게시판
	 * 파일명 		: freeBoardD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.19
	 * 설  명		: 자유공유 게시판 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.19    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!-- 파일업로드  -->
<link rel="stylesheet" href="<c:url value='/css/fileUpload/uploadfile.css'/>">
<link rel="stylesheet" href="<c:url value='/css/fileUpload/uploadfile.custom.css'/>">
<script src="<c:url value='/script/fileUpload/jquery.uploadfile.fix.js'/>"></script>
<script type="text/javascript">
	var formData = {};
	var multiple = false; // 멀티 저장 여부
	var maxFileCount = -1; // 멀티 저장 갯수
	var extraObj;
	
	var fileOptions = {
		 url:"fileUpload.lims?path='00000001'",
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
		 dragdropWidth:  "98%",
		 onLoad:function(obj)
		 {
			var selData = 'name='+name+'&path='+path+'&size=1024';
			if(name != null && name != '') {
				//왜 여기에 있지..?
// 				var json = fnAjaxAction('/lims/selectFileList.lims', selData);
// 				//alert(json);
// 				if(json != null) {
// 				  	$(json).each(function(index, entry) {
// 					  fn_createProgress(entry["name"],entry["path"],entry["size"], obj);
// 					  ++ objfileCount;
// 					  $("#fileCount").text(objfileCount);
// 					});  
// 				}
			}			
		 },
		 deleteCallback: function (name, path) {
			var delData = "path=" + path;
			var json = fnAjaxAction('/lims/deleteFile.lims', delData);
			
			if(json != null) {
				  -- objfileCount;
				  $("#fileCount").text(objfileCount);
			}			 
			/* $.post("/lims/deleteFile.lims", {op: "delete",name: data},
		            function (resp,textStatus, jqXHR) {
		                //Show Message	
		                alert("File Deleted");
		            });
		    for (var i = 0; i < data.length; i++) {
		        $.post("/lims/deleteFile.lims", {op: "delete",name: data[i]},
		            function (resp,textStatus, jqXHR) {
		                //Show Message	
		                alert("File Deleted");
		            });
		    } */
		    //pd.statusbar.hide(); //You choice.
		 },
		 downloadCallback: function(filename, filepath) {
			//alert(filepath);
			var downData = "path=" + filepath;
			 /* filename : 파일명
			  *	filepath : 파일경로(디비저장이므로 다운로드 Key로변경하여 사용) 
			  * Sample
			 */
			location.href="system/boardDown.lims?" + downData;
		 }
	};
	
	$(function () {
		/* 파일업로드 초기화 */
		 extraObj = fn_initFileUpload(fileOptions);
		 
		 $("#btnFileSend").click(function(){
			 extraObj.startUpload();
		 }); 
	});	 
		
		
	// 샘플 추후삭제
	// 파일관리 팝업
	function fnpop_fileManage() { //btn_pop_req_info
		fnBasicStartLoading();
		cfnpop_fileManage("fileMange", "600" , "400");
	}
</script>
<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			게시글
		</td>
		<td class="table_button">
<!-- 		뭔지몰라서 일단 가림 -->
<!-- 			<span class="button white mlarger auth_save" id="btn_Sub_Delete" onclick="fnpop_fileManage();"> -->
<!-- 				<button type="button">파일등록팝업테스트용</button> -->
<!-- 			</span> -->
			<span class="button white mlargeg auth_save" id="btn_Sub_Add" onclick="fn_Sub_ViewPage('insert');">
				<button type="button">덧글쓰기</button>
			</span>
			<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick('main');">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Sub_Delete" onclick="btn_Delete_onclick();">
				<button type="button">삭제</button>
			</span>
		</td>
	</tr>
</table>
<table  class="list_table" >
	<c:if test="${detail.creater_id != null &&  detail.creater_id != ''}">
		<tr>
			<th style="min-width: 120px;">작성자</th>
			<td>${detail.creater_id}</td>
			<th style="min-width: 120px;">작성일</th>
			<td>${detail.create_date}</td>
		</tr>
	</c:if>
	<tr>
		<th style="min-width: 120px;">제목</th>
		<td colspan="3">
			<input type="hidden" id="board_no" name="board_no" value="${detail.board_no}" class="w120px">
			<input type="text" id="title" name="title" value="${detail.title}" class="w300px">
		</td>
	</tr>
	<tr>
		<th class="list_table_p">내용</th>
		<td colspan="3">
			<textarea rows="15" style="width: 80%;" name="contents" class="inputhan">${detail.contents}</textarea>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<!-- 파일형식 -->
		<td colspan="3">
			<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
				<label id="file_name"><a href="system/boardDown.lims?board_no=${detail.board_no}">${detail.file_nm}</a></label>
			</c:if>
			<input name="m_file" id="m_file" type="file" />
			<%-- 
			<div id="fileManageDiv">  <!-- 디자인 작업 필요
				<div id="fileuploader">Upload</div>
				<div id="output" style="/* border: solid 2px #2fa1d4; */ overflow-y: auto;height: 140px;"></div>
				<div id="eventMessage" style="/* border: solid 2px #2fa1d4; */overflow-y: auto;height: 50px;  display:none;"></div>
				<div id="btnFileSend" class="ajax-file-upload-green">Start Upload</div> 
			</div>
			  --%>
		</td>
	</tr>
</table>