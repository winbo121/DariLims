
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 출력물 개정 정보
	 * 파일명 		: revisionPop.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2019.11.18
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.18    허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
input.dis {
	background-color: #e4e4e4;
}
</style>
<script type="text/javascript">
var printGbn = "${printGbn}";
$(function() {
	
	ajaxComboForm("form_seq", printGbn, "NON", null, "revisionPopForm");
	ajaxComboForm("doc_seq", $("#form_seq option:selected").val(), "", "NON", "revisionPopForm");
	
	$("#revisionPopForm").find("#form_seq").change(function() {
		ajaxComboForm("doc_seq", $(this).val(), "", null, "revisionPopForm");
	});
});
</script>

<form id="revisionPopForm" name="revisionPopForm" onsubmit="return false;">
	<table  class="list_table"  style="border-top: solid 1px #82bbce;">
		<tr>
			<th class="indispensable">출력물종류</th>
			<td>
				<select id="form_seq" name="form_seq" class="w200px inputCheck"></select>
			</td>
			<th class="indispensable">개정번호</th>
			<td>
				<select id="doc_seq" name="doc_seq" class="w200px inputCheck"></select>
			</td>
		</tr>
	</table>
</form>
