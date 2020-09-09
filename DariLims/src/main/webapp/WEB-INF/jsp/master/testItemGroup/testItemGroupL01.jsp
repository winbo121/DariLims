
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목 그룹 관리
	 * 파일명 		: testItemGroupL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html> 
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	var deptEdit;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		deptEdit = fnGridCombo('dept', 'NON');
		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "allItemGroupForm"); // 항목 대분류

		grid('master/selectItemGroupList.lims', 'groupForm', 'groupGrid');
		//$('#groupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		fn_Enter_Search('groupForm', 'groupGrid');

		allItemGroupGrid('master/selectTestItemAllList.lims', 'allItemGroupForm', 'allItemGroupGrid');
		//$('#allItemGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴	
		fn_Enter_Search('allItemGroupForm', 'allItemGroupGrid');		
		
		itemGroupGrid('master/selectTestItemInGroupList.lims', 'itemGroupForm', 'itemGroupGrid');
		//$('#itemGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		fn_Enter_Search('itemGroupForm', 'itemGroupGrid');

		$(window).bind('resize', function() {
			$("#groupGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#allItemGroupGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#itemGroupGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');

	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "allItemGroupForm"); // 항목 중분류
	}
	
	function grid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '부서',
				name : 'dept_cd',
				editable : true,
				edittype : 'select',
				editoptions : {
					value : deptEdit
				},
				formatter : 'select'
			}, {
				label : '항목그룹',
				name : 'test_item_group_nm',
				editable : true,
				width : '150'
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				edittype : 'select',
				editoptions : {
					value : 'Y:사용;N:사용안함'
				},
				formatter : 'select'
			}, {
				label : '비고',
				name : 'group_desc',
				editable : true
			}, {
				label : 'test_item_group_no',
				name : 'test_item_group_no',
				key : true,
				hidden : true
			} ],
			gridComplete : function() {
				fnSelectFirst('groupGrid');
				$('#btn_Save').hide();
				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			beforeSelectRow : function(rowId, e) {
				if (rowId && rowId != lastRowId) {
					if (lastRowId == 0) {
						$('#' + grid).jqGrid('delRowData', lastRowId);
					}
				}
				return true;
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_Save').hide();
					$('#btn_Delete').hide();
					if (rowId != 0) {
						$("#allItemGroupForm").find("#test_item_group_no").val(rowId);
						$("#itemGroupForm").find("#test_item_group_no").val(rowId);
						$('#allItemGroupGrid').trigger('reloadGrid');
						$('#itemGroupGrid').trigger('reloadGrid');
					}
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId, true);
				$('#btn_New').show();
				$('#btn_Save').show();
				$('#btn_Delete').show();
			}
		});
	}

	function allItemGroupGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fn_GridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			gridview : true,
			shrinkToFit : true,
			rowNum : 5000,
			rownumbers : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			multiselect : true,
			rowList:[50,100,200],
			prmNames : {
				id : 'KEY',
				page : 'pageNum',
				rows : 'pageSize',
				sort : 'sortTarget',
				order : 'sortValue'
			},
				jsonReader : {        
				root : 'rows',        
				page : 'pageNum',        
				rowNum : 'pageSize',        
				records : 'total',        
				total : 'totalPage',        
				id : 'row_num',     
				repeatitems : true        
			},
			colModel : [ {
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '200',
				hidden : true
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '200',
				hidden : true
			}, {
				label : '항목',
				name : 'test_item_nm',
				width : '250'
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				key : true,
				hidden : true,
				search : false
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '250'
			}, {
				label : '이명',
				name : 'ncknm',
				width : '250'
			}, {
				label : '약어',
				name : 'abrv',
				width : '100'
			}, {
				label : '사용여부',
				name : 'use_flag',
				width : '250'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var b = false;
				var now = $('#' + grid).getRowData(rowId);
				var test_item_cd = now.test_item_cd;
				var ids = $('#itemGroupGrid').jqGrid("getDataIDs");
				for ( var i in ids) {
					var right = $('#itemGroupGrid').getRowData(ids[i]);
					if (test_item_cd == right.test_item_cd) {
						b = true;
					}
				}
				ids = $('#' + grid).getGridParam('selarrrow');
				if (ids.length > 1) {
					for ( var r in ids) {
						if (ids[r] != rowId) {
							var row = $('#' + grid).getRowData(ids[r]);
							if (test_item_cd == row.test_item_cd) {
								b = true;
							}
						}
					}
				}
				if (b) {
					$.showAlert('이미 존재하는 항목입니다.');
					$('#' + grid).jqGrid('setSelection', rowId, false);
				}
			}
		});
	}

	function itemGroupGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_item_group_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '315',
			autowidth : true,
			//width : '200',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [ {
				label : 'test_item_cd',
				name : 'test_item_cd',
				search : false,				
				hidden : true
			}, {
				label : 'user_id',
				name : 'user_id',
				search : false,
				hidden : true
			}, {
				type : 'not',
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '200'
			}, {
				type : 'not',
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '200',
				hidden : true
			}, {
				type : 'not',
				label : '항목',
				name : 'test_item_nm',
				width : '250'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '250'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
		$('#' + grid).sortableRows();
	}
	
	
	
	// 조회 이벤트
	function btn_Select_onclick() {
		var rowId = $('#groupGrid').getGridParam('selrow');
		$('#groupGrid').jqGrid('restoreRow', rowId);
		$('#groupGrid').trigger('reloadGrid');
		$('#btn_New').show();
		$('#btn_Save').hide();
		$('#btn_Delete').hide();
		btn_Select_Sub1_onclick();
	}
	
	
	function btn_AddLine_onclick() {
		var rowId = $('#groupGrid').getGridParam('selrow');
		$('#groupGrid').jqGrid('restoreRow', rowId);
		$('#groupGrid').jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		$('#btn_New').hide();
		$('#btn_Save').show();
		$('#btn_Delete').hide();
	}
	
	
	function btn_Save_onclick() {
		var rowId = $('#groupGrid').getGridParam('selrow');
		var url;
		if (rowId == '0') {
			url = 'master/insertTestItemGroup.lims';
		} else {
			url = 'master/updateTestItemGroup.lims';
		}
		$('#groupGrid').jqGrid('saveRow', rowId, successfunc, url, null, fn_Success);
	}
	
	
	function btn_Delete_onclick() {
		var rowId = $('#groupGrid').getGridParam('selrow');
		if (!confirm('정말 삭제하시겠습니까?')) {
			return false;
		}
		/* $.showConfirm('정말 삭제하시겠습니까?', {
			noCallback : function() {
				return false;
			}
		}); */
		$('#groupGrid').jqGrid('saveRow', rowId, successfunc, 'master/deleteTestItemGroup.lims', null, fn_Success);
	}
	
	
	function fn_Success(json) {
		if (json == null) {
			alert('error');
		} else {
			fnEditRelease('groupGrid');
			$('#groupGrid').trigger('reloadGrid');
			fnSelectFirst('groupGrid');
			$('#btn_Save').hide();
			$('#btn_Delete').hide();
		}
	}
	
	
	
	
	function btn_Move(m) {
		var left = 'allItemGroupGrid';
		var right = 'itemGroupGrid';
		switch (m) {
		case 1:
			var rowArr = $('#' + left).getGridParam('selarrrow');
			var rightRowArr = $('#' + right).jqGrid("getDataIDs");
			var test_item_cd;
			if (rowArr.length > 0) {
				for ( var i in rowArr) {
					var row = $('#' + left).getRowData(rowArr[i]);
					if (test_item_cd != row.test_item_cd) {
						test_item_cd = row.test_item_cd;
						var bool = true;
						for ( var z in rightRowArr) {
							var rightRow = $('#' + right).getRowData(rightRowArr[z]);
							if (test_item_cd == rightRow.test_item_cd) {
								bool = false;
							}
						}

						if (bool) {
							var id = fnNextRowId(right);
							$('#' + right).jqGrid('addRowData', id, row, 'last');
						}
					}
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
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		}
	}
	
	// 서브 조회 이벤트
	function btn_Select_Sub1_onclick() {
		$('#itemGroupGrid').trigger('reloadGrid');
		$('#allItemGroupGrid').trigger('reloadGrid');
	}
	
	
	function btn_Save_Sub1_onclick() {
		var rowArr = $('#itemGroupGrid').jqGrid("getDataIDs");
		if (rowArr.length > 0) {
			var data = fnGetGridAllData('itemGroupGrid') + '&test_item_group_no=' + $('#allItemGroupForm').find('#test_item_group_no').val();
			var json = fnAjaxAction('master/saveTestItemInGroup.lims', data);
			if (json == null) {
				$.showAlert('저장 실패되었습니다.');
			} else {
				$.showAlert('저장이 완료되었습니다.');
				$('#allItemGroupGrid').trigger('reloadGrid');
				$('#itemGroupGrid').trigger('reloadGrid');
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	

	function btn_Copy_onclick() {
		if (!confirm('그룹을 복사하시겠습니까?')) {
			return false;
		}
		
		var rowId = $('#groupGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var json = fnAjaxAction('master/copyTestItemGroup.lims', 'test_item_group_no=' + rowId);
			if (json == null) {
				$.showAlert('복사 실패하였습니다.');
			} else {
				$('#groupGrid').trigger('reloadGrid');
				$.showAlert('복사 완료하였습니다.');
			}
		}
	}
</script>

<div class="sub_purple_01 w100p">
	<form id="groupForm" name="groupForm" onsubmit="return false;">
		<table border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					항목그룹
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Copy" onclick="btn_Copy_onclick();">
						<button type="button">그룹복사</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
						<button type="button">행추가</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">삭제</button>
					</span>
				</td>
			</tr>
		</table>
		<table border="0" class="list_table">
			<tr>
				<th>항목 그룹</th>
				<td>
					<input name="test_item_group_nm" id="test_item_group_nm" type="text" class="inputhan w200px" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="groupGrid"></table>
		</div>
	</form>
</div>

<div class="sub_blue_01 w45p">
	<form id="allItemGroupForm" name="allItemGroupForm" onsubmit="return false;">
		<table border="0" class="select_table">
			<tr>
				<td class="table_title">
					<span>■</span>
					전체 항목
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table border="0" class="list_table">
			<tr>
				<th>항목유형</th>
				<td colspan="3">
					<select name="testitm_lclas_cd" id="testitm_lclas_cd" class="w200px" onchange="fnListLclasChange(this)"></select>
					<select name="testitm_mlsfc_cd" id="testitm_mlsfc_cd" class="w200px"></select>
				</td>
			</tr>
			<tr>
				<th>항목명</th>
				<td>
					<input name="test_item_nm" type="text" class="inputhan w200px" />
				</td>
				<th style='display:none;'>식약처기준 여부</th>
				<td style='display:none;'> 
					<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px"/>예</label>
					<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
				</td>
			</tr>
		</table>
		<input type='hidden' id='use_flag' name='use_flag' value='Y'/>
		<input type="hidden" id="test_item_group_no" name="test_item_group_no">
		<input type='hidden' id='pageNum' name='pageNum'/>
		<input type='hidden' id='pageSize' name='pageSize'/>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type='hidden' id='sortTarget' name='sortTarget'/>
		<input type='hidden' id='sortValue' name='sortValue'/>
		<div id="view_grid_sub_l">
			<table id="allItemGroupGrid"></table>
			<div id="allItemGroupGridPager"></div>
		</div>
	</form>
</div>
<div class="w10p">
	<span>
		<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnRight"></button>
	</span>
	<br>
	<br>
	<span>
		<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnLeft"></button>
	</span>
</div>
<div class="sub_blue_01 w45p">
	<table width="100%" border="0" class="select_table">
		<tr>
			<td class="table_title">
				<span>■</span>
				그룹 항목
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub1_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
	<form id="itemGroupForm" name="itemGroupForm" onsubmit="return false;">
		<input type="hidden" id="test_item_group_no" name="test_item_group_no">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r">
			<table id="itemGroupGrid"></table>
		</div>
	</form>
</div>
