
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부서별단위업무
	 * 파일명 		: deptUnitWorkL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 부서별단위업무 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.21    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 부서 리스트
		ajaxComboForm("dept_cd", "", "ALL", null, 'deptForm'); // 관리부서
		deptGrid('master/deptUnitWork.lims', 'deptForm', 'deptGrid');
		$('#deptGrid').clearGridData(); // 최초 조회시 데이터 안나옴


		// 단위업무
		deptUnitWorkGrid('master/allDeptUnitWork.lims', 'allDeptUnitWorkForm', 'allDeptUnitWorkGrid');
		$('#allDeptUnitWorkGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 담당단위업무
		deptUnitWorkGrid('master/selectDeptUnitWork.lims', 'deptUnitWorkForm', 'deptUnitWorkGrid');
		$('#deptUnitWorkGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#deptGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#allDeptUnitWorkGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#deptUnitWorkGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
	});

	// 상단 그리드
	function deptGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : '부서명',
				width : '200',
				editable : true,
				name : 'dept_nm'
			}, {
				label : '부서코드',
				width : '60',
				name : 'dept_cd',
				align: 'center',
				editable : true,
				key : true
			}, {
				label : '상위부서명',
				width : '200',
				editable : true,
				name : 'pre_dept_nm'
			}, {
				label : '상위부서코드',
				width : '60',
				name : 'pre_dept_cd',
				align: 'center',
				editable : true
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#allDeptUnitWorkForm").find("#dept_cd").val(rowId);
				$("#deptUnitWorkForm").find("#dept_cd").val(rowId);
				$('#allDeptUnitWorkGrid').trigger('reloadGrid');
				$('#deptUnitWorkGrid').trigger('reloadGrid');
			}
		});
	}

	function btn_Select_onclick() {
		$("#allDeptUnitWorkForm").find("#key").val($("#form #dept_cd").val());
		$("#deptUnitWorkForm").find("#key").val($("#form #dept_cd").val());
		$('#allDeptUnitWorkGrid').trigger('reloadGrid');
		$('#deptUnitWorkGrid').trigger('reloadGrid');
		$('#deptGrid').trigger('reloadGrid');
	}

	// 아래 오른쪽(담당 단위업무)
	function deptUnitWorkGrid(url, form, grid) {
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '248',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			multiselect : true,
			colModel : [ {
				label : '대분류',
				width : '30',
				name : 'h_unit_work',
				align : 'center'
			}, {
				label : '중분류',
				width : '70',
				name : 'm_unit_work'
			}, {
				label : '단위업무명',
				width : '110',
				name : 'unit_work_nm'
			}, {
				label : '단위업무설명',
				width : '140',
				name : 'unit_work_desc'
			}, {
				label : '단위업무코드',
				name : 'unit_work_cd',
				key : true,
				hidden : true
			}
			// 			, {
			// 				label : '같은지 비교',
			// 				name : 'use_flag',				
			// 				formatter : 'checkbox',
			// 				hidden : true
			// 			}
			],
			gridComplete : function() {
				//alert(grid);
				if (grid == 'allDeptUnitWorkGrid') {
					fnCheckAction(grid);
				}
				allselect = false;
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (grid == 'deptUnitWorkGrid' || grid == 'allDeptUnitWorkGrid') {
					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
						return 'stop';
					}
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (grid == 'allDeptUnitWorkGrid') {
					var left = $('#' + grid).getRowData(rowId);
					var ic = left.unit_work_cd;
					var ids = $('#deptUnitWorkGrid').jqGrid("getDataIDs");
					for (var i in ids) {
						var right = $('#deptUnitWorkGrid').getRowData(ids[i]);
						if (ic == right.unit_work_cd) {
							$.showAlert('이미 존재하는 항목입니다.');
							$('#' + grid).jqGrid('setSelection', rowId, false);
						}
					}
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId, true);
				$('#btn_New').show();
				$('#btn_Save').show();
				$('#btn_Delete').show();
			},
			onSelectAll : function(selar, status) {
				//좌 allDeptUnitWorkGrid
				//우 deptUnitWorkGrid
				var leftGrid = '#allDeptUnitWorkGrid';
				var rightGrid = '#deptUnitWorkGrid';

				if (!allselect) {
					var i = 0;
					var sel_ids_left = $(leftGrid).jqGrid("getDataIDs");
					for ( var row in sel_ids_left) {
						var left = $(leftGrid).getRowData(sel_ids_left[row]).unit_work_cd;
						var sel_ids = $(rightGrid).jqGrid("getDataIDs");

						for ( var j in sel_ids) {
							var right = $(rightGrid).getRowData(sel_ids[j]).unit_work_cd;
							if (right == left) {
								$(leftGrid).jqGrid('setSelection', sel_ids_left[row], false);
								i++;
							}
						}
					}
					if (i > 0) {
						$.showAlert("이미 존재하는 항목들이 있습니다.");
					}
				} else {
					$("#" + grid).jqGrid('resetSelection');
				}
				allselect = !allselect;
			}
		});
		//$('#' + grid).jqGrid('filterToolbar', {});
	}

	// 리스트 좌우 이동 이벤트 (btn_Move(1), btn_Move(3))	
	function btn_Move(m) {
		var left = 'allDeptUnitWorkGrid'; // 모든 단위업무
		var right = 'deptUnitWorkGrid'; // 부서별 단위업무
		switch (m) {
		case 1:
			var rowArr = $('#' + left).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for ( var i in rowArr) {
					var row = $('#' + left).getRowData(rowArr[i]);
					$('#' + right).jqGrid('addRowData', rowArr[i], row, 'last');
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + left).jqGrid('setSelection', rowArr[i], false);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				$.showAlert("선택된 행이 없습니다.");
			}
			break;
		}
	}

	// 저장 버튼 클릭 이벤트
	function btn_Save_Sub1_onclick() {
		//var grid = 'grid';
		var rowArr = $('#deptUnitWorkGrid').jqGrid("getDataIDs");
		var rowId = $("#deptUnitWorkForm #dept_cd").val();
		//var rowId = $('#' + grid).getGridParam('selrow');
		if (rowArr.length > 0) {
			var data = fnGetGridAllData('deptUnitWorkGrid') + '&dept_cd=' + rowId;
			var json = fnAjaxAction('master/saveDeptUnitWork.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				btn_Select_onclick();
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
<form id="deptForm" name="deptForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<!-- 상단 타이틀 및 버튼 -->
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
					과별 단위업무
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>

		<!-- 상단 조회 폼 -->
		<table  class="list_table" >
			<tr>
				<th>부서명</th>
				<td>
					<select name="dept_cd" id="dept_cd" style="width: 115px;" onchange="btn_Select_onclick();" class="auth_select"></select>
					<!-- 					<input name="dept_nm" type="text" /> -->
					<!-- 				</td> -->
					<!-- 				<th>부서코드</th> -->
					<!-- 				<td> -->
					<!-- 					<input name="dept_cd" type="text" /> -->
					<!-- 				</td> -->
					<!-- 				<th>상위부서명</th> -->
					<!-- 				<td> -->
					<!-- 					<input name="pre_dept_nm" type="text" /> -->
					<!-- 				</td> -->
					<!-- 				<th>상위부서코드</th> -->
					<!-- 				<td> -->
					<!-- 					<input name="pre_dept_cd" type="text" /> -->
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<!-- 상단 Grid List -->
		<div id="view_grid_main">
			<table id="deptGrid"></table>
		</div>
</form>

<!-- 하단 좌측 그리드 -->
<div class="sub_blue_01 w45p">
	<table  class="select_table" >
		<tr>
			<td width="100%" class="table_title">
				<span>■</span>
				단위업무
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<form id="allDeptUnitWorkForm" name="allDeptUnitWorkForm" onsubmit="return false;">
					<input type="hidden" id="mode" name="mode" value="9">
					<input type="hidden" id="dept_cd" name="dept_cd">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub1">
						<table id="allDeptUnitWorkGrid"></table>
					</div>
				</form>
			</td>
		</tr>
	</table>
</div>

<!-- 하단 좌우 이동 버튼 -->
<div class="w10p">
	<span>
		<button type="button" onclick="btn_Move(1);" id="butten_right" class="btnRight"></button>
	</span>
	<br>
	<br>
	<span>
		<button type="button" onclick="btn_Move(3);" id="butten_left" class="btnLeft"></button>
	</span>
</div>

<!-- 하단 우측 그리드 -->
<div class="sub_blue_01 w45p">
	<table  class="select_table" >
		<tr>
			<td width="100%" class="table_title">
				<span>■</span>
				담당 단위업무
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_Sub1_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<form id="deptUnitWorkForm" name="deptUnitWorkForm" onsubmit="return false;">
					<input type="hidden" id="mode" name="mode" value="0">
					<input type="hidden" id="dept_cd" name="dept_cd">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub2">
						<table id="deptUnitWorkGrid"></table>
					</div>
				</form>
			</td>
		</tr>
	</table>
</div>
