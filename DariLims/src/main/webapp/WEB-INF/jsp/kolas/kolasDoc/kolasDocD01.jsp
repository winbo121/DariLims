
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 문서등록상세
	 * 파일명 		: kolasDocD01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.03
	 * 설  명		: 문서등록 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.03    석은주		최초 프로그램 작성         
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
		<th>부서</th>
		<td style="min-width: 120px;">
			<input name="create_dept" type="hidden" class="noinput" value="${detail.create_dept }" />
			<input name="dept_nm" type="text" class="noinput" value="${detail.dept_nm }" readonly="readonly" />
		</td>
		<th>등록자</th>
		<td style="min-width: 180px;">
			<input name="creater_id" type="hidden" class="noinput" value="${detail.creater_id }" />
			<input name="user_nm" type="text" class="noinput" value="${detail.user_nm }" readonly="readonly" />
		</td>
		<th>등록일</th>
		<td style="min-width: 160px;">
			<input name="create_date" id="create_date" type="text" class="w100px" readonly="readonly" value="${detail.create_date }" />
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("create_date")' />
		</td>
		<th class="indispensable">사용여부</th>
		<!--input필수입력-->
		<td style="min-width: 160px;">
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="Y" <c:if test="${detail.use_flag == 'Y' || detail.use_flag == null || detail.use_flag == ''}">checked="checked"</c:if> />
			사용
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="N" <c:if test="${detail.use_flag == 'N' }">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
	<tr>
		<th class="indispensable">문서구분</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="kolas_doc_no" name="kolas_doc_no" value="${detail.kolas_doc_no }" />
			<input type="hidden" id="doc_type_val" value="${detail.doc_type }">
			<select id="doc_type" name="doc_type"></select>
		</td>
		<th class="indispensable">제목</th>
		<td colspan="5">
			<input name="doc_title" id="doc_title" type="text" class="inputhan" value="${detail.doc_title }" />
		</td>
	</tr>
	<tr>
		<th>문서명</th>
		<td colspan="3">
			<input name="file_nm" type="text" class="inputhan" value="${detail.file_nm }" />
		</td>
		<th>첨부파일</th>
		<!-- 파일형식 -->
		<td colspan="3">
			<input name="file_no" id="file_no" type="hidden" value="${detail.file_no }">
			<input name="add_file_nm" id="add_file_nm" type="hidden" value="${detail.add_file_nm }" />
			<c:if test="${detail.add_file_nm == null ||  detail.add_file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${detail.add_file_nm != null && detail.add_file_nm != ''}">
				<label id="file_name"><a href="kolas/kolasDocDown.lims?file_no=${detail.file_no }">${detail.add_file_nm }</a></label>
				<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("kolas_file"), fn_TextClear("add_file_nm")' />
			</c:if>
			<input name="kolas_file" id="kolas_file" type="file" />
		</td>
	</tr>
	<tr>
		<th>비고</th>
		<td colspan="7">
			<textarea rows="4" cols="" name="etc" style="width: 95%">${detail.etc }</textarea>
		</td>
	</tr>
</table>