
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 단위업무
	 * 파일명 		: unitWorkD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 단위업무 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.21    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
	<table  class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
				<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
					<button type="button">삭제</button>
				</span>
			</td>
		</tr>
	</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>단위업무명</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id=unit_work_cd name="unit_work_cd" value="${detail.unit_work_cd}" />
			<input name="unit_work_nm" type="text" class="inputhan" value="${detail.unit_work_nm}" />
		</td>
		<th>단위업무설명</th>
		<!--입력불가-->
		<td>
			<input name="unit_work_desc" type="text" class="inputhan" value="${detail.unit_work_desc}" />
		</td>
		<th>사용여부</th>		
		<!--radio 버튼-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="Y"  <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="N"  <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
</table>