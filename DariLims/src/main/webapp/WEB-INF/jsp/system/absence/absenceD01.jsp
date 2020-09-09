
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부재관리 상세정보
	 * 파일명 		: absenceD01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
	});
</script>

<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			상세정보
		</td>
		<td class="table_button" style="text-align: right; padding-right: 30px;">
			<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
				<button type="button">삭제</button>
			</span>
		</td>
	</tr>
</table>
<form id="detail" name="detail" onsubmit="return false;">
	<table  class="list_table" >
		<tr>
			<th>부재자</th>
			<td>
				<input name="user_id" id="user_id" type="hidden" value="${detail.user_id}" />
				<label>${detail.dept_nm } ${detail.user_nm }</label>
			</td>
			<th>부재기간</th>
			<td>
				<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" value="${detail.startDate }" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
				<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" value="${detail.endDate }" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
			</td>

		</tr>
		<tr>
			<th>대리자</th>
			<td colspan="3">
				<input name="substitute_id" id="substitute_id" type="hidden" value="${detail.substitute_id}" />
				<label id="substitute_dept_nm">${detail.substitute_dept_nm }</label> <label id="substitute_nm">${detail.substitute_nm }</label> 
				<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="btn_Choice_onclick();">
			</td>
		</tr>
		<tr>
			<th>사유 및 내용</th>
			<td colspan="3">
				<textarea id="etc" name="etc" style="width: 100%;" rows="3">${detail.etc}</textarea>
			</td>
		</tr>
	</table>
</form>
