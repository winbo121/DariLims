
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: SMS관리
	 * 파일명 		: smsManageD01.jsp
	 * 작성자 		: 최은향	
	 * 작성일 		: 2015.12.08
	 * 설  명		: SMS관리 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.08    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style></style>
<script type="text/javascript">
	$(function() {

	});	
		
	// 저장 & 수정 이벤트
	function btn_save_onclick() {
		if (formValidationCheck("smsManageDetailForm")){
			return;
		}		
		disabledRun();
		var url ;
		if (fnIsEmpty($('#smsManageDetailForm').find('#sms_key').val())){
			var json = fnAjaxAction('system/selectSmsKeyCheck.lims', $('#smsManageDetailForm').serialize());
			if (json == null) {
				$.showAlert('저장 실패되었습니다.');
				return;
			} else if (json == "1") {
				$.showAlert('이미 등록되어 있는 정보가 있습니다.');
				return;
			} else {
				if (!confirm("저장하시겠습니까?")) {
					return;
				}
			}
			url = 'system/insertSmsManage.lims';
		} else {
		 	url = 'system/updateSmsManage.lims';
		}
		
		var json = fnAjaxAction(url, $('#smsManageDetailForm').serialize());
		if (json == null) {
			$.showAlert('저장 실패되었습니다.');
		} else {
			fn_Search_SmsManage();
			//$('#accessIpGrid').trigger('reloadGrid');
			//$('#detailDiv').empty();
			$.showAlert('저장이 완료되었습니다.');
		}
		
	}
	
	// 삭제 이벤트
	function btn_Delete_onclick() {
		disabledRun();
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
// 		if ($('#detail').find('#user_id').val() != '${session.user_id}') {
// 			$.showAlert('본인건만 삭제 가능합니다.');
// 		} else {
			var json = fnAjaxAction('system/deleteSmsManage.lims', $('#smsManageDetailForm').serialize());
			if (json == null) {
				$.showAlert('삭제 실패되었습니다.');
			} else {
				fn_Search_SmsManage();
				//$('#accessIpGrid').trigger('reloadGrid');
				//$('#detailDiv').empty();
				$.showAlert('삭제 완료되었습니다.');
			}
// 		}
	}
	
	// IP 입력시 이벤트
	function keyEventText(val, id, idE) {
		if (val != '' && !fnIsNumeric(val)) {
			$.showAlert('숫자만 입력가능합니다.');
			$("#"+id).val(val.substring(0, val.length - 1));
			$("#"+idE).val(val.substring(0, val.length - 1));
			return false;
		} else {
			$("#"+idE).val(val);
		}
	}
	
	function disabledRun(){
		$(':radio[id="sms_type"]:checked').attr("disabled", false);
		$(':radio[id="process"]:checked').attr("disabled", false);
	}
</script>

<div>
	<form id="smsManageDetailForm" name="smsManageDetailForm" onsubmit="return false;">
		<input id="sms_key" name="sms_key" class="w200px" type="hidden" value="${detail.sms_key}"/>
		<input type="hidden" id="pageType" name="pageType" value="${pageType}"/>
		<table class="select_table">
			<tr>
				<td class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #27aeea;">■</span>
					SMS 관리 정보
				</td>
				<td class="table_button" >
					<span class="button white mlargeg auth_save" id="btn_Add" onclick="btn_save_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">삭제</button>
					</span>
				</td>
			</tr>
		</table>		
		<table class="list_table">
			<tr>
				<th class="indispensable">문자타입</th>
				<td>
					<input type="radio" name="sms_type" id="sms_type" style="margin-left: 15px; top: 1px;" class="w15" value="A"  <c:if test="${detail.sms_type != 'B'}">checked="checked"</c:if> <c:if test="${detail.sms_type != null}">disabled</c:if> />
					일반
					<input type="radio" name="sms_type" id="sms_type" style="margin-left: 15px; top: 1px;" class="w15" value="B"  <c:if test="${detail.sms_type == 'B'}">checked="checked"</c:if> <c:if test="${detail.sms_type != null}">disabled</c:if> />
					잔류농약
				</td>
				<th class="indispensable">진행상황</th>
				<td>
					<input type="radio" name="process" id="process" style="margin-left: 15px; top: 1px;" class="w15" value="A"  <c:if test="${detail.process != 'F'}">checked="checked"</c:if> <c:if test="${detail.process != null}">disabled</c:if> />
					민원접수완료
					<input type="radio" name="process" id="process" style="margin-left: 15px; top: 1px;" class="w15" value="F"  <c:if test="${detail.process == 'F'}">checked="checked"</c:if> <c:if test="${detail.process != null}">disabled</c:if> />
					결과승인완료
				</td>
				<th class="indispensable" >발송전화번호</th>
				<td>
					<input id="send_tel_no" name="send_tel_no" class="w200px inputCheck inputhan" type="text" value="${detail.send_tel_no}" />
				</td>
			</tr>
			<tr>
				<th class="indispensable">메시지</th>
				<td colspan="5">
					<textarea rows="3" cols="90%" style="border: 1px solid #afafaf; margin:10px 0;" name="msg" id="msg" class="inputhan">${detail.msg}</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
