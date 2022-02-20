
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교육과정 상세
	 * 파일명 		: EduCurriculumD01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.27
	 * 설  명		: 교육과정 등록 상세보기 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.27    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >

<div class="sub_blue_01">
	<table class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeg auth_select" id="btn_Edu_Attend" onclick="btn_Edu_Attend_onclick('${detail.edu_result_no }')">
					<button type="button">교육참석자명단</button>
				</span>
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
				<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
					<button type="button">삭제</button>
				</span>
			</td>
		</tr>
	</table>
</div>
<table class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th class="indispensable">교육종류</th>
		<td>
			<input type="hidden" id="edu_result_no" name="edu_result_no" value="${detail.edu_result_no }">
			<input id="edu_kind_val" type="hidden" class="inputhan" value="${detail.edu_kind }" />
			<select name="edu_kind" id="edu_kind"></select>
		</td>
		<th class="indispensable">관리부서</th>
		<td>
			<select name="mgr_dept" id="dept_cd"></select>
			<input id="dept_cd_val" type="hidden" class="inputhan" value="${detail.mgr_dept }" />
		</td>
		<th class="indispensable">교육기관</th>
		<td>
			<input name="edu_org" id="edu_org" type="text" class="inputhan" value="${detail.edu_org }">
		</td>
	</tr>
	<tr>
		<th>교육장소</th>
		<td>
			<input name="edu_place" id="edu_place" type="text" class="inputhan" value="${detail.edu_place }" />
		</td>
		<th class="indispensable">교육시작일</th>
		<td>
			<input name="edu_sdate" id="edu_sdate" type="text" class="w100px" readonly="readonly" value="${detail.edu_sdate }" />
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="eduSdateStop" style="cursor: pointer;" onClick='fn_TextClear("edu_sdate")' />
		</td>
		<th class="indispensable">교육종료일</th>
		<td>
			<input name="edu_edate" id="edu_edate" type="text" class="w100px" readonly="readonly" value="${detail.edu_edate }" />
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="eduEdateStop" style="cursor: pointer;" onClick='fn_TextClear("edu_edate")' />
		</td>
	</tr>
	<tr>
		<th class="indispensable">사내외구분</th>
		<td>
			<%-- 			<input name="edu_Type" type="text" class="inputhan" value="${detail.edu_Type }" /> --%>
			<input type="radio" name="edu_type" id="edu_type" style="top: 1px;" class="w15" value="사내" <c:if test="${detail.edu_type == '사내' || detail.edu_type == null || detail.edu_type == '' }">checked="checked"</c:if> />
			사내
			<input type="radio" name="edu_type" id="edu_type" style="margin-left: 15px; top: 1px;" class="w15" value="사외" <c:if test="${detail.edu_type == '사외' }">checked="checked"</c:if> />
			사외
		</td>
		<th>교육내용</th>
		<td>
			<input name="edu_content" type="text" class="inputhan" value="${detail.edu_content }" />
		</td>
		<th rowspan="2">비고사항</th>
		<td rowspan="2">
			<textarea style="width: 80%;" name="edu_desc" class="inputhan" rows="3">${detail.edu_desc }</textarea>
		</td>
	</tr>
	<tr>
		<th>문서명</th>
		<td>
			<input name="edu_doc_no" type="hidden" class="inputhan" value="${detail.edu_doc_no }">
			<input name="doc_nm" type="text" class="inputhan" value="${detail.doc_nm }" />
		</td>
		<th>문서내용</th>
		<!-- 파일형식 -->
		<td>
			<input name="file_nm" id="file_nm" type="hidden" value="${detail.file_nm }" />
			<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
				<label id="file_name"><a href="kolas/eduCurriculumDown.lims?edu_doc_no=${detail.edu_doc_no }">${detail.file_nm }</a></label>
				<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("edu_file"), fn_TextClear("file_nm")' />
			</c:if>
			<input name="edu_file" id="edu_file" type="file" />
		</td>
	</tr>
</table>