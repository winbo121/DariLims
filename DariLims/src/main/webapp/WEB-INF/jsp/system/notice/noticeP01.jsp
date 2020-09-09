
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 공지사항 팝업
	 * 파일명 		: noticeP01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.02.10
	 * 설  명		: 공지사항 팝업  
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.10   정우용		최초 프로그램 작성         
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
<title>통합장비관제시스템</title>

<script type="text/javascript">
	$(function() {
		//fnDatePickerImg('notice_start');
		//fnDatePickerImg('notice_end');
		$(window).unload(function() {
			closeWin();
		});
	});

	function setCookie(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + expiredays);
		document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}

	function closeWin() {
		if (document.pop.Notice.checked)
			setCookie("popup" + $("#notice_no").val(), "done", 1);//1은 하루동안 새창을 열지 않게 합니다.
		self.close();
	}
</script>
</head>
<body id="popBody">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>공지사항</h2>
			<div class="pop_intro sub_blue_01" style="margin-top: 8px;">
				<table  class="list_table table_title">
					<tr>
						<th>제목</th>
						<td style="width: 360px;">
							<input type="hidden" id="notice_no" name="notice_no" value="${detail.notice_no}" />
							${detail.notice_title}
						</td>
						<th>공지기간</th>
						<td style="text-align: center;">${detail.notice_start} ~ ${detail.notice_end}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea rows="5" name="notice_desc" style="width: 100%; height: 400px;" readonly>${detail.notice_desc}</textarea>
						</td>
					</tr>
				</table>
				<div>
					<form name="pop" onsubmit="return false;">
						<p style="text-align: center; vertical-align: middle; padding-top: 10px;">
							<input type="checkbox" name="Notice" value="">
							오늘하루 공지 보지않음 <a href="javascript:history.onclick=closeWin()"> [닫기]</a>
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>