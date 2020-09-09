
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 접근IP관리
	 * 파일명 		: accessIpL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.12.8
	 * 설  명		: 접근IP 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.8    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>

<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		accessIpGrid('system/selectAccessIp.lims', 'accessIpForm', 'accessIpGrid');		
		$('#accessIpGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('accessIpForm', 'accessIpGrid');

		$(window).bind('resize', function() {
			$("#accessIpGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

	});

	// 접근 권한 IP 리스트
	function accessIpGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			viewrecords : true,
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'ip_seq',
			sortorder : 'asc',
			colModel : [ {
				label : 'ip_seq',
				name : 'ip_seq',
				key : true,
				hidden : true
			}, {
				label : 'IP명',
				name : 'ip_nm'
			}, {
				label : '사용IP',
				name : 'start_ip',
				align : 'center'
			}, {
				label : '등록자',
				name : 'creater_id',
				align : 'center'
			}, {
				label : '수정자',
				name : 'updater_id',
				align : 'center'
			}, {
				label : '사용여부',
				width : '100',
				align : 'center',
				name : 'use_flag'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {	
				fnViewPage('system/selectAccessIpDetail.lims', 'detailDiv', 'ip_seq=' + rowId);
				$('#ip_seq').val(rowId);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}

	// 조회버튼 클릭 이벤트 - LIMS사용자 조회
	function fn_Search_accessIp() {
		$('#accessIpGrid').trigger('reloadGrid');
		$('#detailDiv').empty();
	}	

	// 신규 IP 추가 
	function btn_Add_onclick() {
		fnViewPage('system/selectAccessIpDetail.lims', 'detailDiv', '');
	}
		
	// 등록자 조회 팝업
	function fnpop_UserInfo(name) { 
		fnBasicStartLoading();		
		fnpop_UserInfoPop('accessIpForm', 500, 500, name, '');		
	}
	
	// 콜백
	function fnpop_callback(returnParam){
		fnBasicEndLoading();
	}
	
	//삭제   ->삭제해도 creater_id가 남아있어서 추가해줌
	function delFunc(){
		$("#creater_id").val('');
		$("#user_nm").val('');
	}
</script>

<div class="sub_purple_01 w100p">
	<form id="accessIpForm" name="accessIpForm" onsubmit="return false;">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span> 접근 IP
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_accessIp();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Add" onclick="btn_Add_onclick();">
						<button type="button">신규</button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table">
			<tr>				
				<th>등록IP명</th>
				<td>
					<input id="ip_nm" name="ip_nm" type="text" class="inputhan"/>
				</td>
				<th>등록자</th>
				<td>
					<input id="creater_id" name="creater_id" type="hidden" class="inputhan"/>
					<input id="user_nm" name="user_nm" type="text" class="inputhan w150px"/>
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="fnpop_UserInfo('accessIp');">
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="delId" style="cursor: pointer;" onClick='delFunc()' />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value="" style="width: 20px" checked="checked" />전체</label> 
					<label><input type='radio' name='use_flag' value="Y" style="width: 20px" />사용함</label> 
					<label><input type='radio' name='use_flag' value="N" style="width: 20px" />사용안함</label>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="accessIpGrid"></table>
		</div>
	</form>
</div>

<div class="sub_blue_01 w100p" id="detailDiv"></div>
