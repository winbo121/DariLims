
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 감사추적 관리
	 * 파일명 		: auditTrailL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.11.13
	 * 설  명		: 감사기록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.11.13    최은향		최초 프로그램 작성    
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
		
		ajaxComboForm("dept_cd", "", "ALL", null, 'auditTrailForm'); // 부서
		
		auditTrailGrid('system/selectAuditTrailList.lims', 'auditTrailForm', 'auditTrailGrid');
		$('#auditTrailGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('auditTrailForm', 'auditTrailGrid');
		
		$(window).bind('resize', function() {
			$("#auditTrailGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');
	});

	// 감사기록
	function auditTrailGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '575',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : false,
			rowNum : -1,			
			rownumbers : true,
			sortname : 'create_date',
			sortorder : 'asc',
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '50',
				align : 'center',
				classes : 'rNum',
				sortable : false,
				hidden: true
			}, {
				label : '메뉴명',
				width : '100',
				align : 'center',
				name : 'menu_nm'
			}, {
				label : '이벤트명',
				width : '100',
				name : 'at_proc'
			}, {
				label : '감사내용',
				width : '500',
				name : 'at_cont'
			}, {
				label : '접수번호',
				align : 'center',
				width : '65',
				name : 'test_req_no'
			}, {
				label : '시료번호',
				align : 'center',
				width : '80',
				name : 'test_sample_seq'
			}, {
				label : '시료명',
				name : 'sample_reg_nm'
			}, {
				label : '항목명',
				name : 'test_item_nm'
			}, {
				label : '사용자명',
				width : '100',
				align : 'center',
				name : 'user_nm'
			}, {
				label : '사용자IP',
				name : 'at_ip'
			}, {
				label : '사용시간',
				name : 'create_date'
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
		$('#auditTrailGrid').trigger('reloadGrid');
		fnViewPage('system/auditTrailPaging.lims', 'paging', $('#auditTrailForm').serialize());
	}	
		
	//조회버튼 클릭 이벤트 - 로그 조회
	function fn_Search_onclick(){
		$('#pageNo').val(1);
		$('#auditTrailGrid').trigger('reloadGrid');
		fnViewPage('system/auditTrailPaging.lims', 'paging', $('#auditTrailForm').serialize());
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('auditTrailGrid');
		fn_Excel_Download(data);
	}
	
</script>
<div class="sub_purple_01 w100p">
<form id="auditTrailForm" name="auditTrailForm" onsubmit="return false;">
	<table  class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				감사기록목록
			</td>
			<td class="table_button">
				<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_onclick();">
					<button type="button">조회</button>
				</span>
				<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
					<button type="button">EXCEL</button>
				</span>
			</td>
		</tr>
	</table>
	<table  class="list_table" >	
		<tr>
			<th>메뉴명</th>
			<td>
				<input id="menu_nm" name="menu_nm" type="text" class="inputhan" />
			</td>			
			<th>사용자ID</th>
			<td>
				<input id="user_id" name="user_id" type="text" class="inputhan" />
			</td>
			<th>사용자명</th>
			<td>
				<input id="user_nm" name="user_nm" type="text" class="inputhan" />
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
		<tr>
			<th>접수번호</th>
			<td>
				<input id="test_req_no" name="test_req_no" type="text"/>
			</td>
			<th>시료번호</th>
			<td>
				<input id="test_sample_seq" name="test_sample_seq" type="text"/>
			</td>
			<th>항목명</th>
			<td colspan="3">
				<input id="test_item_nm" name="test_item_nm" type="text" class="inputhan w200px"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="pageNo" name="pageNo" value="1">
	<input type="hidden" id="totalCount" name="totalCount" value="0">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="auditTrailGrid"></table>
		<div id="paging"></div>
	</div>
</form>	
</div>
