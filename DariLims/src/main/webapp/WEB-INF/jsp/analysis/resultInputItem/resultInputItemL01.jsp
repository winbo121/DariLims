
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 결과입력 (항목별)
	 * 파일명 		: resultInputItemL01.jsp
	 * 작성자 		: 조재환
	 * 작성일 		: 2015.01.18
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.18    조재환		최초 프로그램 작성         
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
	var base_type;
	var select_state;
	var addFileMode;
	var fnGridInit = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "", "ALLNAME", 'reqListForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');

		//결과 일괄입력
		ajaxComboForm("std_type", "C38", "C38002", "", "resultDetailForm");
		ajaxComboForm("result_type", "C31", "C31003", "", "resultDetailForm");
		ajaxComboForm("jdg_type", "C37", "", "", "resultDetailForm");
		ajaxComboForm("unit", "C08", "", "", "resultDetailForm");
		
		//결과입력 엔터키 작동
 		window.onkeydown = function()	{
 			var arrNumber = new Array();
 			
 			if(event.keyCode == 13){
 				var ids = $('#resultGrid').jqGrid("getDataIDs");
 				for ( var i in ids) {
 					var row = $('#resultGrid').getRowData(ids[i]);
 					
 					if (row.chk == 'Yes') {
 						arrNumber.push(ids[i]);
 					
 					}
 					} 				
 				var lastCkhRowNum=Number(arrNumber.pop())+1;			
				fn_Result_ondblClickRow('resultGrid',String(lastCkhRowNum), '21');
				arrNumber=[];
			}

		}
		
		
		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		commonReqGrid('analysis/selectResultReqList.lims?commission_flag='+$("#commission_flag").val(), 'reqListForm', 'reqListGrid', true);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		result_type = fnGridCommonCombo('C31', null);
		unit = fnGridCommonCombo('C08', null);
		jdg_type = fnGridCommonCombo('C37', null);
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);
		base_type = fnGridCommonCombo('C84', null);

		testItemGrid('analysis/selectReqTestItemList.lims', 'resultForm', 'inputItemGrid');

		resultGrid('analysis/selectResultItemList.lims', 'resultForm', 'resultGrid');

		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		fn_set_state($('#reqListForm').find('#state option:selected'));
		
		$("input[name=view_gbn]").change(function() {
			btn_Select_onclick();
		});
	});
	function testItemGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '435',
			autowidth : true,
			loadonce : true,
			shrinkToFit : false,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '항목명',
				name : 'test_item_nm',
				width : '200'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm'
			}, {
				label : '항목유형',
				name : 'test_item_type',
				width : '220'
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : false
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#resultForm").find("#test_item_cd").val(rowId);
				$('#resultGrid').trigger('reloadGrid');
				$('#resultGrid').jqGrid('setLabel', 'chk', '<input type="checkbox" id="chk" onclick="fn_chk(\'resultGrid\' , \'resultForm\');" />');
			},
		});
	}

	var lastRowId;
	function resultGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_item_cd').val() != '') {
					fnGridData(url, form, grid);
				} else {
					$('#' + grid).clearGridData();
				}
			},
			height : '325',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			sortable : true,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '30',
				sortable : true,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : '담당자',
				name : 'tester_nm',
				sortable : false,
				width : '55'
			}, {
				label : '시험자',
				name : 'real_tester_nm',
				sortable : true,
				width : '55'
			}, {
				label : '시료번호',
				name : 'test_sample_seq',
				sortable : true,
				width : '60',
				align : 'center',
			}, {
				label : '접수SEQ',
				name : 'test_req_seq',
				hidden : true
			}, {
				type : 'not',
				label : '시료명',
				name : 'sample_reg_nm',
				sortable : false,
				width : '70'
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				type : 'not',
				label : '시험기준',
				name : 'test_std_nm',
				sortable : false,
				width : '80'
			}, {
				type : 'not',
				label : 'test_std_no',
				name : 'test_std_no',
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
				label : 'test_item_nm',
				name : 'test_item_nm',
				hidden : true
			}, {
				label : 'colla_flag',
				name : 'colla_flag',
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
				width : '110',
				editable : true,
				edittype : "select",
				editoptions : {
					value : result_type
				},
				formatter : 'select'
			}, {
				label : '기준값',
				classes : 'std_val',
				name : 'std_val',
				sortable : false,
				width : '110'
			}, {
				label : 'BASE',
				name : 'base',
				sortable : false,
				align : 'center',
				width : '60',
				editable : true,
				edittype : "select",
				editoptions : {
					value : base_type
				},
				formatter : 'select'
			}, {
				label : '단위',
				classes : 'unit',
				name : 'unit',
				sortable : false,
				width : '90',
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
				width : '60',
				align : 'right'
			}, {
				label : 'result_cd',
				name : 'result_cd',
				hidden : true
			}, {
				label : '결과값',
				classes : 'result_val',
				name : 'result_val',
				editable: true,
				//sortable : false,
				align : 'right',
				width : '100'
			}, {
				label : '성적서표기값',
				name : 'report_disp_val',
				sortable : false,
				align : 'right',
				editable : true
			}, {
				label : '결과판정',
				name : 'jdg_type',
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
				hidden : true
			}, {
				label : '정량상한표기',
				name : 'loq_hval_mark',
				hidden : true
			}, {
				label : '정량하한',
				name : 'loq_lval',
				hidden : true
			}, {
				label : '정량하한표기',
				name : 'loq_lval_mark',
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
				label : 'formula_no(숨김)',
				name : 'formula_no',
				classes : 'formula_no',
				hidden : true
			}, {
				label : '적용계산식',
				name : 'formula_disp',
				classes : 'formula_disp',
				width : '200'
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
				label : '계산결과내역',
				name : 'formula_result_disp',
				width : '150',
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
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_pop',
				sortable : false,
				align : 'center',
				width : '20',
				classes : 'grid_cursor',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_del',
				sortable : false,
				align : 'center',
				width : '20',
				classes : 'grid_cursor',
				formatter : deleteImageFormat
			}, {
				label : 'inst_no',
				name : 'inst_no',
				classes : 'inst_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험기기',
				classes : 'inst_kor_nm',
				name : 'inst_kor_nm',
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_pop',
				sortable : false,
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_del',
				sortable : false,
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				formatter : deleteImageFormat
			}, {
				type : 'not',
				label : 'RDMS',
				name : 'rawdata',
				sortable : false,
				width : '50',
				align : 'center',
				formatter : rawdataImageFormat,
				hidden : true
			}, {
				type : 'not',
				label : '첨부문서',
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
				label : '산화물원소표기',
				name : 'oxide_nm',
				classes : 'oxide_nm',
				editable : true,
				align : 'right',
				hidden : true
			}, {
				label : '산화물표기',
				name : 'oxide_content',
				width : '300',
				hidden : true
			}, {
				label : '산화물표기순서',
				name : 'oxide_cd',
				hidden : true
			}, {
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
				label : 'result_type_gbn',
				name : 'result_type_gbn',
				hidden : true
			}, {
				label : 'sm_code',
				name : 'sm_code',
				hidden : true
			}, {
				label : '지연사유',
				editable : true,
				name : 'exceed_reason',
				classes : 'exceed_reason',
				width : '200',
				align : 'left'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var row = $('#' + grid).getRowData(rowId);
				fn_Result_onCellSelect(grid, rowId, iCol,  $('#resultForm').find('#test_std_no').val());
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				if(select_state == 'B'){
					fn_Result_ondblClickRow(grid, rowId, iCol);
					$('#'+grid).find('#' + rowId + '_jdg_type option[value=C37004]').remove(); // 문서확인함 숨김
					$('#'+grid).find('#' + rowId + '_result_type option[value=C31008]').remove(); // 등급형 숨김
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
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
		fnBasicEndLoading();
	}	
	
	// 항목별 성적서 삭제 후 이벤트
	function callback_del(grid, rowId, iCol){	
		$('#' + grid).find(' #' + rowId + ' .file_nm').val(''); // 파일 이름
		$('#' + grid).find(' #' + rowId + ' .file_nm').text(''); // 파일 이름
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
		fnBasicEndLoading();
	}
	
	// 조회
	function btn_Select_onclick() {		
		if($('#reqListForm').find('#state option:selected').val() == 'B'){
			$('#reqListForm').find('#btn_Complete').show();
		}		
		$('#reqListGrid').trigger('reloadGrid');
		$('#inputItemGrid').clearGridData();
		$('#resultGrid').clearGridData();
	}

	// 결과 항목리스트 저장 ( 시험 일지에 값도 update )
	function btn_Save_onclick() {
		var grid = 'resultGrid';
		fnEditRelease(grid);

		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		
		//처리기한 체크에 사용하는 변수 선언
		var reqGridIds = $('#reqListGrid').jqGrid("getDataIDs");
		var matchedReqRowId, matchedReqRow, reqDeadLineDate;
		var todayNumber = fn_getToday_number();
		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				
				matchedReqRowId = $('#reqListGrid').getGridParam('selrow');
				matchedReqRow = $('#reqListGrid').getRowData(matchedReqRowId);
				
				reqDeadLineDate = replaceAll(matchedReqRow.deadline_date, '-', '');
				
				if( reqDeadLineDate < todayNumber && $.trim(row.exceed_reason) == ''){
					//사유 필수 입력 체크
					alert('처리기한이 지난 항목이므로 사유를 작성해야 저장이 가능합니다.');
					return false;
				}
				
				if (row.result_type != 'C31004') {
					if ($.trim(row.result_cd) == '') {
						alert(row.test_sample_seq + '\n의 결과값을 입력해주세요.');
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
						'&test_cmt=' + $('#resultForm').find('#test_cmt').val() +
						'&temp_min=' + $('#resultForm').find('#temp_min').val() + '&temp_max=' + $('#resultForm').find('#temp_max').val() +
						'&hum_min=' + $('#resultForm').find('#hum_min').val() + '&hum_max=' + $('#resultForm').find('#hum_max').val() + 
						'&pageType=item'+'&menu_cd=' + $('#menu_cd').val() +
						'&test_req_seq=' + $('#reqListGrid').getGridParam('selrow');
			var json = fnAjaxAction('analysis/updateItemResult.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 항목의 저장이 완료되었습니다.');
				$('#resultGrid').trigger('reloadGrid');
			}
		}
	}

	 // 결과 입력 완료
	function btn_Complete_onclick() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('의뢰를 선택해주세요.');
		} else {
			var selrow = $('#reqListGrid').getRowData(rowId);
			if (!confirm('선택된 의뢰의 결과입력을 완료하시겠습니까?')) {
				return false;
			}
			var view_gbn = $(":input:radio[name=view_gbn]:checked").val();
			var data = '&state=C' + '&menu_cd=' + $('#menu_cd').val() + '&test_req_seq=' + selrow.test_req_seq + "&pageType=&result_input_type=C85001&view_gbn="+view_gbn;
			var json = fnAjaxAction('analysis/completeResultInput.lims', data);
			if (json == null) {
				alert("error");
			} else if (json == 0 || json == 1) {
				$('#reqListGrid').jqGrid("delRowData", rowId);

				$('#resultForm').find('input').each(function(index, entry) {
					if ($(this).attr('id') != 'user_id') {
						$(this).val('');
					}
				});
				$('#inputSampleForm').find('label').text('');
				$('#inputSampleForm').find('#test_sample_seq').find('option').remove();
				$('#resultGrid').clearGridData();
				$('#inputItemGrid').clearGridData();
				
				if (json == 1) {
					$("#dialog").dialog({
						buttons : [ {
							text : "확인",
							click : function() {
								$(this).dialog("close");
							}
						} ]
					});
				} else {
					alert('선택된 의뢰의 결과입력이 완료되었습니다.');
				}
			} else {
				alert(json);
			}
		}
	}

	 
	// 기준값 조회
	function fn_selectOriginalSTD(grid, rowId) {
		var url = 'analysis/selectOriginalSTD.lims';
		var row = $('#' + grid).getRowData(rowId);
		var data = 'test_std_no=' + row.test_std_no;
		data += '&test_item_cd=' + row.test_item_cd;
		$.ajax({
			url : url,
			type : 'post',
			dataType : 'json',
			async : false,
			data : data,
			success : function(json) {
				if (json.length > 0) {
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
						$('#' + grid).jqGrid('setCell', rowId, 'std_val', entry["std_val"]);
					});
				}
			},
			error : function() {
				alert('fn_selectOriginalSTD error');
			}
		});
	}
	function fn_Get_Sample(test_req_seq) {
		fnSelectSampleComboForm('inputSampleForm', 'test_sample_seq', test_req_seq, 'user');
	}

	function btn_show_return_comment() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('의뢰를 선택해주세요.');
		} else {
			var obj = new Object();
			obj.msg1 = 'showReturnComment.lims';
			obj.test_req_no = rowId;
			obj.type = 'show';
			fnShowModalWindow("popMain.lims", obj, 900, 600);
		}
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
	
	// 시험방법 선택 팝업 콜백
	function fnpop_methodCallback(rowId,test_method_nm,test_method_no){
		if(rowId=="" || rowId==null){
			$("#test_method_nm").val(test_method_nm);
			$("#test_method_no").val(test_method_no);
			
		}
		else{
		fnBasicEndLoading();
		var grid = 'resultGrid';		
		fnEditRelease(grid);
		$('#' + grid).jqGrid('setCell', rowId, 'chk', 'Yes');
		}
	}
	
	// 계산식 선택 팝업 콜백
	function fnpop_formula_callback(grid, gridRowId, formula_no, formula_disp, average, arrResult){
		fnBasicEndLoading();
		
		$("#"+grid).setCell(gridRowId, "formula_no", formula_no);
		$("#"+grid).setCell(gridRowId, "formula_disp", formula_disp);
		$("#"+grid).setCell(gridRowId, "result_cd", average);
		$("#"+grid).setCell(gridRowId, "result_val", average);
		$("#"+grid).setCell(gridRowId, "report_disp_val", average);
		$("#"+grid).setCell(gridRowId, "formula_result_disp", arrResult.join('/'));
		
		fn_editable(grid, gridRowId);
		fnGridEdit(grid, gridRowId, fn_Result_Row_Click(gridRowId));

		var val = $('#'+grid).find('#' + gridRowId + '_result_val').val();
		if (val.length == 2 && val.indexOf('.') != 1 && parseFloat(val) == 0) {
			$('#'+grid).find('#' + gridRowId + '_result_val').val(parseFloat(val));
		}
		if (val != '' && !fnIsNumeric(val)) {
			$(this).val(val.substring(0, val.length - 1));
		} else if (val.indexOf('.') != val.lastIndexOf('.')) {
			$(this).val(val.substring(0, val.length - 1));
		}
		fn_numerical_result(grid, gridRowId);	
		fnEditRelease(grid);
	}
	
	//설명 : 진행상태변경		 
	function fn_set_state(obj) {
		$('#resultForm').find('#state').val($(obj).val());
		if($(obj).val() == 'C'){
			$('#reqListForm').find('#btn_Complete').hide();
		}
		select_state = $(obj).val();
	}

	function commonReqGrid_rowClick(rowId){
		$('#resultForm').find('#test_req_seq').val(rowId);
		$('#inputItemGrid').trigger('reloadGrid');
		$('#resultGrid').clearGridData();

		var row = $('#reqListGrid').getRowData(rowId);
		$('#resultForm').find('#temp_min').val(row.temp_min);
		$('#resultForm').find('#temp_max').val(row.temp_max);
		$('#resultForm').find('#hum_min').val(row.hum_min);
		$('#resultForm').find('#hum_max').val(row.hum_max);
		$('#resultForm').find('#view_gbn').val($(":input:radio[name=view_gbn]:checked").val());
	}
	
	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}
	function testPopUp(){
		fnpop_testMethodPop("resultGrid","900","500","input");
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
						<!-- 
						<span class="button white mlargeb auth_select" id="rowdata" onclick="btn_RDMS_Viewer(3);">
							<button type="button">RAWDATA</button>
						</span>
						 -->
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Complete" onclick="btn_Complete_onclick();">
							<button type="button">결과입력완료</button>
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
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqListForm", "750", "550", "결과입력")'>
					</td>
					<th>의뢰자</th>
					<td>
						<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
					</td>
					<th>시험완료예정일</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
				<tr>
					<th>시험부서</th>
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
				<tr>
					<th>담당자구분</th>
					<td colspan="5">
						<label><input type='radio' id="view_gbn" name='view_gbn' value='A' style="width: 20px" checked="checked" />${loginUser }</label> 
						<label><input type='radio' id="view_gbn" name='view_gbn' value='B' style="width: 20px" />전체</label>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="result_input_type" name="result_input_type" value="C85001" />
		<div id="view_grid_main">
			<table id="reqListGrid"></table>
		</div>
	</form>
</div>
<div>
	<form id="resultForm" name="resultForm" onsubmit="return false;">
		<div class="sub_blue_01" style="width: 15%; float: left;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="100%" class="table_title">
						<span>■</span>
						항목목록
					</td>
				</tr>
			</table>
			<div id="view_grid_sub1">
				<table id="inputItemGrid"></table>
			</div>
		</div>
		<div class="sub_blue_01" style="margin-left: 3%; width: 82%; float: left;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="50%" class="table_title">
						<span>■</span>
						결과목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlarger auth_select" id="returnChoiceBtn" onclick="btn_show_return_comment();" style="display: none;">
							<button type="button">반려사유 보기</button>
						</span>
						<span class="button white mlarger auth_save" id="btn_NoResult" onclick="btn_NoResult_onclick(1);">
							<button type="button">결과값없음처리</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Num_Show" onclick="fn_visible_column('resultGrid',1);">
							<button type="button">수치형기준 보기</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Choice_Show" onclick="fn_visible_column('resultGrid',0);">
							<button type="button">선택형기준 보기</button>
						</span>
						<span class="button white mlargeb auth_save" id="btn_Save" onclick="btn_Save_onclick();">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" class="list_table" >
				<tr>
					<th>시험환경</th>
					<td>
						온도 : ( <input name="temp_min" id="temp_min" type="text" class="w20px" maxlength="3"/>±
						<input name="temp_max" id="temp_max" type="text" class="w20px" maxlength="3"/> ) ℃,
						습도 : ( <input name="hum_min" id="hum_min" type="text" class="w20px" maxlength="3"/>±
						<input name="hum_max" id="hum_max" type="text" class="w20px" maxlength="3"/>) % R.H
					</td>
				</tr>
				<tr>
					<th>분석의견</th>
					<td style="padding:5px;">
						<textarea id="test_cmt" name="test_cmt" rows="3" class="w100p"></textarea>
					</td>
				</tr>
			</table>
			<input type="hidden" name="test_req_seq" id="test_req_seq" />
			<input type="hidden" id="test_item_cd" name="test_item_cd">
			<input type="hidden" id="state" name="state" value="B">
			<input type="hidden" id="result_input_type" name="result_input_type" value="C85001">
			<input type="hidden" id="view_gbn" name="view_gbn">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub2">
				<table id="resultGrid"></table>
			</div>
		</div>
	</form>
</div>

<div class="sub_purple_01 w100p">
	<form id="resultDetailForm" name="resultDetailForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					수동 일괄입력
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_select" id="btn_insertItemVal" onclick="btn_insertItemVal_onclick(1);">
						<button type="button">결과일괄입력</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_insertItemVal2" onclick="btn_insertItemVal_onclick(2);">
						<button type="button">단위일괄입력</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_insertItemVal3" onclick="btn_insertItemVal_onclick(3);">
						<button type="button">시험방법일괄입력</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_insertItemVal4" onclick="btn_insertItemVal_onclick(4);">
						<button type="button">표기자리일괄입력</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_insertItemVal5" onclick="btn_insertItemVal_onclick(5);">
						<button type="button">지연사유일괄입력</button>
					</span>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table">
			<tr>
				<th>결과값</th>
				<td>
					<input name="result_val" id="result_val" type="text" class="w100px" />
				</td>
				<th>성적서표기값</th>
				<td>
					<input name="report_disp_val" id="report_disp_val" type="text" class="w100px" />
				</td>
				<th>결과판정</th>
				<td>
					<select name="jdg_type" id="jdg_type" class="w100px"></select>
				</td>
			</tr>
			<tr>
				<th>단위</th>
				<td >
					<select name="unit" id="unit" class="w100px"></select>
				</td>
				<th>시험방법</th>
				<td>
					<input type="hidden" name='test_method_no' id="test_method_no" class="w200px">
					<input name="test_method_nm" id="test_method_nm" class="w200px"/><img style="width: 16px;" src="images/common/icon_search.png" onclick="testPopUp()" class="auth_select">					
				</td>
				<th>표기자리</th>
				<td>
					<input name="valid_position" id="valid_position" type="text" class="w100px" />
				</td>
			</tr>
			<tr>
			    <th>지연사유</th>
				<td colspan='5'>
					<input name="exceed_reason" id="exceed_reason" type="text" style="width:400px" />
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="dialog" style="display: none;">
	<label>결과입력이 완료되었습니다.</label>
	<br>
	<label>결재선을 지정하여 상신해 주세요</label>
</div>