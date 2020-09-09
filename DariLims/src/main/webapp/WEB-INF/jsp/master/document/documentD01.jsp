
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 양식관리 상세
	 * 파일명 		: documentD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.01
	 * 설  명		: 양식관리 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.01    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {

		fnDatePickerImg('revisionDate');
	});	
</script>
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
			</td>
		</tr>
	</table>
	<table class="list_table">
		<tr>
			<th class="indispensable" style="min-width:120px;">개정일</th>
			<td>
				<input name="doc_revision_date" id="revisionDate" type="text" class="w80px inputCheck" readonly="readonly"  value="${detail.doc_revision_date}" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="dateDel" style="cursor: pointer;" onClick='fn_TextClear("revisionDate")' />
			</td>
		</tr>
		<tr>
			<th class="indispensable" style="height:40px;">문서</th>
			<!-- 파일형식 -->
			<td>
				<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
					<label id="file_name">첨부파일이 없습니다.</label>
				</c:if>
				<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
					<label id="file_name"><a href="master/formDocDown.lims?doc_seq=${detail.doc_seq}">${detail.file_nm}</a></label>
					<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("mul_file_att"), fn_TextClear("file_nm")' />
				</c:if>
				<br/>
				<input name="mul_file_att" id="mul_file_att" type="file"/>
				<input name="doc_seq" id="doc_seq" type="hidden" value="${detail.doc_seq}" /><!-- 문서번호 -->
				<input name="file_nm" id="file_nm" type="hidden" value="${detail.file_nm}" />
			</td>
		</tr>
		<th style="height:200px;">비고</th>
			<td>
				<textarea rows="14" cols="" name="etc" style="width: 95%">${detail.etc}</textarea>
			</td>
		</tr>				
	</table>