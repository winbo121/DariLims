
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용자관리
	 * 파일명 		: userL02.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.08.24
	 * 설  명		: 사용자관리 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.08.24    윤상준		최초 프로그램 작성         
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
		ajaxComboForm("dept_cd", "", "ALL", null, 'deptForm'); // 부서
		
		deptLimsGrid('system/selectDeptLimsList.lims', 'deptForm', 'deptLimsGrid');
		$('#deptLimsGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('deptForm', 'deptLimsGrid');

		$(window).bind('resize', function() {
			$("#deptLimsGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

	});


	function deptLimsGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			viewrecords : true,
			height : '230',
			autowidth : true,
			loadonce : true,
			shrinkToFit : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'dept_nm',
			sortorder : 'asc',
			colModel : [ /* {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				frozen : true
			},  {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
			},*/ {
				type : 'not',
				label : '부서명',
				width : '200',
				name : 'lvl_dept_nm' // 'dept_nm' 일반보기
			}, {
				label : '부서코드',
				name : 'dept_cd',
				width : '50',
				key : true
			}, {
				label : '상위부서',
				name : 'pre_dept_nm',
				width : '100'
			}, {
				label : '비고',
				name : 'dept_desc',
				width : '300'
			}, {
				label : '사용여부',
				width : '80',
				align : 'center',
				editable : true,
				edittype : 'select',
				editoptions : {
					value : 'Y:사용함;N:사용안함'
				},
				name : 'use_flag'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {	
				fnViewPage('system/selectDeptLimsDetail.lims', 'detailDiv', 'pageType=detail&dept_cd=' + rowId);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				/* fnGridEdit(grid, rowId, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();

				$('#' + grid).setCell(rowId, 'icon', gridU); */
			}
		});
	}

	//조회버튼 클릭 이벤트 - LIMS사용자 조회
	function fn_Search_deptLims() {
		$('#deptLimsGrid').trigger('reloadGrid');
		$('#detailDiv').empty();
	}	

	//신규부서 추가 
	function btn_Add_onclick() {
		fnViewPage('system/selectDeptLimsDetail.lims', 'detailDiv', '');
	}
</script>

<div class="sub_purple_01 w100p">
	<form id="deptForm" name="deptForm" onsubmit="return false;">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					LIMS 사용부서
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_deptLims();">
						<button type="button">조회</button>
					</span>
					<!-- <span class="button white mlargep" id="btn_Save" onclick="btn_Save_onclick('deptLimsGrid');">
						<button type="button">저장</button>
					</span>
					<span class="button white mlargep" id="btn_Sync" onclick="btn_Sync_onclick();">
						<button type="button">동기화</button>
					</span> -->
					<span class="button white mlargep auth_save" id="btn_Add" onclick="btn_Add_onclick();">
						<button type="button">신규</button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table">
			<tr>
				<th>부서명</th>
				<td>
					<select id="dept_cd" name="dept_cd" class="w150px"></select>
<!-- 					<input id="dept_nm" name="dept_nm" class="w200px"/> -->
				</td>
<!-- 				<th>상위부서명</th>
				<td>
					<input id="user_nm" name="user_nm" type="text" class="inputhan" />
				</td>
				<th>사용자아이디</th>
				<td>
					<input name="user_id" type="text" class="inputhan" />
				</td> -->
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value="" style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value="Y" style="width: 20px" />사용함</label> <label><input type='radio' name='use_flag' value="N" style="width: 20px" />사용안함</label>
				</td>
				<!-- 				<td> -->
				<!-- 					<select name="use_flag" id="use_flag" class="w80px"></select> -->
				<!-- 				</td> -->
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="deptLimsGrid"></table>
		</div>
	</form>
</div>
<div class="sub_blue_01 w100p" id="detailDiv"></div>
