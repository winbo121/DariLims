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
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript">
$(function() {

	$("#reportSamplePOPForm").attr("action","report1.lims");
	$("#reportSamplePOPForm").submit();
	
});

</script>

<!-- 화면  -->	
<body>
REPORTSAMPLEPOP!!!!
<div>	
	<form name="reportSamplePOPForm" id="reportSamplePOPForm" > 
	<!-- form 네이밍규칙 화면명+Form  
		name과 id는 동일하게 구성
	-->
	

	</form>
</div>
</body>

