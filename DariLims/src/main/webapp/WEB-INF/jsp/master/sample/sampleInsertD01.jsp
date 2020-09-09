<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료유형등록
	 * 파일명 		: sampleInsertD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 시료유형등록 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.21    최은향		최초 프로그램 작성
	 * 2015.10.13    윤상준		수정 
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
		ajaxComboForm("sample_gubun_cd", "C62", "${detail.sample_gubun_cd}", "", "detail");
	});
		
</script>
	<table  class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
<!-- 				<span class="button white mlarger" id="btn_Delete" onclick="btn_Delete_onclick();"> -->
<!-- 					<button type="button">삭제</button> -->
<!-- 				</span> -->
			</td>
		</tr>
	</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>시료구분</th>
		<td>
			<select name="sample_gubun_cd" id="sample_gubun_cd" class="w200px"></select>
		</td>
		<th class="indispensable">시료유형명</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="sample_cd" name="sample_cd" value="${detail.sample_cd}">
			<input name="sample_nm" type="text" class="inputhan w200px" value="${detail.sample_nm}" />
		</td>
		<th>시료영문명/약어</th>		
		<td>
			<input name="sample_eng_nm" type="text" class="w100px" value="${detail.sample_eng_nm}" />
			<input name="sample_abbr" type="text" class="w80px" value="${detail.sample_abbr}" />
		</td>
	</tr>
	<tr>
		<th >생산업체</th>
		<td>
			<input name="making_org_nm" type="text" class="inputhan w200px" value="${detail.making_org_nm}" />
		</td>
		<th>사업자번호</th>		
		<td>
			<input name="making_org_no" type="text" class="w200px" value="${detail.making_org_no}" />
		</td>
		<th>연락처</th>		
		<td>
			<input name="making_org_tel" type="text" class="w200px" value="${detail.making_org_tel}" />
		</td>
	</tr>
	<tr>
		<th >수입업체</th>
		<td>
			<input name="import_org_nm" type="text" class="inputhan w200px" value="${detail.import_org_nm}" />
		</td>
		<th>사업자번호</th>		
		<td>
			<input name="import_org_no" type="text" class="w200px" value="${detail.import_org_no}" />
		</td>
		<th>연락처</th>		
		<td>
			<input name="import_org_tel" type="text" class="w200px" value="${detail.import_org_tel}" />
		</td>
	</tr>
	<tr>
		<th class="list_table_p">사용여부</th>
		<!--radio 버튼-->
		<td colspan="5">
			<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="Y"  <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="N"  <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
	<tr>
		<th>설명</th>
		<!--한글우선입력-->
		<td colspan="5">
			<textarea style="width: 98%; height:100px;" name="sample_desc" class="inputhan">${detail.sample_desc}</textarea>
		</td>
	</tr>
</table>