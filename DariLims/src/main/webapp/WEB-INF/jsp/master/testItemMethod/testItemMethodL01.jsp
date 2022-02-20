
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목별 시험방법
	 * 파일명 		: testItemMethodL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 항목별 시험방법 목록 조회 화면
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
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />

<style>
</style>
<script type="text/javascript">
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "methodForm"); // 항목 대분류

		grid('master/selectTestItemAllList.lims', 'methodForm', 'methodGrid');
		$('#methodGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		itemMethodGrid('master/selectTestItemMethodList.lims', 'allItemMethodForm', 'allItemMethodGrid');
		
		itemMethodGrid('master/selectTestItemMethodList.lims', 'itemMethodForm', 'itemMethodGrid');

		$(window).bind('resize', function() {
			$("#methodGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#allItemMethodGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#itemMethodGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');

		fn_Enter_Search('methodForm', 'methodGrid');
		fn_Enter_Search('allItemMethodForm', 'allItemMethodGrid');
		fn_Enter_Search('itemMethodForm', 'itemMethodGrid');
		
		$('#allItemMethodGrid').hide();		
	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "methodForm"); // 항목 중분류
	}

	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '530',
			autowidth : true,
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
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
				width : '100'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '100'
			}, {
				label : '항목',
				name : 'test_item_nm',
				width : '150'
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				key : true,
				hidden : true,
				search : false
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '150'
			}, {
				label : '이명',
				name : 'ncknm',
				width : '150'
			}, {
				label : '약어',
				name : 'abrv',
				width : '50'
			}, {
				label : '사용여부',
				name : 'use_flag',
				width : '50'
			}, {
				label : '최종수정일',
				width : '100',
				name : 'last_updt_dtm',
				align : 'center'
			}],
			gridComplete : function() {
				$('#allItemMethodGrid').hide();
				$('#itemMethodGrid').hide();
				//fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {							
				$('#allItemMethodGrid').show();
				$('#itemMethodGrid').show();
				
				$("#allItemMethodForm").find("#test_item_cd").val(rowId);
				$("#itemMethodForm").find("#test_item_cd").val(rowId);
				
				$('#allItemMethodGrid').trigger('reloadGrid');
				$('#itemMethodGrid').trigger('reloadGrid');
			}
		});
	}


	function itemMethodGrid(url, form, grid) {
		var hidden = true;
		if (grid == 'itemMethodGrid') {
			hidden = false;
		}
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
			multiselect : true,
			colModel : [ {
				label : '기본',
				name : 'default_flag',
				formatter : 'checkbox',
				formatoptions : {
					disabled : false
				},
				width : '50',
				align : 'center',
				classes : "default_flag",
				editoptions : {
					value : 'Y:N'
				},
				hidden : hidden
			}, {
				label : '시험방법명',
				name : 'test_method_nm',
				width : 350
			}, {
				label : '인용규격',
				name : 'quot_std'
			}, {
				label : '장비 및 조건',
				name : 'condition'
			}, {
				label : '시험지침서',
				name : 'guide_nm'
			}, {

				label : 'test_method_no',
				name : 'test_method_no',
				key : true,
				search : false,
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (grid == 'itemMethodGrid') {
					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
						return 'stop';
					}
				}
			},
			onSelectRow : function(rowId, status, e) {
				
				if (grid == 'allItemMethodGrid') {
					var ids = $('#itemMethodGrid').jqGrid("getDataIDs");
					for ( var i in ids) {
						if (rowId == ids[i]) {
							alert('이미 존재합니다.');
							$('#' + grid).jqGrid('setSelection', rowId, false);
						}
					}
				}
			}
		});
		check_event(grid);
	}
	
	function check_event(grid) {
		$(".default_flag").change(function(e) {
			var tr = $(e.target).closest('tr');
			var checked = $(e.target).is(":checked");
			if (checked) {
				var ids = $('#' + grid).jqGrid("getDataIDs");
				for ( var i in ids) {
					if (ids[i] == tr[0].id)
						continue;
					var row = $('#' + grid).getRowData(ids[i]);
					for ( var column in row) {
						if (column == 'default_flag') {
							$('#' + grid).jqGrid('setCell', ids[i], column, "N");
						}
					}
				}
			}
		});
	}
	
	function btn_Move(m) {
		var left = 'allItemMethodGrid';
		var right = 'itemMethodGrid';
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
				check_event(right);
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		}
	}
	
	function btn_Select_Sub1_onclick() {
		$('#allItemMethodGrid').trigger('reloadGrid');
	}
	
	function btn_Save_Sub1_onclick() {
		var rowArr = $('#itemMethodGrid').jqGrid("getDataIDs");
		if (rowArr.length > 0) {
			var data = fnGetGridAllData('itemMethodGrid') + '&test_item_cd=' + $('#allItemMethodForm').find('#test_item_cd').val() + '&test_std_no=001';
			var json = fnAjaxAction('master/saveTestItemMethod.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('저장이 완료되었습니다.');
			}
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
	
	// 검사기준콤보박스리로드
	function comboReload(key) {		
		ajaxComboStdNo(key, '');
	}	
	
	// 조회 이벤트
	function btn_Select_onclick() {
		$('#methodGrid').setGridParam({page: 1});
		$('#methodGrid').trigger('reloadGrid');
		btn_Select_Sub1_onclick();
	}
</script>

<div class="sub_purple_01 w49p">
	<form id="methodForm" name="methodForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					
					항목별 시험방법
				 
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>		
			</tr>
		</table>

		<table  class="list_table" >
			<tr>
				<th>항목유형</th>
				<td colspan="3">
					<select name="testitm_lclas_cd" id="testitm_lclas_cd" class="w200px" onchange="fnListLclasChange(this)"></select>
					<select name="testitm_mlsfc_cd" id="testitm_mlsfc_cd" class="w200px"></select>
				</td>
			</tr>
			<tr>
				<th>항목명</th>
				<td colspan="3">
					<input name="test_item_nm" type="text" class="inputhan w200px" />
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px"/>전체</label> 
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용</label>
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" />미사용</label>
				</td>
				<th style='display:none;'>식약처기준 여부</th>
				<td style='display:none;'> 
					<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px"/>예</label>
					<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
				</td>
			</tr>
		</table>
		<input type="hidden" id="test_item_cd" name="test_item_cd">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type='hidden' id='pageNum' name='pageNum'/>
		<input type='hidden' id='pageSize' name='pageSize'/>
		<input type='hidden' id='sortTarget' name='sortTarget'/>
		<input type='hidden' id='sortValue' name='sortValue'/>
		<div id="view_grid_main">
			<table id="methodGrid"></table>
			<div id="methodGridPager"></div>
		</div>
	</form>
</div>

<div class="w5p"></div>

<div class="sub_blue_01 w45p" style="margin-top:0px;">
	<div class="sub_blue_01">
		<form id="allItemMethodForm" name="allItemMethodForm" onsubmit="return false;">
			<table  class="select_table" >
				<tr>
					<td width="100%" class="table_title">
						<span>■</span>
						전체 시험방법
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>시험방법</th>
					<td>
						<input name="test_method_nm" id="test_method_nm" type="text" class="inputhan w100px" />
					</td>
					<th>인용규격</th>
					<td>
						<input name="quot_std" id="quot_std" type="text" class="inputhan w100px" />
					</td>
					<th>장비 및 조건</th>
					<td>
						<input name="condition" id="condition" type="text" class="inputhan w100px" />
					</td>
				</tr>
			</table>
			<input type="hidden" id="pageType" name="pageType" value="all">
			<input type="hidden" id="test_item_cd" name="test_item_cd">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub1">
				<table id="allItemMethodGrid"></table>
			</div>
		</form>
	</div>
	
	<div style="clear:both; padding-top:25px; text-align:center;">
		<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnDown"></button>
		<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnUp"></button>
	</div>

	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td width="100%" class="table_title">
					<span>■</span>
					항목 시험방법
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub1_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
		<form id="itemMethodForm" name="itemMethodForm" onsubmit="return false;">
			<input type="hidden" id="test_item_cd" name="test_item_cd">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub2">
				<table id="itemMethodGrid"></table>
			</div>
		</form>
	</div>
</div>
