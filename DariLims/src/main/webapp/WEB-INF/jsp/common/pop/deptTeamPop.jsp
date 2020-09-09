
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부서팀관리
	 * 파일명 		: deptTeamPop.jsp
	 * 작성자 		: 
	 * 작성일 		: 2015.02.10
	 * 설  명		: 공통팝업  
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.10    			최초 프로그램 작성         
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
<style>
</style>

<script type="text/javascript">
	
	$(function() {
		

	});

	
	function btn_save_onclick(){
		
		if(formValidationCheck("deptTeamPopFrom")){
			return;
		}
		
/* 		if(!fn_lengthCheck("dept_cd","7")){
			return;
		} */
		
		if("insert" == $('#deptTeamPopFrom').find('#pageType').val()){
			url = 'insertDeptTeam.lims';
		}else{
		 	url = 'updateDeptTeam.lims';
		}
		
		if (confirm("저장하시겠습니까?")) {
			var json = fnAjaxAction(url, $('#deptTeamPopFrom').serialize());
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
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
<div class="pop_area pop_intro">
	<h2>부서 팀 관리</h2>
	
<div class="sub_purple_01">
<form name="deptTeamPopFrom" id="deptTeamPopFrom">
<input type="hidden" id="pageType" name="pageType" value="${pageType}"/>
<input type="hidden" id="dept_cd" name="dept_cd" value="${dept_cd}"/>
<input type="hidden" id="team_cd" name="team_cd" value="${team_cd}"/>
<table class="select_table">
	<tr>
		<td class="table_title">
			<span>■</span>
			팀 등록
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
		<th class="indispensable" style="width: 30%">팀 명</th>
		<!--한글우선입력-->
		<td>
			<input id="team_nm" name="team_nm" class="w200px inputCheck" type="text" value="${detail.team_nm}"/>
		</td>
	</tr>
	<tr>
		<th>팀설명</th>
		<!--영문우선입력-->
		<td>
			<input id="team_desc" name="team_desc"  class="w200px" type="text" value="${detail.team_desc}" />
		</td>
	</tr>
	<tr>
		<th>사용여부</th>
		<!--영문우선입력-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15 inputCheck" value="Y"  <c:if test="${detail.use_flag == 'Y'}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15 inputCheck" value="N"  <c:if test="${detail.use_flag != 'Y'}">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
</table>
</form>
</div>
</div>
</div>
</body>
</html>



