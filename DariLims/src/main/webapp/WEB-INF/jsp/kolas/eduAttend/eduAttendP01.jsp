
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교육과정 등록(팝업)
	 * 파일명 		: eduAttendP01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.29
	 * 설  명		: 교육과정 등록 상세보기 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.29    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<style>
	.ui-jqgrid .ui-search-toolbar .ui-search-table {height: 24px;}
	.ui-jqgrid .ui-search-toolbar .ui-search-input input,
	.ui-jqgrid .ui-search-toolbar .ui-search-input select,
	.ui-jqgrid .ui-search-toolbar .ui-search-input textarea {height: 18px;}
</style>
<script type="text/javascript">
	$(function() {
		/* var attendNo = window.dialogArguments["attendNo"];
		var userNm = window.dialogArguments["deptNm"];
		var deptNm = window.dialogArguments["userNm"]; */
	});
	//첨부파일
	function setFile() {
		$('#edu_attend_file').trigger('click');

		var name = $('#edu_attend_file').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}

	//저장버튼 클릭 이벤트 (기존 data에서 파일첨부 부분만 수정)
	function btn_Insert_onclick() {
		if ($('#edu_attend_file').val() != '') {
			fnAjaxFileAction('kolas/updateEduAttend.lims', 'eduAttendForm', fn_suc);
		} else {
			var param = $('#eduAttendForm').serialize();
			var json = fnAjaxAction('kolas/updateEduAttend.lims', param);
			if (json == null) {
				alert('error');
			} else {
				alert('저장이 완료되었습니다.');
				var opener = window.dialogArguments['self'];
				opener.popSearchSub();
				window.close();
			}
		}
	}
	function fn_suc(json) {
		if (json == null) {
			alert('error');
		} else {
			alert('저장이 완료되었습니다.');
			var opener = window.dialogArguments['self'];
			opener.popSearchSub();
			window.close();
		}
	}
	function btn_Cancle_onclick() {
		var opener = window.dialogArguments["self"];
		opener.popSearchSub();
		window.close();
	}
</script>

</head>
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>교육참석자 첨부파일</h2>
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<form name="eduAttendForm" id="eduAttendForm" enctype="multipart/form-data" onsubmit="return false;">
				<table  class="select_table" >
					<tr>
						<td width="40%" class="table_title">
							<span>■</span>
							교육참석자
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;" width="60%">
							<span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
								<button type="button">저장</button>
							</span>
							<span class="button white mlargep" id="btn_Cancle" onclick="btn_Cancle_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table" >
					<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
					<tr>
						<th class="list_table_p">참석자 부서</th>
						<td>
							<input type="hidden" id="attend_no" name="attend_no" value="${detail.attend_no }">
							<input name="dept_nm" type="text" class="noinput" value="${detail.dept_nm }" readonly="readonly" />
						</td>
						<th class="list_table_p">참석자 이름</th>
						<td>
							<input name="user_nm" type="text" class="noinput" value="${detail.user_nm }" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<th>문서명</th>
						<td>
							<input name="doc_nm" type="text" class="inputhan" value="${detail.doc_nm }" />
						</td>
						<th>문서내용</th>
						<!-- 파일형식 -->
						<td>
							<input type="hidden" id="file_nm" name="file_nm" value="${detail.file_nm }">
							<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
								<label id="file_name">첨부파일이 없습니다.</label>
							</c:if>
							<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
								<label id="file_name"><a href="eduAttendFileDown.lims?attend_no=${detail.attend_no }">${detail.file_nm }</a></label>
								<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("edu_attend_file"), fn_TextClear("file_nm")' />
							</c:if>
							<input name="edu_attend_file" id="edu_attend_file" type="file" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>