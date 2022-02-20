
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수리등록
	 * 파일명 		: repairD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.27
	 * 설  명		: 수리등록 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.27    최은향		최초 프로그램 작성         
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
		//fnDatePicker('rpr_date');
		fnDatePickerImg('rpr_date');
	});
</script>

<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			수리 상세정보
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
		<th>수리업체</th>
		<td>
			<input name="rpr_company" type="text" value="${detail.rpr_company}"  class="inputhan" style="width:160px;"/>
			<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
			<input type="hidden" id="rpr_no" name="rpr_no" type="text" value="${detail.rpr_no}" />
		</td>
		<th>수리업체연락처</th>
		<td>
			<input name="rpr_tel" type="text" class="inputhan" style="width:100px;" value="${detail.rpr_tel}" />
		</td>
	</tr>
	
	<tr>
		<th class="indispensable">수리일자</th>
		<td>
			<input name="rpr_date" id="rpr_date" type="text" class="inputhan" value="${detail.rpr_date}" style="width:80px; text-align:center;" readonly/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="rpr_date_Del" style="cursor: pointer;" onClick='fn_TextClear("rpr_date")'/>
		</td>
		<th>확인자</th>
		<td>
			<input name="rpr_user_nm" id="rpr_user_nm" type="text" style="width:100px;" value="${detail.rpr_user_nm}" readonly/>
			<input name="rpr_user_id" id="rpr_user_id" type="hidden" style="width:100px;" value="${detail.rpr_user_id}"/>
			<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="btn_Pop_AdminChoice();">
<%-- 			<input name="rpr_user_id" type="text" value="${detail.rpr_user_id}"  style="width:100px;"/> --%>
		</td>
	</tr>
		
	<tr>
		<th>고장사유</th>
		<td>
			<textarea style="width: 350px; height:100px; border:1px solid #afafaf;" name="brk_reason" class="inputhan">${detail.brk_reason}</textarea>
		</td>		
		<th>수리내용</th>
		<td>
			<textarea style="width: 350px; height:100px; border:1px solid #afafaf;" name="rpr_content" class="inputhan">${detail.rpr_content}</textarea>
		</td>
	</tr>
</table>