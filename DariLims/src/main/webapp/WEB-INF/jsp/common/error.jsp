<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />

<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>


<title>통합장비관제시스템</title>
<style>
</style>
<script type="text/javascript">
	$(function() {
	});
	function login() {
		location.href = "main.lims";
	}
</script>
</head>
<body>
	<div>
		아이디
		<input type="text" id="" name="" />
		패스워드
		<input type="text" id="" name="" />
		<button onclick="login();">로그인</button>
	</div>
</body>
</html>