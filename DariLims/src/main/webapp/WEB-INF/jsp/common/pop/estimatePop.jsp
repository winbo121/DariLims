
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 견적팝업
	 * 파일명 		: estimatePop.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.09.21
	 * 설  명		: 공통팝업  
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.21    	윤상준		최초 프로그램 작성         
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>

<title>LIMS</title>

<script type="text/javascript">	
	$(function() {
		ajaxComboForm("est_gubun", "C57", "${detail.est_gubun}", "", 'estimatePopFrom');
		ajaxComboForm("est_state", "C58", "${detail.est_state}", '', "estimatePopFrom");
		fnDatePickerImg('est_date');
		
		if("insert" == $('#estimatePopFrom').find('#pageType').val()){
			$("#est_state").val("C58001");
		}
	});
	
	function btn_save_onclick(){
		
		if(formValidationCheck("estimatePopFrom")){
			return;
		}
		
		if("insert" == $('#estimatePopFrom').find('#pageType').val()){
			url = 'insertEstimate.lims';
		}else{
		 	url = 'updateEstimate.lims';
		}
		
		if (confirm("저장하시겠습니까?")) {
			var json = fnAjaxAction(url, $('#estimatePopFrom').serialize());
			if (json == null) {
				alert('저장 실패되었습니다.');
			} else {
				//$('#deptLimsGrid').trigger('reloadGrid');
				alert('저장이 완료되었습니다.');
			}
			opener.fnpop_callback();
			window.close();
		}	
	}
	
	// 견적업체 선택 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}
	
	// 견적업체
	function btn_search_onclick(){
		fnpop_reqOrgChoicePop("reqDetailForm", "750", "550", "견적업체");
		fnBasicStartLoading();
	}
	
	function fn_IdTextClear(textId, textId2) {
		if ($("#" + textId) != null || $("#" + textId2) != null) {
			$("#" + textId).val('');
			$("#" + textId2).val('');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
<div class="pop_area pop_intro">
	<h2>견적 관리</h2>
	
<div class="sub_purple_01">
<form name="estimatePopFrom" id="estimatePopFrom">
<input type="hidden" id="pageType" name="pageType" value="${pageType}"/>
<input type="hidden" id="est_no" name="est_no" value="${detail.est_no}"/>
<table class="select_table">
	<tr>
		<td class="table_title">
			<span>■</span>
			<c:if test="${pageType == 'insert'}">견적등록</c:if>
			<c:if test="${pageType == 'detail'}">견적수정</c:if>
		</td>
		<td class="table_button" >
			<span class="button white mlargeb auth_save" id="btn_Add" onclick="btn_save_onclick();">
				<button type="button">저장</button>
			</span>
		</td>
	</tr>
	
</table>
<table class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th class="indispensable" style="width: 17%;">견적제목</th>
		<td colspan = "3">
			<input id="est_title" name="est_title" class="w300px inputCheck" type="text" value="${detail.est_title}"/>
		</td>
	</tr>
	<tr>
		<th class="indispensable">견적일자</th>
		<td>
			<input name="est_date" id="est_date" type="text" class="w80px inputCheck" readonly="readonly" value="${detail.est_date}"/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("est_date")' /> 
		</td>
		<th class="indispensable" style="width: 17%;">견적구분</th>
		<td>
			<select name="est_gubun" id="est_gubun" class="inputCheck"></select>
		</td>
	</tr>
	<tr>
		<th class="indispensable">견적상태</th>
		<td>
			<select name="est_state" id="est_state" class="inputCheck"></select>
		</td>
		<th>Reference</th>
		<td>
			<input name="est_ref" id="est_ref" type="text"  value="${deatil.est_ref} "></select>
		</td>
	</tr>
	<tr>
		<th class="indispensable"> 견적업체명</th>
		<td>
			<input name="est_org_no" id="est_org_no" type="hidden" value="${detail.est_org_no}"/>
			<input name="est_org_nm" id="est_org_nm" type="text" class="w150px inputCheck" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.est_org_nm}"/>
			<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_Req_Org1" onclick='btn_search_onclick();'/>
			<img src="<c:url value='/images/common/icon_stop.png'/>" id="idClear" style="cursor: pointer;vertical-align:text-bottom;" onClick='fn_IdTextClear("est_org_nm", "est_org_no")' />
		</td>
		<th class="indispensable" >견적신청인</th>
		<td>
			<input id="est_charger_nm" name="est_charger_nm" class="inputCheck inputhan" type="text" value="${detail.est_charger_nm}"/>
		</td>
	</tr>
	<tr>
		<th>비고</th>
		<td colspan="3">
			<textarea id="est_desc"  name="est_desc" rows="10" cols="" class="w100p"><c:out value="${detail.est_desc}"></c:out></textarea>
		</td>
	</tr>
	<tr>
		<th >견적작성자</th>
		<td colspan="3">
			<input id="dept_nm" name="dept_nm" class="w200px" type="text" disabled="disabled" value="${dept_nm}"/>/
			<input id="user_nm" name="user_nm" class="w100px" type="text" disabled="disabled" value="${user_nm}"/>
			<input id="user_id" name="user_id" class="" type="hidden" value="${user_id}"/>
		</td>
	</tr>
	
</table>
</form>
</div>
</div>
</div>
</body>
</html>



