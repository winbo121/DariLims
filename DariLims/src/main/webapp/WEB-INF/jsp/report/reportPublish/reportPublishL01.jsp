
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 성적서발행목록
	 * 파일명 		: reportPublishL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.03.10
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.10    진영민		최초 프로그램 작성         
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
	var result_type;
	var unit;
	var jdg_type;
	var hval_type;
	var lval_type;
	var std_type;
	var fit_val;
	var publish_gbn;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		fnDatePickerImg('report_start_date');
		fnDatePickerImg('report_end_date');
		fnDatePickerImg('deadline_start_date');
		fnDatePickerImg('deadline_end_date');

		ajaxComboForm("test_goal", "C05", "ALL", null, "reportWriteForm");
		ajaxComboForm("report_type", "C15", "ALL", null, "reportWriteForm");
		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reportWriteForm");
		ajaxComboForm("dept_cd", "", "ALL", null, 'reportWriteForm');
		ajaxComboForm("supv_dept_cd", "", "${session.dept_cd }", null, 'reportWriteForm');
		
		result_type = fnGridCommonCombo('C31', 'NON');
		unit = fnGridCommonCombo('C08', null);
		jdg_type = fnGridCommonCombo('C37', null);
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);
		publish_gbn = fnGridCommonCombo('P01', null);
		$('#reportWriteForm').find("#dept_cd").change(function() {
			ajaxComboForm("unit_work_cd", $('#reportWriteForm').find("#dept_cd").val(), "ALL", null, 'reportWriteForm');
		});
		$('#reportWriteForm').find('#endDate').val(fnGetToday(0,0));
		$('#reportWriteForm').find('#startDate').val(fnGetToday(1,0));

		reportPublishGrid('report/selectReportWriteList.lims?commission_flag='+$("#commission_flag").val(), 'reportWriteForm', 'reportPublishGrid');
		reportPublishHistoryGrid('report/selectReportPublishHistoryList.lims', 'reportWriteForm', 'reportPublishHistoryGrid');
		$('#reportPublishGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		$('#reportPublishHistoryGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 항목 결과 리스트
		resultEndGrid('report/selectReportWriteSampleItemList.lims', 'publishForm', 'resultEndGrid');

		// 시료 목록
		reportWriteSampleGrid('report/selectReportWriteSampleList.lims', 'reportWriteSampleForm', 'reportWriteSampleGrid');
		
		// 시료별 성적서 리스트
		sampleReportListGrid('analysis/selectsampleReportList.lims', 'sampleReportListForm', 'sampleReportListGrid');

		fn_Enter_Search('reportWriteForm', 'reportPublishGrid');

		$(window).bind('resize', function() {
			$("#reportPublishGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#reportPublishHistoryGrid").setGridWidth($('#sub_blue_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#reportWriteSampleGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#sampleReportListGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#resultEndGrid").setGridWidth($('#view_grid_sub3').width(), true);
		}).trigger('resize');

	});

	function reportPublishGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '80'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '100',
				align : 'center'
			}, {
				label : '의뢰업체명',
				name : 'req_org_nm'
			}, {
				label : '의뢰자',
				name : 'req_nm',
				width : '60',
				align : 'center'
			}, {
				label : '상태',
				name : 'state',
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'X:성적서발행대기;Y:성적서발행완료'
				},
				formatter : 'select'
			}, 
			{
				label : 'report_file_nm',
				name : 'report_file_nm',
				hidden : true
			}, {
				label : '발행횟수',
				name : 'log_cnt',
				width : '60',
				align : 'center'
			}, {
				label : '작성차수',
				name : 'degree',
				width : '60',
				align : 'center'
			}, {
				label : '성적서번호',
				name : 'report_no',
				width : '100',
				align : 'center'
			}, {
				label : '발행일자',
				name : 'report_last_date',
				width : '80',
				align : 'center'
			}, {
				label : '검증코드',
				name : 'verify_id',
				width : '150',
				align : 'center'
			}, {
				label : '제목',
				name : 'title',
				width : '200'
			}, {
				label : '분리발행여부',
				name : 'separation',
				width : '100',
				align : 'center'
			}, {
				label : '수신처',
				name : 'destination_nm'
			}, {
				label : '우편번호',
				name : 'zip_code',
				width : '60',
				align : 'center'
			}, {
				label : '주소',
				width : '200',
				name : 'req_org_addr'
			}, {
				label : '성적서작성자',
				name : 'user_nm',
				width : '80',
				align : 'center'
			}, {
				label : 'report_make_id',
				name : 'report_make_id',
				hidden : true
			}, {
				label : 'report_sign_id',
				name : 'report_sign_id',
				hidden : true
			}, {
				label : 'report_doc_seq',
				name : 'report_doc_seq',
				hidden : true,
				key : true
			}, {
				label : 'pick_no',
				name : 'pick_no',
				hidden : true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'deadline_date',
				name : 'deadline_date',
				hidden : true
			}, {
				label : 'user_id',
				name : 'user_id',
				hidden : true
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '접수부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : '단위업무',
				name : 'unit_work_cd'
			}, {
				label : '검사목적',
				name : 'test_goal'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#reportWriteForm").find('#report_doc_seq').val(rowId);
				var gridRow = $('#'+grid).getRowData(rowId);
				$("#reportWriteForm").find('#test_req_seq').val(gridRow.test_req_seq);
				$("#reportWriteForm").find('#test_sample_seq').val(gridRow.test_sample_seq);
				$("#reportWriteForm").find('#pick_no').val(gridRow.pick_no);
				$("#reportWriteSampleForm").find('#report_doc_seq').val(rowId);
				$('#reportPublishHistoryGrid').trigger('reloadGrid');
				$('#reportWriteSampleGrid').trigger('reloadGrid');

				$("#publishForm").find('#report_doc_seq').val(rowId);
				$('#publishForm').find('#test_sample_seq').val('');
				$('#resultEndGrid').trigger('reloadGrid'); // 항목리스트

				$('#sampleReportListForm').find('#test_sample_seq').val('');
				$('#sampleReportListGrid').trigger('reloadGrid'); // 시료리스트
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'state',
				numberOfColumns : 13,
				titleText : '성적서정보'
			}, {
				startColumnName : 'dept_nm',
				numberOfColumns : 3,
				titleText : '검사정보'
			}, {
				startColumnName : 'req_type',
				numberOfColumns : 5,
				titleText : '의뢰정보'
			} ]
		});
	}
	
	function reportPublishHistoryGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '262',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '발행구분',
				name : 'publish_gbn',
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : publish_gbn
				},
				formatter : 'select'
			}, 
			{
				label : '성적서번호',
				name : 'report_no',
				hidden : true
			}, {
				label : '성적서발행번호',
				name : 'report_publish_no',
				width : '130'
			}, {
				label : '발행일자',
				name : 'log_date',
				align : 'center',
				width : '130'
			}, {
				label : '출력물명',
				name : 'form_title',
				width : '150'
			}, {
				label : '개정번호',
				name : 'doc_revision_seq',
				align : 'center',
				width : '60'
			}, {
				label : '지연사유',
				name : 'report_exceed_reason',
				align : 'center',
				width : '150'
			}, {
				label : '출력물파일명',
				name : 'form_name',
				hidden : true
			}, {
				label : 'form_seq',
				name : 'form_seq',
				hidden : true
			}, {
				label : 'doc_seq',
				name : 'doc_seq',
				hidden : true
			}, {
				label : 'log_no',
				name : 'log_no',
				hidden : true,
				key : true
			}, {
				label : 'pick_no',
				name : 'pick_no',
				hidden : true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'report_doc_seq',
				name : 'report_doc_seq',
				hidden : true
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : 'user_id',
				name : 'user_id',
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}
	
 	// 시료리스트
 	var lastRowId;
	function reportWriteSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#report_doc_seq').val() != '') {
					fnGridData(url, form, grid);
				} else {
					$('#' + grid).clearGridData();
				}
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료번호',
				name : 'test_sample_seq',
				width : '100',
				align : 'center'
			}, {
				label : '시료명',
				name : 'sample_reg_nm'
			}, {
				label : '시료유형',
				name : 'sample_nm'
			}, {
				label : '접수일자',
				name : 'req_date',
				width : '100',
				align : 'center'
			}, {
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '100',
				align : 'center'
			}, {
				label : '시험기준',
				name : 'test_std_nm',
				width : '200'
			},
			{
				label : '비고',
				name : 'etc_desc'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
				$('#publishForm').find('#test_sample_seq').val($('#reportWriteSampleGrid').getRowData(rowId).test_sample_seq);
				$('#resultEndGrid').trigger('reloadGrid'); // 항목리스트
				
				$('#sampleReportListForm').find('#test_sample_seq').val($('#reportWriteSampleGrid').getRowData(rowId).test_sample_seq);
				$('#sampleReportListGrid').trigger('reloadGrid'); // 시료리스트
			}
		});
	}
	
	// 시료별 성적서 리스트
	var lastRowId;
	function sampleReportListGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '240',
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
			}, 
			{
				label : '첨부 문서명',
				width : '300',
// 				name : 'file_nm'
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

	
	
	// 항목 결과 리스트
	var lastRowId;
	function resultEndGrid(url, form, grid) {
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

			colModel : [			            
			{
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
				label : 'report_doc_seq',
				name : 'report_doc_seq',
				hidden : true
			}, {
				label : 'report_seq',
				name : 'report_seq',
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
			},  {
				index : 'not',
				label : '제외여부',
				name : 'except_flag',
				width : '60',
				align : 'center'
			}, {
				type : 'not',
				label : '시험항목',
				name : 'test_item_nm',
				sortable : false,
				width : '160'
			},  {
				index : 'not',
				label : '기준값',
				name : 'std_val',
				width : '110'
			}, {
				index : 'not',
				label : '단위',
				name : 'unit',
				width : '100'
			}, {
				index : 'not',
				label : '결과값',
				name : 'result_val'				
			}, {
				index : 'not',
				label : '성적서표기값',
				name : 'report_disp_val',
				align : 'right'
			}, {
				index : 'not',
				label : '결과판정',
				name : 'jdg_type',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				fn_Result_afterInsertRow(grid, rowId);
			}
		});
	}

	//각각 ROW에 첨부파일 다운로드 링크 걸기
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
		$('#reportPublishGrid').trigger('reloadGrid');
		$('#reportWriteSampleForm').find('#report_doc_seq').val('');
		$('#reportPublishHistoryGrid').clearGridData();
		$('#reportWriteSampleGrid').clearGridData();
		$('#sampleReportListForm').find('#test_sample_seq').val('');
		$('#publishForm').find('#test_sample_seq').val('');
		$('#sampleReportListGrid').clearGridData();
		$('#resultEndGrid').clearGridData();
	}

	
	// [성적서 발행] 이벤트
	function btn_Publish_onclick(btnGbn) {
		var grid;
		
		if(btnGbn == "P"){
			grid = "reportPublishGrid";
		}else{
			grid = "reportPublishHistoryGrid";
		}
		
		var rowId = $('#'+grid).getGridParam('selrow');
		var gridRow = $('#'+grid).getRowData(rowId);

		if (rowId != null) {
			$("#dialog").dialog({
				width : 700,
				height : 200,
				resizable : false,
				title : '성적서발행 정보',
				modal : true,
				open : function(event, ui) {
					$(".ui-dialog-titlebar-close").hide();
					var data = "test_req_seq=" + gridRow.test_req_seq;
					data += "&viewGbn=PUBLISH";
					data += "&report_doc_seq=" + gridRow.report_doc_seq;
					fnViewPage('report/selectReportDetail.lims', 'dialog', data);
					
					
					if(btnGbn == "P"){
							$('.ui-dialog-buttonpane button:contains("발행")').button().show();
							$('.ui-dialog-buttonpane button:contains("재발행")').button().hide();
					}else{
						$('.ui-dialog-buttonpane button:contains("발행")').button().hide();
						$('.ui-dialog-buttonpane button:contains("재발행")').button().show();
					}
				},
				buttons : [
				{
					text : "미리보기",
					click : function() {
						// 필수 체크
						if(formValidationCheck("reportWritePopForm")){
							return;
						} else {
							if(btnGbn == "P"){
 								var formNm = $("#reportWritePopForm").find("#doc_seq").val();
								var formVersion = $("#reportWritePopForm").find("#doc_seq option:checked").text();
								var form_seq = $("#reportWritePopForm").find("#form_seq").val();
								
								var fileNm = formNm + "_V" + formVersion + ".mrd";

								var test_req_seq = $('#reportWriteForm').find('#test_req_seq').val(); 
								var test_sample_seq = $('#reportWriteForm').find('#test_sample_seq').val();
								var report_doc_seq = $('#reportWriteForm').find('#report_doc_seq').val();
								var pick_no = $('#reportWriteForm').find('#pick_no').val(); 
								
								//바이오고형연료성적서구분
								if(form_seq == "19-025" || form_seq == "19-026"|| form_seq == "19-028"|| form_seq == "19-029"){
									html5Viewer(fileNm, "/rp ["+report_doc_seq+"] ["+pick_no+"] [REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] [REPORT_DOC_SEQ] " , false);
								//목재제품규격품질검사구분
								}else if(form_seq == "19-002" || form_seq == "19-003" || form_seq == "19-004" || form_seq == "19-005" ){
									html5Viewer(fileNm, "/rp ["+report_doc_seq+"]["+test_sample_seq+"][REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] [REPORT_DOC_SEQ]" , false);
									
								}else{
									var reportChk = $("#reportWritePopForm").find("#doc_seq").val().match(/multiplex/);
									var reportChkSingle = $("#reportWritePopForm").find("#doc_seq").val().match(/single/); 
									
									var std_flag = "N";
									if ( form_seq == "19-011" || form_seq == "19-012" || form_seq == "19-019" || form_seq == "19-020" || form_seq == "20-005" ){
									
										std_flag = "Y";
									}
									
									if(reportChk == "multiplex"){
										//공인 - 일반 Mix
										if (form_seq == "20-005"||form_seq == "20-006"){
											if (test_sample_seq.length > 19){
											alert("공인/일반 성적서의 시료는 2개까지 가능합니다.")
												return false;
											} else {
												var arrReportFile = new Array();
												
												arrReportFile[0] = "TestResultKOLAS-multiplexEN_V01.mrd";
												arrReportFile[1] = "TestResult-multiplexEN_V01.mrd";
												
												if(test_sample_seq.length > 1){
													var arr_sample = test_sample_seq.split(',');
													var separation = new Array();
			
													for (i = 1; i <test_sample_seq.length+1; i++ ){
														var add = i;
														separation[i-1]=add;
													}
													html5Viewer3(arrReportFile, report_doc_seq, arr_sample, "REPORT_DOC", "REPORT_SAMPLE", "REPORT_SAMPLE_ITEM", std_flag, "REPORT_DOC_SEQ", separation);
												}
											}
										} else {
											//분리발행
											if(test_sample_seq.length > 9){
												var arr_sample = test_sample_seq.split(',');
												var separation = new Array();
												for (i = 1; i <((test_sample_seq.length+1)/10)+1; i++ ){
													var add = i;
													separation[i-1]=add;
												}
												html5Viewer2(fileNm, report_doc_seq, arr_sample, "REPORT_DOC", "REPORT_SAMPLE", "REPORT_SAMPLE_ITEM", std_flag, "REPORT_DOC_SEQ" ,separation );
											} else {
												var separation = null;
												html5Viewer(fileNm, "/rp ["+report_doc_seq+"]["+test_sample_seq+"][REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] ["+std_flag+"][REPORT_DOC_SEQ]["+separation+"]" , false);
											}
										}
									}
									//단일항목
									if( reportChkSingle == "single"){
										var arr_sample = test_sample_seq.split(',');
										html5Viewer(fileNm, "/rp ["+report_doc_seq+"]["+test_sample_seq+"][REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] ["+std_flag+"][REPORT_DOC_SEQ] " , false);
									}
						
								}
							}else{
								var gridRow = $('#reportPublishHistoryGrid').getRowData(rowId);

								var formNm = gridRow.form_name;
								var formVersion = gridRow.doc_revision_seq;
								var form_seq = gridRow.form_seq;
								
								var fileNm = formNm + "_V" + formVersion + ".mrd";

								var test_req_seq = gridRow.test_req_seq; 
								var test_sample_seq = gridRow.test_sample_seq;
								var report_doc_seq = gridRow.report_doc_seq;
								var pick_no = gridRow.pick_no;
								var report_publish_no = gridRow.report_publish_no;

								//바이오고형연료성적서구분
								if(form_seq == "19-025" || form_seq == "19-026"|| form_seq == "19-028"|| form_seq == "19-029"){
									html5Viewer(fileNm, "/rp ["+report_publish_no+"] ["+pick_no+"] [REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] [REPORT_PUBLISH_NO] " , false);
								//목재제품규격품질검사구분
								}else if(form_seq == "19-002" || form_seq == "19-003" || form_seq == "19-004" || form_seq == "19-005" ){
									html5Viewer(fileNm, "/rp ["+report_publish_no+"] ["+test_sample_seq+"] [REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] [REPORT_PUBLISH_NO]" , false);
									
								}else{
									var reportChk = $("#reportWritePopForm").find("#doc_seq").val().match(/multiplex/);
									var reportChkSingle = $("#reportWritePopForm").find("#doc_seq").val().match(/single/); 
									
									var std_flag = "N";
									if ( form_seq == "19-011" || form_seq == "19-012" || form_seq == "19-019" || form_seq == "19-020" || form_seq == "20-005"){
										std_flag = "Y";
									}
									if(reportChk == "multiplex"){
										//공인 - 일반 Mix
										if (form_seq == "20-005"||form_seq == "20-006"){
											if (test_sample_seq.length > 19){
											alert("공인/일반 성적서의 시료는 2개까지 가능합니다.")
												return false;
											} else {
												var arr_sample = test_sample_seq.split(',');
												var arrReportFile = new Array();
												
												arrReportFile[0] = "TestResultKOLAS-multiplexEN_V01.mrd";
												arrReportFile[1] = "TestResult-multiplexEN_V01.mrd";
												
												if(test_sample_seq.length > 1){
													var arr_sample = test_sample_seq.split(',');
													var separation = new Array();
			
													for (i = 1; i <test_sample_seq.length+1; i++ ){
														var add = i;
														separation[i-1]=add;
													}
													html5Viewer3(arrReportFile, report_publish_no, arr_sample, "REPORT_PUBLISH_LOG", "REPORT_SAMPLE_PL", "REPORT_SAMPLE_ITEM_PL", std_flag, "REPORT_PUBLISH_NO", separation);
												}
											}
										} else {
											//분리발행
											if(test_sample_seq.length > 9){
												var arr_sample = test_sample_seq.split(',');
												var separation = new Array();
												for (i = 1; i <((test_sample_seq.length+1)/10)+1; i++ ){
													var add = i;
													separation[i-1]=add;
												}
												html5Viewer2(fileNm, report_publish_no, arr_sample, "REPORT_PUBLISH_LOG", "REPORT_SAMPLE_PL", "REPORT_SAMPLE_ITEM_PL", std_flag, "REPORT_PUBLISH_NO" ,separation);
											} else {
												var separation = null;
												html5Viewer(fileNm, "/rp ["+report_publish_no+"]["+test_sample_seq+"][REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL]["+std_flag+"][REPORT_PUBLISH_NO]["+separation+"]" , false);
											}
										}
									}
									//단일항목
									if( reportChkSingle == "single"){
										var arr_sample = test_sample_seq.split(',');
										html5Viewer(fileNm, "/rp ["+report_publish_no+"]["+test_sample_seq+"][REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL]["+std_flag+"][REPORT_PUBLISH_NO]" , false);
									}
								}
							}
						}
					}
				},  
				{
					text : "발행",
					click : function() {
						if(formValidationCheck("reportWritePopForm")){
							return;
						}else{
						
 							//처리기한 체크에 사용하는 변수 선언
							var todayNumber = fn_getToday_number();
							var report_exceed_reason = $("#reportWritePopForm").find("#report_exceed_reason").val(); 
							
							//성적서 발행일자를 넘기면 
							if (todayNumber > gridRow.deadline_date && (report_exceed_reason == ''||report_exceed_reason == null)) {
								//사유 필수 입력 체크 
								alert('처리기한이 지난 항목이므로 사유를 작성해야 저장이 가능합니다.');
								return false;
							}
							 
							//fn_Send_Mail_report_onclick('reportPublishGrid', gridRow.report_doc_seq);
							var data = "report_doc_seq=" + gridRow.report_doc_seq;
							data += '&form_seq='+$("#reportWritePopForm").find("#form_seq").val();
							data += '&doc_seq='+$("#reportWritePopForm").find("#form_seq").val()+"-"+$("#reportWritePopForm").find("#doc_seq option:checked").text();
							/* data += '&publish_gbn=P01001' */
							data += '&publish_gbn=P01002'
							data += "&test_req_seq=" + gridRow.test_req_seq
							data += "&report_exceed_reason=" + report_exceed_reason;
							data += "&dept_cd=" + gridRow.dept_cd + "&user_id=" + gridRow.user_id ;
							
							
							var json = fnAjaxAction('report/insertReportPublishLog.lims', data);
							if (json == null) {
								$.showAlert('성적서작성을 실패하였습니다.');
							} else {
								$.showAlert('선택된 시료의 성적서작성이 완료되었습니다.');
							}

							$('#reportPublishGrid').trigger('reloadGrid');
							$('#reportPublishHistoryGrid').clearGridData();
							$('#reportWriteSampleGrid').clearGridData();
							$('#sampleReportListGrid').clearGridData();
							$('#resultEndGrid').clearGridData();
							$('#dialog').dialog("destroy");  
						}
					}
				},
// 				{
// 					text : "수정발행",
// 					click : function() {
// 						if(formValidationCheck("reportWritePopForm")){
// 							return;
// 						}else{
// 							var data = "report_doc_seq=" + gridRow.report_doc_seq;
// 							data += '&form_seq='+$("#reportWritePopForm").find("#form_seq").val();
// 							data += '&doc_seq='+$("#reportWritePopForm").find("#form_seq").val()+"-"+$("#reportWritePopForm").find("#doc_seq option:checked").text();
// 							data += '&publish_gbn=P01002'
							
// 							var json = fnAjaxAction('report/insertReportPublishLog.lims', data);
// 							if (json == null) {
// 								$.showAlert('성적서작성을 실패하였습니다.');
// 							} else {
// 								$.showAlert('선택된 시료의 성적서작성이 완료되었습니다.');
// 							}
// 							$('#reportPublishGrid').trigger('reloadGrid');
// 							$('#reportPublishHistoryGrid').clearGridData();
// 							$('#reportWriteSampleGrid').clearGridData();
// 							$('#sampleReportListGrid').clearGridData();
// 							$('#resultEndGrid').clearGridData();
// 							$('#dialog').dialog("destroy");	
// 						}
// 					}
// 				},
				{
					text : "재발행",
					click : function() {
						if(formValidationCheck("reportWritePopForm")){
							return;
						}else{
							var data = "sec_log_no=" + gridRow.log_no;
							data += '&form_seq='+$("#reportWritePopForm").find("#form_seq").val();
							data += '&doc_seq='+$("#reportWritePopForm").find("#form_seq").val()+"-"+$("#reportWritePopForm").find("#doc_seq option:checked").text();
							data += '&publish_gbn=P01003'
							data += "&report_doc_seq=" + gridRow.report_doc_seq;
							data += "&dept_cd=" + gridRow.dept_cd + "&user_id=" + gridRow.user_id + "&test_req_seq=" + gridRow.test_req_seq ;
							var json = fnAjaxAction('report/insertReportPublishLog.lims', data);
							if (json == null) {
								$.showAlert('성적서작성을 실패하였습니다.');
							} else {
								$.showAlert('선택된 시료의 성적서작성이 완료되었습니다.');
							}
							$('#reportPublishGrid').trigger('reloadGrid');
							$('#reportPublishHistoryGrid').clearGridData();
							$('#reportWriteSampleGrid').clearGridData();
							$('#sampleReportListGrid').clearGridData();
							$('#resultEndGrid').clearGridData();
							$('#dialog').dialog("destroy");	
						}
					}
				},
				{
					text : "취소",
					click : function() {
						$('#dialog').dialog("destroy");
					}
				}]
			});
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	function btn_Delete_onclick() {
		var rowId = $('#reportPublishGrid').getGridParam('selrow');
		if (rowId != null) {
			if (!confirm('성적서를 삭제하시겠습니까.')) {
				
			}else{
				var row = $('#reportPublishGrid').getRowData(rowId);
				if ('${session.user_id}' != row.report_make_id && '${session.user_id}' != row.report_sign_id) {
					$.showAlert('본인이 작성한 건이 아닙니다.');
				} else {
					var json = fnAjaxAction('report/deleteReport.lims', 'report_doc_seq=' + rowId);
					if (json == null) {
						alert('error');
					} else {
						alert('선택된 성적서의 삭제가 완료되었습니다.');
						$('#reportPublishGrid').trigger('reloadGrid');
						$('#reportWriteSampleForm').find('#report_doc_seq').val('');
						$('#reportWriteSampleGrid').trigger('reloadGrid');
						$('#reportWriteSampleForm').find('#test_sample_seq').val('');
						$('#reportWriteSampleGrid').trigger('resultEndGrid');					
						$('#sampleReportListGrid').trigger('resultEndGrid');
					}
				}
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
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
	
	// 엑셀 다운로드
	function btn_Excel_onclick(grid) {
		var data = fn_Excel_Data_Make(grid);
		fn_Excel_Download(data);
	}

	function btn_Save_onclick(){
		if($("#publishForm").find("#report_doc_seq").val()==""||$("#publishForm").find("#test_sample_seq").val()==""){
			alert("먼저 성적서 시료를 선택해야합니다.");			
			return false;
		}

		var grid = 'resultEndGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {		
				c++;
			}
		}

		if (c == 0) {
			alert('선택된 항목이 없습니다.');
		} else {
			param = fnGetGridCheckData("resultEndGrid") + 
				"&report_doc_seq=" + $("#publishForm").find("#report_doc_seq").val() + 
				"&test_sample_seq=" + $("#publishForm").find("#test_sample_seq").val(); 
			var json = fnAjaxAction('report/saveExceptItem.lims', param);
			if (json == null) {
				alert("저장이 실패되었습니다.");			
				return false;
			} else {				
				alert("저장이 완료되었습니다.");
				$('#resultEndGrid').trigger('reloadGrid');
			}
		}
		
	}
	
	function btn_Report_onclick(){
		var rowId = $('#reportPublishHistoryGrid').getGridParam('selrow');
		
		if(rowId == null){
			alert("이력을 선택하여 주세요.");
			return;
		}else{
			var gridRow = $('#reportPublishHistoryGrid').getRowData(rowId);

			// 필수 체크
			if(formValidationCheck("reportWritePopForm")){
				return;
			} else {
				var formNm = gridRow.form_name;
				var formVersion = gridRow.doc_revision_seq;
				var form_seq = gridRow.form_seq;
				
				var fileNm = formNm + "_V" + formVersion + ".mrd";

				var test_req_seq = gridRow.test_req_seq; 
				var test_sample_seq = gridRow.test_sample_seq;
				var pick_no = gridRow.pick_no;
				var report_publish_no = gridRow.report_publish_no;
				var report_doc_seq = gridRow.report_doc_seq;
				
				//바이오고형연료성적서구분
				if(form_seq == "19-025" || form_seq == "19-026"|| form_seq == "19-028"|| form_seq == "19-029"){
					html5Viewer(fileNm, "/rp ["+report_publish_no+"] ["+pick_no+"] [REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] [REPORT_PUBLISH_NO] " , false);
				//목재제품규격품질검사구분
				}else if(form_seq == "19-002" || form_seq == "19-003" || form_seq == "19-004" || form_seq == "19-005" ){
					html5Viewer(fileNm, "/rp ["+report_publish_no+"] ["+test_sample_seq+"] [REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] [REPORT_PUBLISH_NO]" , false);
				}else{
					var reportChk = formNm.match(/multiplex/);
					var reportChkSingle = formNm.match(/single/); 
					var arr_sample = new Array();
					
					var std_flag = "N";
					if ( form_seq == "19-011" || form_seq == "19-012" || form_seq == "19-019" || form_seq == "19-020" || form_seq == "20-005"){
						std_flag = "Y";
					}
					
					if(reportChk == "multiplex"){
						//공인 - 일반 Mix
						if (form_seq == "20-005"||form_seq == "20-006"){
							if (test_sample_seq.length > 19){
							alert("공인/일반 성적서의 시료는 2개까지 가능합니다.")
								return false;
							} else {
								var arrReportFile = new Array();
								
								arrReportFile[0] = "TestResultKOLAS-multiplexEN_V01.mrd";
								arrReportFile[1] = "TestResult-multiplexEN_V01.mrd";
								
								if(test_sample_seq.length > 1){
									var arr_sample = test_sample_seq.split(',');
									var separation = new Array();

									for (i = 1; i <test_sample_seq.length+1; i++ ){
										var add = i;
										separation[i-1]=add;
									}
									html5Viewer3(arrReportFile, report_publish_no, arr_sample, "REPORT_PUBLISH_LOG", "REPORT_SAMPLE_PL", "REPORT_SAMPLE_ITEM_PL", std_flag, "REPORT_PUBLISH_NO", separation);
								}
							}
						} else {
							//분리발행
							if(test_sample_seq.length > 9){
								var arr_sample = test_sample_seq.split(',');
								var separation = new Array();
								for (i = 1; i <((test_sample_seq.length+1)/10)+1; i++ ){
									var add = i;
									separation[i-1]=add;
								}
								html5Viewer2(fileNm, report_publish_no, arr_sample, "REPORT_PUBLISH_LOG", "REPORT_SAMPLE_PL", "REPORT_SAMPLE_ITEM_PL", std_flag, "REPORT_PUBLISH_NO",separation );
								
							} else {
								var separation = null;
								html5Viewer(fileNm, "/rp ["+report_publish_no+"]["+test_sample_seq+"][REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] ["+std_flag+"][REPORT_PUBLISH_NO]["+separation+"]" , false);
							}
						}
					}
					//단일항목
					if( reportChkSingle == "single"){
						var arr_sample = test_sample_seq.split(',');
						html5Viewer(fileNm, "/rp ["+report_publish_no+"]["+test_sample_seq+"][REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL]["+std_flag+"][REPORT_PUBLISH_NO] " , false);
					}
				}
			}
		}
	}
	function btn_history_delete_onclick() {
		if($('#reportPublishHistoryGrid').getGridParam('selrow')=='' || $('#reportPublishHistoryGrid').getGridParam('selrow')==null){
			$.showAlert('이력을 선택하세요');
		}else{
			var json = fnAjaxAction('report/deleteReportPublishLog.lims?log_no='+$('#reportPublishHistoryGrid').getGridParam('selrow'), '');
			if (json == null) {
					$.showAlert('성적서이력 삭제를 실패하였습니다.');
				} else {
					$.showAlert('성적서이력 삭제가 완료되었습니다.');
				}
			$('#reportPublishGrid').trigger('reloadGrid');
			$('#reportPublishHistoryGrid').clearGridData();
			$('#reportWriteSampleGrid').clearGridData();
			$('#sampleReportListGrid').clearGridData();
			$('#resultEndGrid').clearGridData();
			$('#dialog').dialog("destroy");	
		}
	}
	
</script>
<div class="sub_purple_01 w100p">
	<form id="reportWriteForm" name="reportWriteForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					성적서작성목록
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
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reportWriteForm", "750", "550", "성적서발행")'/>
				</td>
				<th>의뢰자</th>
				<td>
					<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
				</td>
				<th>접수일자</th>
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
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
				</td>
				<th>단위업무</th>
				<td>
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>
				<th>검사목적</th>
				<td>
					<select name="test_goal" id="test_goal" class="w200px"></select>
				</td>
			<tr>
				<th>발행상태</th>
				<td>
					<select name="state" id="state" class="w200px">
						<option value="">전체</option>
						<option value="X" selected="selected">성적서발행대기</option>
						<option value="Y">성적서발행완료</option>
					</select>
				</td>
				<th>성적서발행예정일</th>
				<td>
					<input name="deadline_start_date" id="deadline_start_date" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="deadlinestartDateStop" style="cursor: pointer;" onClick='fn_TextClear("deadline_start_date")' /> ~
					<input name="deadline_end_date" id="deadline_end_date" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="deadlineEndDateStop" style="cursor: pointer;" onClick='fn_TextClear("deadline_end_date")' />
				</td>
				<th>발행일자</th>
				<td>
					<input name="report_start_date" id="report_start_date" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="report_start_dateStop" style="cursor: pointer;" onClick='fn_TextClear("report_start_date")' /> ~
					<input name="report_end_date" id="report_end_date" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="report_end_dateStop" style="cursor: pointer;" onClick='fn_TextClear("report_end_date")' />
				</td>
			</tr>			
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="report_doc_seq" name="report_doc_seq" />
		<input type="hidden" id="test_req_seq" name="test_req_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="pick_no" name="pick_no" />
		<input type="hidden" id="doc_seq" name="doc_seq" />
		
		<div class="sub_purple_01 w60p" style="padding-bottom:20px;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					성적서 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">					
					<span class="button white mlargeg auth_save" id="btn_Publish" onclick="btn_Publish_onclick('P');">
						<button type="button">성적서발행</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">성적서삭제</button>
					</span> 
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick('reportPublishGrid');">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<div id="view_grid_main">
			<table id="reportPublishGrid"></table>
		</div>
		</div>
		<div class="w35p" style="float:right; display:inline-block;">
			<div class="sub_blue_01">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							발행이력 목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_save" id="btn_Publish" onclick="btn_Publish_onclick('R');">
								<button type="button">성적서재발행</button>
							</span>
							<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_history_delete_onclick();">
								<button type="button">이력 삭제</button>
							</span>
							<span class="button white mlargep auth_select" id="btn_Report" onclick="btn_Report_onclick();">
								<button type="button">성적서보기</button>
							</span>
							<span class="button white mlargep auth_select" id="btn_Send_Mail" onclick="fn_Send_Mail_report_onclick('reportPublishHistoryGrid');">
								<button type="button">메일전송</button>
							</span>
							<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick('reportPublishHistoryGrid');">
								<button type="button">EXCEL</button>
							</span>
						</td>
					</tr>
				</table>
				<input type="hidden" id="report_doc_seq" name="report_doc_seq" />
			</div>
			<div id="view_grid_main2">
				<table id="reportPublishHistoryGrid"></table>
			</div>
		</div>
	</form>
</div>

<div class="sub_purple_01 w60p" style="padding-bottom:20px;">
	<form id="reportWriteSampleForm" name="reportWriteSampleForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
				</td>
			</tr>
		</table>
		<input type="hidden" id="report_doc_seq" name="report_doc_seq" />		
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_1">
			<table id="reportWriteSampleGrid"></table>
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
						항목별 첨부 문서 목록
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

<div class="sub_purple_01 w100p">
	<form id="publishForm" name="publishForm" onsubmit="return false;">
		<div class="sub_blue_01">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						항목 목록
					</td>
<!-- 					<td class="table_button">
						<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
							<button type="button">저장</button>
						</span>						
					</td> -->
				</tr>
			</table>
		</div>
		<input type="hidden" id="report_doc_seq" name="report_doc_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub3">
			<table id="resultEndGrid"></table>
		</div>
	</form>
</div>

<div id="dialog" class="sub_blue_01 w100p" style="display: none; margin-top: 0px;"></div>









