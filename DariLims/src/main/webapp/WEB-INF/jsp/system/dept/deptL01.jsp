
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부서관리
	 * 파일명 		: deptL01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.01.24
	 * 설  명		: 부서관리 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.24    정우용		최초 프로그램 작성         
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
		
		deptCmmnGrid('system/selectDeptCmmnList.lims', 'mainForm', 'deptCmmnGrid');
		//$('#deptCmmnGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		deptLimsGrid('system/selectDeptLimsList.lims', 'subForm', 'deptLimsGrid');

		$(window).bind('resize', function() {
			$("#deptCmmnGrid").setGridWidth($('#view_grid_sub_l').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#deptLimsGrid").setGridWidth($('#view_grid_sub_r').width(), true);
		}).trigger('resize');
	});

	function deptCmmnGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : 'auto',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'lvl_dept_nm',
			sortorder : 'asc',
			colModel : [ {
				label : '부서명',
				name : 'lvl_dept_nm'
			}, {
				label : '부서코드',
				name : 'dept_cd',
				key : true
			}, {
				label : '상위부서코드',
				name : 'pre_dept_cd',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}

	function deptLimsGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			viewrecords : true,
			height : 'auto',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'lvl_dept_nm',
			sortorder : 'asc',
			colModel : [ {
				label : '부서명',
				name : 'lvl_dept_nm',
				editable : false
			}, {
				label : '부서코드',
				name : 'dept_cd',
				key : true,
				editable : false,
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:미사용'
				}
			} ],
			gridComplete : function() {
				$('#btn_Reset').show();
				$('#btn_Save').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease(grid);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#btn_Reset').hide();
				$('#btn_Save').show();

				fnEditRelease(grid);
				$('#' + grid).jqGrid('editRow', rowId);
			}
		});
	}

	//부서그룹 확인버튼 클릭 이벤트
	function btn_Reset_onclick() {
		if (!confirm("부서정보를 동기화하시겠습니까?")) {
			return false;
		}
		var json = fnAjaxAction('system/saveDeptLims.lims', $('#subForm').serialize());
		if (json == null) {
			alert('error');
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#deptLimsGrid').trigger('reloadGrid');
		}
	}

	//부서그룹 저장버튼 클릭 이벤트
	function btn_Save_onclick() {
		var grid = 'deptLimsGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/updateDeptLims.lims', {
			dept_cd : rowId
		}, fn_Success, null, null);
	}
</script>
<div class="sub_purple_01 w49p">
	<form id="mainForm" name="mainForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					공통부서
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_l">
			<table id="deptCmmnGrid"></table>
		</div>
	</form>
</div>

<div class="sub_purple_01 w49p">
	<form id="subForm" name="subForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					LIMS부서
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_save" id="btn_Reset" onclick="btn_Reset_onclick();">
						<button type="button">동기화</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r">
			<table id="deptLimsGrid"></table>
		</div>
	</form>
</div>
