
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용일지
	 * 파일명 		: useLogD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.25
	 * 설  명		: 사용일지 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.25    최은향		최초 프로그램 작성         
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
		//fnDatePicker('use_sdate');
		//fnDatePicker('use_edate');
	});
</script>
<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			현황 상세정보
		</td>
		<td class="table_button">
			<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Insert_onclick();">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Delete_Sub1" onclick="btn_Delete_onclick();">
				<button type="button">삭제</button>
			</span>
		</td>
	</tr>
</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>사용시작일시</th>
		<td>
			<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
			<input type="hidden" id="use_no" name="use_no" value="${detail.use_no}" />
			<input id="use_sdate" name="use_sdate" type="text" value="${detail.use_sdate}" style="width:160px;text-align:center;" readonly/>
		</td>
		<th>사용종료일시</th>
		<td>
			<input id="use_edate" name="use_edate" type="text" value="${detail.use_edate}" style="width:160px;text-align:center;" readonly/>
		</td>		
	</tr>
	
	<tr>
		<th>사용목적</th>
		<!--한글우선입력-->
		<td>
			<input name="use_purpose" type="text" class="inputhan" value="${detail.use_purpose}" style="width:160px;" />
		</td>
		<th>장비사용자</th>
		<td>
			<input name="his_user" type="text" value="${detail.his_user}" style="width:160px;" />
		</td>		
	</tr>
	
	<tr>
		<th>장비사용비고</th>
		<!--한글우선입력-->
		<td colspan='3'>
			<textarea style="width: 250px; height:100px; border:1px solid #afafaf;" name="use_etc" class="inputhan">${detail.use_etc}</textarea>
		</td>
	</tr>
</table>