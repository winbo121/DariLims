
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매정보
	 * 파일명 		: buyingInfoD01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.17
	 * 설  명		: 구매정보 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.17   석은주		최초 프로그램 작성         
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
				<span class="button white mlargeb auth_save" id="btn_Pre_Insert" onclick="btn_Insert_onclick(1);">
					<button type="button">임시저장</button>
				</span>
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Bf_Insert_onclick();">
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
		<%--<th>*진행상태</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no" value="${detail.mtlr_mst_no }">
			<input type="hidden" id="buy_sts_val" value="${detail.buy_sts}">
			<select name="buy_sts" id="buy_sts" style="border:1px solid #afafaf;" disabled="disabled"></select>
		</td>		 --%>
		<th class="indispensable">구&nbsp;&nbsp;매&nbsp;&nbsp;년&nbsp;&nbsp;도</th>
		<td>
			<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no" value="${detail.mtlr_mst_no }">
			<input type="hidden" id="buy_sts" value="${detail.buy_sts}">
			<input type="hidden" id="buy_year_val" value="${detail.buy_year}">
			<select name="buy_year" id="buy_year" style="border:1px solid #afafaf; width: 115px;"></select>
		</td>
		<th class="indispensable">구&nbsp;&nbsp;매&nbsp;&nbsp;분&nbsp;&nbsp;기</th>
		<!--한글우선입력-->
		<td>
			<input id="buy_q_val" type="hidden" class="inputhan" value="${detail.buy_q}" />
			<select id="buy_q" name="buy_q" style="border:1px solid #afafaf; width: 115px;"></select>
		</td>
		<th class="indispensable">구&nbsp;&nbsp;매&nbsp;&nbsp;명&nbsp;&nbsp;칭</th>
		<td>
			<input name="buy_title" id="buy_title" type="text" class="inputhan" value="${detail.buy_title}" class="w300px"/>
		</td>							
	</tr>
	<%-- <tr>				
		<th>진행상태</th>
		<td>
			<input name="state" type="text" class="inputhan" value="${detail.state}" />
		</td>		
	</tr> --%>
	<tr>
		<th>수요조사시작일</th>
		<td>
			<input name="buy_date" id="buy_date" type="text" class="w100px" readonly="readonly" value="${detail.buy_date }"/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("buy_date")' />
		</td>		
		<th>수요조사종료일</th>
		<td colspan="3">
			<input name="dmd_date" id="dmd_date" type="text" class="w100px" readonly="readonly" value="${detail.dmd_date }"/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("dmd_date")' />
		</td>
	</tr>
	<tr>		
		<th>구&nbsp;&nbsp;매&nbsp;&nbsp;비&nbsp;&nbsp;고</th>
		<!-- textarea -->
		<td colspan="5" style="height: 85px;">
			<textarea style="border:1px solid #afafaf; width: 95%" rows="5" name="buy_etc" class="inputhan">${detail.buy_etc}</textarea>
		</td>
	</tr>
</table>