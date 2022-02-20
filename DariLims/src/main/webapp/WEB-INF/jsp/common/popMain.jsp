
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 공통팝업
	 * 파일명 		: popMain.jsp
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

		fnViewPage($("#popUrl").val(), 'detail', null);

	});
</script>
</head>
<body id="popBody">
	<input type="hidden" id="popParam" name="popParam" value="${popParam}"/>
	<input type="hidden" id="popUrl" name="popUrl" value="${popUrl}"/>
	<form id="frmBinder" name="frmBinder" onsubmit="return false;">
		<input type="hidden" name="gridData" id="gridData" value="">
	</form>
	<iframe id="ifrmexcel" name="ifrmexcel" class="ifrmexcel" width="0" height="0"></iframe>
	<div id="detail" style="width: 100%;"></div>
</body>
</html>



