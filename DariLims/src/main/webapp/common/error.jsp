<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>실험실정보관리시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" media="screen" type="text/css" href="/eLABMate/css/common/sub.css" />

<style>
/* +++ error +++ */
.error_style {
	background: #ffffff;
	padding-top: 100px;
}

.error {
	width: 604px;
	margin: 0 auto;
}

.error_top {
	height: 34px;
	padding: 26px 0 20px 25px;
	background: url(/eLABMate/images/error_bg.png) no-repeat 0 0;
}

.top_logo {
	width: 250px;
	height: 33px;
	display: block;
	overflow: hidden;
	text-indent: 100%;
	white-space: nowrap;
}

.error_middle {
	padding: 30px 70px 10px 70px;
	background: url(/eLABMate/images/error_bg.png) repeat-y -610px 0;
}

.icon_error {
	width: 136px;
	height: 154px;
	margin: 0 auto;
	display: block;
	background: url(/eLABMate/images/icon_error.png) no-repeat;
	overflow: hidden;
	text-indent: 100%;
	white-space: nowrap;
}

.txt_error {
	padding: 50px 0;
}

.error_bottom {
	height: 30px;
	background: url(/eLABMate/images/error_bg.png) no-repeat 0 -80px;
}
/* ++++++++++ box ++++++++++ */
.box_c {
	text-align: center;
}


.btn_error_home, .btn_error_home:link, .btn_error_home:visited, .btn_error_home:active {
	display: inline-block;
	width: 60px;
	height: 25px;
	line-height: 25px;
	padding: 0 0 0 20px;
	background: url(/eLABMate/images/btn_error_control.png) no-repeat 0 0;
	font-weight: bold;
	color: #ffffff;
	cursor: pointer;
}
</style>
</head>

<body class="error_style">
	<!-- 500 에러 -->
	<div class="error">
		<div class="error_top">
			<p class="top_logo">실험실정보관리시스템</p>
		</div>

		<div class="error_middle">
			<p class="icon_error">ERROR</p>

			<div class="txt_error">
				<p>관리자에게 문의하시기 바랍니다.</p>
			</div>

			<div class="box_c">
				<a href="/" class="btn_error_home">홈으로</a>
			</div>
		</div>

		<div class="error_bottom"></div>
	</div>

</body>
</html>
