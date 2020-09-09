
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 접근IP관리
	 * 파일명 		: accessIpD01.jsp
	 * 작성자 		: 최은향	
	 * 작성일 		: 2015.12.08
	 * 설  명		: 접근IP관리 상세 조회 화면
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
		var startIp = "${detail.start_ip}";
		var endIp = "${detail.end_ip}";
		var arrStartIp = new Array;
		var arrEndIp = new Array;
		
		if(startIp != "" && startIp != null){
			arrStartIp = startIp.split("\.");
			$('#start_ip01').val(arrStartIp[0]);
			$('#start_ip02').val(arrStartIp[1]);
			$('#start_ip03').val(arrStartIp[2]);
			$('#start_ip04').val(arrStartIp[3]);
		}
		
		if(endIp != "" && endIp != null){
			arrEndIp = endIp.split("\.");
			$('#end_ip01').val(arrEndIp[0]);
			$('#end_ip02').val(arrEndIp[1]);
			$('#end_ip03').val(arrEndIp[2]);
			$('#end_ip04').val(arrEndIp[3]);
		}
	});	
		
	// 저장 & 수정 이벤트
	function btn_save_onclick() {
		if (formValidationCheck("accessIpDetailForm")){
			return;
		}		
		// 벨리데이션 체크
		var start_ip04 = $('#start_ip04').val();
		var end_ip04 = $('#end_ip04').val();
		
		if (Number(end_ip04) < Number(start_ip04)){
			alert('IP 범위가 잘못되었습니다.');
			$('#end_ip04').focus();
			return false;
		}		
		
		if (confirm("저장하시겠습니까?")) {
			var url ;
			if (fnIsEmpty($('#accessIpDetailForm').find('#ip_seq').val())){
				url = 'system/insertAccessIp.lims';
			} else {
			 	url = 'system/updateAccessIp.lims';
			}
 			var json = fnAjaxAction(url, $('#accessIpDetailForm').serialize());
			if (json == null) {
				$.showAlert('저장 실패되었습니다.');
			} else {
				fn_Search_accessIp();
				//$('#accessIpGrid').trigger('reloadGrid');
				//$('#detailDiv').empty();
				$.showAlert('저장이 완료되었습니다.');
			}
		}
	}
		
	// 삭제 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
// 		if ($('#detail').find('#user_id').val() != '${session.user_id}') {
// 			$.showAlert('본인건만 삭제 가능합니다.');
// 		} else {
			var json = fnAjaxAction('system/deleteAccessIp.lims', $('#accessIpDetailForm').serialize());
			if (json == null) {
				$.showAlert('삭제 실패되었습니다.');
			} else {
				fn_Search_accessIp();
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
</script>

<div>
	<form id="accessIpDetailForm" name="accessIpDetailForm" onsubmit="return false;">
		<input id="ip_seq" name="ip_seq" class="w200px" type="hidden"/>
		<table class="select_table">
			<tr>
				<td class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #27aeea;">■</span>
					접근 IP 정보
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
				<th class="indispensable">IP명</th>
				<td>
					<input id=ip_nm name="ip_nm" class="w200px inputCheck inputhan" type="text" value="${detail.ip_nm}"/>
				</td>
				<th class="indispensable">사용가능IP</th>
				<td>
					<input id="start_ip01" name="start_ip01" class="w20px inputCheck inputhan" maxlength="3" type="text" onkeyup="keyEventText($(this).val(),'start_ip01', 'end_ip01');"/>.
					<input id="start_ip02" name="start_ip02" class="w20px inputCheck inputhan" maxlength="3" type="text" onkeyup="keyEventText($(this).val(),'start_ip02', 'end_ip02');"/>.
					<input id="start_ip03" name="start_ip03" class="w20px inputCheck inputhan" maxlength="3" type="text" onkeyup="keyEventText($(this).val(),'start_ip03', 'end_ip03');"/>.
					<input id="start_ip04" name="start_ip04" class="w20px inputCheck inputhan" maxlength="3" type="text"/>~					 					
					<input id="end_ip01" name="end_ip01" class="w20px inputhan noinput" maxlength="3" type="text" readonly/>.
					<input id="end_ip02" name="end_ip02" class="w20px inputhan noinput" maxlength="3" type="text" readonly/>.
					<input id="end_ip03" name="end_ip03" class="w20px inputhan noinput" maxlength="3" type="text" readonly/>.
					<input id="end_ip04" name="end_ip04" class="w20px inputCheck inputhan" maxlength="3" type="text"/>
				</td>
				<th>사용여부</th>
				<td>
					<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="Y"  <c:if test="${detail.use_flag != 'N'}">checked="checked"</c:if> />
					사용함
					<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="N"  <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
					사용안함
				</td>
				
			</tr>
			<tr>
				<th>비고</th>
				<td colspan="5">
					<textarea rows="3" cols="90%" style="border: 1px solid #afafaf; margin:10px 0;" name="etc" id="etc" class="inputhan">${detail.etc}</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
