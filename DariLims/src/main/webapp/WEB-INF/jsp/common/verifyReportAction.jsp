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

	});

	function btn_Return_onclick() {
		document.location.href = "verifyReport.lims";
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
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						성적서 진위확인
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Return" onclick="btn_Return_onclick();">
							<button type="button">돌아가기</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>진위확인 코드</th>
					<td>
						${verify_id1} - ${verify_id2} - ${verify_id3} - ${verify_id4}
					</td>
				</tr>
				<tr>
					<th>조회결과</th>
					<td>
						<c:choose>
						<c:when test="${reportState eq 'Y'}">
						성적서 '${reportInfo.destination_nm}' 가 검색되었습니다.
						</c:when>
						<c:when test="${reportState eq 'N'}">
						검색된 성적서가 없습니다.
						</c:when>
						<c:otherwise>
						잘못된 진위확인 코드입니다.
						</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
		
		
<c:if test="${reportState eq 'Y'}">
		<div class="sub_purple_01 w100p">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						성적서 내역
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
					</td>
				</tr>
			</table>
			<table class="list_table" >
				<tr>
					<th>성적서번호</th>
					<td>
						${reportInfo.report_doc_seq}
					</td>
					<th>접수번호</th>
					<td>
						${reportInfo.test_req_no}
					</td>					
				</tr>
				<tr>
					<th>시료접수일</th>
					<td>
						${reportInfo.req_date}
					</td>
					<th>시험완료일</th>
					<td>
						${reportInfo.dept_appr_date}
					</td>
				</tr>
				<tr>
					<th>업체명</th>
					<td>
						${reportInfo.destination_nm}
					</td>
					<th>의뢰인</th>
					<td>
						${reportInfo.req_nm}
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						${reportInfo.req_org_addr}
					</td>
				</tr>
				<tr>
					<th>시료명</th>
					<td>
						${reportInfo.sample_reg_nm}
					</td>
					<th>시료수</th>
					<td>
						${reportInfo.tot_sample_count}
					</td>
				</tr>
				<tr style="display:none">
					<th>시험규격</th>
					<td colspan="3">

					</td>
				</tr>
			</table>
		</div>
		
		<div class="sub_purple_01 w100p">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시험분석 결과
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
					</td>
				</tr>
			</table>
			<table class="list_table" >
				<tr>
					<th>시료구분</th>
					<th>시험항목</th>
					<th>단위</th>
					<th>결과치</th>
				</tr>
				
				<c:forEach var="result" items="${reportInfoItem}" varStatus="status">
				<tr>
					<td height="25">${result.sample_reg_nm}</td>
					<td>${result.test_item_nm}</td>
					<td>${result.unit}</td>
					<td>${result.report_disp_val}</td>
				</tr>
                </c:forEach>
				<c:if test="${fn:length(reportInfoItem) == 0}">
				<tr>
					<td class="center" colspan="4">
						검색된 시험결과가 없습니다.
					</td>
				</tr>
				</c:if>	
			</table>
		</div>
		</c:if>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<div id="footer">
		<img src="images/FooterTxt.png" alt="통합장비관제시스템">
	</div>
	<!-- //footer -->
</body>
</html>