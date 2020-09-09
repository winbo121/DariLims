
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 산화물표기관리
 * 파일명 		: oxideMark02.jsp
 * 작성자 		: 한지연
 * 작성일 		: 2020.01.14
 * 설  명		: 산화물표기 추가 및 조회 화면
 *---------------------------------------------------------------------------------------
 * 변경일		 변경자		변경내역 
 *---------------------------------------------------------------------------------------
 *2020.01.14 한지연        	최초 프로그램 작성         
 * 
 *---------------------------------------------------------------------------------------
 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<div class="sub_blue_01">
	<table  class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
</div>
<table class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th class="indispensable">산화물표기 내용</th>
		<td>
			<input type="hidden" id="oxide_cd" name="oxide_cd" value="${detail.oxide_cd }" />
			<input name="oxide_content" id="oxide_content" type="text" class="inputhan" value="${detail.oxide_content}" />
		</td>
	</tr>
	<tr>
		<th class="indispensable">사용여부</th>
		<td>
			<input type="radio" name="used_flag" id="used_flag" style="margin-left: 15px; top: 1px;" class="w15" value="Y" <c:if test="${detail.used_flag == 'Y' || detail.used_flag == null || detail.used_flag == ''}">checked="checked"</c:if> />
			사용
			<input type="radio" name="used_flag" id="used_flag" style="margin-left: 15px; top: 1px;" class="w15" value="N" <c:if test="${detail.used_flag == 'N' }">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
</table>