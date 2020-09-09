
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 통합상담
 * 파일명 		: counselTotalPop.jsp
 * 작성자 		: 허태원
 * 작성일 		: 2015.10.16
 * 설  명		: 상담관리 업체 팝업 화면
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

<!DOCTYPE html>
<html id="popHtml" class="minH170">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>
<title>LIMS</title>

<script type="text/javascript">
	var pageType = "${pageType}";
	$(function() {		
		//최초상담일자
		fnDatePickerImg('counsel_date');
		//상담경로 콤보조회
		ajaxComboForm("counsel_path", "C56", "", "", "counselTotalPopForm");
		
		//현재날짜
		if ($('#counselTotalPopForm').find('#counsel_date').val() == '') {
			$('#counselTotalPopForm').find('#counsel_date').val(fnGetToday(0,0));
		}
	});
	
	//통합상담 등록
	function btn_insert_onclick() {

		// 벨리데이션 체크
		if(formValidationCheck("counselTotalPopForm")){
			return;
		}
				
		var param = $('#counselTotalPopForm').serialize();
		if(pageType == 'insert'){
			var json = fnAjaxAction(fn_getConTextPath()+'/insertCounselTotal.lims', param);
			if (json == null) {
				alert("저장이 실패되었습니다.");
				return false;
			} else {				
				alert("저장이 완료되었습니다.");
				opener.fnpop_callback_total();
				window.close();
			}	
		}else{
			var json = fnAjaxAction(fn_getConTextPath()+'/updateCounselTotal.lims', param);
			if (json == null) {
				alert("수정이 실패되었습니다.");
				return false;
			} else {		
				alert("수정이 완료되었습니다.");
				opener.fnpop_callback_total();
				window.close();
			}
		}	
		
	} 
	
	function btn_search_onclick(){
		fnpop_reqOrgChoicePop("reqDetailForm", "750", "550", "상담의뢰업체");
		fnBasicStartLoading();
	}	
	
	function fnpop_callback(){
		fnBasicEndLoading();
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<form id="counselTotalPopForm" name="counselTotalPopForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table class="select_table" >
					<tr style="width: 200px;">
						<td class="table_title">
							<span>■</span>
							통합상담
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_save" id="btn_save" onclick="btn_insert_onclick();">
								<button type="button">저장</button>
							</span>									
						</td>
					</tr>
				</table>
				<table class="list_table" >
					<tr id="total_no_view">
						<th style="width: 20%;">통합상담번호</th>
						<td >
							<input name="total_no" id="total_no" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.total_no }"/>
						</td>
						<th class="indispensable">최초상담일자</th>
						<td colspan="4">
							<input name="counsel_date" id="counsel_date" type="text" class="w100px inputCheck" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.counsel_date }"/>
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="counsel_dateStop" style="cursor: pointer;" onClick='fn_TextClear("counsel_date")' />
						</td>
					</tr>					
					<tr>
						<th class="indispensable">업체명</th>
						<td>
							<input name="req_org_no" id="req_org_no" type="hidden" value="${detail.req_org_no }"/>
							<input name="org_nm" id="org_nm" type="text" class="w100px inputCheck" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.org_nm }"/>
							<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_Req_Org1" onclick='btn_search_onclick();'/>
						</td>
						<th>업체구분</th>
						<td>
							<input name="org_type_cd" id="org_type_cd" type="hidden" value="${detail.org_type_cd }"/>
							<input name="org_type" id="org_type" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.org_type }"/>							
						</td>
					</tr>									
					<tr>
						<th>사업자번호</th>
						<td>
							<input name="biz_no1" id="biz_no1" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.biz_no1 }"/>
						</td>
						<th style="width: 20%;">대표번호</th>
						<td>
							<input name="pre_tel_num" id="pre_tel_num" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.pre_tel_num }"/>
						</td>
					</tr>	
					<tr>
						<th class="indispensable">신청인명</th>
						<td>
							<input name="counsel_client_nm" id="counsel_client_nm" type="text" class="inputhan w100px inputCheck" value="${detail.counsel_client_nm }"/>
						</td>
<%-- 						<th>담당자</th>
						<td>
							<input name="req_nm" id="req_nm" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.req_nm }"/>
						</td> --%>
						<th>담당자 전화번호</th>
						<td>
							<input name="req_tel" id="req_tel" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.req_tel }"/>
						</td>					
					</tr>
					<tr>
						<th>업체 주소</th>
						<td colspan="3">
							<input name=zip_code id="zip_code" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.zip_code }"/>
							<input name="addr1" id="addr1" type="text" class="w270px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.addr1 }"/>
						</td>
					</tr>				 			
					<tr>						
						<th>이메일</th>
						<td>
							<input name="counsel_client_email" id="counsel_client_email" type="text" class="w100px"  value="${detail.counsel_client_email }"/>
						</td>	
						<th>상담자명</th>
						<td>
							<c:choose>								
								<c:when test="${!empty detail.counselor_nm}">
									<input name="counselor_nm" id="counselor_nm" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.counselor_nm }"/>
								</c:when>
								<c:otherwise>
									<input name="counselor_nm" id="counselor_nm" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${session.user_nm }"/>
								</c:otherwise>
							</c:choose>
						</td>

					</tr>		
				</table>
			</div>
		</form>
	</div>
</div>
</body>
</html>