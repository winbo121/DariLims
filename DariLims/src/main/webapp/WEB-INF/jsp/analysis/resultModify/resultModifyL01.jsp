
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료별 결과수정
	 * 파일명 		: resultModifyL01.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 *          
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
input[type=text] {
	ime-mode: auto;
}
</style>
<script type="text/javascript">
	var result_type;
	var unit;
	var jdg_type;
	var hval_type;
	var lval_type;
	var std_type;
	var fit_val;
	var fnGridInit = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "${session.dept_cd }", "ALLNAME", 'reqListForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');

		//결과 일괄입력
		ajaxComboForm("std_type", "C38", "C38002", "", "resultDetailForm");
		ajaxComboForm("result_type", "C31", "C31003", "", "resultDetailForm");
		ajaxComboForm("jdg_type", "C37", "", "", "resultDetailForm");
		ajaxComboForm("unit", "C08", "", "", "resultDetailForm");

		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		$('#reqListForm').find('#endDate').val(fnGetToday(0,0));
		$('#reqListForm').find('#startDate').val(fnGetToday(1,0));

		commonReqGrid('analysis/selectModifyReqList.lims', 'reqListForm', 'reqListGrid', true);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		result_type = fnGridCommonCombo('C31', 'NON');
		unit = fnGridCommonCombo('C08', null);
		jdg_type = fnGridCommonCombo('C37', null);
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);

		testSampleGrid('analysis/selectSampleList.lims', 'resultForm', 'inputItemGrid');
		
		resultGrid('analysis/selectModifyResultList.lims', 'resultForm', 'resultGrid');

		// 시료별 성적서 리스트
		sampleReportListGrid('analysis/selectsampleReportList.lims', 'sampleReportListForm', 'sampleReportListGrid');

		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#sampleReportListGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub3').width(), false);
		}).trigger('resize');
		

	});

	function testSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '150',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료번호',
				name : 'test_sample_seq',
				align : 'center',
				width : '80',
				hidden : false
			}, {
				label : '시료명',
				name : 'sample_reg_nm',
				width : '200'
			} , {
				label : '시험결과',
				name : 'test_sample_result_nm',
				align : 'center',
				width : '100'
			}, {
				label : '시료유형',
				name : 'sample_nm',
				width : '100'
			}, {
				label : '검사기준',
				name : 'test_std_nm',
				width : '150'
			}, {
				label : '비고',
				name : 'etc_desc',
				width : '300'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#resultForm').find('#test_sample_seq').val(row.test_sample_seq);
				$('#resultGrid').trigger('reloadGrid');
				
				$('#sampleReportListForm').find('#test_sample_seq').val(row.test_sample_seq);
				$('#sampleReportListGrid').trigger('reloadGrid'); // 성적서리스트
			},
		});
	}
	
	var lastRowId;
	function resultGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_sample_seq').val() != '') {
					fnGridData(url, form, grid);
				} else {
					$('#' + grid).clearGridData();
				}
			},
			height : '350',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
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
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : 'colla_flag',
				name : 'colla_flag',
				hidden : true
			}, {
				label : '시험항목',
				name : 'test_item_nm',
				sortable : false,
				width : '160'
			}, {
				type : 'not',
				label : '항목유형',
				name : 'test_item_type',
				sortable : false,
				width : '220',
				hidden : true
			}, {
				label : '기준',
				name : 'std_type',
				sortable : false,
				align : 'center',
				width : '75',
				editable : true,
				edittype : "select",
				editoptions : {
					value : std_type
				},
				formatter : 'select'
			}, {
				label : '결과유형',
				name : 'result_type',
				sortable : false,
				align : 'center',
				width : '120',
				editable : true,
				edittype : "select",
				editoptions : {
					value : result_type
				},
				formatter : 'select'
			}, {
				label : '기준값',
				name : 'std_val',
				sortable : false,
				width : '110'
			}, {

				label : '단위',
				name : 'unit',
				sortable : false,
				width : '100',
				edittype : "select",
				editoptions : {
					value : unit
				},
				formatter : 'select'
			}, {
				label : '표기자리',
				name : 'valid_position',
				sortable : false,
				width : '60',
				align : 'right'
			}, {
				label : 'result_cd',
				name : 'result_cd',
				hidden : true
			}, {
				label : '결과값',
				name : 'result_val',
				sortable : false,
				align : 'right',
				width : '80'
			}, {
				label : '성적서표기값',
				name : 'report_disp_val',
				width : '80',
				sortable : false,
				align : 'right',
				editable : true
			}, {
				label : '결과판정',
				name : 'jdg_type',
				width : '110',
				sortable : false,
				align : 'center',
				edittype : "select",
				editoptions : {
					value : jdg_type
				},
				formatter : 'select'
			}, {
				label : '기준하한',
				name : 'std_lval',
				sortable : false,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '하한구분',
				name : 'lval_type',
				sortable : false,
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : lval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '기준상한',
				name : 'std_hval',
				sortable : false,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '상한구분',
				name : 'hval_type',
				sortable : false,
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : hval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '정량상한',
				name : 'loq_hval',
				sortable : false,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '기준적합값',
				name : 'std_fit_val',
				sortable : false,
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '기준부적합값',
				name : 'std_unfit_val',
				sortable : false,
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				label : 'test_method_no',
				name : 'test_method_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험방법',
				name : 'test_method_nm',
				sortable : false
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
				label : 'inst_no',
				name : 'inst_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험기기',
				name : 'inst_kor_nm',
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				type : 'not',
				label : 'RDMS',
				name : 'rawdata',
				sortable : false,
				width : '50',
				align : 'center',
				formatter : rawdataImageFormat
			}, {
				type : 'not',
				label : '첨부문서',
				width : '200',
				name : 'file_nm',
				classes : 'file_nm',
				formatter : displayAlink,
				sortable : false
			}, {
				label : 'att_seq',
				name : 'att_seq',
				classes : 'att_seq',
				sortable : false,
				hidden : true
			}, {
				type : 'not',
				label : ' ',
				name : 'report_pop',
				sortable : false,
				align : 'center',
				width : '20',
				classes : 'grid_cursor',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'report_del',
				sortable : false,
				align : 'center',
				width : '20',
				classes : 'grid_cursor',
				formatter : deleteImageFormat
			}, {
				type : 'not',
				label : '상태',
				name : 'state',
				sortable : false,
				align : 'center',
				width : '80'
			}, {
				label : 'return_flag',
				name : 'return_flag',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				fn_Result_onCellSelect(grid, rowId, iCol);
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fn_Result_ondblClickRow(grid, rowId, iCol);
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				fn_Result_afterInsertRow(grid, rowId);
			}
		});
		fn_Result_setGroupHeaders(grid);
		$('#' + grid).bind("jqGridInlineAfterRestoreRow", function(e, rowId, orgClickEvent) {
			var row = $('#' + grid).getRowData(rowId);
			$('#' + grid).jqGrid('setCell', rowId, 'result_cd', row.result_val);
			return e.result === undefined ? true : e.result;
		});
	}
	
	// 시료별 성적서 리스트
	var lastRowId;
	function sampleReportListGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '150',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '성적서 번호',
				name : 'att_seq',
				hidden : true
			}, {
				label : '시료 번호',
				name : 'test_sample_seq',
				align : 'center',
				hidden : true
			}, {
				label : '항목 번호',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : '항목 이름',
				name : 'test_item_nm',
				hidden : true
			}, {
				label : '성적서 종류',
				name : 'sample_flag',
				hidden : true,
				align : 'center'
			}, {
				label : '첨부 문서명',
// 				name : 'file_nm'
				width : '300',
				formatter : displayAlink
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
				//$('#updateSampleBtn').show();
				//$('#insertSampleBtn').hide();
				//$('#sampleReportForm').find('#att_seq').val($('#sampleReportGrid').getRowData(rowId).att_seq);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				//btn_Sample_Report_onclick();
			}
		});
	}
	
	// 각각 ROW에 첨부파일 다운로드 링크 걸기
	function displayAlink(cellvalue, options, rowObject) {
		var edit;
		if (rowObject.file_nm == undefined)
			edit = '<label></label>';
		else
			edit = "<label><a href='analysis/reportDown.lims?att_seq=" + rowObject.att_seq + "'>" + rowObject.file_nm + "</a></label>";
		return edit;
	}
	
	// 항목별 성적서 작성후 콜백
	function callback(grid, rowId, iCol) {
/* 		$('#' + grid).jqGrid('setCell', rowId, 'result_cd', 'C31005');
		$('#' + grid).jqGrid('setCell', rowId, 'jdg_type', 'C37004');
		$('#' + grid).setCell(rowId, 'report_disp_val', '첨부문서참조');
		$('#' + grid).setCell(rowId, 'result_type', 'C31005');
		$('#' + grid).setCell(rowId, 'result_val', '첨부문서참조');
		$('#' + grid).setCell(rowId, 'std_val', '-');
		$('#' + grid).setCell(rowId, 'unit', '-');
		$('#' + grid).setCell(rowId, 'valid_position', '-'); */
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
		fnBasicEndLoading();
	}	
	
	// 항목별 성적서 삭제 후 이벤트
	function callback_del(grid, rowId, iCol){	
/* 		$('#' + grid).jqGrid('setCell', rowId, 'result_cd', 'C31003');
		$('#' + grid).setCell(rowId, 'result_type', 'C31003');
		$('#' + grid).setCell(rowId, 'report_disp_val', null);
		$('#' + grid).setCell(rowId, 'jdg_type', null);
		$('#' + grid).setCell(rowId, 'result_val', null); */
		$('#' + grid).find(' #' + rowId + ' .file_nm').val(''); // 파일 이름
		$('#' + grid).find(' #' + rowId + ' .file_nm').text(''); // 파일 이름
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
		//fn_Result_ondblClickRow(grid, rowId, iCol);
		fnBasicEndLoading();
	}

	function btn_Select_onclick() {
		$('#reqListGrid').trigger('reloadGrid');
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'state') {
				$(this).val('');
			}
		});
		$('#resultGrid').clearGridData();
	}

	// 저장
	function btn_Save_onclick() {
		var grid = 'resultGrid';
		fnEditRelease(grid);

		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				fn_editable(grid, ids[i]);
				if (row.result_type != 'C31004') {
					if ($.trim(row.result_cd) == '') {
						alert(row.test_item_nm + '\n항목의 결과값을 입력해주세요.');
						fnGridEdit(grid, ids[i], fn_Result_Row_Click);
						$("#" + ids[i] + "_result_val").focus();
						return false;
					}
				}
				/* if (row.result_type == 'C31002') {
					var valid_position = row.valid_position;
					if (valid_position == '') {
						$('#' + grid).jqGrid('setCell', ids[i], 'valid_position', '0');
						valid_position = 0;
					}
					var decPos = row.report_disp_val.indexOf('.');
					var report_disp_val_length = row.report_disp_val.substring(decPos + 1, row.report_disp_val.length).length;
					if (valid_position > 0) {
						if (report_disp_val_length != valid_position) {
							alert(row.test_item_nm + '\n항목의 성적서표기값이 표기자리수가 맞지 않습니다.');
							fnGridEdit(grid, ids[i], fn_Result_Row_Click);
							$("#" + ids[i] + "_report_disp_val").focus();
							return false;
						}
					} else {
						if (decPos != -1) {
							alert(row.test_item_nm + '\n항목의 성적서표기값이 표기자리수가 맞지 않습니다.');
							fnGridEdit(grid, ids[i], fn_Result_Row_Click);
							$("#" + ids[i] + "_report_disp_val").focus();
							return false;
						}
					}
				} */
				c++;
			}
		}
		if (c == 0) {
			alert('선택된 항목이 없습니다.');
		} else {
/* 			var data =	fnGetGridCheckData(grid) + '&pageType=item'+
						'&menu_cd=' + $('#menu_cd').val() +
						'&test_req_no=' + $('#reqListGrid').getGridParam('selrow')+
						'&test_req_seq=' + $('#reqListGrid').getGridParam('selrow');
			
			var json = fnAjaxAction('analysis/updateItemResult.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 항목의 저장이 완료되었습니다.');
			} */
			
			var reqListGrid_rowId = $('#reqListGrid').getGridParam('selrow');
			var reqListGrid = $('#reqListGrid').getRowData(reqListGrid_rowId);
		
			var data =	fnGetGridCheckData(grid) + '&pageType=item'+
						'&menu_cd=' + $('#menu_cd').val() +
						'&test_req_no=' + reqListGrid.test_req_no + 
						'&test_req_seq=' + reqListGrid.test_req_seq;
			
			var json = fnAjaxAction('analysis/updateItemResult.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 항목의 저장이 완료되었습니다.');
			}
		}
	}

	function fn_selectOriginalSTD(grid, rowId) {
		var url = 'analysis/selectOriginalSTD.lims';
		var data = 'test_std_no=' + $('#resultForm').find('#test_std_no').val();
		var row = $('#' + grid).getRowData(rowId);
		data += '&test_item_cd=' + row.test_item_cd;
		$.ajax({
			url : url,
			type : 'post',
			dataType : 'json',
			async : false,
			data : data,
			success : function(json) {
				$(json).each(function(index, entry) {
					$("#" + rowId + "_std_lval").val(entry["std_lval"]);
					$("#" + rowId + "_std_hval").val(entry["std_hval"]);
					$("#" + rowId + "_result_type").val(entry["result_type"]);
					$("#" + rowId + "_valid_position").val(entry["valid_position"]);
					$("#" + rowId + "_unit").val(entry["unit"]);
					$("#" + rowId + "_std_fit_val").val(entry["std_fit_val"]);
					$("#" + rowId + "_std_unfit_val").val(entry["std_unfit_val"]);
					$("#" + rowId + "_hval_type").val(entry["hval_type"]);
					$("#" + rowId + "_lval_type").val(entry["lval_type"]);
					$("#" + rowId + "_loq_hval").val(entry["loq_hval"]);
					//$("#" + rowId + "_std_val").val(entry["std_val"]);
					$('#' + grid).jqGrid('setCell', rowId, 'std_val', entry["std_val"]);
				});
			},
			error : function() {
				alert('fn_selectOriginalSTD error');
			}
		});
	}

	function fn_return_change_color(grid, rowId) {
	}
	// 진행상황 팝업
// 	function btn_pop_state_info() {
// 		var rowId = $('#reqListGrid').getGridParam('selrow');
// 		if (rowId == null) {
// 			alert('의뢰를 선택해주세요.');
// 		} else {
// 			fn_pop_state_info(rowId, '');
// 		}
// 	}
	
	// 의뢰정보 팝업
// 	function btn_pop_req_info() {
// 		var rowId = $('#reqListGrid').getGridParam('selrow');
// 		if (rowId == null) {
// 			alert('의뢰를 선택해주세요.');
// 		} else {
// 			var ret = fn_pop_req_info(rowId, false);
// 			if (ret == 'reloadGrid') {
// 				$('#reqListGrid').trigger('reloadGrid');
// 			}
// 		}
// 	}
	
	// 의뢰정보 팝업
	function fnpop_reqInfo(grid) { //btn_pop_req_info
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var ret = 'reloadGrid';
			
			fnBasicStartLoading();
			fnpop_reqInfoPop(grid, "900" , "660" , 'reloadGrid', rowId, true);
			
		}
	}

	// 진행상황 팝업
	function fnpop_stateInfo() { // btn_pop_state_info
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('시료를 선택해주세요.');
		} else {
			var row = $('#reqListGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_stateInfoPop("reqListGrid", "1000", "560", rowId, row.test_req_seq, row.test_req_no, null);
		}
	}
	
	
	// 결과보기 팝업
	function fnpop_reqResultInfo() { // btn_pop_req_result_info
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var row = $('#reqListGrid').getRowData(rowId);
			
			fnBasicStartLoading();
			fnpop_reqResultInfoPop("reqListGrid", "900", "700", row.test_req_seq, row.test_req_no);
			
		}
	}
	
	// 의뢰처 팝업
	function fnpop_reqOrgChoice(name, width, hight, text){		
		fnpop_reqOrgChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}
	
	// 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}

	function commonReqGrid_rowClick(rowId){
		$('#resultForm').find('#test_req_seq').val(rowId);
		$('#inputItemGrid').trigger('reloadGrid');
		$('#resultGrid').clearGridData();
	}
</script>
<div>
	<input type="hidden" id="pageType" value="${pageType }">
	<form id="reqListForm" name="reqListForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						접수목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="reqViewBtn" onclick="fnpop_reqInfo('reqListGrid');">
							<button type="button">의뢰정보</button>
						</span>
						<span class="button white mlargeb auth_select" id="stateViewBtn" onclick="fnpop_stateInfo();">
							<button type="button">진행상황</button>
						</span>
						<span class="button white mlargeb auth_select" id="resultViewBtn" onclick="fnpop_reqResultInfo();">
							<button type="button">결과보기</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" class="list_table" >
				<tr>
					<th>접수번호</th>
					<td>
						<input name="test_req_no" id="test_req_no" type="text" class="w100px" />
					</td>
					<th>의뢰구분</th>
					<td>
						<select name="req_type" id="req_type" class="w100px"></select>
					</td>
					<th>제목</th>
					<td>
						<input name="title" id="title" type="text" class="w300px" />
					</td>
				</tr>
				<tr>
					<th>의뢰업체명</th>
					<td>
						<input name="req_org_nm" id="req_org_nm" type="text" class="w100px" />
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqListForm", "750", "550", "결과입력")'/>
					</td>
					<th>의뢰자</th>
					<td>
						<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
					</td>
					<th>의뢰일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
				<tr>
					<th>접수부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w200px"></select>
					</td>
					<th>단위업무</th>
					<td>
						<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
					</td>
					<th>진행상태</th>
					<td></td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reqListGrid"></table>
		</div>
	</form>
</div>

<div id="sampleDiv" class="w60p" style="padding-bottom:20px;">
	<div class="sub_purple_01 w100p">
		<table width="100%" border="0" class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료 목록
				</td>
			</tr>
		</table>
		<div id="view_grid_sub1">
			<table id="inputItemGrid"></table>
		</div>
	</div>
</div>

<div class="w35p" style="float:right; display:inline-block;">
	<form id="sampleReportListForm" name="sampleReportListForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시료별 성적서 목록
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub2">
			<table id="sampleReportListGrid"></table>
		</div>
	</form>
</div>


<div id="itemDiv">
	<form id="resultForm" name="resultForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시험결과
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="btn_Num_Show" onclick="fn_visible_column('resultGrid',1);">
							<button type="button">수치형기준 보기</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Choice_Show" onclick="fn_visible_column('resultGrid',0);">
							<button type="button">선택형기준 보기</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="test_req_seq" name="test_req_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="test_std_no" name="test_std_no"/>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub3">
			<table id="resultGrid"></table>
		</div>
	</form>
</div>
<div class="sub_purple_01 w100p">
	<form id="resultDetailForm" name="resultDetailForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					수동 일괄입력
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_select" id="btn_insertItemVal" onclick="btn_insertItemVal_onclick();">
						<button type="button">결과일괄입력</button>
					</span>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table" >
			<tr>
				<th>기준</th>
				<td>
					<select name="std_type" id="std_type" class="w100px" disabled="disabled"></select>
				</td>
				<th>결과유형</th>
				<td>
					<select name="result_type" id="result_type" class="w100px" disabled="disabled"></select>
				</td>
				<th>단위</th>
				<td>
					<select name="unit" id="unit" class="w100px"></select>
				</td>
			</tr>
			<tr>
				<th>결과값</th>
				<td>
					<input name="result_val" id="result_val" type="text" class="w100px" />
				</td>
				<!-- <th>성적서표기값</th>
				<td>
					<input name="report_disp_val" id="report_disp_val" type="text" class="w100px" value="" />
				</td> -->
				<th>결과판정</th>
				<td colspan="3">
					<select name="jdg_type" id="jdg_type" class="w100px"></select>
				</td>
				<!-- <th>시험방법</th>
				<td>
					<input name="test_method_nm" id="test_method_nm" type="text" class="w100px"  value="" />
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" onclick="btn_Pop_Method();">
				</td>
				<th>시험기기</th>
				<td>
					<input name="inst_kor_nm" id="report_inst_kor_nmdisp_val" type="text" class="w100px"  value="" />
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" onclick="btn_Pop_Machine();">
				</td> -->
			</tr>
		</table>
	</form>
</div>

