<%
/***************************************************************************************
* 시스템명 		: 통합장비관제시스템
* 업무명 		: 구매요청(승인)
* 파일명 		: buyingConfirmationL03.jsp
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
		
		// 구매확정
		buyingConfirmationGrid('reagents/buyingConfirmationList.lims?mtlr_mst_no=' + mtlr_mst_no, 'receivePayForm', 'receivePayGrid');

	 	// 그리드 사이즈 		
		$(window).bind('resize', function() {
		    $("#receivePayGrid").setGridWidth($('#view_grid_sub2').width(), false); 
		}).trigger('resize');
	 	
		// 구매 상태가 '구매요청'이면 확장(수불등록) 안되게 (요청:C39001, 확정:C39004)
		if(appr_flag == 'C39001'){
			$('#btn_Conf').show();
			$('#btn_Save').hide();
			$('#btn_Reagents').show();
			$('#btn_Del').show();
		}else{
			$('#btn_Conf').hide();
			$('#btn_Save').hide();
			$('#btn_Reagents').hide();
			$('#btn_Del').hide();
		}	 	
	});
	
</script>
<table  class="select_table" >
	<tr>
		<td  style="min-width:80px;" class="table_title">
			<span>■</span>
			구매 확정 목록
		</td>
		<td class="table_button">
			<span class="button white mlargeb auth_save" id="btn_Reagents" onclick="btn_Reagents_Info_onclick();">
				<button type="button">구매리스트추가</button>
			</span>
			<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_Sub_onclick();">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Del" onclick="btn_Del_Sub_onclick();">
				<button type="button">삭제</button>
			</span>
			
			<span class="button white mlargeb auth_save" style="margin-left:10px;" id="btn_Conf" onclick="btn_Conf_Sub_onclick();">
				<button style="color:#7b2da3;" type="button">확정</button>
			</span>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="hidden" id="mode" name="mode" value="0">
			<input type="hidden" id="key" name="key">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no">
			<table id="receivePayGrid"></table>
		</td>
	</tr>
</table>