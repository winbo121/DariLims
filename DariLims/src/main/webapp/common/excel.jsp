<%@ page language="java" contentType="application/vnd.ms-excel;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	response.setHeader("Content-Disposition", "attachment; filename=lims_excel.xls");
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>excel</title>
<style>
</style>
</head>
<body>
	<c:forEach items="${excel}" varStatus="status" var="excel">
		<table border="1" style="table-layout: fixed; width: 100%;">
			<thead>
				<c:if test="${fn:length(excel.label_sub)>0}">
					<tr>
						<th style="background-color: #e5f2fc;" colspan="1" rowspan="2">번호</th>
						<c:forEach items="${excel.label}" var="label">
							<th style="background-color: #e5f2fc;" colspan="${label[1]}" <c:if test="${label[1]==1}">rowspan="2"</c:if>>${label[0]}</th>
						</c:forEach>
					</tr>
					<tr>
						<c:forEach items="${excel.label_sub}" var="label">
							<th style="background-color: #e5f2fc;" colspan="${label[1]}">${label[0]}</th>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${fn:length(excel.label_sub)<=0}">
					<tr>
						<th style="background-color: #e5f2fc;" colspan="1" rowspan="1">번호</th>
						<c:forEach items="${excel.label}" var="label">
							<th style="background-color: #e5f2fc;"">${label[0]}</th>
						</c:forEach>
					</tr>
				</c:if>
			</thead>
			<tbody>
				<c:forEach items="${excel.data}" varStatus="status" var="row">
					<tr>
						<td>${status.count}</td>
						<c:forEach items="${row}" var="item">
							<td>${item}</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<c:if test="${fn:length(excel.foot)>0}">
					<tr>
						<th style="background-color: #e5f2fc;"></th>
						<c:forEach items="${excel.foot}" var="foot">
							<th style="background-color: #e5f2fc;" colspan="${foot[1]}">${foot[0]}</th>
						</c:forEach>
					</tr>
				</c:if>
			</tfoot>
		</table>
		<br>
	</c:forEach>
</body>
</html>