
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용자관리(연동)
	 * 파일명 		: userL01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.01.24
	 * 설  명		: 사용자관리 리스트 조회 화면
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
<!DOCTYPE html>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		//ajaxCombo("use_flag", "C53", "ALL", "");

		ajaxComboForm("dept_cd", "", "ALL", null, 'mainForm'); // 부서
		ajaxComboForm("dept_cd", "", "ALL", null, 'subForm'); // 부서

		userCmmnGrid('system/selectUserCmmnList.lims', 'mainForm', 'userCmmnGrid');
		$('#userCmmnGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		userLimsGrid('system/selectUserLimsList.lims', 'subForm', 'userLimsGrid');

		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('mainForm', 'userCmmnGrid');
		fn_Enter_Search('subForm', 'userLimsGrid');

		$(window).bind('resize', function() {
			$("#userCmmnGrid").setGridWidth($('#view_grid_sub_l').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#userLimsGrid").setGridWidth($('#view_grid_sub_r').width(), true);
		}).trigger('resize');

	});

	function userCmmnGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'user_nm',
			sortorder : 'asc',
			colModel : [ {
				label : '부서명',
				name : 'dept_nm',
				editable : true
			}, {
				label : '사용자명',
				name : 'user_nm',
				editable : true
			}, {
				label : '사용자ID',
				name : 'user_id',
				key : true,
				editable : true,
			}, {
				label : '직급',
				name : 'rank_nm',
				editable : true
			}, {
				label : '전화번호',
				name : 'tel_num',
				editable : true
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

	function userLimsGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			viewrecords : true,
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'user_nm',
			sortorder : 'asc',
			colModel : [ {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				frozen : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
			}, {
				type : 'not',
				label : '부서명',
				name : 'dept_nm'
			}, {
				type : 'not',
				label : '사용자명',
				name : 'user_nm',
				width : '80'
			}, {
				label : '사용자ID',
				name : 'user_id',
				width : '100',
				key : true
			}, {
				type : 'not',
				label : '직급',
				name : 'rank_nm',
				width : '80'
			}, {
				type : 'not',
				label : '전화번호',
				name : 'office_tel_num',
				width : '120'
			}, {
				label : '사용여부',
				width : '100',
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

			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();

				$('#' + grid).setCell(rowId, 'icon', gridU);
			}
		});
	}

	//조회버튼 클릭 이벤트 - 공통사용자 조회
	function fn_Search_userCmmn() {
		$('#userCmmnGrid').trigger('reloadGrid');
	}

	//조회버튼 클릭 이벤트 - LIMS사용자 조회
	function fn_Search_userLims() {
		$('#userLimsGrid').trigger('reloadGrid');
	}

	//사용자그룹 저장버튼 클릭 이벤트
	function btn_Sync_onclick() {
		if (!confirm("사용자정보를 동기화하시겠습니까?")) {
			return false;
		}
		var json = fnAjaxAction('system/saveUserLims.lims', $('#subForm').serialize());
		if (json == null) {
			alert('error');
		} else {
			alert('저장이 완료되었습니다.');
			$('#userLimsGrid').trigger('reloadGrid');
		}
	}

	//신규사용자 추가 팝업
	function btn_Add_onclick() {
		//var data = 'pageType=insert';
		//fnViewPage('system/selectUserLimsDetail.lims', 'userLimsDetail', data);
		var url = 'system/selectUserLimsDetail.lims';
		var popOptions = "dialogWidth: 300px; dialogHeight: 400px; center: yes; resizable: yes; status: no; scroll: no;";
		var popup = window.open(url, 'userLimsDetail', popOptions);
		popup.focus();
		return popup;
	}

	function btn_Save_onclick(grid) {
		$.showConfirm("사용자정보를 저장하시겠습니까?", {
			yesCallback : function() {
				fnEditRelease(grid);
				var json = fnAjaxAction('system/updateUserFlag.lims', fnGetGridAllData(grid));
				if (json == null) {
					alert('error');
				} else {
					$('#userLimsGrid').trigger('reloadGrid');
					$.showAlert('저장 완료되었습니다.');
				}
			}
		});
	}
</script>


<div class="sub_purple_01 w49p">
	<form id="mainForm" name="mainForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td class="table_title">
					<span>■</span>
					공통사용자
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_userCmmn();">
						<button type="button">조회</button>
					</span>

				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table">
			<tr>
				<th>부서명</th>
				<td>
					<select id="dept_cd" name="dept_cd"></select>
					<!-- 					<input id="dept_nm" name="dept_nm" type="text" class="inputhan" /> -->
				</td>
				<th>사용자명</th>
				<td>
					<input name="user_nm" type="text" class="inputhan" />
				</td>
				<th>사용자ID</th>
				<td>
					<input name="user_id" type="text" class="inputhan" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_l">
			<table id="userCmmnGrid"></table>
		</div>
	</form>
</div>

<div class="sub_purple_01 w49p">
	<form id="subForm" name="subForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td class="table_title">
					<span>■</span>
					LIMS사용자
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_userLims();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick('userLimsGrid');">
						<button type="button">저장</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Sync" onclick="btn_Sync_onclick();">
						<button type="button">동기화</button>
					</span>
					<!--  
				<span class="button white mlargep" id="btn_Add" onclick="btn_Add_onclick();">
					<button type="button">신규</button>
				</span>
				-->
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table">
			<tr>
				<th>부서명</th>
				<td>
					<select id="dept_cd" name="dept_cd"></select>
					<!-- 					<input id="dept_nm" name="dept_nm" type="text" class="inputhan" /> -->
				</td>
				<th>사용자명</th>
				<td>
					<input id="user_nm" name="user_nm" type="text" class="inputhan" />
				</td>
				<th>사용자ID</th>
				<td>
					<input name="user_id" type="text" class="inputhan" />
				</td>
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
		<div id="view_grid_sub_r">
			<table id="userLimsGrid"></table>
		</div>
	</form>
</div>
