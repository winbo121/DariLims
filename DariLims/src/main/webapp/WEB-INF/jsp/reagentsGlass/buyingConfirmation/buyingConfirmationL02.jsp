<%
/***************************************************************************************
* 시스템명 		: 통합장비관제시스템
* 업무명 		: 구매요청(승인)
* 파일명 		: buyingConfirmationL02.jsp
* 작성자 		: 최은향
* 작성일 		: 2015.02.25
* 설  명		: 구매요청(승인) 목록 조회 화면
*---------------------------------------------------------------------------------------
* 변경일		변경자		변경내역 
*---------------------------------------------------------------------------------------
* 2015.02.25    최은향		최초 프로그램 작성         
* 
*---------------------------------------------------------------------------------------
****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("dept_cd", "", "ALL", null, 'allBuyingConfirmationListForm');
		ajaxComboForm("m_mtlr_info", "", "All", "", 'allBuyingConfirmationListForm'); // 중분류 검색창 초기화용
		
		// 구매요청목록
		//allBuyingConfirmationListGrid('reagents/selectBuyingRequestList.lims', 'allBuyingConfirmationListForm', 'allBuyingConfirmationListGrid');	
		allBuyingConfirmationListGrid('reagents/allBuyingConfirmationList.lims', 'allBuyingConfirmationListForm', 'allBuyingConfirmationListGrid');	
		
		// 그리드 사이즈 	
		$(window).bind('resize', function() {
			$("#allBuyingConfirmationListGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우(구매요청 그리드 조회)
		fn_Enter_Search('allBuyingConfirmationListForm', 'allBuyingConfirmationListGrid');
	});
	
	// 조회버튼 클릭 이벤트
	function btn_Search_sub_onclick() {		
		$('#allBuyingConfirmationListGrid').trigger('reloadGrid');		
	}
	
</script>

<table class="select_table" >
	<tr>
		<td class="table_title">
			<span>■</span>
			구매 요청 목록
		</td>
		<td class="table_button">
			<span class="button white mlargep auth_save" onclick="btn_Modify_sub_onclick();" id="btn_Modify">
					<button type="button">수정</button>
			</span>
			<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_sub_onclick();">
					<button type="button">조회</button>
			</span>
		</td>
	</tr>
</table>
<table  class="list_table" >
	<tr>
		<th>대분류</th>
		<td>
			<select name="h_mtlr_info" id="h_mtlr_info" style="width:80px"	onchange="comboReload()">
				<option value=" ">전체</option>
				<option value="C42">시약류</option>
				<option value="C43">소모품류</option>
			</select>
		</td>
		<th>중분류</th>
		<td>
			<select name="m_mtlr_info" id="m_mtlr_info" style="width:90px"></select>
		</td>
		<th style="min-width:70px;">요청부서명</th>
		<td>
			<select id="dept_cd" name="dept_cd" style="width:110px"></select>
		</td>
	</tr>
	<tr>
		<th style="min-width:90px;">시약실험기구명</th>
		<td colspan="5">
			<input id="item_kor_nm" name="item_kor_nm" type="text" style="width:300px;"/>
		</td>
	</tr>
</table>
<input type="hidden" id="sortName" name="sortName">
<input type="hidden" id="sortType" name="sortType">
<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no" value="${detail.mtlr_mst_no}">
<table id="allBuyingConfirmationListGrid"></table>			