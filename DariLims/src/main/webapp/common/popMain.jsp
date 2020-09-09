
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 공통팝업
	 * 파일명 		: popMain.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.02.10
	 * 설  명		: 공통팝업  
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.10    	정우용		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />

<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />

<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>

<script type="text/javascript" src="<c:url value='/script/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/gridCommon.js'/>"></script>

<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>

<title>통합장비관제시스템1</title>
<style>
.ui-jqgrid .ui-search-toolbar .ui-search-table {
	height: 24px;
}

.ui-jqgrid .ui-search-toolbar .ui-search-input input,.ui-jqgrid .ui-search-toolbar .ui-search-input select,.ui-jqgrid .ui-search-toolbar .ui-search-input textarea {
	height: 18px;
}

.ui-datepicker {
	z-index: 9999 !important;
}

.ui-datepicker-trigger {
	cursor: pointer !important;
}

.ui-dialog {
	z-index: 9999 !important;
}
</style>

<script type="text/javascript">
	var obj = window.dialogArguments;
	$(function() {
		/*
		*obj.msg1 = 부모창에 넘길값
		*obj.msg2 = 부모창에 넘길값	
		*
		*fnViewPage(obj.msg1, 'detail', data);
		*특정값 조회시 
		* var data = 'type=' + obj.msg1 + '&pageType=detail&test_req_no=' + obj.msg2;
		*
		*/
		fnViewPage(obj.msg1, 'detail', null);
	});
</script>
</head>
<body>
	<form id="frmBinder" name="frmBinder" onsubmit="return false;">
		<input type="hidden" name="gridData" id="gridData" value="">
	</form>
	<iframe id="ifrmexcel" name="ifrmexcel" scrolling="no" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0"></iframe>
	<div id="detail" style="width: 100%;"></div>
</body>
</html>