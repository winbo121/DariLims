
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 결과입력(등급별)
	 * 파일명 		: resultInputGradeL01.jsp
	 * 작성자 		: 송성수
	 * 작성일 		: 2019.11.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.26     송성수		최초 프로그램 작성         
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
	var grade_range;
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
		ajaxComboForm("jdg_type", "C76", "", "", "resultDetailForm");
		ajaxComboForm("unit", "C08", "", "", "resultDetailForm");

		result_type = fnGridCommonCombo('C31', null);
		unit = fnGridCommonCombo('C08', null);
		jdg_type = fnGridCommonCombo('C76', null);
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);
		grade_range = fnGridCommonCombo('C81', 'All');
		
		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		commonReqGrid('analysis/selectResultReqList.lims?commission_flag='+$("#commission_flag").val(), 'reqListForm', 'reqListGrid', true);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		testSampleGrid('analysis/selectSampleList.lims', 'resultForm', 'inputItemGrid');
		resultGrid('analysis/selectResultSampleGradeList.lims', 'resultForm', 'resultGrid');
		
		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		fn_set_state($('#reqListForm').find('#state option:selected'));
		
		$("input[name=view_gbn]").change(function() {
			btn_Select_onclick();
		});
	});

	function testSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '435',
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
				width : '150'
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
			height : '325',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			sortable:true,
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
				label : '담당자',
				name : 'tester_nm',
				sortable : false,
				width : '55'
			}, {
				label : '시험자',
				name : 'real_tester_nm',
				sortable : false,
				width : '55'
			}, {
				label : '시험항목',
				name : 'test_item_nm',
				sortable : true,
				width : '160'
			}, {
				label : '기준유형',
				name : 'std_type',
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
				editable : false,
				edittype : "select",
				editoptions : {
					value : result_type
				},
				formatter : 'select'
			}, {
				type : 'not',
				label : '항목유형',
				name : 'test_item_type',
				sortable : false,
				width : '220',
				hidden : true
			},  {
				label : 'result_cd',
				name : 'result_cd',
				hidden : true
			}, {
				label : '결과값',
				editable : true,
				classes : 'result_val',
				name : 'result_val',
				align : 'right',
				width : '80'
			}, {
				label : '성적서표기값',
				name : 'report_disp_val',
				classes : 'report_disp_val',
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
				label : '적용계산식',
				name : 'formula_disp',
				classes : 'formula_disp',
				width : '200'
			}, {
				type : 'not',
				label : ' ',
				name : 'formula_pop',
				sortable : true,
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
				label : 'formula_no(숨김)',
				name : 'formula_no',
				classes : 'formula_no',
				hidden : true
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
			}, {
				label : '등급1',
				name : 'grade1_nm',
				sortable : false,
				align : 'center',
				width : '75'
			}, {
				label : '등급2',
				name : 'grade2_nm',
				sortable : false,
				align : 'center',
				width : '75'
			}, {
				label : '등급3',
				name : 'grade3_nm',
				sortable : false,
				align : 'center',
				width : '75'
			}, {
				label : '등급4',
				name : 'grade4_nm',
				sortable : false,
				align : 'center',
				width : '75'
			}, {
				label : '표기자리',
				name : 'valid_position',
				classes : 'valid_position',
				sortable : false,
				width : '60',
				align : 'right'
			}, {
				label : '등급1 값',
				name : 'grade1',
				sortable : false,
				align : 'center',
				width : '75',
				hidden : true
			}, {
				label : '등급1 범위',
				name : 'grade1_range',
				sortable : false,
				align : 'center',
				width : '75',
				editable : false,
				edittype : "select",
				editoptions : {
					value : grade_range
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '등급2 값',
				name : 'grade2',
				sortable : false,
				align : 'center',
				width : '75',
				hidden : true
			}, {
				label : '등급2 범위',
				name : 'grade2_range',
				sortable : false,
				align : 'center',
				width : '75',
				editable : false,
				edittype : "select",
				editoptions : {
					value : grade_range
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '등급3 값',
				name : 'grade3',
				sortable : false,
				align : 'center',
				width : '75',
				hidden : true
			}, {
				label : '등급3 범위',
				name : 'grade3_range',
				sortable : false,
				align : 'center',
				width : '75',
				editable : false,
				edittype : "select",
				editoptions : {
					value : grade_range
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '등급4 값',
				name : 'grade4',
				sortable : false,
				align : 'center',
				width : '75',
				hidden : true
			}, {
				label : '등급4 범위',
				name : 'grade4_range',
				sortable : false,
				align : 'center',
				width : '75',
				editable : false,
				edittype : "select",
				editoptions : {
					value : grade_range
				},
				formatter : 'select',
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
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
				if(select_state == 'B'){
					fn_Result_ondblClickRow(grid, rowId, iCol);
					$('#'+grid).find('#' + rowId + '_jdg_type option[value=C37004]').remove(); // 문서확인함 숨김
					$('#'+grid).find('#' + rowId + '_result_type option[value=C31001]').remove(); // 선택형 숨김
					$('#'+grid).find('#' + rowId + '_result_type option[value=C31002]').remove(); // 수치형 숨김
					$('#'+grid).find('#' + rowId + '_result_type option[value=C31003]').remove(); // 서술형 숨김
				} else {
					alert("결과입력가능 상태가 아닙니다.");
					return false;
				}
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				fn_Result_afterInsertRow(grid, rowId);
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'grade1_nm',
				numberOfColumns : 5,
				titleText : '등급기준(VIEW)'
			}, {
				startColumnName : 'grade1',
				numberOfColumns : 8,
				titleText : '등급기준(MODIFY)'
			}, {
				startColumnName : 'formula_disp',
				numberOfColumns : 5,
				titleText : '적용계산식'
			}, {
				startColumnName : 'test_method_no',
				numberOfColumns : 4,
				titleText : '시험방법'
			}, {
				startColumnName : 'result_val',
				numberOfColumns : 3,
				titleText : '결과'
			}]
		});

		$('#' + grid).bind("jqGridInlineAfterRestoreRow", function(e, rowId, orgClickEvent) {
			var row = $('#' + grid).getRowData(rowId);
			$('#' + grid).jqGrid('setCell', rowId, 'result_cd', row.result_val);
			return e.result === undefined ? true : e.result;
		});
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
	
	// 각각 ROW에 첨부파일 다운로드 링크 걸기
	function displayAlink(cellvalue, options, rowObject) {
		var edit;
		if (rowObject.file_nm == undefined)
			edit = '<label></label>';
		else
			edit = "<label><a href='analysis/reportDown.lims?att_seq=" + rowObject.att_seq + "'>" + rowObject.file_nm + "</a></label>";
		return edit;
	}
	
	// 조회
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
		$('#inputItemGrid').clearGridData();
		$('#resultGrid').clearGridData();
		
		$('#resultForm').find('#result_input_type').val("C85002");
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
				
				//현재 일자가 체크된 항목의 처리기한을 넘겼다면 사유를 필수 입력하도록 합니다. 시작
				matchedReqRowId = reqGridIds.filter(function (id) {
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
				
				//fn_editable(grid, ids[i]);
				
				if ($.trim(row.result_cd) == '') {
					alert(row.test_item_nm + '\n항목의 결과값을 입력해주세요.');
					fnGridEdit(grid, ids[i], fn_Result_Row_Click);
					$("#" + ids[i] + "_result_val").focus();
					return false;
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
						'&test_req_seq=' + $('#reqListGrid').getGridParam('selrow') +
						'&test_sample_seq=' + $('#resultForm').find('#test_sample_seq').val() +
						'&menu_cd=' + $('#menu_cd').val();
			var json = fnAjaxAction('analysis/updateItemResult.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 항목의 저장이 완료되었습니다.');
				$('#resultGrid').trigger('reloadGrid');
			}
		}
	}
	
	// 결과입력완료 버튼 이벤트
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
			var data = '&state=C' + '&menu_cd=' + $('#menu_cd').val() + '&test_req_seq=' + selrow.test_req_seq + "&pageType=&result_input_type=C85002&view_gbn="+view_gbn;
			var json = fnAjaxAction('analysis/completeResultInput.lims', data);
			if (json == null) {
				alert("error");
			} else if (json == 0 || json == 1) {

				$('#reqListGrid').jqGrid("delRowData", rowId);

				$('#resultForm').find('input').each(function(index, entry) {
					if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'state') {
						$(this).val('');
					}
				});

				$('#inputItemGrid').clearGridData();
				$('#resultGrid').clearGridData();

				if (json == 1) {
					$("#dialog").dialog({
						buttons : [ {
							text : "확인",
							click : function() {
								$('#dialog').dialog("destroy");
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
					$('#' + grid).jqGrid('setCell', rowId, 'std_val', entry["std_val"]);
				});
			},
			error : function() {
				alert('fn_selectOriginalSTD error');
			}
		});
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
	
	// 콜백
	function fn_callback(){
		$('#reqListGrid').trigger('reloadGrid');
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'dept_cd') {
				$(this).val('');
			}
		});
		$('#inputItemGrid').clearGridData();
		$('#resultGrid').clearGridData();
		fnBasicEndLoading();
	}
	
	// 의뢰정보 팝업
	function fnpop_reqInfo(grid) { //btn_pop_req_info
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			fnBasicStartLoading();
			fnpop_reqInfoPop(grid, "900" , "660" , 'reloadGrid', rowId, true);
			
		}
	}

	// 진행상황 팝업
	function fnpop_stateInfo() {
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
	function fnpop_reqResultInfo() { 
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
		fn_grade_result(grid, gridRowId);	
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
	
	// 계산식적용 버튼		 
	function fnpop_account() {
		var rowId = $('#resultGrid').getGridParam('selrow');
 		if (rowId == null) {
 			alert('선택된 행이 없습니다.');
 			return false;
		} else {
			var row = $('#resultGrid').getRowData(rowId);
			if(fnIsEmpty(row.test_method_no)){
				alert("시험방법이 입력되지않아 계산식을 적용할 수 없습니다.\n시험방법을 선택해주세요.");
				return;
			}
			
			var json = fnAjaxAction('master/checkAccount.lims', "test_method_no=" + row.test_method_no);
			if (json == null) {
				alert('계산식조회시 에러가 발생하였습니다.');
			} else {
				
				if(json == "0"){
					alert("등록된 계산식이 없습니다.");
					return;
				}else{
					fnBasicStartLoading();
					fnpop_accountPop("resultGrid", "900", "860", rowId, row.test_method_no, row.test_item_cd, row.test_sample_seq);
				}
			}
 		}
	}
	// 시험방법 선택 팝업 콜백
	function fnpop_methodCallback(rowId,test_method_nm,test_method_no){
		if(rowId=="" || rowId==null){
			$("#test_method_nm").val(test_method_nm)
			$("#test_method_no").val(test_method_no);
			
		}
		else{
		fnBasicEndLoading();
		var grid = 'resultGrid';		
		fnEditRelease(grid);
		$('#' + grid).jqGrid('setCell', rowId, 'chk', 'Yes');
		}
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
	function testPopUp(){
		fnpop_testMethodPop("resultGrid","900","500","input");
	}
</script>
<div>
	<input type="hidden" id="pageType" value="${pageType }">
	<form id="reqListForm" name="reqListForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table class="select_table" >
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
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqListForm", "750", "550", "결과입력")' />
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
		<input type="hidden" id="result_input_type" name="result_input_type" value="C85002">
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
		<div class="sub_blue_01" style="margin-left: 3%; width: 82%; float: left;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="50%" class="table_title">
						<span>■</span>
						시험결과
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlarger auth_select" id="returnChoiceBtn" onclick="btn_show_return_comment();" style="display: none;">
							<button type="button">반려사유 보기</button>
						</span>
						<span class="button white mlarger auth_save" id="btn_NoResult" onclick="btn_NoResult_onclick(2);">
							<button type="button">결과값없음처리</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Grade_Show" onclick="fn_visible_column('resultGrid',2);">
							<button type="button">등급별기준 보기</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
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
			<input type="hidden" id="user_id" name="user_id" value="${session.user_id }" />
			<input type="hidden" id="test_req_seq" name="test_req_seq" />
			<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
			<input type="hidden" name="test_std_no" id="test_std_no"/>
			<input type="hidden" id="state" name="state" value="B">
			<input type="hidden" id="view_gbn" name="view_gbn">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<input type="hidden" id="result_input_type" name="result_input_type" value="C85002">
			<div id="view_grid_sub1">
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
					<span class="button white mlargeb auth_select" id="btn_insertItemVal3" onclick="btn_insertItemVal_onclick(3);">
						<button type="button">시험방법일괄입력</button>
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
			<th>시험방법</th>
				<td>
					<input type="hidden" name='test_method_no' id="test_method_no" class="w200px">
					<input name="test_method_nm" id="test_method_nm" class="w200px"/><img style="width: 16px;" src="images/common/icon_search.png" onclick="testPopUp()" class="auth_select">					
				</td>
				<th>지연사유</th>
				<td colspan="3">
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



