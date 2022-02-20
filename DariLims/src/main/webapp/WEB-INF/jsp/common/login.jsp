
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/login.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.login.js'/>"></script>
<title>LIMS 로그인</title>
<script type="text/javascript">
	$(function() {
		// 엔터키 눌렀을 경우
		$("form[name=form] input , form[name=form] select").keypress(function(e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCOde == 13)) {
				loginChk();
			}
		});
	});
</script>
</head>
<body class="intro_body">
	<div class="intro">
		<div class="login_wrap">
			<h1>
				<img src="images/txt_heading.png" alt="대덕분석기술연구소 실험실정보관리시스템">
			</h1>
			<div class="login">
			   
				<form id="form" name="form" onsubmit="return false;">
					<fieldset>
						<legend>로그인</legend>
						<dl>
							<dt>
								<img src="images/txt_id.png" alt="아이디">
							</dt>
							<dd>
								<input type="text" id="user_id" name="user_id" style="width: 150px;" placeholder="아이디 입력" />
							</dd>
							<dt>
								<img src="images/txt_pw.png" alt="비밀번호">
							</dt>
							<dd>
								<input type="password" id="user_pw" name="user_pw" style="width: 150px; margin-right: 7px;" placeholder="비밀번호 입력" />
							</dd>
						</dl>
						<button name="test" id="test" type="button" onclick="loginChk();" onfocus="blur()">로그인</button>
						<!-- <span>
							<input class="check" type="checkbox" id="idsave" onchange="" />
							<p>아이디 저장</p>
						</span> -->
					</fieldset>
				</form>

<!-- 
				<div class="login_footer">
					<a href="verifyReport.lims"><img src="images/btnVerify.png" alt="성적서 진본확인"></a><br>
					<img src="images/txt_copyright.png" alt="인터페이스정보기술 COPYRIGHTⓒ2015 INTERFACE IT. ALL RIGHTS RESERVED">
				</div>
 -->				
			</div>
		</div>


	</div>
	<!--//.intro-->
</body>
<!--//.intro_body-->
</html>