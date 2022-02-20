
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 요청목록 기기 수정 팝업
	 * 파일명 		: purchaseConfirmP02.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.10
	 * 설  명		: 요청목록 기기 수정 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.18   최은향		최초 프로그램 작성         
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
	var obj;
	var mtlr_no_;
	var mtlr_req_no;

	$(function() {
		obj = window.dialogArguments;
		mtlr_no_ = obj.ids;
		//$('#mtlr_no').val(obj.ids);

		ajaxComboForm("unit", "C16", "${detail.unit}", "", 'buyingConfirmationModifyForm'); // 단위(수량단위-선택)
		ajaxComboForm("mtlr_flag", "C26", "${detail.mtlr_flag}", "", 'buyingConfirmationModifyForm'); // 물품(선택)
		ajaxComboForm("h_mtlr_info", "", "${detail.h_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 대분류
		ajaxComboForm("m_mtlr_info", "", "", "", 'buyingConfirmationModifyForm'); // 중분류

		if ($("#h_mtlr_info_detail").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "${detail.m_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 중분류
		} else if ($("#h_mtlr_info_detail").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "${detail.m_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 중분류
		} else {
			ajaxComboForm("m_mtlr_info", "", "${detail.m_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 중분류
		}
		$('#tabDiv4').width($('#tabDiv4').width() - 40);

		//팝업 윈도우 close버튼으로 닫을때 이벤트
		$(window).on("beforeunload", function() {
		});

	});

	// 대분류 콤보(detail)
	function comboReload_detail() {
		if ($("#h_mtlr_info_detail").val() == "C42") {
			//alert($("#h_mtlr_info_detail").val());
			ajaxComboForm("m_mtlr_info", "C42", "${detail.m_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 중분류			
		} else if ($("#h_mtlr_info_detail").val() == "C43") {
			//alert($("#h_mtlr_info_detail").val());
			ajaxComboForm("m_mtlr_info", "C43", "${detail.m_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 중분류
		} else {
			//alert($("#h_mtlr_info_detail").val());
			ajaxComboForm("m_mtlr_info", "", "${detail.m_mtlr_info}", "", 'buyingConfirmationModifyForm'); // 중분류
		}
	}

	//저장 버튼 클릭 이벤트
	function btn_Insert_onclick() {
		var param = $('#buyingConfirmationModifyForm').serialize();
		var id = $('#buyingConfirmationModifyForm').find('#mtlr_no').val();
		mtlr_req_no = $('#buyingConfirmationModifyForm').find('#mtlr_req_no').val(); // 요청코드		
		var url = '';
		var opener = window.dialogArguments["self"];
		//alert("test");

		// 저장
		if (id == null || id == '') {
			//url = 'reagents/insertPopReagentsGlassInfo.lims';
			url = 'reagents/updatePopReagentsGlassInfo.lims?mtlr_no=' + mtlr_no_ + '&mtlr_req_no=' + mtlr_req_no;
		} else {
			//alert(mtlr_req_no);
			url = 'reagents/updatePopReagentsGlassInfo.lims?mtlr_no=' + mtlr_no_ + '&mtlr_req_no=' + mtlr_req_no + '&modify_flag=' + id;
		}
		var json = fnAjaxAction(url, param);
		if (json == null) {
			alert("저장 실패하였습니다.");
		} else {
			alert('저장완료되었습니다.')
			window.returnValue = 'reloadGrid';
			window.close();
		}
	}

	// 닫기클릭이벤트
	function btn_New_Close_onclick() {
		window.close();
	}

	// 관리자 등록팝업
	function btn_Pop_AdminChoice() {
		var form = 'buyingConfirmationModifyForm';
		var obj = new Object();
		obj.msg1 = 'reagents/popMasterList.lims';
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 360);

		//alert(popup);
		if (popup != null) {
			var arr = popup.split('■★■');
			for ( var r in arr) {
				var v = arr[r].split('●★●');
				var id = v[0];
				if (id == 'mtlr_no') {
					id = 'mtlr_no'; // 시약실험기구번호					
					//mtlr_no_ = $('#' + form).find('#' + id).val(v[1]);
					mtlr_no_ = v[1];
				} else if (id == 'item_nm') {
					id = 'item_nm'; // 시약/실험기구명
				} else if (id == 'spec1') {
					id = 'spec1'; // 제조사
				} else if (id == 'spec2') {
					id = 'spec2'; // Cas no.
				} else if (id == 'spec_etc') {
					id = 'spec_etc'; // Cat # (제품번호)
				} else if (id == 'use') {
					id = 'use'; // Lot # (로트번호)
				} else if (id == 'mtlr_vol') {
					id = 'mtlr_vol'; // 용량
				} else if (id == 'use_flag') {
					id = 'use_flag'; // 사용여부
				} else if (id == 'content') {
					id = 'content'; // 내용
				} else if (id == 'etc') {
					id = 'etc'; // 비고
				}
				$('#' + form).find('#' + id).val(v[1]);

				if (id == 'h_mtlr_info_grid') {
					id = 'h_mtlr_info_detail'; // 대분류					
					$('#' + form).find('#' + id).val(v[1]);
				}

				if (id == 'm_mtlr_info_grid') {
					id = 'm_mtlr_info'; // 중분류					
					if ($('#' + form).find('#h_mtlr_info_detail').val() == 'C42') {
						ajaxComboForm("m_mtlr_info", "C42", v[1], "", 'buyingConfirmationModifyForm'); // 중분류
					}
					if ($('#' + form).find('#h_mtlr_info_detail').val() == 'C43') {
						ajaxComboForm("m_mtlr_info", "C43", v[1], "", 'buyingConfirmationModifyForm'); // 중분류
					}
				}

				if (id == 'unit_code') {
					id = 'unit'; // 단위
					$('#' + form).find('#' + id).val(v[1]);
				}
			}
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>시약/실험기기 수정</h2>
		<div id="tabDiv4" style="margin-top: 20px; margin-bottom: 20px;">
			<form id="buyingConfirmationModifyForm" name="buyingConfirmationModifyForm" onsubmit="return false;">
				<div class="sub_purple_01">
					<table  class="select_table" >
						<tr>
							<td width="60%" class="table_title">
								<span>■</span>
								시약/실험기기 수정
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_select" id="btn_Master" onclick="btn_Pop_AdminChoice();">
									<button type="button">마스터목록</button>
								</span>
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
						<tr>
							<th>대분류</th>
							<td>
								<select name="h_mtlr_info" id="h_mtlr_info_detail" onchange="comboReload_detail();" class="w100px">
									<option value="">전체</option>
									<option value="C42" <c:if test="${detail.h_mtlr_info == 'C42'}">selected</c:if>>시약류</option>
									<option value="C43" <c:if test="${detail.h_mtlr_info == 'C43'}">selected</c:if>>소모품류</option>
								</select>
							</td>
							<th>중분류</th>
							<td>
								<select name="m_mtlr_info" id="m_mtlr_info" class="w120px"></select>
							</td>
						</tr>
						<tr>
							<th>시약/실험기구명</th>
							<!--한글우선입력-->
							<td>
								<input type="hidden" id="mtlr_req_no" name="mtlr_req_no" value="${detail.mtlr_req_no}">
								<input type="hidden" id="mtlr_no" name="mtlr_no" style="width: 50px;">
								<input name="item_nm" id="item_nm" type="text" class="inputhan" value="${detail.item_nm}" />
							</td>
							<th>단위</th>
							<td>
								<select name="unit" id="unit" class="w120px"></select>
							</td>
						</tr>
						<tr>
							<th>제조사</th>
							<td>
								<input name="spec1" id="spec1" type="text" value="${detail.spec1}" />
							</td>
							<th>Cas no.</th>
							<td>
								<input name="spec2" id="spec2" type="text" value="${detail.spec2}" />
							</td>
						</tr>
						<tr>
							<th>Cat # (제품번호)</th>
							<td>
								<input name="spec_etc" id="spec_etc" type="text" value="${detail.spec_etc}" />
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
							<td colspan="3">
								<input type="radio" name="use_flag" id="use_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
								사용함
								<input type="radio" name="use_flag" id="use_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
								사용안함
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="5">
								<textarea rows="3" cols="90%" style="border: 1px solid #afafaf;" name="content" id="content" class="inputhan">${detail.content}</textarea>
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td colspan="3">
								<textarea rows="3" cols="90%" style="border: 1px solid #afafaf;" name="etc" id="etc" class="inputhan">${detail.etc}</textarea>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
