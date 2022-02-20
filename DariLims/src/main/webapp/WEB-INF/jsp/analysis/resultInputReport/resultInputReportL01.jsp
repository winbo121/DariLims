
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 결과입력 (성적서)
	 * 파일명 		: resultInputReportL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.07
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.07    최은향		최초 프로그램 작성         
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
	var select_state;
	var fnGridInit = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "", "ALLNAME", 'reqListForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');

		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		// 접수 리스트
		commonReqGrid('analysis/selectResultReqList.lims?commission_flag='+$("#commission_flag").val(), 'reqListForm', 'reqListGrid', true);
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

		// 시료 리스트		
		testSampleGrid('analysis/selectSampleList.lims', 'resultForm', 'inputItemGrid');

		// 항목 결과 리스트
		resultGrid('analysis/selectResultSampleList.lims', 'resultForm', 'resultGrid');

		// 시료별 성적서 리스트
		sampleReportGrid('analysis/selectsampleReportList.lims', 'sampleReportForm', 'sampleReportGrid');
		$('#insertSampleBtn').hide();
		$('#updateSampleBtn').hide();

		// 시료를 바꿀때 마다
		$('#resultForm').find("#test_sample_seq").change(function() {
			fn_getSample($('#reqListGrid').getGridParam('selrow'));
		});

		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#sampleReportGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub3').width(), false);
		}).trigger('resize');

		
		fn_set_state($('#reqListForm').find('#state option:selected'));

		var width = $('#view_grid_sub2').width();

		// TAB
		$('#tabsReport').tabs({
			create : function(event, ui) {
			},
			activate : function(event, ui) {
				var TabNo = $('#tabsReport').tabs('option', 'active');
				TabNo++;
				//window["fn_tabAct"+TabNo]();
			}
		});
		$('#resultGrid').setGridWidth(width - 40);
		$('#sampleReportGrid').setGridWidth(width - 40);
	});

	// 시료 리스트
	var lastRowId;
	function testSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '560',
			autowidth : false,
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
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
				$('#insertSampleBtn').show();
				$('#resultForm').find('#test_sample_seq').val($('#inputItemGrid').getRowData(rowId).test_sample_seq);
				$('#resultGrid').trigger('reloadGrid'); // 시료리스트
				$('#sampleReportForm').find('#test_sample_seq').val($('#inputItemGrid').getRowData(rowId).test_sample_seq);
				$('#sampleReportGrid').trigger('reloadGrid'); // 성적서리스트
			}
		});
	}

	// 항목 결과 리스트
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
				hidden : true,
				align : 'center',
				width : '75',
				value : 'C38002',
				formatter : function(value) {
					return 'C38002';					
				}
			}, {
				label : '결과유형',
				name : 'result_type',
				sortable : false,
				hidden : true,
				value : 'C31005',
				formatter : function(value) {
					return 'C31005';					
				}
			}, {
				label : '기준값',
				classes : 'std_val',
				name : 'std_val',
				sortable : false,
				hidden : true,
				width : '110'
			}, {

				label : '단위',
				classes : 'unit',
				name : 'unit',
				hidden : true,
				sortable : false,
				width : '100',
				edittype : "select",
				editoptions : {
					value : unit
				},
				formatter : 'select'
			}, {
				label : '표기자리',
				classes : 'valid_position',
				name : 'valid_position',
				sortable : false,
				hidden : true,
				width : '60',
				align : 'right'
			}, {
				label : 'result_cd',
				name : 'result_cd',
				hidden : true
			}, {
				label : '결과값',
				name : 'result_val',
				editable: true,
				sortable : false,
				hidden : true,
				value : '첨부문서참조 ',
				formatter : function(value) {
					return '첨부문서참조 ';					
				}
			}, {
				label : '성적서표기값',
				name : 'report_disp_val',
				width : '80',
				hidden : true,
				sortable : false,
				align : 'right',
				editable : true
			}, {
				label : '결과판정',
				name : 'jdg_type',
				hidden : true,
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
				hidden : true,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '하한구분',
				name : 'lval_type',
				sortable : false,
				hidden : true,
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
				hidden : true,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '상한구분',
				name : 'hval_type',
				sortable : false,
				hidden : true,
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
				hidden : true,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '기준적합값',
				name : 'std_fit_val',
				hidden : true,
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
				hidden : true,
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
				classes : 'test_method_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험방법',
				name : 'test_method_nm',
				classes : 'test_method_nm',
				hidden : true,
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_pop',
				sortable : false,
				hidden : true,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_del',
				sortable : false,
				hidden : true,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : 'inst_no',
				name : 'inst_no',
				classes : 'inst_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험기기',
				name : 'inst_kor_nm',
				classes : 'inst_kor_nm',
				hidden : true,
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_pop',
				hidden : true,
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_del',
				hidden : true,
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				type : 'not',
				label : 'RDMS',
				name : 'rawdata',
				sortable : false,
				hidden : true,
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
			}, {
				label : 'absence_flag',
				name : 'absence_flag',
				hidden : true
			}, {
				label : '지연사유',
				editable : true,
				name : 'exceed_reason',
				classes : 'exceed_reason',
				width : '80',
				align : 'left'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				fn_Result_onCellSelect(grid, rowId, iCol, $('#resultForm').find('#test_std_no').val());
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				if (select_state == 'B') {
					fn_Result_ondblClickRow(grid, rowId, iCol);
				} else {
					alert("결과입력가능 상태가 아닙니다.");
					return false;
				}
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
	function sampleReportGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '435',
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
				$('#updateSampleBtn').show();
				$('#insertSampleBtn').hide();
				$('#sampleReportForm').find('#att_seq').val($('#sampleReportGrid').getRowData(rowId).att_seq);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Sample_Report_onclick();
			}
		});
	}

	// 항목별 성적서 삭제 후 이벤트
	function fn_report_del(){
		btn_Item_Select_onclick();
	}
	
	
	// 시료 성적서 등록
	function btn_Sample_Report_onclick() {
		var sample_seq = $('#sampleReportForm').find('#test_sample_seq').val();
		var att_seq = $('#sampleReportForm').find('#att_seq').val();
		 
		if (sample_seq == '' || sample_seq == null) {
			alert("시료를 선택해 주세요.");
			return false;
		} else {
			fnBasicStartLoading();
			var sample_seq = $('#sampleReportForm').find('#test_sample_seq').val();
			fnpop_filePop('sampleReportGrid', '500', '175', '', sample_seq, att_seq, '');
		}
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
	
	// 성적서 등록 팝업 콜백
	function callback(grid, rowId, iCol) {
		if (grid == 'resultGrid'){
			$('#' + grid).jqGrid('setCell', rowId, 'result_cd', 'C31005');
			$('#' + grid).jqGrid('setCell', rowId, 'jdg_type', 'C37004');
			$('#' + grid).setCell(rowId, 'report_disp_val', '첨부문서참조');
			$('#' + grid).setCell(rowId, 'result_type', 'C31005');
			$('#' + grid).setCell(rowId, 'result_val', '첨부문서참조');
			$('#' + grid).setCell(rowId, 'std_val', null);
			$('#' + grid).setCell(rowId, 'unit', 'C08001');
			$('#' + grid).setCell(rowId, 'valid_position', null);
			$('#' + grid).setCell(rowId, 'chk', 'Yes');
		} else {
			btn_Sample_Select_onclick();
			btn_Item_Select_onclick();
		}
		fnBasicEndLoading();	
	}
	
	// 항목별 성적서 삭제 후 이벤트
	function callback_del(grid, rowId, iCol){	
		$('#' + grid).jqGrid('setCell', rowId, 'result_cd', 'C31003');
		$('#' + grid).setCell(rowId, 'result_type', 'C31003');
		$('#' + grid).setCell(rowId, 'report_disp_val', null);
		$('#' + grid).setCell(rowId, 'jdg_type', null);
		$('#' + grid).setCell(rowId, 'result_val', null);
		$('#' + grid).find(' #' + rowId + ' .file_nm').val(''); // 파일 이름
		$('#' + grid).find(' #' + rowId + ' .file_nm').text(''); // 파일 이름
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
		//fn_Result_ondblClickRow(grid, rowId, iCol);
		fnBasicEndLoading();
	}
	
	// 접수 목록에서 조회
	function btn_Select_onclick() {
		$('#reqListGrid').trigger('reloadGrid');
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'state') {
				$(this).val('');
			}
		});
		if($('#reqListForm').find('#state option:selected').val() == 'B'){
			$('#reqListForm').find('#btn_Complete').show();
		}
		$('#resultForm').find('#test_sample_seq').val('');
		$('#resultForm').find('#test_req_no').val('');		
		$('#resultGrid').clearGridData();
		$('#inputItemGrid').clearGridData();
		$('#updateSampleBtn').hide();
		$('#insertSampleBtn').hide();
		
		$('#sampleReportForm').find('#test_sample_seq').val('');
		btn_Sample_Select_onclick();
		btn_Item_Select_onclick();
	}

	// 시료별 성적서 조회	
	function btn_Sample_Select_onclick() {
		$('#updateSampleBtn').hide();
		$('#insertSampleBtn').show();
		
		//$('#sampleReportForm').find('#test_sample_seq').val('');
		$('#sampleReportForm').find('#att_seq').val('');
		$('#sampleReportGrid').clearGridData();
		$('#sampleReportGrid').trigger('reloadGrid');
	}
	
	// 항목별 성적서 조회	
	function btn_Item_Select_onclick() {
		$('#resultForm').find('#test_req_no').val('');	
		$('#resultGrid').trigger('reloadGrid');
	}

	// 저장 
	function btn_Save_onclick() {
		var grid = 'resultGrid';
		fnEditRelease(grid);

		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		
		//처리기한 체크에 사용하는 변수 선언
		var reqGridIds = $('#reqListGrid').jqGrid("getDataIDs");
		var matchedReqRowId, matchedReqRow, reqDeadLineDate;
		var todayNumber = fn_getToday_number();
		//
		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				
				//현재 일자가 체크된 항목의 처리기한을 넘겼다면 사유를 필수 입력하도록 합니다. 시작
				matchedReqRowId = reqGridIds.find(function (id) {
					return id == row.test_req_seq;
				});
				matchedReqRow = $('#reqListGrid').getRowData(matchedReqRowId);
				reqDeadLineDate = matchedReqRow.deadline_date.replace(/\-/g, '');
				
				if( reqDeadLineDate < todayNumber && row.exceed_reason.replace(/\s/g,'') == '' ){
					//사유 필수 입력 체크
					alert('처리기한이 지난 항목이므로 사유를 작성해야 저장이 가능합니다.');
					return false;
				}
				//
				
				fn_editable(grid, ids[i]);
				if (row.result_type != 'C31004') { // 결과값 없음
					if ($.trim(row.result_cd) == '' || $.trim(row.file_nm) == '<label></label>') {
						alert(row.test_item_nm + '\n항목의 첨부문서를 등록해주세요');
						fnGridEdit(grid, ids[i], fn_Result_Row_Click);
						$("#" + ids[i] + "_result_val").focus();
						return false;
					}
				}
				c++;
			}
		}
		if (c == 0) {
			alert('선택된 항목이 없습니다.');
		} else {
			fn_set_cell(grid, 'result_val', 'text', null);
			var data = fnGetGridCheckData(grid) + 
						'&test_req_seq=' + $('#reqListGrid').getGridParam('selrow') + 
						'&test_sample_seq=' + $('#resultForm').find('#test_sample_seq').val() +
						'&menu_cd=' + $('#menu_cd').val() +
						'&jdg_type=C37004';
			var json = fnAjaxAction('analysis/updateItemResult.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 항목의 저장이 완료되었습니다.');
				//$('#inputSampleForm').find('#test_sample_result').text(json);
				btn_Item_Select_onclick();
			}
		}
	}

	// 결과입력완료(성적서) 버튼 이벤트
	function btn_Complete_onclick() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('의뢰를 선택해주세요.');
		} else {
			var selrow = $('#reqListGrid').getRowData(rowId);
			var rowId = $('#reqListGrid').getGridParam('selrow');			
			//alert(rowId);
			
			if (!confirm('선택된 의뢰의 결과입력을 완료하시겠습니까?')) {
				return false;
			}
			var data = '&state=C' + '&menu_cd=' + $('#menu_cd').val() + '&test_req_seq=' + selrow.test_req_seq + "&pageType=";
			// 시료에 성적서가 있으면,
			//if(true){
				var json = fnAjaxAction('analysis/completeResultInput.lims?pageType=report', data);
			//} else {
			//	var json = fnAjaxAction('analysis/completeResultInput.lims', data);
			//}
			if (json == null) {
				alert("error");
			} else if (json == 0 || json == 1) {
				$('#reqListGrid').jqGrid("delRowData", rowId);
				$('#resultForm').find('input').each(function(index, entry) {
					if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'state') {
						$(this).val('');
					}
				});

				$('#resultForm').find('#test_sample_seq').val('');

				$('#inputItemGrid').clearGridData();
				$('#resultGrid').clearGridData();
				btn_Sample_Select_onclick();
				btn_Item_Select_onclick();				

				if (json == 1) {
					$("#dialog").dialog({
						buttons : [ {
							text : "확인",
							click : function() {
								$('#dialog').dialog("destroy");
							}
						} ]
					});
					btn_Select_onclick();
					btn_Sample_Select_onclick();
					btn_Item_Select_onclick();				
				} else {
					alert('선택된 의뢰의 결과입력이 완료되었습니다.');					
					btn_Select_onclick();
					btn_Sample_Select_onclick();
					btn_Item_Select_onclick();				
				}
			} else {
				alert(json);
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
		var row = $('#' + grid).getRowData(rowId);
		if (row.absence_flag == '${session.user_id}') {
			$('#' + grid).jqGrid('setCell', rowId, 'test_item_nm', '[대리]' + row.test_item_nm, {
				color : 'orange'
			});
		}
		row = $('#' + grid).getRowData(rowId);
		if (row.return_flag == 'Y') {
			$('#' + grid).jqGrid('setCell', rowId, 'test_item_nm', '[반려]' + row.test_item_nm, {
				color : 'red'
			});
		}
	}

	function btn_show_return_comment() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('의뢰를 선택해주세요.');
		} else {
			var obj = new Object();
			obj.msg1 = 'showReturnComment.lims';
			obj.test_req_seq = rowId;
			obj.type = 'show';
			fnShowModalWindow("popMain.lims", obj, 900, 600);
		}
	}

	// 콜백
	function fn_callback() {
// 		$('#reqListGrid').trigger('reloadGrid');
// 		$('#resultForm').find('input').each(function(index, entry) {
// 			if ($(this).attr('id') != 'dept_cd') {
// 				$(this).val('');
// 			}
// 		});
// 		$('#inputSampleForm').find('label').text('');
// 		$('#inputSampleForm').find('#test_sample_seq').find('option').remove();
// 		$('#resultGrid').clearGridData();
		fnBasicEndLoading();
	}

	// 의뢰정보 팝업
	function fnpop_reqInfo(grid) { //btn_pop_req_info
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var ret = 'reloadGrid';

			fnBasicStartLoading();
			fnpop_reqInfoPop(grid, "900", "660", 'reloadGrid', rowId, true);

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
	function fnpop_reqOrgChoice(name, width, hight, text) {
		fnpop_reqOrgChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}

	// 콜백
	function fnpop_callback() {
		fnBasicEndLoading();
	}

	//설명 : 진행상태변경		 
	function fn_set_state(obj) {
		$('#resultForm').find('#state').val($(obj).val());
		if($(obj).val() == 'C'){
			$('#reqListForm').find('#btn_Complete').hide();
		}
		select_state = $(obj).val();
	}

	// 계산식		 
	function fnpop_account() {
		var rowId = $('#resultGrid').getGridParam('selrow');
		var row = $('#resultGrid').getRowData(rowId);
		fnBasicStartLoading();
		fnpop_accountPop("resultGrid", "900", "730", row.test_req_seq);
	}

	function commonReqGrid_rowClick(rowId){
		$('#resultForm').find('#test_req_seq').val(rowId);
		$('#inputItemGrid').trigger('reloadGrid');
		$('#resultGrid').clearGridData();
	}
</script>
<div>
	<form id="reqListForm" name="reqListForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table width="100%" border="0" class="select_table">
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
						<span class="button white mlargeb auth_select" id="rowdata" onclick="btn_RDMS_Viewer(3);">
							<button type="button">RAWDATA</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Complete" onclick="btn_Complete_onclick();">
							<button type="button">결과입력완료</button>
						</span>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" class="list_table">
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
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqListForm", "750", "550", "결과입력")' />
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
					<td>
						<select name="state" id="state" class="w200px" onchange="fn_set_state(this);">
							<option value="B">결과입력대기</option>
							<option value="C">결과입력완료</option>
						</select>
					</td>
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


<div id="sampleDiv1" class="w35p" style="display:inline-block;">
	<div class="sub_purple_01">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료 목록
				</td>
			</tr>
		</table>
	</div>
	<div id="view_grid_sub1">
		<table id="inputItemGrid"></table>
	</div>
</div>


<div class="sub_purple_01 w60p" style="float:right;">
	<table width="100%" border="0" class="select_table">
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				성적서 목록
			</td>
		</tr>
	</table>
	<c:set var="tabName1" value="시료별 성적서" />
	<c:set var="tabName2" value="항목별 성적서" />
	<div id="tabsReport" class="tabsReport">
		<ul>
			<li id="tab1"><a href="#tabDiv1">${tabName1}</a></li>
			<li id="tab2"><a href="#tabDiv2">${tabName2}</a></li>
		</ul>
		<div id="tabDiv1">
			<form id="sampleReportForm" name="sampleReportForm" onsubmit="return false;">
				<div class="sub_blue_01">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시료별 성적서 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Sample_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargep auth_save" id="insertSampleBtn" onclick="btn_Sample_Report_onclick();">
									<button type="button">등록</button>
								</span>
								<span class="button white mlargep auth_save" id="updateSampleBtn" onclick="btn_Sample_Report_onclick();">
									<button type="button">수정</button>
								</span>
							</td>
						</tr>
					</table>
				</div>
				<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
				<input type="hidden" id="att_seq" name="att_seq" />
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_sub2">
					<table id="sampleReportGrid"></table>
				</div>
			</form>
		</div>
	
		<div id="tabDiv2">
			<form id="resultForm" name="resultForm" onsubmit="return false;">
				<div class="sub_blue_01">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								항목별 성적서 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
									<button type="button">저장</button>
								</span>
							</td>
						</tr>
					</table>
				</div>
				<input type="hidden" id="user_id" name="user_id" value="${session.user_id }" />
				<input type="hidden" id="test_req_seq" name="test_req_seq" />
				<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
				<input type="hidden" id="state" name="state" value="B">
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_sub3">
					<table id="resultGrid"></table>
				</div>
			</form>
		</div>
	</div>
</div>

<div id="dialog" style="display: none;">
	<label>결과입력이 완료되었습니다.</label>
	<br>
	<label>결재선을 지정하여 상신해 주세요</label>
</div>
