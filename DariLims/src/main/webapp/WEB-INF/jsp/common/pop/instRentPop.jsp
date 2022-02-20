
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 상담관리 업체 팝업
 * 파일명 		: instRentPop.jsp
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
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>

<script type="text/javascript">
	var pageType = "${pageType}";
	$(function() {		
		
	});
	
	//업체 등록/수정
	function btn_Save_onclick() {

		// 벨리데이션 체크
		if(formValidationCheck("instRentPopForm")){
			return;
		}
				
		var param = $('#instRentPopForm').serialize();
		if(pageType == 'insert'){
			var json = fnAjaxAction(fn_getConTextPath()+'/accept/insertInstRentOrg.lims', param);
			if (json == null) {
				alert("저장이 실패되었습니다.");
				return false;
			} else {				
				alert("저장이 완료되었습니다.");
				opener.fnpop_callback_org();
				window.close();
			}	
		}else{
			var json = fnAjaxAction(fn_getConTextPath()+'/accept/updateInstRentOrg.lims', param);
			if (json == null) {
				alert("수정이 실패되었습니다.");
				return false;
			} else {		
				alert("수정이 완료되었습니다.");
				opener.fnpop_callback_org();
				window.close();
			}
		}	 
		
	}
	
	function btn_Search_onclick(){
		fnpop_reqOrgChoicePop("reqDetailForm", "750", "550", "장비대여접수");
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
		<form id="instRentPopForm" name="instRentPopForm" onsubmit="return false;">
		<input type="hidden" name="instRent_receipt_no" id="instRent_receipt_no" value="${detail.instRent_receipt_no }">
			<div class="sub_purple_01">
				<table class="select_table" >
					<tr style="width: 200px;">
						<td class="table_title">
							<span>■</span>
							장비대여 업체등록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
								<button type="button">저장</button>
							</span>									
						</td>
					</tr>
				</table>
				<table class="list_table" >
					<tr>
						<th class="indispensable" style="width: 15%;">업체명</th>
						<td>
							<input name="req_org_no" id="req_org_no" type="hidden" value="${detail.req_org_no }"/>
							<input name="org_nm" id="org_nm" type="text" class="w100px inputCheck" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.org_nm }"/>
							<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_Select" onclick='btn_Search_onclick();'/>
						</td>
						<th style="width: 15%;">업체구분</th>
						<td>
							<input name="org_type_cd" id=""org_type_cd"" type="hidden" value="${detail.org_type_cd }"/>
							<input name="org_type" id="org_type" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.org_type }"/>							
						</td>
					</tr>									
					<tr>
						<th>사업자번호</th>
						<td>
							<input name="biz_no1" id="biz_no1" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.biz_no1 }"/>
						</td>
						<th>대표번호</th>
						<td>
							<input name="pre_tel_num" id="pre_tel_num" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.pre_tel_num }"/>
						</td>
					</tr>	
					<tr>
						<th>담당자</th>
						<td>
							<input name="req_nm" id="req_nm" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.req_nm }"/>
						</td>
						<th>담당자 전화번호</th>
						<td>
							<input name="req_tel" id="req_tel" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.req_tel }"/>
						</td>					
					</tr>
					<tr>
						<th>업체 주소</th>
						<td colspan="3">
							<input name="zip_code" id="zip_code" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.zip_code }"/>
							<input name="addr1" id="addr1" type="text" class="w295px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.addr1 }"/>
						</td>
					</tr>			
					<tr>
						<th class="indispensable">사용자명</th>
						<td>
							<input name="instRent_user_nm" id="instRent_user_nm" type="text" class="w100px inputCheck" value="${detail.instRent_user_nm }"/>
						</td>
						<th>접수담당자명</th>
						<td>
							<c:choose>
								<c:when test="${!empty detail.instRent_taker_nm }">
									<input name="instRent_taker_nm" id="instRent_taker_nm" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.instRent_taker_nm }"/>
								</c:when>
								<c:otherwise>
									<input name="instRent_taker_nm" id="instRent_taker_nm" type="text" class="w100px" readonly="readonly" style="background-color: #D5D5D5;" value="${session.user_nm }"/>
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