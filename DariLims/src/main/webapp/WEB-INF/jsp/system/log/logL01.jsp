
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 로그관리
	 * 파일명 		: logL01.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명		: 로그관리 리스트 조회 화면
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
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style type="text/css">
	.rNum {
		background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
		color: #2e6e9e !important;
	}
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		$('#startDate').val(fnGetToday(1,0));
		$('#endDate').val(fnGetToday(0,0));
		
		ajaxComboForm("dept_cd", "", "ALL", null, 'Form'); // 부서
		
		logGrid('system/selectLogList.lims', 'Form', 'logGrid');
		$('#logGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		fnViewPage('system/logPaging.lims', 'paging', $('#Form').serialize());
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('Form', 'logGrid');
		
		$(window).bind('resize', function() {
			$("#logGrid").setGridWidth($('#view_grid_main').width(), true);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');
	});

	function logGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '575',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : true,
			rowNum : -1,			
			rownumbers : true,
			sortname : 'user_login_date',
			sortorder : 'asc',
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '30',
				align : 'center',
				classes : 'rNum',
				sortable : false,
				hidden: true
			}, {
				label : '부서명',
				name : 'dept_nm'
			}, {
				label : '사용자명',
				name : 'user_nm'
			}, {
				label : '사용자ID',
				name : 'user_id'
			}, {
				label : '사용자IP',
				name : 'user_ip'
			}, {
				label : '로그인시간',
				name : 'user_login_date'
			}, {
				label : '로그아웃시간',
				name : 'user_logout_date'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}
	
	// 페이징 이벤트(하단 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#logGrid').trigger('reloadGrid');
		fnViewPage('system/logPaging.lims', 'paging', $('#Form').serialize());
	}	
		
	//조회버튼 클릭 이벤트 - 로그 조회
	function fn_Search_onclick(){
		$('#pageNo').val(1);
		$('#logGrid').trigger('reloadGrid');
		fnViewPage('system/logPaging.lims', 'paging', $('#Form').serialize());
	}
</script>
<div class="sub_purple_01 w100p">
<form id="Form" name="Form" onsubmit="return false;">
	<table  class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				로그목록
			</td>
			<td class="table_button">
				<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_onclick();">
					<button type="button">조회</button>
				</span>
			</td>
		</tr>
	</table>
	<table  class="list_table" >	
		<tr>	
			<th>부서명</th>
			<td>
				<select name="dept_cd" id="dept_cd"></select>
<!-- 				<input id="dept_nm" name="dept_nm" type="text" class="inputhan" /> -->
			</td>
			<th>사용자명</th>
			<td>
				<input id="user_nm" name="user_nm" type="text" class="inputhan" />
			</td>
			<th>ID</th>
			<td>
				<input name="user_id" type="text"/>
			</td>
			<th>로그일자</th>
			<td>
				<input style="width: 80px" name="startDate" id="startDate" type="text" class="inputhan" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' />
				~
				<input style="width: 80px" name="endDate" id="endDate" type="text" class="inputhan" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
			</td>
		</tr>
	</table>
	<input type="hidden" id="pageNo" name="pageNo" value="1">
	<input type="hidden" id="totalCount" name="totalCount" value="0">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="logGrid"></table>
		<div id="paging"></div>
	</div>
</form>	
</div>
