
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약/실험기구등록(팝업)
	 * 파일명 		: buyingRequestP02.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.03.10
	 * 설  명		: 시약/실험기구정보 일반사용자 등록 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.10   석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml" class="minH170">
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
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>
<script type="text/javascript">
	$(function() {
		ajaxComboForm("unit", "C16", null, "", 'reagentsForm'); // 단위(수량단위-선택)
		ajaxComboForm("m_mtlr_info", "", "All", "", 'reagentsForm'); // 중분류

		//팝업 윈도우 close버튼으로 닫을때 이벤트
		$(window).on("beforeunload", function() {
		});
	});

	//저장, 수정 버튼 클릭 이벤트
	function btn_Insert_onclick() {
		// 필수값 체크 
		var form = "#reagentsForm";
		var param = $(form).serialize();
		var id = $(form).find('#mtlr_no').val();
		var url = '';		
				
		// 필수값 입력 체크
		var h_mtlr_info = $(form).find('#h_mtlr_info').val();
		var m_mtlr_info = $(form).find('#m_mtlr_info').val();
		var item_nm = $(form).find('#item_nm').val();
		var unit = $(form).find('#unit').val();
		var spec1 = $(form).find('#spec1').val();
		var spec2 = $(form).find('#spec2').val();
		var spec_etc = $(form).find('#spec_etc').val();
		var use = $(form).find('#use').val();

		if (h_mtlr_info == null || h_mtlr_info == "") {
			alert('"대분류"를 선택 하세요');
			$(form).find('#h_mtlr_info').focus();
			return false;
		}
		if (m_mtlr_info == null || m_mtlr_info == "") {
			alert('"중분류"를 선택 하세요');
			$(form).find('#m_mtlr_info').focus();
			return false;
		}
		if (item_nm == null || item_nm == "") {
			alert('"품명"을 선택 하세요');
			$(form).find('#item_nm').focus();
			return false;
		}
		if (unit == null || unit == "") {
			alert('"단위"을 선택 하세요');
			$(form).find('#unit').focus();
			return false;
		}
		if (spec1 == null || spec1 == "") {
			alert('"제조사"를 입력 하세요');
			$(form).find('#spec1').focus();
			return false;
		}		
		// 사업소에선 필요없는 벨리데이션
// 		if (spec2 == null || spec2 == "") {
// 			alert('"규격2"을 입력 하세요');
// 			$(form).find('#spec2').focus();
// 			return false;
// 		}		
// 		if (spec_etc == null || spec_etc == "") {
// 			alert('"규격기타"을 입력 하세요');
// 			$(form).find('#spec_etc').focus();
// 			return false;
// 		}		
// 		if (use == null || use == "") {
// 			alert('"용도"을 입력 하세요');
// 			$(form).find('#use').focus();
// 			return false;
// 		}		
		
		// 저장
		if (id == null || id == '') {
			url = fn_getConTextPath()+'/insertPopReagentsGlassInfo.lims';
		}
		var json = fnAjaxAction(url, param);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			//마지막 row 선택항목에 넣기	
			var addData = {
				"mtlr_no" : json,
				"h_mtlr_info" : $(form).find("#h_mtlr_info option:selected").text(),
				"m_mtlr_info" : $(form).find("#m_mtlr_info option:selected").text(),
				// 			"h_mtlr_info": $('#reagentsForm').find("#h_mtlr_info").val(),
				// 			"m_mtlr_info": $('#reagentsForm').find("#m_mtlr_info").val(),
				"item_nm" : $(form).find('#item_nm').val(),
				// 			"unit" : $('#reagentsForm').find('#unit').val(),
				"unit" : $(form).find("#unit option:selected").text(),
				"use" : $('#reagentsForm :radio[id="use"]:checked').val(),
				// 			"use" : $('#reagentsForm').find('#use').val(),
				"spec1" : $(form).find('#spec1').val(),
				"spec2" : $(form).find('#spec2').val(),
				"content" : $(form).find('#content').val(),
				"etc" : $(form).find('#etc').val(),
				"master_yn" : '일반'
			};

			$.showAlert("", {
				type : 'insert'
			});
			
			opener.fn_popCallback(addData);
			//var returnValue = addData;
			//window.returnValue = returnValue;
			window.close();
		}
	}

	//닫기클릭이벤트
	function btn_New_Close_onclick() {
		window.close();
	}

	// 대분류 콤보
	function comboReload() {
		//alert($("#h_mtlr_info").val());
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'reagentsForm'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'reagentsForm'); // 중분류
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>구매필요대상등록</h2>
		<form id="reagentsForm" name="reagentsForm" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
				<table  class="select_table" >
					<tr>
						<td width="60%" class="table_title">
							<span>■</span>
							<!-- 						시약/실험기구 추가등록 -->
							구매필요대상등록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
								<button type="button">저장</button>
							</span>
							<span class="button white mlargep" id="btn_New_Close" onclick="btn_New_Close_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table" >
					<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
					<tr>
						<th>대분류</th>
						<td>
							<select name="h_mtlr_info" id="h_mtlr_info" onchange="comboReload()" class="w100px">
								<option value="">전체</option>
								<option value="C42">시약류</option>
								<option value="C43">소모품류</option>
							</select>
						</td>
						<th>중분류</th>
						<td>
							<select name="m_mtlr_info" id="m_mtlr_info" class="w120px"></select>
						</td>
					</tr>
					<tr>
						<th>품명</th>
						<!--한글우선입력-->
						<td>
							<input type="hidden" id="mtlr_no" name="mtlr_no">
							<input name="item_nm" id="item_nm" type="text" class="inputhan" />
						</td>
						<th>단위</th>
						<td>
							<select name="unit" id="unit" class="w120px"></select>
						</td>
					</tr>
					<tr>
						<th>제조사</th>
						<td>
							<input name="spec1" id="spec1" type="text" />
						</td>
						<th>Cas no.</th>
						<td>
							<input name="spec2" id="spec2" type="text" />
						</td>
					</tr>
					<tr>
						<th>Cat # (제품번호)</th>
						<td>
							<input name="spec_etc" id="spec_etc" type="text" />
						</td>
						<th>Lot # (로트번호)</th>
						<td>
							<input name="use" id="use" type="text" value="${detail.use}" />
						</td>
					</tr>
					<tr>
						<th>용량</th>
						<td>
							<input name="mtlr_vol" id="mtlr_vol" type="text" value="${detail.mtlr_vol}" />
						</td>
						<th>사용여부</th>
						<!--radio 버튼-->
						<td colspan="3">
							<input type="radio" name="use_flag" id="use_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
							사용함
							<input type="radio" name="use_flag" id="use_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
							사용안함
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<!--한글우선입력-->
						<td colspan="5">
							<textarea rows="3" cols="90%" style="border: 1px solid #afafaf;" name="content" id="content" class="inputhan">${detail.content}</textarea>
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<!--한글우선입력-->
						<td colspan="3">
							<textarea rows="3" cols="90%" style="border: 1px solid #afafaf;" name="etc" id="etc" class="inputhan">${detail.etc}</textarea>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</div>
</body>
</html>
