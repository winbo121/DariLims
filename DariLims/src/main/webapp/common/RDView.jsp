<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RDServer</title>
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript">
	$(function() {
	
		rdViewer.FileOpen("http://211.232.4.102:80/RDServer/mrd/1.Virus_Pure(COA6).mrd","/rp [15-001901]");

	});
</script>
</head>
<body>

<OBJECT id=rdViewer 
   classid="clsid:5A7B56B3-603D-4953-9909-1247D41967F8"
  codebase="http://98.28.5.217:9090/RDServer/cab/rdviewer50u.cab#version=5,0,0,521"
	  name=rdViewer width=100% height=100%>
</OBJECT>

</body>
</html>