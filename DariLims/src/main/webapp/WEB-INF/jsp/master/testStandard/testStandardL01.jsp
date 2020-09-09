<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.not-editable-cell {
	background-color: gray;
}

/* 한글우선입력 */
.imeon input {
	ime-mode: active;
}
</style>
<script type="text/javascript">
var fnGridInit = false;
var result_type;
var base_cd_sel;
var mxmm_val_dvs_cd;
var mimm_val_dvs_cd;
var choic_fit;
var choic_impropt;
var unit_cd;
var oxide_cd;
$(function() {
	/* 세부권한검사 */
	fn_auth_check();

	ajaxComboForm("protocol", "", "NON", "NON", "insPrdForm");
	ajaxCombo('result_type', 'C31', 'ALL', '');
	ajaxCombo('base_cd', 'C84', 'ALL', '');
	ajaxCombo('unit_cd', 'C08', 'ALL', '');
	
	result_type = fnGridCommonCombo('C31', null);
	base_cd_sel = fnGridCommonCombo('C84', null);
	mxmm_val_dvs_cd = fnGridCommonCombo('C36', null);
	mimm_val_dvs_cd = fnGridCommonCombo('C35', null);
	choic_fit = fnGridCommonCombo('C34', null);
	choic_impropt = fnGridCommonCombo('C34', null);
	unit_cd = fnGridCommonCombo('C08', null);
	oxide_cd = fnGridCommonCombo('oxide_cd', null);
	
	prdGrid('master/selectStandardList.lims', 'allPrdForm', 'allPrdGrid');
	itemGrid('master/selectStandardRItemList.lims', 'testPrdStdRevGridForm', 'testPrdStdRevGrid');

	//그리드 사이즈 
	$(window).bind('resize', function() {
		$("#allPrdGrid").setGridWidth($('#sub_purple_01').width(), false);
	}).trigger('resize');
	$(window).bind('resize', function() {
		$("#testPrdStdRevGrid").setGridWidth($('#sub_blue_01').width(), false);
	}).trigger('resize');

	//엔터이벤트
	fn_Enter_Search('allPrdForm', 'allPrdGrid');
	$('#testPrdStdRevGrid').clearGridData(); // 최초 조회시 데이터 안나옴
	
	//fn_visible_column('0');
});


// 품목 그리드
function prdGrid(url, form, grid) {	
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fn_GridData(url, form, grid);
		},
		height : '500',
		rownumbers : true,
		autowidth : false,
		gridview : false,
		shrinkToFit : true,
		viewrecords : true,
		scroll : true,
		rowNum : -1,
		colModel : [{
			label : '스탠다드코드',
			name : 'sm_code',
			key : true,
			hidden : true
		}, {
			label : '스탠다드한글명',
			name : 'sm_name',
			width : '200'
		}, {
			label : '스탠다드영문명',
			name : 'sm_name_e',
			width : '150'
		}, {
			label : '사용여부',
			name : 'use_flag',
			edittype : "select",
			width : '75',
			editoptions : {
				value : {'Y':'사용','N':'미사용'}
			},
			formatter : 'select',
			align : 'center'
		}, {
			label : 'prdlst_cd',
			name : 'prdlst_cd',
			hidden : true
		} ],
		gridComplete : function(data) {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
		},			
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			$("#testPrdStdRevGridForm").find("#sm_name").val(row.sm_name);
			$("#testPrdStdRevGridForm").find("#sm_code").val(row.sm_code);
			$("#testPrdStdRevGridForm").find("#prdlst_cd").val(row.prdlst_cd);
			$("#insPrdForm").find("#sm_name").val(row.sm_name);
			$("#insPrdForm").find("#sm_name_e").val(row.sm_name_e);
			$("#insPrdForm").find("#sm_code").val(row.sm_code);
			$("#insPrdForm").find("#protocol").val(row.prdlst_cd);
			
			ajaxComboForm("protocol", "", $('#insPrdForm').find("#protocol").val(), null, 'insPrdForm');
			if(row.use_flag == "Y"){
				$("#insPrdForm").find('input:radio[name="use_flag"][value="Y"]').prop('checked', true);
			}else{
				$("#insPrdForm").find('input:radio[name="use_flag"][value="N"]').prop('checked', true);
			}
			btn_Search_onclick();
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
		}
	});
}

function itemGrid(url, form, grid) {
	var lastRowId = 0;
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridData(url, form, grid);
		},
		height : '540',
		autowidth : false,
		mtype : "POST",
		gridview : true,
		shrinkToFit : false,
		rowNum : -1,
		rownumbers : true,
		colModel : [ {
			type : 'not',
			label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
			name : 'chk',
			width : '40',
			sortable : false,
			align : 'center',
			formatter : "checkbox",
			formatoptions : {
				disabled : false
			}
		}, {
			type : 'not',
			label : ' ',
			name : 'icon',
			width : '20',
			align : 'center'
		}, {
			label : '스탠다드명',
			name : 'sm_name',
			hidden : true
		}, {
			label : '프로토콜명',
			name : 'prdlst_nm',
			width : '100'
		}, {
			label : '항목코드',
			name : 'testitm_cd',
			width : '70'
		}, {
			label : '대분류',
			name : 'testitm_lclas_nm',
			width : '90'
		}, {
			label : '중분류',
			name : 'testitm_mlsfc_nm',
			width : '90'
		}, {
			label : '항목명',
			name : 'testitm_nm',
			width : '100'
		}, {
			label : '항목 영문명',
			name : 'eng_nm',
			width : '120'
		},{
			label : '정렬순서',
			name : 'item_order',
			width : '70',
			editable : true
		}, {
			label : '단위',
			classes : 'unit',
			name : 'unit_cd',
			sortable : false,
			width : '100',
			editable : true,
			edittype : "select",
			editoptions : {
				value : unit_cd
			},
			formatter : 'select'
		}, {
			label : 'test_method_no',
			name : 'test_method_no',
			classes : 'test_method_no',
			hidden : true
		}, {
			type : 'not',
			label : '시험방법',
			name : 'test_method_nm',
			classes : 'test_method_nm'
		}, {
			type : 'not',
			label : ' ',
			name : 'test_method_pop',
			sortable : false,
			width : '20',
			align : 'center',
			formatter : imageFormat
		}, {
			type : 'not',
			label : ' ',
			name : 'test_method_del',
			sortable : false,
			width : '20',
			align : 'center',
			formatter : deleteImageFormat
		}, {
			label : '산화물측정방법',
			name : 'oxide_cd',
			editable : true,
			edittype : "select",
			width : '300',
			hidden : true,
			editoptions : {
				value : oxide_cd
			},
			formatter : 'select'
		}, {
			label : '계산식 번호',
			name : 'formula_no',
			classes : 'formula_no',
			sortable : false,
			hidden : true
		}, {
			type : 'not',
			label : '계산식',
			name : 'formula_nm',
			classes : 'formula_nm',
			sortable : false,
			width : '120'
		}, {
			type : 'not',
			label : ' ',
			name : 'formula_pop',
			sortable : false,
			width : '20',
			align : 'center',
			formatter : imageFormat
		}, {
			type : 'not',
			label : ' ',
			name : 'formula_del',
			sortable : false,
			width : '20',
			align : 'center',
			formatter : deleteImageFormat
		}, {
			label : 'BASE',
			name : 'base_cd',
			width : '50',
			editable : true,
			formatter : 'select',
			edittype : "select",
			editoptions : {
				value : base_cd_sel
			}
		}, {
			label : '결과값형태<span class="indispensableGrid"></span>',
			name : 'jdgmnt_fom_cd',
			editable : true,
			edittype : "select",
			width : '80',
			align : 'center',
			formatter : 'select',				
			editoptions : {
				value : result_type,
				dataEvents : [ {
					type : 'change',
					fn : function(e) {
						editable(grid,e);
					}
				} ]
			}
		}, {
			label : '기준값<span class="indispensableGrid"></span>',
			name : 'spec_val',
			classes : 'imeon'
		}, {
			label : '표기자리수',
			name : 'vald_manli',
			width : '70',
			align : 'right'
		}, {
			label : '기준하한값',
			name : 'mimm_val',
			width : '70',
			align : 'right'
		}, {
			label : '하한값구분',
			name : 'mimm_val_dvs_cd',
			width : '70',
			align : 'center',
			formatter : 'select',
			edittype : "select",
			editoptions : {
				value : mimm_val_dvs_cd
			}
		}, {
			label : '기준상한값',
			name : 'mxmm_val',
			width : '70',
			align : 'right'
		}, {
			label : '상한값구분',
			name : 'mxmm_val_dvs_cd',
			width : '70',
			align : 'center',
			formatter : 'select',
			edittype : "select",
			editoptions : {
				value : mxmm_val_dvs_cd
			}
		}, {
			label : '기준적합값',
			name : 'choic_fit', 
			width : '100',
			edittype : "select",
			formatter : 'select',
			editoptions : {
				value : choic_fit
			}
		}, {
			label : '기준부적합값',
			name : 'choic_impropt',
			width : '100',
			edittype : "select",
			formatter : 'select',
			editoptions : {
				value : choic_impropt
			}
		}, {
			label : '정량하한값',
			name : 'loq_lval',
			width : '100'
		}, {
			label : '정량하한표기',
			name : 'loq_lval_mark',
			width : '100'
		}, {
			label : '정량상한값',
			name : 'loq_hval',
			width : '100'
		}, {
			label : '정량상한표기',
			name : 'loq_hval_mark',
			width : '100'
		}, {
			label : '성적서 표시 여부',
			name : 'report_flag',
			editable : true,
			width : '100',
			align : 'center',
			edittype : "select",
			editoptions : {
				value : 'Y:표시함;N:표시안함'
			},
			formatter : 'select'
		}, {
			label : '시험항목코드',
			name : 'test_item_cd',
			hidden : true,
			editable : true
		}, {
			label : 'indv_spec_seq',
			name : 'indv_spec_seq',
			hidden : true
		}, {
			label : 'kfda_yn',
			name : 'kfda_yn',
			hidden : true
		}, {
			label : 'del_st_spec',
			name : 'del_st_spec',
			hidden : true
		}, {
			label : 'crud',
			name : 'crud',
			hidden : true
		}, {
			label : 'standard_spec_seq',
			name : 'standard_spec_seq',
			hidden : true
		}, {
			label : 'sm_code',
			name : 'sm_code',
			hidden : true
		} ],
		emptyrecords : '데이터가 존재하지 않습니다.',
		gridComplete : function() {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
				return 'stop';
			}
		},
		beforeSelectRow : function(rowId, e) {
			if (rowId && rowId != lastRowId) {
				if (!valiCheck(lastRowId))
					return 'stop';
			}
			return true;
		},
		onCellSelect : function(rowId, iCol, cellcontent, e) {
			var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
			var col = colArr[iCol].name;
			if (col == 'formula_pop') {
				fnpop_formulaPop(grid, "900", "500", rowId, "", "M", null);
				testPrdStdRevGridEditCell(grid, rowId);
			}
			else if (col == 'formula_del') {
				$('#' + grid).jqGrid('setCell', rowId, 'formula_no', null);
				$('#' + grid).jqGrid('setCell', rowId, 'formula_nm', null);
				testPrdStdRevGridEditCell(grid, rowId);
			}
			else if (col == 'test_method_pop') {
				fnpop_testMethodPop(grid, '900', '500', rowId);
				
			} else if (col == 'test_method_del') {
				$('#' + grid).jqGrid('setCell', rowId, 'test_method_nm', null);
				$('#' + grid).jqGrid('setCell', rowId, 'test_method_no', null);
				testPrdStdRevGridEdit(grid, rowId)
			}
		},
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			$("#fnprtItemGridForm").find("#sm_code").val(row.sm_code);
			$("#fnprtItemGridForm").find("#sm_name").val(row.sm_name);
			$("#fnprtItemGridForm").find("#standard_spec_seq").val(row.standard_spec_seq);
			
			if (rowId && rowId != lastRowId) {
				fnEditRelease(grid);
				lastRowId = rowId;
			}
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
			fnEditRelease(grid);
			testPrdStdRevGridEdit(grid, rowId);
			var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
			$('#' + rowId + '_' + colArr[iCol].name).focus();
		},
	});

	$('#' + grid).jqGrid('setGroupHeaders', {
		useColSpanStyle : true,
		groupHeaders : [ {
			startColumnName : 'item_order',
			numberOfColumns : 7,
			titleText : '프로토콜'
		}, {
			startColumnName : 'vald_manli',
			numberOfColumns : 5,
			titleText : '수치형기준'
		}, {
			startColumnName : 'choic_fit',
			numberOfColumns : 2,
			titleText : '선택형기준'
		} ]
	});
	
	$('#' + grid).jqGrid('setFrozenColumns');
}

//에디트모드
function testPrdStdRevGridEdit(grid, rowId) {
	var row = $('#' + grid).getRowData(rowId);
	if (row.crud != 'n') {
		$('#' + grid).setCell(rowId, 'icon', gridU);
		$('#' + grid).setCell(rowId, 'crud', 'u');
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
	}
	editable(grid,'');
}

//업데이트 아이콘 생성
function testPrdStdRevGridEditCell(grid, rowId) {
	var row = $('#' + grid).getRowData(rowId);
	if (row.crud != 'n') {
		$('#' + grid).setCell(rowId, 'icon', gridU);
		$('#' + grid).setCell(rowId, 'crud', 'u');
	}
}

// 셀 수정 여부
function editable(grid, e) {
	var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
	var arr = new Array();
	arr.push('base_cd');
	arr.push('jdgmnt_fom_cd');
	arr.push('unit_cd');
	arr.push('oxide_cd');
	arr.push('item_order');	
	arr.push('report_flag');	
	// 결과값형태
	var row = $("#" + grid).jqGrid('getRowData', rowId);
	var row_jdgmnt_fom_cd = '';
	if (e != '') {
		row_jdgmnt_fom_cd = $(e.target).val();
		fnEditRelease(grid);
	} else
		row_jdgmnt_fom_cd = row.jdgmnt_fom_cd;

	switch (row_jdgmnt_fom_cd) {
	// 선택형
	case 'C31001':
		arr.push('spec_val');
		arr.push('choic_fit');
		arr.push('choic_impropt');
		break;
	// 수치형
	case 'C31002':
		arr.push('spec_val');
		arr.push('vald_manli');
		arr.push('mxmm_val');
		arr.push('mxmm_val_dvs_cd');
		arr.push('mimm_val');
		arr.push('mimm_val_dvs_cd');
		arr.push('loq_lval');
		arr.push('loq_hval');
		arr.push('loq_lval_mark');
		arr.push('loq_hval_mark');
		break;
	// 서술형
	case 'C31003':
		arr.push('spec_val');
		arr.push('vald_manli');
		break;
	// 결과값없음
	case 'C31004':
		break;
	}
	for ( var column in row) {
		if ($.inArray(column, arr) !== -1) {
			$("#" + grid).jqGrid('setColProp', column, {
				editable : true
			});
		} else {
			$("#" + grid).jqGrid('setColProp', column, {
				editable : false
			});
		}
	}
	if (e != '') {
		for ( var column in row)
			if (column != 'sm_code' && column != 'sm_name' && column != 'jdgmnt_fom_cd' && column != 'testitm_nm' 
				&& column != 'testitm_cd' && column != 'crud' && column != 'icon' && column != 'standard_spec_seq'
				&& column != 'prdlst_nm' && column != 'testitm_lclas_nm' && column != 'testitm_mlsfc_nm' && column != 'unit_cd'
					&& column != 'test_method_no' && column != 'test_method_nm' && column != 'oxide_cd' && column != 'item_order')
				$("#" + grid).jqGrid('setCell', rowId, column, null);
	}
	$("#" + grid).jqGrid('editRow', rowId);
	
	if (row_jdgmnt_fom_cd == 'C31001' || row_jdgmnt_fom_cd == 'C31002') {
		fnStdTotal(grid, rowId);
	}
}

// spec_val에 합계 값 입력
function fnStdTotal(grid, rowId) {		
	$("#"+grid+"Form").find('#' + rowId + '_vald_manli').keyup(function() {
		if (!fnIsNumeric($("#"+grid+"Form").find('#' + rowId + '_vald_manli').val()) && $("#"+grid+"Form").find('#' + rowId + '_vald_manli').val() != '') {
			$.showAlert("숫자만 입력가능합니다.", {
				callback : function() {
					$("#"+grid+"Form").find('#' + rowId + '_vald_manli').val("");
					$("#"+grid+"Form").find('#' + rowId + '_vald_manli').focus();
				}
			});
		}
	});
	//기준적합값 selectbox선택
	$("#"+grid+"Form").find('#' + rowId + '_choic_fit').change(function() {
		addStdTotal_fit(grid, rowId, 'choic_fit');
	});
	$("#"+grid+"Form").find('#' + rowId + '_mimm_val,' + '#' + rowId + '_mxmm_val').keyup(function() {
		addStdTotal(grid, rowId);
	});
	$("#"+grid+"Form").find('#' + rowId + '_mimm_val_dvs_cd,' + '#' + rowId + '_mxmm_val_dvs_cd').change(function() {
		addStdTotal(grid, rowId);
	});
}

// 기준적합값 selectbox선택 값 기준에 붙임
function addStdTotal_fit(grid, rowId, column) {
	var stdFitVal = '';
	if ($("#"+grid+"Form").find('#' + rowId + '_' + column).val() == '')
		stdFitVal = '';
	else
		stdFitVal = $("#"+grid+"Form").find('#' + rowId + '_' + column + ' option:selected').text();
	if (stdFitVal != null && stdFitVal != '') {
		$("#"+grid+"Form").find('#' + rowId + '_spec_val').val(stdFitVal);
	}
}

// 수치형 합산값 기준에 붙임
function addStdTotal(grid, rowId) {
	var total = '';
	var stdLval = '';
	var lvalType = '';
	var stdHval = '';
	var hvalType = '';
	var row = $('#'+grid).getRowData(rowId);
	for ( var column in row) {
		switch (column) {
		case 'mxmm_val':
			stdHval = $("#"+grid+"Form").find('#' + rowId + '_' + column).val();
			if (!fnIsNumeric(stdHval) && stdHval != '') {
				$.showAlert("숫자만 입력가능합니다.", {
					callback : function() {
						$("#"+grid+"Form").find('#' + rowId + '_mxmm_val').val(null);
						$("#"+grid+"Form").find('#' + rowId + '_mxmm_val').focus();
					}
				});
				stdHval = '';
			}
			break;
		case 'mxmm_val_dvs_cd':
			if ($("#"+grid+"Form").find('#' + rowId + '_' + column).val() == '')
				hvalType = '';
			else
				hvalType = ' ' + $('#' + rowId + '_' + column + ' option:selected').text();
			break;
		case 'mimm_val':
			stdLval = $("#"+grid+"Form").find('#' + rowId + '_' + column).val();
			if (!fnIsNumeric(stdLval) && stdLval != '') {
				$.showAlert("숫자만 입력가능합니다.", {
					callback : function() {
						$("#"+grid+"Form").find('#' + rowId + '_mimm_val').val(null);
						$("#"+grid+"Form").find('#' + rowId + '_mimm_val').focus();
					}
				});
				stdLval = '';
			}
			break;
		case 'mimm_val_dvs_cd':
			if ($("#"+grid+"Form").find('#' + rowId + '_' + column).val() == '')
				lvalType = '';
			else
				lvalType = ' ' + $("#"+grid+"Form").find('#' + rowId + '_' + column + ' option:selected').text();
			break;
		}
	}
	if (lvalType != null && lvalType != '' && hvalType != null && hvalType != '')
		lvalType += ' ';
	total = stdLval + lvalType + stdHval + hvalType;

	var row_jdgmnt_fom_cd = $("#"+grid+"Form").find("#" + rowId + "_jdgmnt_fom_cd").val();
	switch (row_jdgmnt_fom_cd) {
	//수치형
	case 'C31002':
		$('#'+grid).jqGrid('setCell', rowId, 'spec_val', total);
		break;
	default:
		$("#"+grid+"Form").find('#' + rowId + '_spec_val').val(total);
		break;
	}
}

// 조회버튼 클릭 이벤트
function btn_Search_onclick() {
	fnEditRelease('testPrdStdRevGrid');
	$('#testPrdStdRevGrid').trigger('reloadGrid');

	$("#fnprtItemGridForm").find("#sm_name").val("");
	$("#fnprtItemGridForm").find("#sm_code").val("");
	$("#fnprtItemGridForm").find("#standard_spec_seq").val("");
}

// 기준별 시험항목 목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
function editCount(grid) {
	var check = false;
	var ids = $('#' + grid).jqGrid("getDataIDs");
	for ( var i in ids) {
		var row = $('#' + grid).getRowData(ids[i]);
		if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
			check = true;
	}
	return check;
}

// 저장버튼 클릭이벤트
function btn_Update_onclick(grid) {
	var rowId = $('#' + grid).jqGrid('getGridParam', "selrow");
	if (!valiCheck(rowId))
		return;
	fnEditRelease(grid);
	
	var ids = $('#' + grid).jqGrid("getDataIDs");		
	
	if (ids.length < 1) {
		$.showAlert("시험항목 목록이 존재하지 않습니다.");
		return;
	}

	if (!editCount(grid)) {
		alert("변경된 시험항목 목록이 없습니다.");
		return;
	}
	var data = fnGetGridAllData(grid);

	if(grid == "testPrdStdRevGrid"){
		var json = fnAjaxAction('master/insertTestStandardItem.lims', data);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Search_onclick(2);
		}			
	}else{
		
		var json = fnAjaxAction('master/insertTestStandardItem.lims', data);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Search_onclick();
		}
	}
	return data;
}


// 시험항목추가 팝업
function btn_Add_onclick(form) {
	var standard_spec_seq = $("#"+form).find("#standard_spec_seq").val();
	var sm_code = $("#"+form).find("#sm_code").val();
	var sm_name = $("#"+form).find("#sm_name").val();
	var prdlst_cd = $("#"+form).find("#prdlst_cd").val(); 
	
	if(form == "testPrdStdRevGridForm"){
		if(sm_code == ""){
			alert("스탠다드를 선택해야 합니다.");
			return;
		}
	}
	param =  sm_code + "◆★◆" + sm_name + "◆★◆" + standard_spec_seq + "◆★◆" + prdlst_cd;

	var url = "master/testStandardItemChoice.lims";
	var height = "867";
	var width = "1000";
	var option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, top=50%, left=50%, width=" + width + 'px, height=' + height +'px' ;
	openPopup = window.open(url, param, option);

	fnBasicStartLoading();
}

// 자식 -> 부모창 함수 호출
function fnpop_callback(returnParam){
	btn_Search_onclick(1);
	fnBasicEndLoading();
}

// 시험 항목 삭제 버튼 클릭
function btn_Delete_onclick(grid) {
	var b = false;
	var ids = $('#'+grid).jqGrid("getDataIDs");
	if (ids.length > 0) {
		for ( var i in ids) {
			var row = $('#'+grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				b = true;
			}
		}
		if (b) {
			GridDeleteMultiLine(grid);
		} else {
			$.showAlert('선택된 행이 없습니다. 체크박스를 선택해주세요');
		}
	}
}

// 삭제실행
function GridDeleteMultiLine(grid) {		
	var ids = $('#' + grid).jqGrid("getDataIDs");
	if (ids.length > 0) {
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				if (row.crud != 'n') {
					$('#' + grid).setCell(ids[i], 'icon', gridD);
					$('#' + grid).setCell(ids[i], 'crud', 'd');
					$('#' + grid).setCell(ids[i], 'chk', 'No');
				} else {
					$('#' + grid).jqGrid('delRowData', ids[i]);
				}
			}
		}
	}
}

// 기준값 validation체크
function valiCheck(rowId) {
	var result_id = $('#' + rowId + '_jdgmnt_fom_cd ').val();
	var check = true;
	if (result_id == 'C31002') { // 수치형
		var stdHval = $('#' + rowId + '_mxmm_val');
		var stdLval = $('#' + rowId + '_mimm_val');
		var lvalType = $('#' + rowId + '_mimm_val_dvs_cd');
		var hvalType = $('#' + rowId + '_mxmm_val_dvs_cd');
		if (stdHval.val() != '' && stdLval.val() != '') {
			if (parseFloat(stdLval.val()) >= parseFloat(stdHval.val())) {
				alert("기준상한값보다 큰 값을 입력하셔야 합니다.");
				stdHval.val(null);
				stdHval.focus();
				check = false;
			}
		}
		if (check) {
			if (stdLval.val() == '') {
				if (lvalType.val() != '') {
					$.showAlert("기준하한값을 입력하세요.", {
						callback : function() {
							stdLval.focus();
						}
					});
					check = false;
				}
			} else {
				if (lvalType.val() == '') {
					$.showAlert("하한값구분을 선택하세요.", {
						callback : function() {
							lvalType.focus();
						}
					});
					check = false;
				}
			}
		}
		if (check) {
			if (stdHval.val() == '') {
				if (hvalType.val() != '') {
					$.showAlert("기준상한값을 입력하세요.", {
						callback : function() {
							stdHval.focus();
						}
					});
					check = false;
				}
			} else {
				if (hvalType.val() == '') {
					$.showAlert("상한값구분을 선택하세요.", {
						callback : function() {
							hvalType.focus();
						}
					});
					check = false;
				}
			}
		}
	}
	return check;
}

function fnpop_formula_callback(grid, gridRowId, formula_no, formula_disp, average){
	if(grid == 'testPrdStdDetailForm'){
		$("#"+grid).find("#formula_no").val(formula_no);
		$("#"+grid).find("#formula_nm").val(formula_disp);
	} else {
		$("#"+grid).setCell(gridRowId, "formula_no", formula_no);
		$("#"+grid).setCell(gridRowId, "formula_nm", formula_disp);	
	}
}

// 스탠다드 조회
function btn_Select_Sub_onclick() {
	$('#allPrdGrid').trigger('reloadGrid');
}

//스탠다드 등록
function btn_Insert_Sub_onclick(gbn) {
	var url;
	var sm_name = $("[name=sm_name_e]").parent().parent().prev().children().next().children().val();
	var sm_name_e = $("[name=sm_name_e]").val();
	
	if(sm_name == "") {
		alert("스탠다드한글명 : 필수 입력 입니다.");
		return false;
	} else if(sm_name_e == "") {
		alert("스탠다드영문명 : 필수 입력 입니다.");
		return false;
	}
	
	if(gbn == "U" && $("#insPrdForm").find("#sm_code").val() == ""){
		alert("스탠다드를 선택하여 주세요.");
		return false;
	}
	
	if(gbn == "I" && !confirm('등록하시겠습니까?')){
		return false;
	}
	
	if(gbn == 'I'){
		url = 'master/insertStandardItem.lims';	
	}else{
		url = 'master/updateStandardItem.lims';	
	}
	
	var json = fnAjaxAction(url, $('#insPrdForm').serialize());
	
	if (json == null) {
		$.showAlert('저장 실패되었습니다.');
	} else {
		$.showAlert('저장이 완료되었습니다.');
		$("#insPrdForm")[0].reset();
		$('#allPrdGrid').trigger('reloadGrid');
		$('#testPrdStdRevGrid').clearGridData();
	}
}

function fn_visible_column(gbn) {
	var grid = 'testPrdStdRevGrid';
	
	var arr = new Array();
	
	arr.push('item_order');
	arr.push('unit_cd');
	arr.push('test_method_nm');
	arr.push('test_method_pop');
	arr.push('test_method_del');
	arr.push('oxide_cd');
	
	if(gbn == "0"){
		$('#' + grid).hideCol(arr);
	}else{
		if($('#btn_View').find('button').text() == '프로토콜정보보기'){		
			$('#btn_View').find('button').text('프로토콜정보숨김')
			$('#' + grid).showCol(arr);
		}else{
			$('#btn_View').find('button').text('프로토콜정보보기')
			$('#' + grid).hideCol(arr);
		}
	}
}

//시험방법 선택 팝업 콜백- 그리드용
function fnpop_methodCallback(rowId){
	fnBasicEndLoading();
	var grid = 'testPrdStdRevGrid';
	fnEditRelease(grid);
	testPrdStdRevGridEdit(grid, rowId);
}

//시험방법 -일괄입력
function btn_search_onclick(div){
	var grid = 'testPrdStdDetailForm';
	fnpop_methodPop('', '900', '500', '', '', grid);
	fnBasicStartLoading();		
} 

//시험방법일괄입력
function btn_testMethodVal_onclick() {
	var grid = 'testPrdStdRevGrid';
	var ids = $('#' + grid).jqGrid("getDataIDs");
	var rowCnt = 0;
	
	for ( var i in ids) {
		var row = $('#' + grid).getRowData(ids[i]);
		if (row.chk == 'Yes') {
			rowCnt++;
		}
	}
	
	if (rowCnt == 0) {
		alert("선택된 항목이 없습니다.");
		return;
	} else {
		var unit_cd = $('#testPrdStdDetailForm').find('#unit_cd').val();
		var test_method_nm = $('#testPrdStdDetailForm').find('#test_method_nm').val();
		var test_method_no = $('#testPrdStdDetailForm').find('#test_method_no').val();
		var formula_no = $('#testPrdStdDetailForm').find('#formula_no').val();
		var formula_nm = $('#testPrdStdDetailForm').find('#formula_nm').val();
		var base_cd = $('#testPrdStdDetailForm').find('#base_cd').val();
		var spec_val = $('#testPrdStdDetailForm').find('#spec_val').val();
		var loq_lval = $('#testPrdStdDetailForm').find('#loq_lval').val();
		var loq_lval_mark = $('#testPrdStdDetailForm').find('#loq_lval_mark').val();
/* 		if(unit_cd == '' && test_method_no == ''){
			alert("일괄입력 정보를 선택하여주세요.");
			return;	
		} */
		
		var nids = $('#' + grid).jqGrid("getDataIDs");
		for ( var j in nids) {
			var nrow = $('#' + grid).getRowData(nids[j]);
			if (nrow.chk == 'Yes') {
				$('#' + grid).jqGrid('setCell', ids[j], 'unit_cd', unit_cd);
				$('#' + grid).jqGrid('setCell', ids[j], 'test_method_nm', test_method_nm);
				$('#' + grid).jqGrid('setCell', ids[j], 'test_method_no', test_method_no);
				$('#' + grid).jqGrid('setCell', ids[j], 'formula_no', formula_no);
				$('#' + grid).jqGrid('setCell', ids[j], 'formula_nm', formula_nm);
				$('#' + grid).jqGrid('setCell', ids[j], 'base_cd', base_cd);
				$('#' + grid).jqGrid('setCell', ids[j], 'spec_val', spec_val);
				$('#' + grid).jqGrid('setCell', ids[j], 'loq_lval', loq_lval);
				$('#' + grid).jqGrid('setCell', ids[j], 'loq_lval_mark', loq_lval_mark);
				$('#' + grid).jqGrid('setCell', ids[j], 'icon', gridU);
				$('#' + grid).jqGrid('setCell', ids[j], 'crud', 'u');
			}
		}
		
	}
}

//계산식 -일괄입력
function btn_formula_onclick(div){
	var grid = 'testPrdStdDetailForm';
	fnpop_formulaPop(grid, "900", "500", '', "", "M", null);
	fnBasicStartLoading();		
} 

//시험 항목 복사 버튼 클릭
function btn_Copy1_onclick(grid) {
	var b = false;
	var ids = $('#'+grid).jqGrid("getDataIDs");
	if (ids.length > 0) {
		for ( var i in ids) {
			var row = $('#'+grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				b = true;
			}
		}
		if (b) {
			var data = fnGetGridCheckData(grid);
			var json = fnAjaxAction('master/copyTestStandardItem.lims', data);
			btn_Search_onclick();	
		} else {
			$.showAlert('선택된 행이 없습니다. 체크박스를 선택해주세요');
		}
	}
}

//복사버튼 클릭이벤트
function btn_Copy_onclick() {
	var rowId = $('#allPrdGrid').jqGrid('getGridParam', "selrow");
	var row = $('#allPrdGrid').getRowData(rowId);
	
	if(rowId == null){
		$.showAlert("복사되는 스탠다드를 선택해주세요.");
		return;
	}
	
	if (!confirm("복사하시겠습니까?")) {
		return;
	}
	
	var data = $('#insPrdForm').serialize() + '&sm_code_n='+row.sm_code;
	
	var json = fnAjaxAction('master/copyStandard.lims', data);
	if (json == null) {
		$.showAlert("복사 실패하였습니다.");
	} else {
		$.showAlert("", {
			type : 'insert'
		});
		btn_Select_Sub_onclick();
	}	
}

</script>
<div class="sub_purple_01 w30p" style="margin-top:0px;">
	<div class="sub_purple_01">
		<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						스탠다드 목록
					</td>
					<td class="table_button" style="text-align: right;">
						<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>스탠다드명</th>
					<td>
						<input type="text" name="sm_name"/>
					</td>					
				</tr>
				<tr>
					<th>사용여부</th>
					<td>
						<label><input type='radio' name='use_flag' value='' style="width: 20px" />전체</label>
						<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용함</label>
						<label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
					</td>
				</tr>
			</table>
			<input type="hidden" id="prdlst_yn" name="prdlst_yn" value='Y'>
			<input type="hidden" id="use_yn" name="use_yn" value='Y'>
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<input type='hidden' id='pageNum' name='pageNum'/>
			<input type='hidden' id='pageSize' name='pageSize'/>
			<input type='hidden' id='sortTarget' name='sortTarget'/>
			<input type='hidden' id='sortValue' name='sortValue'/>
			<div id="view_grid_prd">
				<table id="allPrdGrid"></table>
				<div id="gridPrdLstPopPager"></div>
			</div>
		</form>
	</div>
	<div style="clear:both; padding-top:10px; text-align:center;">
	</div>
	<div class="sub_purple_01">
		<form id="insPrdForm" name="insPrdForm" onsubmit="return false;">
		<input type="hidden" id="sm_code" name="sm_code">
		<table width="100%" border="0" class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					스탠다드 등록
				</td>
				<td class="table_button" style="text-align: right;">
					<span class="button white mlargeg auth_save" id="btn_Copy" onclick="btn_Copy_onclick();">
						<button type="button">복사</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_Insert" onclick="btn_Insert_Sub_onclick('I');">
						<button type="button">등록</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_Update" onclick="btn_Insert_Sub_onclick('U');">
						<button type="button">수정</button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table" >
			<tr>
				<th class="indispensable">스탠다드한글명</th>
				<td>
					<input type="text" name="sm_name" id="sm_name"/>
				</td>
			</tr>
			<tr>
				<th class="indispensable">스탠다드영문명</th>
				<td>
					<input type="text" name="sm_name_e" id="sm_name_e"/>
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>					
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용함</label>
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
				</td>
			</tr>
			<tr>
				<th>프로토콜</th>
				<td>
					<select name="protocol" id="protocol" style="width: 253px !important"></select>
				</td>
			</tr>
		</table>
	</form>
	</div>
</div>

<div class="w5p"></div>

<div class="sub_blue_01 w65p" style="margin-top:0px;">
	<div class="sub_blue_01">
		<form id="testPrdStdRevGridForm" name="testPrdStdRevGridForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					기준규격 목록
				</td>
				<td class="table_button" style="text-align: right;">
					<span class="button white mlargeb auth_save" id="btn_View" onclick="fn_visible_column('1');" style="display: none;">
						<button type="button">프로토콜정보보기</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Add1" onclick="btn_Add_onclick('testPrdStdRevGridForm');">
						<button type="button">시험항목추가</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Copy1" onclick="btn_Copy1_onclick('testPrdStdRevGrid');">
						<button type="button">시험항목복사</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Del1" onclick="btn_Delete_onclick('testPrdStdRevGrid');">
						<button type="button">시험항목삭제</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Ins1" onclick="btn_Update_onclick('testPrdStdRevGrid');">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	
		<div id="view_grid_rev">
			<table id="testPrdStdRevGrid"></table>
		</div>
		<input type="hidden" id="standard_spec_seq" name="standard_spec_seq">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="sm_code" name="sm_code">
		<input type="hidden" id="sm_name" name="sm_name">
		<input type="hidden" id="prdlst_cd" name="prdlst_cd">
		</form>
	</div>	
	<div style="clear:both; padding-top:10px; text-align:center;">
	</div>
	<div class="sub_purple_01 ">
	<form id="testPrdStdDetailForm" name="testPrdStdDetailForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					일괄입력
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_select" id="btn_insertItemVal" onclick="btn_testMethodVal_onclick();">
						<button type="button">일괄입력</button>
					</span>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table">
			<tr>
				<th>단위</th>
				<td>
					<select name="unit_cd" id="unit_cd" class="w100px"></select>
				</td>
 				<th id="test_method">시험방법</th>
				<td>
					<input name="test_method_no" id="test_method_no" type="hidden" />
					<input name="test_method_nm" id="test_method_nm" type="text" class="w120px inputhan" " />
					<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_method_serach" onclick="btn_search_onclick('method');"/>
					<img src="<c:url value='images/common/icon_stop.png'/>" id="test_method_del" style="cursor: pointer;" onClick='fn_TextClear("test_method_nm")' />
				</td> 
 				<th id="test_method">계산식</th>
				<td>
					<input name="formula_no" id="formula_no" type="hidden" />
					<input name="formula_nm" id="formula_nm" type="text" class="w120px inputhan" " />
					<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_formula_serach" onclick="btn_formula_onclick('formula');"/>
					<img src="<c:url value='images/common/icon_stop.png'/>" id="test_formula_del" style="cursor: pointer;" onClick='fn_TextClear("test_formula_nm")' />
				</td> 
			</tr>
			<tr>
				<th>Base</th>
				<td>
					<select name="base_cd" id="base_cd" class="w100px"></select>
				</td>
				<th>기준값</th>
				<td>
					<input type="text" name="spec_val" id="spec_val" class="w100px"/>
				</td>
				<th>정량하한값</th>
				<td colspan = "2">
					<input type="text" name="loq_lval" id="loq_lval" class="w100px"/>
				</td>
			</tr>
			<tr>
			<th>정량하한표기</th>
			<td colspan = "5">
					<input type="text" name="loq_lval_mark" id="loq_lval_mark" class="w100px"/>
				</td>
			</tr>
		</table>
	</form>
	</div>
</div>