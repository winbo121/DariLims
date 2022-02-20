
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
	$(function() {
		
		ajaxComboForm("report_type", "C60001", "CHOICE", "", "reportWriteform");
		ajaxComboForm("test_goal", "C05", '${detail.test_goal }', null, "reportWriteform");

		$('#reportWriteform').find("#report").change(function() {
		});
		$('#reportWriteform').find("input[id=onnara_link_yn]").click(function() {
		});
	});
</script>

<form id="reportWriteform" name="reportWriteform" onsubmit="return false;">
	<table  class="list_table" >
		<tr>
			<th>성적서번호</th>
			<td>
				<input id="vw_report_doc_seq" type="text" class="inputhan w100px dis" disabled="disabled" />
				<input name="report_doc_seq" id="report_doc_seq" type="hidden" />
			</td>
			<th>접수번호</th>
			<td>
				<input type="text" class="inputhan w100px dis" value="${detail.test_req_no }" disabled="disabled" />
				<input name="test_req_no" id="test_req_no" type="hidden" value="${detail.test_req_no }" />
				<input name="test_req_seq" id="test_req_seq" type="hidden" value="${detail.test_req_seq }" />
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3">
				<input name="title" id="title" type="text" class="inputhan w100p" value="${detail.title }" />
			</td>
		</tr>
		<tr>
			<th>의뢰일자</th>
			<td>
				<input name="req_date" id="req_date" type="text" class="inputhan w100px dis" value="${detail.req_date }" disabled="disabled" />
			</td>
			<th>검사완료일자</th>
			<td>
				<input name="dept_appr_date" id="dept_appr_date" type="text" class="inputhan w100px dis" value="${detail.dept_appr_date }" disabled="disabled" />
			</td>
		</tr>
		<tr>
			<th>의뢰처</th>
			<td colspan="3">
				<input name="zip_code" id="zip_code" type="hidden" value="${detail.zip_code4 }" />
				<input name="destination_nm" id="destination_nm" type="text" class="inputhan w200px" value="${detail.req_org_nm4 }" />
				<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="btn_Req_Org" onclick="fn_zipcode();">
				<input name="req_org_addr" id="req_org_addr" type="text" class="inputhan w300px" value="${detail.req_org_addr4 }" />
			</td>
		</tr>
		<tr>
<!-- 			<th>검사목적</th>
			<td>
				<select id="test_goal" name="test_goal" class="w200px" disabled="disabled"></select>
			</td> -->
			<th>의뢰자</th>
			<td>
				<input name=req_nm id="req_nm" type="text" class="inputhan w200px" value="${detail.req_nm}" />
			</td>
			<th>성적서종류</th>
			<td>
				<select id="report" name="report_type" class="w200px"></select>
			</td>
		</tr>
	</table>
	<div id="kolasDiv" style="display: none;">
		<table  class="list_table" >
			<tr>
				<th>성적서 용도</th>
				<td colspan="3">
					<input type="text" class="w100p" id="kolas_rpt_use" name="kolas_rpt_use">
				</td>
			</tr>
			<tr>
				<th>시료 내용</th>
				<td colspan="3">
					<input type="text" class="w100p" id="kolas_smp_desc" name="kolas_smp_desc">
				</td>
			</tr>
			<tr>
				<th>시험환경</th>
				<td colspan="3">
					<input type="text" class="w100p" id="kolas_test_env" name="kolas_test_env">
				</td>
			</tr>
		</table>
	</div>
	<div id="approvalDiv" style="display: none;">
		<table  class="list_table" >
			<tr>
				<th>실무자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
				<th>실무자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
				<th>실무자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
			</tr>
			<tr>
				<th>기술책임자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
				<th>기술책임자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
				<th>기술책임자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
			</tr>
			<tr>
				<th>담당자</th>
				<td>
					<input type="text" value="${session.user_nm }" class="w80px" id="approvalSelect">
				</td>
				<th>품질책임자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
				<th>경영책임자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
			</tr>
		</table>
	</div>
	<div id="approvalDiv2" style="display: none;">
		<table  class="list_table" >
			<tr>
				<th>확인자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
				<th>기술책임자</th>
				<td>
					<input type="text" class="w80px" id="approvalSelect">
				</td>
			</tr>
		</table>
	</div>
	<div id="onnaraDiv" style="display: none;">
		<table  class="list_table" >
			<tr>
				<th>연계 제목</th>
				<td>
					<input name="onnara_title" id="onnara_title" type="text" class="inputhan w100p" />
				</td>
			</tr>
			<tr>
				<th>연계 내용</th>
				<td colspan="3">
					<textarea rows="3" name="onnara_con" id="onnara_con" style="width: 100%;"></textarea>
				</td>
			</tr>
		</table>
	</div>
</form>
