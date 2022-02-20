
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 진행상태조회
	 * 파일명 		: acceptHistorySub.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.11    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />

<c:set var="list_size" value="${fn:length(historyList)}" />
<table class="list_table" >
	<c:if test="${list_size == 0}">
		<tr>
			<th>진행구분</th>
			<td>
				<label>이력정보가 없습니다.</label>
			</td>
			<th>부서</th>
			<td>
				<label>이력정보가 없습니다.</label>
			</td>
			<th>이름</th>
			<td>
				<label>이력정보가 없습니다.</label>
			</td>
			<th>날짜</th>
			<td>
				<label>이력정보가 없습니다.</label>
			</td>
		</tr>
	</c:if>
	<c:if test="${list_size > 0}">
		<c:forEach var="state" items="${historyList}" varStatus="status">
			<tr>
				<th>진행구분</th>
				<td>
					<label>${state.sample_state_nm}</label>
				</td>
				<th>부서</th>
				<td>
					<label>${state.dept_nm}</label>
				</td>
				<th>이름</th>
				<td>
					<label>${state.user_nm}</label>
				</td>
				<th>날짜</th>
				<td>
					<label>${state.work_date}</label>
				</td>
			</tr>
			<c:if test="${!empty state.etc}">
				<tr>
					<th>내용</th>
					<td colspan="9">
						<textarea style="width: 100%;" rows="4">${state.etc}</textarea>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</c:if>
</table>
