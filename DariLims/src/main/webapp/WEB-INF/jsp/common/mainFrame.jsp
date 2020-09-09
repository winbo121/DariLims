
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 
	 * 파일명 		: main.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명		: 
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

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
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/menu.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/crownix-viewer.min.css'/>" />

<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script> --%>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/resultInputCommon.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/crownix-invoker.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/crownix-viewer.min.js?time=${now}'/>"></script>
<title>실험실정보관리시스템</title>
<style>
.ui-jqgrid .ui-search-toolbar .ui-search-table {
	height: 24px;
}

.ui-jqgrid .ui-search-toolbar .ui-search-input input,.ui-jqgrid .ui-search-toolbar .ui-search-input select,.ui-jqgrid .ui-search-toolbar .ui-search-input textarea {
	height: 18px;
}

.ui-datepicker {
	z-index: 9999 !important;
}

.ui-datepicker-trigger {
	cursor: pointer !important;
}

.ui-dialog {
	z-index: 9998 !important;
}

#mainList tr:hover {
	background-color: #faeb87;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(function() {
		//window.onbeforeunload = function() {
		//logout();
		//};
		
		$(".location").hide();
		$(".subtitle_wrap").hide();
		$("#footer").hide();
		fn_mainMenu();
		$("#helpDesk").hide();

		fn_mainNotice();
		fn_accountFlag(); // 수수료 사용여부
		$('#tbMenu').click(function() {
			if ($("#mainMenu").css("display") == "none") {
				$("#mainMenu").show('blind', {}, 500, null);
				$("#wildMenu").hide('slide', {}, 500, null);
			} else {
				$("#mainMenu").hide('blind', {}, 500, null);
			}
		});

		// wild menu
		$('#wildMenuBar').click(function() {
			if ($("#wildMenu").css("display") == "none") {
				$("#wildMenu").show('slide', {}, 500, null);
				$("#mainMenu").hide('blind', {}, 500, null);
			} else {
				$("#wildMenu").hide('slide', {}, 500, null);
			}
		});

		// HELP DESK 클릭
		$('#helpDeskBtn').click(function() {
			if ($("#helpDesk").css("display") == "none") {
				$("#helpDesk").show('blind', {}, 500, null);
			} else {
				$("#helpDesk").hide('blind', {}, 500, null);
			}
		});

		$("#logout").click(function() {
			if (!confirm("로그아웃 하시겠습니까?")) {
				return false;
			}
			logout();
		});

		$(document).keydown(function(e) {
			if (e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA") {
				if (e.keyCode === 8) {
					return false;
				}
			} else {
				if (e.target.readOnly == true) {
					if (e.keyCode === 8) {
						return false;
					}
				}
			}
		});
		
		$('#devRefresh').click(function() {
			fnViewPage($("#menu_id").val() + '.lims', 'contents', null);
		});
	});

	
	function logout() {
		$.ajax({
			url : 'logout.lims',
			dataType : 'json',
			type : 'POST',
			async : false,
			data : $('#form').serialize(),
			success : function(json) {
				if (json == 'loginout') {
					location.href = "login.lims";
					//window.close();
				}
			},
			error : function() {
				alert('login error');
			}
		});
	}

	function fn_mainMenu() {
		$("#mainMenu").fancytree({
			source : {
				url : 'selectMenuList.lims',
				type : 'post',
				dataType : 'json',
				async : false,
				data : null
			},
			click : function(event, data) {
				var node = data.node;
				if (!node.folder) {
					$("#pTitle").text(node.getParent().title);
					$("#mTitle").text(node.title);

					fn_Change_MainCSS(node.title);
					$("#footer").show();

					$("#menu_cd").val(node.refKey);
					$("#menu_id").val(node.key);
					fnViewPage(node.key + '.lims', 'contents', null);
				} else {
					node.toggleExpanded();
				}
			}
		});

		$("#wildMenu").fancytree({
			source : {
				url : 'selectMenuList.lims',
				type : 'post',
				dataType : 'json',
				async : false,
				data : null
			},
			click : function(event, data) {
				var node = data.node;
				if (!node.folder) {
					$("#pTitle").text(node.getParent().title);
					$("#mTitle").text(node.title);
					fn_Change_MainCSS(node.title);
					$("#footer").show();

					$("#menu_cd").val(node.refKey);

					fnViewPage(node.key + '.lims', 'contents', null);
				} else {
					node.toggleExpanded();
				}
			}
		});
	}

	function fn_mainNotice() {
		var json = fnAjaxAction('mainNotice.lims', null);
		if (json == null) {
			alert('error');
		} else {
			$(json).each(function(index, entry) {
				//var obj = new Object();
				//obj.msg1 = "공지사항";
				//obj.msg2 = "system/noticeDetail.lims";
				//obj.msg3 = 'mode=5&key='+entry["notice_no"];

				//popMain.lims 팝업 공통 메인 프레임
				//fnShowModalWindow("popMain.lims", obj, 750, 500);
				var value = entry["notice_no"];
				popup_open(value);
			});

		}
	}

	function popup_open(value) {
		if (getCookie("popup" + value) != "done") {
			noticeWindow = window.open("system/noticeP01.lims?mode=5&key=" + value, "popup" + value, "width=700px, height=530px, toolbar=no, location=no, menubar=no, scrollbars=no, status=no, resizable=no");
			noticeWindow.opener = self;
		}
	}

	function getCookie(name) {
		var nameOfCookie = name + "=";
		var x = 0;
		while (x <= document.cookie.length) {
			var y = (x + nameOfCookie.length);
			if (document.cookie.substring(x, y) == nameOfCookie) {
				if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
					endOfCookie = document.cookie.length;
				return unescape(document.cookie.substring(y, endOfCookie));
			}
			x = document.cookie.indexOf(" ", x) + 1;
			if (x == 0)
				break;
		}
		return "";
	}

	function btn_Popup_onclick() {
		var obj = new Object();
		//팝업 URL주소
		/*
		*obj.msg1 = 자식창에 넘길값
		*obj.msg2 = 자식창에 넘길값	
		*
		*/
		obj.msg1 = "master/popSamplingPointManage.lims";
		//popMain.lims 팝업 공통 메인 프레임
		fnShowModalWindow("popMain.lims", obj, 800, 600);
	}

	function btn_Pop_notice() {
		var obj = new Object();
		obj.msg1 = "공지사항";
		obj.msg2 = "system/noticeManage.lims";
		//popMain.lims 팝업 공통 메인 프레임
		fnShowModalWindow("popMain.lims", obj, 750, 500);
		/*
		if (popup == null) {
			alert("close");
			return false;
		}
		*/
	}

	function fnViewLink(menuFlag) {
		var data = "";
		var menu = "";
		if (menuFlag == "freeBoard") {
			menu = "system/freeBoardManage.lims";
			$("#pTitle").text("시스템관리");
			$("#mTitle").text("자유공유게시판");
			$("#menu_cd").val("021000");
		} else if (menuFlag == "qna") {
			menu = "system/qnaBoardManage.lims";
			$("#pTitle").text("시스템관리");
			$("#mTitle").text("질문과답변");
			$("#menu_cd").val("021100");
		} else if (menuFlag == "notice") {
			menu = "system/noticeManage.lims";
			$("#pTitle").text("시스템관리");
			$("#mTitle").text("공지사항관리");
			$("#menu_cd").val("020700");
		} else if (menuFlag == "menual") {
			menu = "system/menual.lims";
			$("#pTitle").text("시스템관리");
			$("#mTitle").text("매뉴얼");
			$("#menu_cd").val("000000");
			var url = location.host + location.pathname.substring(0, location.pathname.lastIndexOf('/', location.pathname.length - 1));
			ifrmexcel.location.href = "http://" + url + "/manual/lims_manual.doc";
			return false;

		} else if (menuFlag == "cnt1") {
			menu = "accept/accept.lims";
			$("#pTitle").text("접수관리");
			$("#mTitle").text("접수");
			$("#menu_cd").val("030400");
			data = "type=move2";
		} else if (menuFlag == "cnt2") {
			menu = "analysis/resultInputSample.lims";
			$("#pTitle").text("결과입력");
			$("#mTitle").text("결과입력(시료별)");
			$("#menu_cd").val("040100");
		} else if (menuFlag == "cnt3") {
			menu = "analysis/resultInputGrade.lims";
			$("#pTitle").text("결과입력");
			$("#mTitle").text("결과입력(등급별)");
			$("#menu_cd").val("041400");
		} else if (menuFlag == "cnt4") {
			menu = "analysis/resultCheck.lims";
			$("#pTitle").text("결과입력");
			$("#mTitle").text("시험결과확인");
			$("#menu_cd").val("040400");
		} else if (menuFlag == "cnt5") {
			menu = "report/reportWrite.lims?cntType=5";
			$("#pTitle").text("성적서");
			$("#mTitle").text("성적서작성");
			$("#menu_cd").val("050100");
		} else if (menuFlag == "cnt11") {
			menu = "/instrument/correctionManage.lims?pageType=B&cntType=13";
			$("#pTitle").text("장비정보");
			$("#mTitle").text("교정등록");
			$("#menu_cd").val("060300");
		} else if (menuFlag == "cnt12") {
			menu = "/instrument/correctionManage.lims?pageType=B&cntType=15";
			$("#pTitle").text("장비정보");
			$("#mTitle").text("교정등록");
			$("#menu_cd").val("060300");
		} else if (menuFlag == "cnt21") {
			menu = "/instrument/correctionManage.lims?pageType=A&cntType=14";
			$("#pTitle").text("장비정보");
			$("#mTitle").text("교정등록");
			$("#menu_cd").val("060300");
		} else if (menuFlag == "cnt22") {
			menu = "/instrument/correctionManage.lims?pageType=A&cntType=16";
			$("#pTitle").text("장비정보");
			$("#mTitle").text("교정등록");
			$("#menu_cd").val("060300");
		} 
		fn_Change_MainCSS($("#mTitle").text());
		fnViewPage(menu, 'contents', data);
	}

	function fn_moveResultInputSample(test_sample_seq) {
		var menu = "analysis/resultInputSample.lims";
		$("#pTitle").text("결과입력");
		$("#mTitle").text("결과입력(시료별)");
		$("#menu_cd").val("040100");
		fn_Change_MainCSS($("#pTitle").text());
		var data = 'type=move';
		if (test_sample_seq != undefined) {
			data += '&test_sample_seq=' + test_sample_seq;
		}
		fnViewPage(menu, 'contents', data);
	}

	// 서브로 넘어 갈때
	function fn_Change_MainCSS(pTitle) {
		$("#mainTitle").text(pTitle);
		$("#top_line").css({
			"margin-left" : "0px",
			"width" : "100%"
		});
		$("#mainconDiv").css({
			"margin-left" : "0px"
		});
		$("#mainMenu").hide('blind', {}, 500, null);
		$("#wildMenu").hide('slide', {}, 500, null);
		$("#helpDesk").hide('blind', {}, 500, null);
		$(".location").show();
		$(".subtitle_wrap").show();
	}
	
	function fn_moveReq(test_req_no) {
		var menu = "accept/accept.lims";
		$("#pTitle").text("접수관리");
		$("#mTitle").text("접수");
		$("#menu_cd").val("030400");
		fn_Change_MainCSS($("#pTitle").text());
		var data = 'type=move';
		if (test_req_no != undefined) {
			data += '&test_req_no=' + test_req_no;
		}
		fnViewPage(menu, 'contents', data);
	}
	
	
	// 수수료 제어 여부
	function fn_accountFlag() {
		var json = fnAjaxAction('accept/commissionFlag.lims', null);
		//alert(json);
		if (json == null) {
			alert('error');
		} else {			
			$("#commission_flag").val(json);
		}
	}

	
	
</script>
</head>
<body id="mainBody" >
	<input type="hidden" id="menu_cd" name="menu_cd"/>
	<input type="hidden" id="menu_id" name="menu_id"/>
	<input type="hidden" id="commission_flag" name="commission_flag"/>
	<!-- RDMS VIWER --->
	<form id="frmBinder" name="frmBinder" onsubmit="return false;">
		<input type="hidden" name="vParam" id="vParam" value="">
		<input type="hidden" name="gridData" id="gridData" value="">
	</form>
	<iframe id="ifrmexcel" name="ifrmexcel"  width="0" height="0" style="display: none;"></iframe>
	<!-- RDMS VIWER END--->

	<!-- TOP --->
	<div id="header">
		<div class="TopBg_left"></div>
		<div class="TopBg_right"></div>
		<div id="top_line" class="top_area">
			<div style="width: 100%">
				<h1 class="toptitle">
					<a href="main.lims"><img id="topTitle" src="images/TopTitle.png"></a>
				</h1>
				<div>
					<ul class="topmenulayout">
						<li onclick="$('#topTitle').click();">HOME</li>
						<li id="helpDeskBtn">
							HELP DESK
							<div id="helpDesk">
								<ul>
									<li class="phone">
										<span>
											<img src="images/help_phone.png">
										</span>
									</li>
									<li class="name">LIMS 개발팀</li>
									<li class="phoneNum">02-443-3274</li>
								</ul>
							</div>
						</li>
						<li id="logout">LOGOUT</li>
					</ul>
					<span class="TopTxt">
						<img src="images/TopTxt.png">
					</span>
					<div class="topuser UserBg">
						<ul>
							<li class="UserBg_left"></li>
							<li class="UserBg_back">
								<strong><c:out value="${session.user_nm}"></c:out></strong>님이 로그인 하셨습니다. &#40;
								<span>
									<c:out value="${session.dept_nm}"></c:out>
								</span>
								&sbquo;
								<span>
									<c:out value="${session.total_role_nm}"></c:out>
								</span>
								&#41;
							</li>
							<li class="UserBg_right"></li>
						</ul>
						<div class="location">
							<p>
								<em><a href="javascript:$('#topTitle').click();">HOME</a></em>
								<span>
									<label id='pTitle'></label>
								</span>
								<span id="devRefresh">
									<label id='mTitle'></label>
								</span>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //TOP -->
	<!--left menu -->
	<table class="select_bor">
		<tr>
			<td>
				<img src="images/LeftMenu_01.png" border="0" usemap="#LeftMenu" class="pointer" id="tbMenu" style="float: left;" /> <img src="images/LeftMenu_02.png" border="0" usemap="#LeftMenu" class="pointer" id="wildMenuBar" style="position: absolute;" />
			</td>
		</tr>
		<tr>
			<td>
				<div id="mainMenu" class="tree_bg"></div>
			</td>
		</tr>
	</table>
	<!-- //left menu -->

	<!-- wildMenu -->
	<table class="select_bor_wild">
		<tr>
			<td>
				<div id="wildMenu" class="wild_menu_bg"></div>
			</td>
		</tr>
	</table>
	<!-- //wildMenu -->

	<!-- subtitle_wrap -->
	<div class="subtitle_wrap">
		<div class="subtitle">
			<p>
				<label class="mainTitle" id='mainTitle'></label>
			</p>
		</div>
	</div>
	<!-- //subtitle_wrap -->

	<!-- contents -->
	<div id="contents">

		<!-- maincon -->
		<div id="mainconDiv" class="maincon ml110">
			<!-- maincon_left -->
			<div class="maincon_left"></div>
			<!-- //maincon_left -->

			<!-- maincon_right -->
			<div class="maincon_right" style="width: 608px;">
				<div class="right1-1">
					<h2>
						<img src="images/mTitle1-1.png" alt="시험정보">
					</h2>
					<dl class="clearL" onclick="fnViewLink('cnt1');">
						<dt>
							<img src="images/right1-1_dt01.png" alt="접수대기">
						</dt>
						<dd>
							<c:out value="${resultMainCnt.cnt1}"></c:out>
							<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt2');">
						<dt>
							<img src="images/right1-1_dt02_1.png" alt="결과입력대기(시료별)">
						</dt>
						<dd>${resultMainCnt.cnt2}<img src="images/right1_txt.png" alt="건">
							<b style="margin:33px 0 0 0; font-family: Arial; font-weight: bold; font-size: 15px; color: #FF0000;">(${resultMainCnt.cnt6})</b>
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt3');">
						<dt>
							<img src="images/right1-1_dt02_2.png" alt="결과입력대기(등급별)">
						</dt>
						<dd>
							${resultMainCnt.cnt3}<img src="images/right1_txt.png" alt="건">
							<b style="margin:33px 0 0 0; font-family: Arial; font-weight: bold; font-size: 15px; color: #FF0000;">(${resultMainCnt.cnt7})</b>
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt4');">
						<dt>
							<img src="images/right1-1_dt03.png" alt="결과확인대기">
						</dt>
						<dd>
							${resultMainCnt.cnt4}<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt5');">
						<dt>
							<img src="images/right1-1_dt05.png" alt="성적서작성대기">
						</dt>
						<dd>
							${resultMainCnt.cnt5}<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
				</div>				
				<div class="right2">
					<!-- 처리기한 임박 접수리스트 -->
					<h2>
						<img src="images/mTitle2.png" alt="처리기한 임박 접수리스트">
					</h2>
					<p>${fn:length(deadline)}건</p>
					<span>
						<img onclick="fn_moveReq()" src="images/more.png" alt="more" title="더보기" class="pointer">
					</span>

					<div class="doc_con_wrap">
						<div class="doc_con">
							<table class="d_table">
								<caption> 처리기한 임박 접수리스트</caption>
								<colgroup>
									<col style="width: 98px;">
									<col style="width: 83px;">
									<col style="width: auto;">
									<col style="width: 88px;">
									<col style="width: 60px;">
								</colgroup>
								<thead>
									<tr>
										<th>접수번호</th>
										<th>접수일자</th>
										<th>제목</th>
										<th>처리기한</th>
										<th class="last">의뢰자</th>
									</tr>
								</thead>
								<tbody id="mainList">
									<c:forEach items="${deadline}" var="list">
										<tr onclick="fn_moveReq('${list.test_req_no}');">
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>${list.test_req_no}</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>${list.sample_arrival_date}</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>
												<c:if test="${fn:length(list.title ) > 20}">
													<label title="${list.title}"> ${fn:substring(list.title, 0, 20)}.. </label>
												</c:if>
												<c:if test="${fn:length(list.title ) <= 20}">${list.title}</c:if>
											</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>${list.deadline_date}</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>
												<c:if test="${fn:length(list.req_nm ) > 3}">
													<label title="${list.req_nm }">${fn:substring(list.req_nm, 0, 3)}..</label>
												</c:if>
												<c:if test="${fn:length(list.req_nm ) <= 3}">${list.req_nm}</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- //.doc_con -->
					</div>

				</div>

				<div class="right3">
					<!-- 시험대기 접수리스트 -->
					<h2>
						<img src="images/mTitle3.png" alt="시험대기 접수리스트">
					</h2>
					<span>
						<img onclick="fn_moveResultInputSample();" src="images/more.png" alt="more" title="더보기" class="pointer">
					</span>
					<div class="doc_con_wrap">
						<div class="doc_con">
							<table class="d_table">
								<caption>시험대기 접수리스트</caption>
								<colgroup>
									<col style="width: 98px;">
									<col style="width: 83px;">
									<col style="width: auto;">
									<col style="width: 88px;">
									<col style="width: 60px;">
								</colgroup>
								<thead>
									<tr>
										<th>접수번호</th>
										<th>접수일자</th>
										<th>시료명</th>
										<th>처리기한</th>
										<th class="last">의뢰자</th>
									</tr>
								</thead>
								<tbody id='mainList'>
									<c:forEach items="${resultInput}" var="list">
										<tr onclick="fn_moveResultInputSample('${list.test_sample_seq}');">
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>${list.test_req_no}</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>${list.sample_arrival_date}</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>
												<c:if test="${fn:length(list.sample_reg_nm ) > 20}">
													<label title="${list.sample_reg_nm}"> ${fn:substring(list.sample_reg_nm, 0, 20)}.. </label>
												</c:if>
												<c:if test="${fn:length(list.sample_reg_nm ) <= 20}">${list.sample_reg_nm}</c:if>
											</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>${list.deadline_date}</td>
											<td <c:if test="${list.type =='Y'}">style="color: red"</c:if>>
												<c:if test="${fn:length(list.req_nm ) > 3}">
													<label title="${list.req_nm }">${fn:substring(list.req_nm, 0, 3)}..</label>
												</c:if>
												<c:if test="${fn:length(list.req_nm ) <= 3}">${list.req_nm}</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- //.doc_con -->
					</div>

				</div>
				<!-- <div class="banner1">
					<ul>
						<li class="b1-1">
							<a><img onclick="fnViewLink('freeBoard');" src="images/mainBanner1-1.png" alt="자유공유 게시판" title="자유공유 게시판" /></a>
						</li>
						<li class="b1-2">
							<a><img onclick="fnViewLink('qna');" src="images/mainBanner1-2.png" alt="질문과답변" title="질문과답변" /></a>
						</li>
						<li class="b1-3">
							<a><img onclick="fnViewLink('notice');" src="images/mainBanner1-3.png" alt="공지사항" title="공지사항" /></a>
						</li>
						<li class="b1-4">
							<a><img onclick="fnViewLink('menual');" src="images/mainBanner1-4.png" alt="메뉴얼" title="메뉴얼" /></a>
						</li>
					</ul>
				</div> -->
				<div class="right1-1-2">
					<h2>
						<img src="images/mTitle1-1-2.png" alt="장비정보">
					</h2>
					<dl class="clearL" onclick="fnViewLink('cnt11');" style="position: relative; left: 10%;">
						<dt>
							<img src="images/right1-1-2_dt01.png" alt="검교정대기">
						</dt>
						<dd>${machineMainCnt.cnt13 }<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt12');" style="position: relative; left: 10%;">
						<dt>
							<img src="images/right1-1-2_dt02.png" alt="검교정초과">
						</dt>
						<dd>${machineMainCnt.cnt15 }<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt21');" style="position: relative; left: 10%;">
						<dt>
							<img src="images/right1-1-2_dt03.png" alt="중간점검대기">
						</dt>
						<dd>
							${machineMainCnt.cnt14 }<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
					<dl onclick="fnViewLink('cnt22');" style="position: relative; left: 10%;">
						<dt>
							<img src="images/right1-1-2_dt04.png" alt="중감점검초과">
						</dt>
						<dd>
							${machineMainCnt.cnt16 }<img src="images/right1_txt.png" alt="건">
						</dd>
					</dl>
				</div>
			</div>
			<!-- //maincon_right -->
		</div>
		<!-- //maincon -->
	</div>
	<br/>
	<!-- //contents -->

	<!-- footer 
	<div id="footer">
		<img src="images/FooterTxt.png" alt="통합장비관제시스템">
	</div>
	-->
</body>
</html>