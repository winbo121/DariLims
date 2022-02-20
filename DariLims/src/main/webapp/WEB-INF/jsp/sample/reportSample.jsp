<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 필요한 라이브러리만 등록  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	/***************************************************************************************
	 * 시스템명 		: 
	 * 업무명 		: 
	 * 파일명 		: chartSample.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.07.30
	 * 설  명			: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.07.30    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>

<!-- 스크립트 -->
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/flot/flot.css'/>" />
<script type="text/javascript" src="<c:url value='/script/flot/jquery.flot.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/flot/jquery.flot.categories.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/flot/jquery.flot.pie.js'/>"></script>
<script type="text/javascript">
$(function() {

	
		
});

	function btn_report(){
			
		var obj = new Object();
		var url = '/lims/reportSamplePOP.lims';
		
		result = window.open(url, obj, "width=600px, height=700px, toolbar=no, location=no, menubar=no, scrollbars=no, status=no, resizable=no");
		return result;


	}
</script>

<!-- 화면  -->	
<body>
<div>	
	<form name="reportSampleForm" id="reportSampleForm" > 
	<!-- form 네이밍규칙 화면명+Form  
		name과 id는 동일하게 구성
	-->
	
     	
	<div class="sub_purple_01 w100p" style="margin-top: 0px;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					REPORT SAMPLE
				</td>
				<td>
					<span class="button white mlargep" id="btn_search" onclick="btn_report();">
				   		<button type="button"><spring:message code="button.report"/></button>
				   	</span>

				</td>
			</tr>
		</table>

   	</div>
	</form>
</div>
</body>

