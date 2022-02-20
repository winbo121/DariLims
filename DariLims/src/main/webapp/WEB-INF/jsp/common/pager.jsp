<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<table style="width: 100%; ">
	<tr>
		<td style="text-align: center; width: 100%;">
			<ui:pagination paginationInfo="${pageInfo}" type="image" jsFunction="linkPage" />
		</td>
		<td style="text-align: right; white-space: nowrap; ">
			<label>Show</label> 
			<select id="rowSize" name="rowSize" onchange="changeRowSize();">
				<option value="10" <c:if test="${pageInfo.recordCountPerPage == 10}">selected="selected"</c:if> >10</option>
				<option value="20" <c:if test="${pageInfo.recordCountPerPage == 20}">selected="selected"</c:if> >20</option>
				<option value="30" <c:if test="${pageInfo.recordCountPerPage == 30}">selected="selected"</c:if> >30</option>
			</select>
			<label>Total ${pageInfo.totalRecordCount}</label>
		</td>
	</tr>
</table>
