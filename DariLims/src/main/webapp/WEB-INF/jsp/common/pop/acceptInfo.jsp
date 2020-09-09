
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 의뢰정보
	 * 파일명 		: acceptInfo.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.11    진영민		최초 프로그램 작성         
	 * 2016.02.02    윤상준       수정
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

<title>LIMS</title>

<script type="text/javascript">
	$(function() {
		fnDatePickerImg('req_date');
		fnDatePickerImg('deadline_date');
		
		fn_Item_Count();
		fn_Fee_Calculate();
		fn_selectTestComment();

		ajaxComboForm("unit_work_cd", '', "${detail.unit_work_cd }", null, 'reqForm');
		ajaxComboForm("test_goal", "C05", "${detail.test_goal}", "", "reqForm");
		$('#btn_Req_Org').show();
	});
	
	//검체 및 시험항목 수 
	function fn_Item_Count() {
		var test_req_seq = $('#reqForm').find('#test_req_seq').val();
		var data = 'test_req_seq=' + test_req_seq;
		if (test_req_seq != '') {
			var url = 'accept/itemCalculate.lims';
			var json = fnAjaxAction(url, data);
			$('#reqForm').find('#sampleCnt').text(json.sampleCnt);
			$('#reqForm').find('#itemCnt').text(json.itemCnt);
		}
	}
		
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>의뢰정보</h2>
		<div class="sub_purple_01" style="margin-top: 0px;">
			<form id="reqForm" name="reqForm" onsubmit="return false;">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							의뢰 정보
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table">
					<tr>
						<th>제목</th>
						<td style="width:200px">
							<label class="w150px">${detail.title }</label>
						</td>
						<th>의뢰분류</th>
						<td style="width:150px">
							<label class="w150px">${detail.req_class }</label>
						</td>
						<th>의뢰분류상태</th>
						<td style="width:150px">
							<c:set var="name" value="${detail.express_flag }" />
							<c:choose>
							    <c:when test="${name eq 'N'}">일반</c:when>
							    <c:when test="${name eq 'Y'}">지급</c:when>
							    <c:otherwise>입회</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>의뢰번호</th>
						<td>
							<input name="test_req_seq" id="test_req_seq" type="hidden" value="${detail.test_req_seq }" />
							<input name="test_req_no" id="test_req_no" type="hidden" value="${detail.test_req_no }" />
							<label>${detail.test_req_no }</label>
						</td>
						<th>상태</th>
						<td>
							<input name="state" id="state" type="hidden" value="${detail.process }" />
							<label>${detail.state }</label>
						</td>
						<th>의뢰구분</th>
						<td>
							<label>${detail.req_type }</label>
						</td>
					</tr>
					<tr>
						<th>등록일자</th>
						<td>
							<label>${detail.req_type }</label>
						</td>
						<th>검체수</th>
						<td>
							<label id="sampleCnt"></label> &nbsp; 개
						</td>
						<th>시험항목수</th>
						<td>
							<label id="itemCnt"></label> &nbsp; 항목
						</td>
					</tr>
					<tr>
						<th>최종수수료금액</th>
						<td>
							<label id="fee_tot">${detail.fee_tot }</label> 원</td>
						<th>수수료납입방법</th>
						<td>
							<label id="commission_type">${detail.commission_type }</label>
						</td>
						<th>RAWDATA발급</th>
						<td>
							<c:set var="name" value="${detail.rawdata_flag }" />
							<c:choose>
							    <c:when test="${name eq 'N'}">미발급</c:when>
							    <c:when test="${name eq 'Y'}">발급</c:when>
							    <c:otherwise></c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>견적서</th>
						<td>
							<label>${detail.est_title }</label>
						</td>
						<th>견적서전송여부</th>
						<td>
							<c:set var="name" value="${detail.est_check }" />
							<c:choose>
							    <c:when test="${name eq 'N'}">전송안함</c:when>
							    <c:when test="${name eq 'Y'}">전송함</c:when>
							    <c:otherwise></c:otherwise>
							</c:choose>
						</td>
						<th>접수방법</th>
						<td>
							<c:set var="name" value="${detail.accept_method }" />
							<c:choose>
							    <c:when test="${name eq 'A'}">방문 접수</c:when>
							    <c:when test="${name eq 'B'}">택배, 등기</c:when>
							    <c:otherwise></c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>산출내역</th>
						<td colspan = "5">
								<textarea rows="1" class="w100p"  id="sales_user_id" readonly="readonly">${detail.calculation }</textarea>
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan = "5">
								<textarea rows="1" class="w100p"  id="sales_user_id" readonly="readonly">${detail.req_message }</textarea>
						</td>
					</tr>
					<tr>
						<th>관리자메모</th>
						<td colspan = "5">
								<textarea rows="1" class="w100p"  id="sales_user_id" readonly="readonly">${detail.admin_message }</textarea>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title" style="border-width: 0px;">
							<span>■</span>
							의뢰업체
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table" style="border-top: solid 1px #82bbce;">
					<tr>
						<th>업체명</th>
						<td colspan = "5">
							<label>${detail.req_org_nm }</label>
						</td>
					</tr>
					<tr>
						<th>의뢰자</th>
						<td style="width:210px">
							<label>${detail.req_nm }</label>
						</td>
						<th>연락처</th>
						<td style="width:150px">
							<label>${detail.charger_tel }</label>
						</td>
						<th style="width:150px">Email</th>
						<td>
							<label>${detail.email }</label>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan = "5">
							<label>${detail.zip_code }</label>&nbsp / &nbsp<label>${detail.addr1 }</label>&nbsp<label>${detail.addr2 }</label>
						</td>
					</tr>
					<tr>
						<th>공장명</th>
						<td colspan = "3">
							<label>${detail.req_plant_nm }</label>
						</td>
						<th>공장전화번호</th>
						<td>
							<label>${detail.req_plant_tel }</label>
						</td>
					</tr>
					<tr>
						<th>공장주소</th>
						<td colspan="5">
							<label>${detail.req_plant_addr }</label>
						</td>
					</tr>
				</table>
				
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title" style="border-width: 0px;">
							<span>■</span>
							검사정보
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table" style="border-top: solid 1px #82bbce;">
					<tr>
						<th>영업담당자부서</th>
						<td>
							<label>${detail.sales_dept_cd }</label>
						</td>
						<th>영업담당자</th>
						<td style="width:150px">
							<label>${detail.sales_user_id }</label>
						</td>
						<th>접수일자</th>
						<td style="width:150px">
							<label>${detail.sample_arrival_date }</label>
						</td>
					</tr>
					<tr>
						<th>주관부서</th>
						<td>
							<label>${detail.dept_cd }</label>
						</td>
						<th>의뢰근거</th>
						<td>
							<label>${detail.req_basis }</label>
						</td>
						<th>시험완료예정일</th>
						<td>
							<label>${detail.test_end }</label>
						</td>
					</tr>
					<tr>
						<th>단위업무</th>
						<td >
							<label>${detail.unit_work_cd }</label>
						</td>
						<th>검사목적</th>
						<td>
							<label>${detail.test_goal }</label>
						</td>
						<th>성적서발행예정일</th>
						<td>
							<label>${detail.deadline_date }</label>
						</td>
					</tr>
				</table>
				
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title" style="border-width: 0px;">
							<span>■</span>
							검사내용
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table" style="border-top: solid 1px #82bbce;">
					<tr>
						<th>품징검사원1</th>
						<td style="width:200px">
							<label>${detail.quality_dept_cd1 }</label>&nbsp / &nbsp<label>${detail.quality_user_id1 }</label>
						</td>
						<th>품질검사원2</th>
						<td style="width:150px">
							<label>${detail.quality_dept_cd2 }</label>&nbsp / &nbsp<label>${detail.quality_user_id2 }</label>
						</td>
						<th>수량</th>
						<td>
							<label>${detail.test_count }</label>
						</td>
					</tr>
					<tr>
						<th>Sampling NO</th>
						<td>
							<label>${detail.sampling_no }</label>
						</td>
						<th>Sample Number</th>
						<td colspan = "3">
							<label>${detail.sample_num }</label>
						</td>

					</tr>
					<tr>
						<th>시험장소구분 </th>
						<td colspan = "5">
							<c:set var="name" value="${detail.test_place }" />
							<c:choose>
							    <c:when test="${name eq 'A'}">고정실험실</c:when>
							    <c:when test="${name eq 'B'}">현장실험</c:when>
							    <c:otherwise></c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>시험장소 </th>
						<td colspan = "5">
							<label>${detail.test_zip_code }</label>&nbsp / &nbsp<label>${detail.test_addr1 }</label>&nbsp<label>${detail.test_addr2 }</label>
						</td>
					</tr>
					<tr>
						<th>시험장소(영문) </th>
						<td colspan = "5">
							<label>${detail.addr1_eng }</label>&nbsp<label>${detail.addr2_eng }</label>
						</td>
					</tr>
					<tr>
						<th>성적서주소</th>
						<td colspan = "5">
							<label>${detail.addr_report }</label>
						</td>
					</tr>
					<tr>
						<th>성적서 전화번호</th>
						<td>
							<label>${detail.tel_report }</label>
						</td>
						<th>성적서 팩스</th>
						<td colspan = "3">
							<label>${detail.fax_report }</label>
						</td>
					</tr>
					<tr>
						<th>라벨설명</th>
						<td colspan = "5">
								<textarea rows="1" class="w100p"  id="barcode_desc" readonly="readonly">${detail.barcode_desc }</textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>