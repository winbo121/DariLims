
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: SMS관리
	 * 파일명 		: smsManageL01.jsp
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

		smsManageGrid('system/selectSmsManage.lims', 'smsManageForm', 'smsManageGrid');		
		$('#smsManageGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('smsManageForm', 'smsManageGrid');

		$(window).bind('resize', function() {
			$("#smsManageGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

	});

	// SMS관리 리스트
	function smsManageGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			viewrecords : true,
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			rowNum : -1,
			rownumbers : true,
			sortname : 'sms_key',
			sortorder : 'asc',
			colModel : [ {
				label : 'sms_key',
				name : 'sms_key',
				key : true,
				hidden : true
			}, {
				label : 'sms_type',
				name : 'sms_type',
				hidden : true
			}, {
				label : '문자타입',
				name : 'sms_type_nm',
				width : 100 
			}, {
				label : 'process',
				name : 'process',
				hidden : true
			}, {
				label : '진행상황',
				name : 'process_nm',
				width : 100 
			}, {
				label : '메시지',
				name : 'msg',
				width : 500 
			}, {
				label : '발송전화번호',
				name : 'send_tel_no',
				align : 'center',
				width : 100 
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				fnViewPage('system/selectSmsManageDetail.lims', 'detailDiv', 'pageType=detail&sms_type=' + row.sms_type + '&process=' + row.process);
				$('#pageType').val("detail");
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}

	function btn_Add_onclick() {
		fnViewPage('system/selectSmsManageDetail.lims', 'detailDiv', '');
	}
	
	function fn_Search_SmsManage(){
		$('#smsManageGrid').trigger('reloadGrid');
		$('#detailDiv').empty();
	}

</script>

<div class="sub_purple_01 w100p">
	<form id="smsManageForm" name="smsManageForm" onsubmit="return false;">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span> SMS 관리
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_SmsManage();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Add" onclick="btn_Add_onclick();">
						<button type="button">신규</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="smsManageGrid"></table>
		</div>
	</form>
</div>

<div class="sub_blue_01 w100p" id="detailDiv">
&nbsp;
</div>