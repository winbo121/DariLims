
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 공지사항
	 * 파일명 		: noticeD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.19
	 * 설  명		: 공지사항 상세 화면
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
<script type="text/javascript">
	$(function() {
		fnDatePickerImg('notice_start');
		fnDatePickerImg('notice_end');
	});
</script>

<div class="sub_blue_01">
	<table  class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="istBtn" onclick="func(1);">
					<button type="button">저장</button>
				</span>
				<span class="button white mlargeg auth_save" id="udtBtn" onclick="func(2);">
					<button type="button">수정</button>
				</span>
				<span class="button white mlarger auth_save" id="delBtn" onclick="func(3);">
					<button type="button">삭제</button>
				</span>
			</td>
		</tr>
	</table>
		
	<table  class="list_table" >
		<tr>
			<th>제목</th>
			<td>
				<input type="hidden" id="notice_no" name="notice_no" value="${detail.notice_no}" />
				<input id="notice_title" name="notice_title" type="text" style="width:90%; min-width:300px;" class="inputhan" value="${detail.notice_title}" />
			</td>
			<th>공지기간</th>
			<td>
				<input style="width: 80px; text-align:center;" name="notice_start" id="notice_start" type="text" class="inputhan" value="${detail.notice_start}" readonly/>
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="notice_startStop" style="cursor: pointer;" onClick='fn_TextClear("notice_start")' />
				~
				<input style="width: 80px; text-align:center;" name="notice_end" id="notice_end" type="text" class="inputhan" value="${detail.notice_end}" readonly/>
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="notice_endStop" style="cursor: pointer;" onClick='fn_TextClear("notice_end")' />
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3">
				<textarea rows="15" style="width:99%;" name="notice_desc">${detail.notice_desc}</textarea>
			</td>
		</tr>
	</table>
</div>