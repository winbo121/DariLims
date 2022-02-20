
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 보고서작성
	 * 파일명 		: paperWriteD01.jsp
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowY" />
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		fnDatePickerImg('week_start');
		fnDatePickerImg('week_end');
		fnDatePickerImg('write_date');
		$('#paperDetailForm').find('#write_date').val(fnGetToday(0,0));

		ajaxComboForm("qreport_id", '', "${detail.qreport_id}", 'NON', 'paperDetailForm');
		if ('${detail.qreport_id}' == '') {
			fn_set_unit_work_nm($('#paperDetailForm').find('#qreport_id').val());
		}
		ajaxComboForm("qreport_type", "C54", "${detail.qreport_type}", "NON", "paperDetailForm");
		ajaxComboForm("quart", "C14", "${detail.quart}", "", "paperDetailForm");
		$('#paperDetailForm').find("#qreport_id").change(function() {
			fn_set_unit_work_nm($(this).val());
		});

		fn_show_type('typeTh', 'paperDetailForm', $('#paperDetailForm').find("#qreport_type").val());
		$('#paperDetailForm').find("#qreport_type").change(function() {
			fn_show_type('typeTh', 'paperDetailForm', $(this).val());
		});
		$('#paperDetailForm').find("input[id=onnara_link_yn]").click(function() {
			var val = $(this).val();
			if (val == 'Y') {
				$('#onnaraDiv').show();
			} else {
				$('#onnaraDiv').hide();
				$('#onnara_title').val('');
				$('#onnara_con').val('');
			}
		});
	});
	function fn_set_unit_work_nm(val) {
		var arr = val.split('$%');
		if (arr.length > 2) {
			$('#paperDetailForm').find('#unit_work_nm').text(arr[2]);
		} else {
			$('#paperDetailForm').find('#unit_work_nm').text('');
		}
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="paperDetailForm" name="paperDetailForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					보고서 상세정보
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>보고서</th>
				<td style="width: 240px;">
					<input name="qreport_no" id="qreport_no" type="hidden" value="${detail.qreport_no }" />
					<input name="user_id" id="user_id" type="hidden" value="${detail.user_id }" />
					<select name="qreport_id" id="qreport_id" class="w200px"></select>
				</td>
				<th>단위업무</th>
				<td>
					<label id="unit_work_nm">${detail.unit_work_nm }</label>
				</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>
					<input name="write_date" id="write_date" type="text" class="w80px" readonly="readonly" value="${detail.write_date }" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("write_date")' />
				</td>
				<th>작성자</th>
				<td>
					<label>${session.user_nm}</label>
				</td>
			</tr>
			<tr>
				<th>구분</th>
				<td>
					<select name="qreport_type" id="qreport_type" class="w80px"></select>
				</td>
				<th id="typeTh"></th>
				<td colspan="2">
					<select name="year" id="year" class="w80px">
						<c:forEach begin="2000" end="2030" var="va">
							<option value="${va }" <c:if test="${nowY == va}">selected="selected"</c:if>>${va }</option>
						</c:forEach>
					</select>
					<select name="quart" id="quart" class="w80px"></select>
					<select name="mon" id="mon" class="w80px">
						<c:forEach begin="1" end="12" varStatus="st">
							<option value="${st.count }" <c:if test="${detail.mon ==  st.count}">selected="selected"</c:if>>${st.count }</option>
						</c:forEach>
					</select>
					<div id="dateDiv">
						<input name="week_start" id="week_start" type="text" class="w80px" readonly="readonly" value="${detail.week_start }" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("week_start")' /> ~
						<input name="week_end" id="week_end" type="text" class="w80px" readonly="readonly" value="${detail.week_end }" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("week_end")' />
					</div>
				</td>
			</tr>
			<tr>
				<th>업무관리시스템 연계</th>
				<td colspan="3">
					<input type="radio" id="onnara_link_yn" name="onnara_link_yn" value="Y">
					<label>예</label>
					<input type="radio" id="onnara_link_yn" name="onnara_link_yn" value="N" checked="checked">
					<label>아니요</label>
				</td>
			</tr>
		</table>
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
</div>
