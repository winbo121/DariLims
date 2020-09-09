<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
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
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree.js'/>"></script>
<title>실험실정보관리시스템</title>
<script type="text/javascript">
	$(function() {
		$(".inputNext").keydown(function(e){
			var keys = [8, 9, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];
			if(e.which == 8 && this.value.length == 0){
				$(this).prev(".inputNext").focus();
			}else if($.inArray(e.which, keys) >= 0){
				return true;			
			}else if(this.value.length >= this.maxLength){
				$(this).next(".inputNext").focus();
				return false;		
			}else if(
					e.shiftKey || 
					!((e.which >= 65 && e.which <= 90) || (e.which >= 48 && e.which <= 57))
					){
				return false;
			}
		});
		
		$(".inputNext").keyup(function(){
			if(this.value.length == this.maxLength){
				$(this).next(".inputNext").focus();
			}
		});
	});
	
	function btn_Query_onclick() {
		if ($("#verify_id1").val()=="" || $("#verify_id1").val().length != 5) {
			alert('성적서 진위확인 코드를 정확하게 입력하세요.');
			$("#verify_id1").focus();
			return;
		}

		if ($("#verify_id2").val()=="" || $("#verify_id2").val().length != 5) {
			alert('성적서 진위확인 코드를 정확하게 입력하세요.');
			$("#verify_id2").focus();
			return;
		}
		
		if ($("#verify_id3").val()=="" || $("#verify_id3").val().length != 5) {
			alert('성적서 진위확인 코드를 정확하게 입력하세요.');
			$("#verify_id3").focus();
			return;
		}
		
		if ($("#verify_id4").val()=="" || $("#verify_id4").val().length != 5) {
			alert('성적서 진위확인 코드를 정확하게 입력하세요.');
			$("#verify_id4").focus();
			return;
		}
		
		$("form[id=verifyForm]").submit();
	}
</script>
</head>
<body id="mainBody" >

	<!-- TOP --->
	<div id="header">
		<div class="TopBg_left"></div>
		<div class="TopBg_right"></div>
		<div id="top_line" class="top_area">
			<div style="width: 100%">
				<h1 class="toptitle">
					<a href="main.lims"><img id="topTitle" src="images/TopTitle.png"></a>
				</h1>
			</div>
		</div>
	</div>
	<!-- //TOP -->
	
	<!-- subtitle_wrap -->
	<div class="subtitle_wrap">
		<div class="subtitle">
			<p>
				<label class="mainTitle" id='mainTitle'>성적서 진위확인</label>
			</p>
		</div>
	</div>
	<!-- //subtitle_wrap -->

	<!-- contents -->
	<div id="contents">
		<div class="sub_purple_01 w100p">
			<form id="verifyForm" name="verifyForm" method="post" action="verifyReportAction.lims">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							성적서 진위확인
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
						</td>
					</tr>
				</table>
				<table  class="list_table" >
					<tr>
						<th>진위확인 코드</th>
						<td>
							<input name="verify_id1" id="verify_id1" type="text" class="inputNext" style="text-transform:uppercase;ime-mode:disabled;width:50px;" maxlength="5"/>- 
							<input name="verify_id2" id="verify_id2" type="text" class="inputNext" style="text-transform:uppercase;ime-mode:disabled;width:50px;" maxlength="5"/>- 
							<input name="verify_id3" id="verify_id3" type="text" class="inputNext" style="text-transform:uppercase;ime-mode:disabled;width:50px;" maxlength="5"/>- 
							<input name="verify_id4" id="verify_id4" type="text" class="inputNext" style="text-transform:uppercase;ime-mode:disabled;width:50px;" maxlength="5"/>
							<span class="button white mlargep auth_select" id="btn_Query" onclick="btn_Query_onclick();">
								<button type="button">조회</button>
							</span>
						</td>
					</tr>		
				</table>
			</form>
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<div id="footer">
		<img src="images/FooterTxt.png" alt="통합장비관제시스템">
	</div>
	<!-- //footer -->
</body>
</html>