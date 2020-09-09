
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 성적서작성 정보
	 * 파일명 		: reportWriteP01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.03.10
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.10    진영민		최초 프로그램 작성         
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
var viewGbn = "${viewGbn}";

$(function() {
	ajaxComboForm("form_seq", "C60001", "${detail2.form_seq}", "NON", "reportWritePopForm");
	
	ajaxComboForm("doc_seq", "${detail2.form_seq}" != "" ? "${detail2.form_seq}" : $("#form_seq option:selected").val(), "", "NON", "reportWritePopForm");
	
	$("#reportWritePopForm").find("#report_no").val("${detail2.report_no}");
	
	if(viewGbn == "PUBLISH"){
		/* $(".reportWritePopTR").show(); */
		$(".reportWritePopTR").hide();
		$("#reportWritePopForm").find("#form_seq").prop("disabled",true);
		$(".reportWritePopOnly").hide();
	}else{
		$(".reportWritePopTR").hide();		
		$(".reportPublishPopOnly").hide();		
	}
	
	$("#reportWritePopForm").find("#form_seq").change(function() {
		ajaxComboForm("doc_seq", $(this).val(), "", "NON", "reportWritePopForm");
	});
});
</script>

<form id="reportWritePopForm" name="reportWritePopForm" onsubmit="return false;">
	<table class="list_table"  style="border-top: solid 1px #82bbce;">
		<tr>
			<th>성적서번호</th>
			<td>
				<input id="report_no" type="text" class="inputhan w100px dis" disabled="disabled" />
				<input name="report_doc_seq" id="report_doc_seq" type="hidden" />				
			</td>
			<th>접수번호</th>
			<td>
				<input type="text" class="inputhan w100px dis" value="${detail.test_req_no }" disabled="disabled" />
				<input name="test_req_no" id="test_req_no" type="hidden" value="${detail.test_req_no }" />
				<input name="test_req_seq" id="test_req_seq" type="hidden" value="${detail.test_req_seq }" />
			</td>
		</tr>
		<tr class="reportWritePopTR">
			<th>제목</th>
			<td colspan="3">
				<input name="title" id="title" type="text" class="inputhan w100p" value="${detail.title }" />
			</td>
		</tr>
		<tr class="reportWritePopTR">
			<th>의뢰일자</th>
			<td>
				<input name="req_date" id="req_date" type="text" class="inputhan w100px dis" value="${detail.req_date }" disabled="disabled" />
			</td>
			<th>검사완료일자</th>
			<td>
				<input name="dept_appr_date" id="dept_appr_date" type="text" class="inputhan w100px dis" value="${detail.dept_appr_date }" disabled="disabled" />
			</td>
		</tr>
		<tr class="reportWritePopTR">
			<th>의뢰처</th>
			<td colspan="3">
				<input name="zip_code" id="zip_code" type="hidden" value="${detail.zip_code4 }" />
				<input name="destination_nm" id="destination_nm" type="text" class="inputhan w200px" value="${detail.req_org_nm4 }" />
				<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="btn_Req_Org" onclick="fnpop_reqOrgChoice('reportWritePopForm', '750', '550', '성적서_POPUP');">
				<input name="req_org_addr" id="req_org_addr" type="text" class="inputhan w300px" value="${detail.req_org_addr4 }" />
			</td>
		</tr>
		<tr class="reportWritePopTR">
			<th>의뢰자</th>
			<td colspan="3">
				<input name=req_nm id="req_nm" type="text" class="inputhan w200px" value="${detail.req_nm}" />
			</td>
		</tr>
		<tr>
			<th class="indispensable">성적서종류</th>
			<td>
				<select id="form_seq" name="form_seq" class="w200px inputCheck"></select>
			</td>
			<th class="indispensable">개정번호</th>
			<td>
				<select id="doc_seq" name="doc_seq" class="w200px inputCheck"></select>
			</td>
		</tr>
		<tr class="reportWritePopOnly">
			<th>비고</th>
			<td colspan = "3">
				<textarea rows="2"  style="width: 100%;" name="req_etc" id="req_etc" type="text" class="inputhan"  >
ar: As received basis, ad: Air dried basis, d: Dried basis</textarea>
			</td>
		</tr>
		<tr class="reportPublishPopOnly">
			<th>지연사유</th>
			<td colspan = "3">
				<textarea rows="2"  style="width: 100%;" name="report_exceed_reason" id="report_exceed_reason" type="text" class="inputhan"  ></textarea>
			</td>
		</tr>
	</table>
</form>

<!-- <div id="setDownloadFileName">setDownloadFileName</div> -->
