
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 상담관리 개별 상담 팝업
 * 파일명 		: counselPersonalPop.jsp
 * 작성자 		: 허태원
 * 작성일 		: 2015.10.16
 * 설  명		: 상담관리 개별 상담 팝업 화면
 *---------------------------------------------------------------------------------------
 * 변경일		 변경자		변경내역 
 *---------------------------------------------------------------------------------------
 * 2015.10.16    허태원		최초 프로그램 작성         
 * 
 *---------------------------------------------------------------------------------------
 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>

<script type="text/javascript">
	var pageType = "${pageType}";
	$(function() {
		//최초상담일자
		fnDatePickerImg('counsel_date');
		
		//상담경로 콤보박스
		ajaxComboForm("counsel_path", "C56", "${detail.counsel_path}", "", "counselPersonalPopForm");
		//상담구분 콤보박스
		ajaxComboForm("counsel_div", "C70", "${detail.counsel_div}", "", "counselPersonalPopForm");
		//상담진행상태 콤보박스
		ajaxComboForm("counsel_progress_sts", "C63", "${detail.counsel_progress_sts}", "NON", "counselPersonalPopForm");
		//상담결과 콤보박스
		ajaxComboForm("counsel_result", "C67", "${detail.counsel_result}", "", "counselPersonalPopForm");
		
		//현재날짜
		if ($('#counselPersonalPopForm').find('#counsel_date').val() == '') {
			$('#counselPersonalPopForm').find('#counsel_date').val(fnGetToday(0,0));
		}
		
		// 최초 등록일때
		if(pageType == "insert"){
			$("#counsel_progress_sts option").not(":selected").attr("disabled", "disabled");
			var totalNo = "${totalNo}";
			$('#counselPersonalPopForm').find('#total_no').val(totalNo);
			
			$("#counsel_result").attr("disabled", "disabled"); // 상담결과
			$("#counsel_result_content").attr("disabled", "disabled"); // 상담결과
		}
	});
	
	// 개별상담 등록
	function btn_insert_onclick() {
		// 벨리데이션 체크
		if(formValidationCheck("counselPersonalPopForm")){
			return;
		}		
		
		$("#counsel_progress_sts option").not(":selected").attr("disabled", "");
		
		var param = $('#counselPersonalPopForm').serialize();		
		if(pageType == 'insert'){
			var json = fnAjaxAction(fn_getConTextPath()+'/insertCounselPersonal.lims', param);
			if (json == null) {
				alert("저장이 실패되었습니다.");
				return false;
			} else {				
				alert("저장이 완료되었습니다.");
				opener.fnpop_callback_personal();
				window.close();
			}	
		}
		else{			
			var json = fnAjaxAction(fn_getConTextPath()+'/updateCounselPersonal.lims', param);
			if (json == null) {
				alert("수정이 실패되었습니다.");
				return false;
			} else {				
				alert("수정이 완료되었습니다.");
				opener.fnpop_callback_personal();
				window.close();
			}
		}
	}
	
	// 상담결과 수정 이벤트
	function fn_counsel_result(result){
		if(result != '' && result != null){
			$('#counsel_progress_sts').val('C63002').attr('selected', 'selected');
			//$("#counsel_progress_sts option").not(":selected").attr("disabled", "disabled");
		} else {
			$("#counsel_progress_sts option").not(":selected").attr("disabled", false);
		}
	}
	
	// 상담진행상태 수정 이벤트
	function fn_counsel_progress(progress){
		if(progress == 'C63001'){
			$('#counsel_result').val('').attr('selected', 'selected');
			//$('#counsel_result_content').attr('readonly', '');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<form id="counselPersonalPopForm" name="counselPersonalPopForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table class="select_table" >
					<tr>
						<td class="table_title">
							<span>■</span>
							개별상담
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_save" id="btn_save" onclick="btn_insert_onclick();">
								<button type="button">저장</button>
							</span>
						</td>
					</tr>
				</table>
				<table class="list_table" >
					<tr>
						<th style="width:110px;">통합상담번호</th>
						<td>
							<input name="total_no" id="total_no" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.total_no}" />
						</td>
						<th>개별상담번호</th>
						<td>
							<input name="personal_no" id="personal_no" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.personal_no}" />
						</td>
					</tr>
					<tr>	
						<th class="indispensable" style="width:110px;">상담경로</th>
						<td>
							<select name="counsel_path" id="counsel_path" class="w100px inputCheck"></select>
						</td>							
						<th class="indispensable" style="width:110px;">상담구분</th>
						<td>
							<select name="counsel_div" id="counsel_div" class="w100px inputCheck"></select>
						</td>
					</tr>
					<tr>
						<th class="indispensable" style="width:110px;">상담일자</th>
						<td>
							<input name="counsel_date" id="counsel_date" type="text" class="w100px inputCheck" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.counsel_date}"/>
							<img src="<c:url value='../images/common/calendar_del.png'/>" id="counsel_dateStop" style="cursor: pointer;" onClick='fn_TextClear("counsel_date")' />
						</td>
						<th class="indispensable" style="width:110px;">진행상태</th>
						<td>
							<select name="counsel_progress_sts" id="counsel_progress_sts" class="w100px inputCheck" onChange="fn_counsel_progress(this.value);"></select>							
						</td>
					</tr>
					<tr>
						<th class="indispensable" style="width:110px; word-break:break-all;">상담내용</th>
						<td colspan="4">
							<textarea rows="22" cols="80" name="counsel_content" id="counsel_content" class="inputCheck" >${detail.counsel_content}</textarea>
						</td>
					</tr>
					<tr>
						<th style="width:110px; word-break:break-all;">상담결과</th>
						<td colspan="4">
							<select name="counsel_result" id="counsel_result" class="w100px" onChange="fn_counsel_result(this.value);" ></select>							
							<input name="counsel_result_content" id="counsel_result_content" style="vertical-align:middle;" type="text" class="w100px" value="${detail.counsel_result_content}"/>
<%-- 							<textarea rows="12" cols="80" name="counsel_result" id="counsel_result" >${detail.counsel_result}</textarea> --%>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</div>
</body>
</html>
