
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 페이징
	 * 파일명 		: noticePaging.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명		: 그리드 페이징
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 *         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
$(function() {
	$("#paging").width($("#paging").width());
});
</script>
<style>
	table.paging { padding:2px 0px 0px 0px; border:1px solid #a6c9e2 !important; border-top:0px solid #fff !important; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;}
	.paging { background:#dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x; }
	.paging td img { vertical-align:middle;}
	.paging td, .paging td label, .paging td a, .paging td a:hover,.paging td a:active, .paging td a:focus { color:#2e6e9e !important; }
	.paging td a:hover,.paging td a:active, .paging td a:focus {text-decoration:underline;}
	.paging label { padding-right: 10px;}
	.paging label span { font-weight: bold; color:#2e6e9e !important; }
</style>

<table width="100%" class="paging">
	<tr>
		<td style="text-align: center;">
			<ui:pagination paginationInfo="${pageInfo}" type="image" jsFunction="linkPage"/>
			<label style="float:right;">Total <span>${pageInfo.totalRecordCount}</span></label>
		</td>
		<%-- 
		<td style="text-align: right; white-space: nowrap; ">
			<select id="rowSize" name="rowSize" onchange="changeRowSize();">
				<option value="10" <c:if test="${pageInfo.recordCountPerPage == 10}">selected="selected"</c:if> >10</option>
				<option value="20" <c:if test="${pageInfo.recordCountPerPage == 20}">selected="selected"</c:if> >20</option>
				<option value="30" <c:if test="${pageInfo.recordCountPerPage == 30}">selected="selected"</c:if> >30</option>
			</select>
		</td>
		--%>
	</tr>
</table>

