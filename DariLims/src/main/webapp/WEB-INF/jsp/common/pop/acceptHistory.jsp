
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 진행상태조회
	 * 파일명 		: acceptHistory.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.11    진영민		최초 프로그램 작성         
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
	$(function() {
		if ($("#test_sample_seq").val() == null) {
		} else {
			fnViewPage('showReqHistorySub.lims', 'reqHistoryDiv', $('#reqHitoryForm').serialize());
		}
		
		$('#reqHitoryForm').find("#test_sample_seq").change(function() {
			fnViewPage('showReqHistorySub.lims', 'reqHistoryDiv', $('#reqHitoryForm').serialize());
		});
		$('#reqHitoryForm').find("#dept_cd").change(function() {
			fnViewPage('showReqHistorySub.lims', 'reqHistoryDiv', $('#reqHitoryForm').serialize());
		});
		ajaxComboForm("dept_cd", "", "", "ALLNAME", 'reqHitoryForm');
	});
	
	// 닫기
	function fn_close(){
		opener.fnpop_callback();
		window.close();
	}	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area">
		<h2>진행상태 조회</h2>
		<div class="pop_intro">
			<div class="sub_purple_01">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							진행상태
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargep" id="btn_Cancel" onclick="fn_close();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<form id="reqHitoryForm" name="reqHitoryForm" onsubmit="return false;">
					<table width="100%" border="0" class="list_table">
						<tr>
							<th>접수번호</th>
							<td>
								<input class="inputhan w100px" type="text" id="test_req_no" name="test_req_no" value="${test_req_seq}" readonly="readonly"/>
							</td>
							<th>시료번호</th>
							<td colspan="7">
								<select name="test_sample_seq" id="test_sample_seq" class="w300px">
									<c:forEach items="${sampleList}" var="list">
										<option value="${list.test_sample_seq}">${list.test_sample_seq}/${list.sample_reg_nm }</option>
									</c:forEach>
								</select>
							</td>
							<th>부서</th>
							<td>
								<select name="dept_cd" id="dept_cd" class="w200px"></select>
							</td>
						</tr>
					</table>
				</form>
				<div id="reqHistoryDiv" style="margin-top: 10px; margin-top: 10px; overflow-x: hidden; overflow-y: scroll; width: 100%; height: 400px;">
					<table width="100%" border="0" class="list_table" style="border-top: solid 1px #82bbce;">
						<tr>
							<th>시료번호</th>
							<td>
								<label>이력정보가 없습니다.</label>
							</td>
							<th>진행구분</th>
							<td>
								<label>이력정보가 없습니다.</label>
							</td>
							<th>부서</th>
							<td>
								<label>이력정보가 없습니다.</label>
							</td>
							<th>이름</th>
							<td>
								<label>이력정보가 없습니다.</label>
							</td>
							<th>날짜</th>
							<td>
								<label>이력정보가 없습니다.</label>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>