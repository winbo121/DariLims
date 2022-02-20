
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험결과확인
	 * 파일명 		: resultCheckL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.26    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
#JdgUpdateDiv {
	background-color: white;
	border: 2px;
	border-radius: 8px;
	border-style: solid;
	border-color: #b27ce0;
	width: 510px;
	position: absolute;
	padding-bottom: 15px;
	z-index:2000;
}
</style>
<script type="text/javascript">
	var result_type;
	var unit;
	var jdg_type;
	var jdg_type_grade;
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
		
		$('#JdgUpdateDiv').hide();
		$('#jdg_etc').hide();
		$('#btn_ApprLine').hide();
		$('#approvalLine').hide();
		
		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "ALL", "ALLNAME", 'reqListForm');
		
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');

		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		commonReqGrid('analysis/selectCheckReqList.lims', 'reqListForm', 'reqListGrid', true);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		result_type = fnGridCommonCombo('C31', 'NON');
		unit = fnGridCommonCombo('C08', null);
		jdg_type_grade = fnGridCommonCombo('C76', 'NON');
		jdg_type = fnGridCommonCombo('C37', 'NON');
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);
		

		ajaxComboForm("jdg_type", "C37", "NON", "", "inputSampleForm");
		
		testSampleGrid('analysis/selectSampleList.lims', 'resultForm', 'inputItemGrid');
		
		itemGrid('analysis/selectResultSampleList.lims', 'resultForm', 'resultGrid');
		
		// 시료별 성적서 리스트
		sampleReportListGrid('analysis/selectsampleReportList.lims', 'sampleReportListForm', 'sampleReportListGrid');
		
		// 시료 판정값 변경
		$('#JdgUpdateDiv').find("#jdg_type").change(function() {
			if( $('#JdgUpdateDiv').find('#jdg_type option:selected').val() == 'C37006'){
				//$('#jdg_etc').val('');
				$('#jdg_etc').show();
			}
		});

		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_main').width()*.600);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#sampleReportListGrid").setGridWidth($('#view_grid_main').width()*.350);
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
			shrinkToFit : true,
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
				label : '진행상태',
				name : 'state',
				width : '100',
				align : 'center'
			}, {
				label : '시료유형',
				name : 'sample_nm',
				width : '100'
			}, {
				label : '검사기준',
				name : 'test_std_nm',
				width : '100'
			}, {
				label : '시료판정',
				name : 'test_sample_result_nm',
				width : '150'
			}, {
				label : '시료판정코드',
				name : 'test_sample_result_cd',
				hidden : true
			}, {
				type : 'not',
				label : ' ',
				name : 'test_judge_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				label : '판정수정사유',
				name : 'test_sample_result_reason',
				width : '150'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var row = $('#' + grid).getRowData(rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				if (col == 'test_judge_pop'){
					$('#inputSampleForm').find('#test_sample_seq').val(row.test_sample_seq);
					$('#inputSampleForm').find('#jdg_type').val(row.test_sample_result_cd);
					$('#inputSampleForm').find('#test_sample_result_reason').text('');
					$('#inputSampleForm').find('#jdg_etc').text('');
					btn_JdgUpdate_onclick(0);
				}				
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
	function itemGrid(url, form, grid) {
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
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [ {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true
			}, {
				index : 'not',
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				index : 'not',
				label : 'colla_flag',
				name : 'colla_flag',
				hidden : true
			}, {
				index : 'not',
				label : '시험항목',
				name : 'test_item_nm',
				width : '180'
			}, {
				index : 'not',
				label : '항목유형',
				name : 'test_item_type',
				width : '220',
				hidden : true
			}, {
				index : 'not',
				label : '기준값',
				name : 'std_val',
				width : '110'
			}, {
				index : 'not',
				label : '단위',
				name : 'unit',
				edittype : "select",
				editoptions : {
					value : unit
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : 'BASE',
				name : 'base1',
				width : '80',
				align : 'right'
			}, {
				index : 'not',
				label : '표기자리',
				name : 'valid_position',
				width : '100',
				align : 'right'
			}, {
				index : 'not',
				label : '결과값',
				name : 'result_val',
				align : 'right',
				width : '100'
			}, {
				index : 'not',
				label : '성적서표기값',
				name : 'report_disp_val',
				align : 'right'
			}, {
				index : 'not',
				label : '등급판정',
				name : 'jdg_type_grade',
				align : 'right',
 				edittype : "select",
				editoptions : {
					value : jdg_type_grade
				},
				formatter : 'select' 
			}, {
				index : 'not',
				label : '결과판정',
				name : 'jdg_type',
				align : 'right',
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
				label : '계산결과내역',
				name : 'formula_result_disp',
				width : '150',
			}, {
				index : 'not',
				label : 'inst_no',
				name : 'inst_no',
				hidden : true
			}, {
				index : 'not',
				label : '시험기기',
				name : 'inst_kor_nm'
			}, {
				index : 'not',
				label : 'test_method_no',
				name : 'test_method_no',
				hidden : true
			}, {
				index : 'not',
				label : '시험방법',
				name : 'test_method_nm'
			}, {
				label : '성적서 표시 여부',
				name : 'report_flag',
				width : '200',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Y:표시함;N:표시안함'
				},
				formatter : 'select'
			}, {
				type : 'not',
				label : '첨부문서',
				name : 'file_nm',
				formatter : displayAlink			
			}, {
				label : 'att_seq',
				name : 'att_seq',
				hidden : true
			}, {
				index : 'not',
				label : '상태',
				name : 'state'
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
				index : 'not',
				label : '기준',
				name : 'std_type',
				align : 'center',
				width : '100',
				edittype : "select",
				editoptions : {
					value : std_type
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : '결과유형',
				name : 'result_type',
				align : 'center',
				width : '120',
				edittype : "select",
				editoptions : {
					value : result_type
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : '기준하한',
				name : 'std_lval',
				align : 'right',
				width : '60',
				hidden : true
			}, {
				index : 'not',
				label : '하한구분',
				name : 'lval_type',
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : lval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				index : 'not',
				label : '기준상한',
				name : 'std_hval',
				align : 'right',
				width : '60',
				hidden : true
			}, {
				index : 'not',
				label : '상한구분',
				name : 'hval_type',
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : hval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				index : 'not',
				label : '정량상한',
				name : 'loq_hval',
				align : 'right',
				width : '60',
				hidden : true
			}, {
				index : 'not',
				label : '기준적합값',
				name : 'std_fit_val',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				index : 'not',
				label : '기준부적합값',
				name : 'std_unfit_val',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '담당자',
				name : 'tester_nm',
				sortable : false,
				width : '100'
			}, {
				label : '시험자',
				name : 'real_tester_nm',
				sortable : false,
				width : '100'
			}, {
				index : 'not',
				label : '진행상태',
				name : 'state',
				width : '150',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				fn_change_color(grid, rowId);
			}
		});
		fn_Result_setGroupHeaders2(grid);
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
			shrinkToFit : true,
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
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
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

	// 조회
	function btn_Select_onclick() {
		var state = $('#reqListForm').find('#state').val();
		if (state == 'O' || state == 'D') {
			$('#btn_Return').hide();
			$('#btn_Cancel').show();
			$('#btn_Complete').hide();
		} else {
			$('#btn_Return').show();
			$('#btn_Cancel').hide();
			$('#btn_Complete').show();
		}
		$('#reqListGrid').trigger('reloadGrid');
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'dept_cd') {
				$(this).val('');
			}
		});
		$('#inputItemGrid').clearGridData();
		$('#resultGrid').clearGridData();
	}
	
	// 결재선 지정 팝업
	function fnpop_apprLine(grid) {
		var obj = new Object();
		obj.msg1 = 'analysis/approvalLine.lims';
		obj.type = '${type}';
		var ret = 'reloadGrid';
		
		fnBasicStartLoading();
		fnpop_apprLinePop(grid, "1200" , "730" , 'reqListGrid', obj, true);
	}

	function btn_Complete_onclick() {
		var data = "";
		var rowId = $('#reqListGrid').getGridParam('selrow');
		var row = $('#reqListGrid').getRowData(rowId);
		if (rowId == null) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}
		if ('${type}' == 'dept') {
			if (row.supv_dept_cd != '${session.dept_cd}') {
				alert('본인 부서건만 결과확인 하실 수 있습니다.');
				return false;
			}
			data += 'state=O';
		} else {
			data += 'state=F';
			data += '&test_dept_cd=${session.dept_cd}'
		}

		if(row.state != 'C'){
			alert('결과입력완료된 의뢰가 아닙니다.');
			return false;	
		}
		
		if (!confirm('선택한 의뢰의 결과확인을 완료하시겠습니까?')) {
			return false;
		}

		data += '&test_req_seq=' + rowId;
		data += '&appr_mst_seq=' + $('#reqListForm').find('#appr_mst_seq').val() + '&menu_cd=' + $('#menu_cd').val();
		var json = fnAjaxAction('analysis/completeResultCheck.lims', data);
		if (json == null) {
			alert('error');
		} else {
			alert('선택된 의뢰가 시험완료되었습니다.');
			$('#reqListGrid').trigger('reloadGrid');

			$('#resultForm').find('input').each(function(index, entry) {
				if ($(this).attr('id') != 'dept_cd') {
					$(this).val('');
				}
			});
			$('#inputItemGrid').clearGridData();
			$('#resultGrid').clearGridData();
		}
	}
	
	function btn_Cancel_onclick() {
		var data = "";
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}
		if ('${type}' == 'dept') {
			var row = $('#reqListGrid').getRowData(rowId);
			if (row.supv_dept_cd != '${session.dept_cd}') {
				alert('본인 부서건만 회수하실 수 있습니다.');
				return false;
			}
			data += 'state=O';
		} else {
			data += 'state=D';
			data += '&test_dept_cd=${session.dept_cd}'
		}

		if (!confirm('선택한 의뢰를 회수하시겠습니까?')) {
			return false;
		}

		data += '&test_req_seq=' + rowId + '&menu_cd=' + $('#menu_cd').val();
		var json = fnAjaxAction('analysis/cancelResultCheck.lims', data);
		if (json == null) {
			alert('error');
		} else {
			alert('선택된 의뢰를 회수 완료되었습니다.');
			$('#reqListGrid').trigger('reloadGrid');

			$('#resultForm').find('input').each(function(index, entry) {
				if ($(this).attr('id') != 'dept_cd') {
					$(this).val('');
				}
			});
			$('#inputItemGrid').clearGridData();
			$('#resultGrid').clearGridData();
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
		btn_Select_onclick();
	}
	
	// 반려팝업 콜백
	function fnpop_return_callback(){
		$('#resultGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}	
	
	// 시료판정 수정
	function btn_JdgUpdate_onclick(state) {		
		var sampleSeq = $('#inputSampleForm').find('#test_sample_seq').val();
		if(sampleSeq == '' || sampleSeq == null){			
			$.showAlert("시료가 선택되지 않았습니다.");
			return false;
		}else{
			if(state == '0'){
				$('#JdgUpdateDiv').css("top", ($(window).height() / 2.5) - ($('#JdgUpdateDiv').outerHeight() / 2));
				$('#JdgUpdateDiv').css("left", ($(window).width() / 2) - ($('#JdgUpdateDiv').outerWidth() / 2));
				$('#JdgUpdateDiv').show();
				fnBasicStartLoading();
			} else {
			var param = $('#inputSampleForm').serialize();
				var json = fnAjaxAction('analysis/updateSampleJdg.lims', param);				
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {type : 'insert'});
					//$('#JdgUpdateDiv').find('#test_sample_result_reason').val('');
					//$('#JdgUpdateDiv').find('#test_sample_seq').val('');
					btn_Close_onclick();
					$('#inputItemGrid').trigger('reloadGrid');
				}
			}
		}		
	}
	
	// 시료판정 수정 div 닫기버튼 이벤트
	function btn_Close_onclick() {
		$('#JdgUpdateDiv').hide();
		fnBasicEndLoading();
	}
	
	// 항목별결과보기
	function fnpop_itemHistory() {
		var rowId = $('#inputItemGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var row = $('#inputItemGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_itemResultHistoryPop('resultForm', '800', '600', row.test_sample_seq);
		}
	}
	

	function btn_Return_onclick() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		
		if (rowId == null) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}
		var row = $('#reqListGrid').getRowData(rowId);
		if(row.state != 'C'){
			alert('결과입력완료된 의뢰가 아닙니다.');
			return false;	
		}
		
		var obj = new Object();
		obj.msg1 = 'showReturnComment.lims';
		obj.test_req_seq = rowId;
		obj.type = '${type}';
		obj.state = 'B';
		fnBasicStartLoading();
		fnpop_return (obj, '900', '630');
		
	}

	function commonReqGrid_rowClick(rowId){
		$('#resultForm').find('#test_req_seq').val(rowId);
		$('#inputItemGrid').trigger('reloadGrid');
		$('#resultGrid').clearGridData();		
	}

	function btn_reqReport_onclick() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId != null) {
			var url = "reqReport02.lims?test_req_seq=" + rowId;
			$('#excelReportForm').attr({action:url, method:'post'}).submit();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
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
						<span class="button white mlargeb auth_save" id="btn_ApprLine" onclick="fnpop_apprLine('reqListGrid')">
							<button type="button">결재선지정</button>
						</span>
						<span class="button white mlarger auth_save" id="btn_Return" onclick="btn_Return_onclick();">
							<button type="button">반려</button>
						</span>
						<span class="button white mlarger auth_save" id="btn_Cancel" onclick="btn_Cancel_onclick();" style="display: none;">
							<button type="button">상신회수</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Complete" onclick="btn_Complete_onclick();">
							<button type="button">시험완료</button>
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
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select"  onclick='fnpop_reqOrgChoice("reqListForm", "750", "550", "결과입력")'/>
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
						<select name="state" id="state" class="w200px">
							<c:if test="${type == 'dept' }">
								<option value="F">시험부서 결과승인완료</option>
								<option value="O">주관부서 결과확인완료</option>
							</c:if>
							<c:if test="${type != 'dept' }">
								<option value="C">결과입력완료</option>
								<option value="F">결과확인완료</option>
								<option value="B">결과입력중</option>
							</c:if>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<div id="approvalLine">
			<table width="100%" border="0" class="select_table"  style="height: 30px;">
				<tr>
					<td>
						<span style="font-size: 14px;">
							<strong>기본결제선 : <input type="text" id="appr_line_nm" name="appr_line_nm" value="${detail.appr_line_nm}" style="border: 0;" readonly="readonly" /></strong>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<c:if test="${type != 'dept' }">
			<input type="hidden" id="test_dept_cd" name="test_dept_cd" value="${session.dept_cd }">
		</c:if>
		<input type="hidden" id="supv_dept_cd" name="supv_dept_cd" value="${session.dept_cd }">
		<input type="hidden" id="appr_mst_seq" name="appr_mst_seq" value="${detail.appr_mst_seq}" />
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
	
	<form id="inputSampleForm" name="inputSampleForm" onsubmit="return false;">
	<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
	<div id='JdgUpdateDiv'>
		<div class="sub_purple_01" style="width: 90%">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						시료판정 수정
					</td>
					<td class="table_button" style="text-align: right;">
						<span class="button white mlargep auth_save" id="btn_Jdg_Update" onclick="btn_JdgUpdate_onclick(1);">
							<button type="button">수정</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Jdg_Update_Close" onclick="btn_Close_onclick();">
							<button type="button">닫기</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table">
				<tr>
					<th>시료 판정</th>
					<td width="30%">
						<select name="jdg_type" id="jdg_type" class="w100px"></select>
						<input type="text" id="jdg_etc" name="jdg_etc" class="w100px" style="display:none;"/>
					</td>
				</tr>
				<tr>
					<th>판정 수정 사유</th>
					<td width="30%">
						<input type="text" id="test_sample_result_reason" name="test_sample_result_reason" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	</form>
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
		<div class="sub_purple_01">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						항목목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="btn_Num_Show" onclick="fn_visible_column('resultGrid',1);">
							<button type="button">수치형기준 보기</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Choice_Show" onclick="fn_visible_column('resultGrid',0);">
							<button type="button">선택형기준 보기</button>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<%-- <c:if test="${type != 'dept'}">
			<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd} " />
		</c:if> --%>
		<input type="hidden" id="dept_cd" name="dept_cd" />
		<input type="hidden" id="test_req_seq" name="test_req_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub3">
			<table id="resultGrid"></table>
		</div>
	</form>
	<form id="excelReportForm" name="excelReportForm"></form>
</div>

<div id="dialog"></div>

