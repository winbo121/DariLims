
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 메뉴관리
	 * 파일명 		: menuD01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.01.20
	 * 설  명		: 메뉴관리 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.20    정우용		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>검체명</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="sample_cd" name="sample_cd" value="${detail.sample_cd }">
			<input name="sample_nm" type="text" class="inputhan" value="${detail.sample_nm }" />
		</td>
		<th>검체영문명</th>
		<!--영문우선입력-->
		<td>
			<input name="sample_Ename" type="text" class="" value="${detail.sample_Ename}" />
		</td>
	</tr>
	<tr>
		<th class="list_table_p">검체약어</th>
		<!--영문우선입력-->
		<td>
			<input name="sample_Abbr" type="text" class="" value="${detail.sample_Abbr}" maxLength = "2"/>
		</td>
		<th>설명</th>
		<!--한글우선입력-->
		<td>
			<input name="sample_Desc" type="text" class="inputhan" value="${detail.sample_Desc}" />
		</td>
	</tr>
	<tr>
		<th class="list_table_p">사용여부</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="1"  <c:if test="${detail.use_flag == 1}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="0"  <c:if test="${detail.use_flag == 0}">checked="checked"</c:if> />
			사용안함
		</td>
		<th class="list_table_p"></th>
		<td>
		</td>
	</tr>
</table>
