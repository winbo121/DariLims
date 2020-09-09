
<%
	/***************************************************************************************
	 * 시스템명 	: 실험실정보관리시스템
	 * 업무명 		: 성적서승인목록
	 * 파일명 		: reportApprovalL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2020.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.02.26    허태원		최초 프로그램 작성         
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
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		fnDatePickerImg('report_start_date');
		fnDatePickerImg('report_end_date');

		ajaxComboForm("test_goal", "C05", "ALL", null, "reportApprovalForm");
		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reportApprovalForm");
		ajaxComboForm("dept_cd", "", "ALL", null, 'reportApprovalForm');
		
		$('#reportApprovalForm').find('#endDate').val(fnGetToday(0,0));
		$('#reportApprovalForm').find('#startDate').val(fnGetToday(1,0));

		// 성적서리시트
		reportApprovalGrid('report/selectReportApprovalList.lims', 'reportApprovalForm', 'reportApprovalGrid');
		$('#reportApprovalGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 시료 리스트
		reportApprovalSampleGrid('report/selectReportApprovalSampleList.lims', 'reportApprovalSampleForm', 'reportApprovalSampleGrid');
		
		// 항목 리스트
		reportApprovalItemGrid('report/selectReportApprovalItemList.lims', 'reportApprovalItemForm', 'reportApprovalItemGrid');
		
		fn_Enter_Search('reportApprovalForm', 'reportApprovalGrid');

		$(window).bind('resize', function() {
			$("#reportApprovalGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#reportApprovalSampleGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#reportApprovalItemGrid").setGridWidth($('#view_grid_sub3').width(), true);
		}).trigger('resize');

		$('#reportApprovalForm').find("#report_appr_yn").change(function() {
			var sState = $('#reportApprovalForm').find("#report_appr_yn").val();
			$('#btn_Approval').attr("onclick", '').unbind('click');
			$('#btn_Return').attr("onclick", '').unbind('click');
			
			if (sState == "Y") {
				$('#btn_Approval').attr("onclick", '').click(showAlert);
				$('#btn_Return').attr("onclick", '').click(showAlert);				
			} else {
				$('#btn_Approval').attr("onclick", '').click(btn_Approval_onclick);
				$('#btn_Return').attr("onclick", '').click(btn_Return_onclick);
			}
		});
	});

	function reportApprovalGrid(url, form, grid) {
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
				label : '성적서발행 예정일 ',
				name : 'deadline_date',
				width : '120',
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
				label : '성적서작성자',
				name : 'user_nm',
				width : '80',
				align : 'center'
			}, {
				label : '성적서번호',
				name : 'report_no',
				width : '100',
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
				width : '300',
				name : 'req_org_addr'
			}, {
				label : 'report_make_id',
				name : 'report_make_id',
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
			},  {
				label : '접수부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : '단위업무',
				name : 'unit_work_cd'
			}, {
				label : '검사목적',
				name : 'test_goal'
			}, {
				label : 'form_seq',
				name : 'form_seq',
				hidden : true
			}, {
				label : 'form_name',
				name : 'form_name',
				hidden : true
			}, {
				label : 'doc_revision_seq',
				name : 'doc_revision_seq',
				hidden : true
			}, ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#reportApprovalForm").find('#report_doc_seq').val(rowId);
				var gridRow = $('#'+grid).getRowData(rowId);
				$("#reportApprovalForm").find('#test_req_seq').val(gridRow.test_req_seq);
				$("#reportApprovalForm").find('#test_sample_seq').val(gridRow.test_sample_seq);
				$("#reportApprovalForm").find('#pick_no').val(gridRow.pick_no);
				$("#reportApprovalSampleForm").find('#report_doc_seq').val(rowId);
				$('#reportApprovalSampleGrid').trigger('reloadGrid');

				$("#reportApprovalItemForm").find('#report_doc_seq').val(rowId);
				$('#reportApprovalItemForm').find('#test_sample_seq').val('');
				$('#reportApprovalItemGrid').trigger('reloadGrid'); // 항목리스트

				$('#sampleReportListForm').find('#test_sample_seq').val('');
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'report_file_nm',
				numberOfColumns : 9,
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

	// 시료리스트
 	var lastRowId;
	function reportApprovalSampleGrid(url, form, grid) {
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
				label : '처리기한',
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
				$('#reportApprovalItemForm').find('#test_sample_seq').val($('#reportApprovalSampleGrid').getRowData(rowId).test_sample_seq);
				$('#reportApprovalItemGrid').trigger('reloadGrid'); // 항목리스트
				
				$('#sampleReportListForm').find('#test_sample_seq').val($('#reportApprovalSampleGrid').getRowData(rowId).test_sample_seq);
			}
		});
	}
	
	// 항목 결과 리스트
	var lastRowId;
	function reportApprovalItemGrid(url, form, grid) {
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
			}
		});
	}
	
	// 조회
	function btn_Select_onclick() {
		$('#reportApprovalGrid').trigger('reloadGrid');
		$('#reportApprovalSampleForm').find('#report_doc_seq').val('');
		$('#reportApprovalSampleGrid').clearGridData();
		$('#sampleReportListForm').find('#test_sample_seq').val('');
		$('#reportApprovalItemForm').find('#test_sample_seq').val('');
		$('#reportApprovalItemGrid').clearGridData();
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
	
	// 승인
	function btn_Approval_onclick(){	
		var grid = 'reportApprovalGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		var arr_report = new Array();
		var arr_req = new Array();
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {		
				c++;
				arr_report.push(row.report_doc_seq);
				arr_req.push(row.test_req_seq);
			}
		}
		
		if (!confirm('선택된 성적서 승인하시겠습니까?')) {
			return false;
		}

		var data = 'arr_report='+arr_report + '&arr_req=' + arr_req;
		console.log(data)
		if (c == 0) {
			alert('선택된 성적서가 없습니다.');
		} else {
			var json = fnAjaxAction('report/updateReportApproval.lims', data);
			if (json == null) {
				alert("승인이 실패되었습니다.");			
				return false;
			} else {				
				alert("승인이 완료되었습니다.");
				$('#reportApprovalGrid').trigger('reloadGrid');
				$('#reportApprovalSampleGrid').clearGridData();
				$('#reportApprovalItemGrid').clearGridData();
			}
		}
	}
	
	// 반려(성적서삭제)
	function btn_Return_onclick(){
		var grid = 'reportApprovalGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		var arr_report = new Array();
		var arr_req = new Array();		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {		
				c++;
			}
		}
		
		if (c == 0) {
			alert('선택된 성적서가 없습니다.');
		}else{
			if (confirm('선택된 성적서 반려하시겠습니까?')) {
				var obj = new Object();
				obj.msg1 = 'showReturnComment.lims';
				obj.type = 'callback';
				fnBasicStartLoading();
				fnpop_return (obj, '900', '630');
			}
		}
	}
	
	// 반려팝업 콜백
	function fnpop_return_callback(return_comment){
		var grid = 'reportApprovalGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		var arr_report = new Array();
		var arr_req = new Array();		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {		
				c++;
				arr_report.push(row.report_doc_seq);
				arr_req.push(row.test_req_seq);
			}
		}
		
		var data = 'arr_report='+arr_report+'&arr_req='+arr_req+'&return_comment='+return_comment;;
		
		if (c == 0) {
			alert('선택된 성적서가 없습니다.');
		} else {
			var json = fnAjaxAction('report/deleteReportReturn.lims', data);
			if (json == null) {
				alert("반려가 실패되었습니다.");			
				return false;
			} else {				
				alert("반려가 완료되었습니다.");
				$('#reportApprovalGrid').trigger('reloadGrid');
				$('#reportApprovalSampleGrid').clearGridData();
				$('#reportApprovalItemGrid').clearGridData();
			}
		}
	}
	
	// 성적서보기
	function btn_Report_onclick(){
		var grid = "reportApprovalGrid";
		var rowId = $('#'+grid).getGridParam('selrow');
		
		if(rowId == null){
			alert("성적서를 선택하여 주세요.");
			return;
		}else{
			var gridRow = $('#'+grid).getRowData(rowId);
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
				var report_doc_seq = gridRow.report_doc_seq;
				//바이오고형연료성적서구분
				if(form_seq == "19-025" || form_seq == "19-026"|| form_seq == "19-028"|| form_seq == "19-029"){
					html5Viewer(fileNm, "/rp ["+report_doc_seq+"] ["+pick_no+"] [REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] [REPORT_DOC_SEQ] " , false);
				//목재제품규격품질검사구분
				}else if(form_seq == "19-002" || form_seq == "19-003" || form_seq == "19-004" || form_seq == "19-005" ){
					html5Viewer(fileNm, "/rp ["+report_doc_seq+"] ["+test_sample_seq+"] [REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] [REPORT_DOC_SEQ] " , false);
				}else{
					var reportChk = formNm.match(/multiplex/);
					var reportChkSingle = formNm.match(/single/); 
					
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
								html5Viewer2(fileNm, report_doc_seq, arr_sample, "REPORT_DOC", "REPORT_SAMPLE", "REPORT_SAMPLE_ITEM", std_flag, "REPORT_DOC_SEQ",separation);
								
							} else {
								var separation = null;
								html5Viewer(fileNm, "/rp ["+report_doc_seq+"]["+test_sample_seq+"][REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM] ["+std_flag+"][REPORT_DOC_SEQ]["+separation+"]" , false);
								
							}
						}							
					}
					//단일항목
					if( reportChkSingle == "single"){
						var arr_sample = test_sample_seq.split(',');
						html5Viewer(fileNm, "/rp ["+report_doc_seq+"]["+test_sample_seq+"][REPORT_DOC] [REPORT_SAMPLE] [REPORT_SAMPLE_ITEM]["+std_flag+"][REPORT_DOC_SEQ] " , false);
					}
				}
			}
		}
	}
	
	function showAlert(){
		alert('조회조건의 [진행상태]가 [승인대기]인 경우 승인 혹은 반려 가능합니다.\n진행상태를 변경해주세요.');
		return false;
	}
	
</script>
<div class="sub_purple_01 w100p">
	<form id="reportApprovalForm" name="reportApprovalForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					성적서작성목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb auth_select" id="btn_Approval" onclick="btn_Approval_onclick();">
						<button type="button">승인</button>
					</span>
					<span class="button white mlarger auth_select" id="btn_Return" onclick="btn_Return_onclick();">
						<button type="button">반려</button>
					</span>
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
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reportReqForm", "750", "550", "성적서작성")'>
				</td>
				<th>의뢰자</th>
				<td>
					<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
				</td>
				<th>성적서발행예정일</th>
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
				<th>검사목적</th>
				<td>
					<select name="test_goal" id="test_goal" class="w200px"></select>
				</td>
				<th>진행상태</th>
				<td>
					<select name="report_appr_yn" id="report_appr_yn" class="w200px">
						<option value="N">승인대기</option>
						<option value="Y">승인완료</option>
					</select>
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
		
		<div class="sub_purple_01" style="padding-bottom:20px;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					성적서 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Report" onclick="btn_Report_onclick();">
						<button type="button">성적서보기</button>
					</span>
				</td>
			</tr>
		</table>
		<div id="view_grid_main">
			<table id="reportApprovalGrid"></table>
		</div>
		</div>
	</form>
</div>

<div class="sub_purple_01" style="padding-bottom:20px;">
	<form id="reportApprovalSampleForm" name="reportApprovalSampleForm" onsubmit="return false;">
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
			<table id="reportApprovalSampleGrid"></table>
		</div>
	</form>
</div>

<div class="sub_purple_01">
	<form id="reportApprovalItemForm" name="reportApprovalItemForm" onsubmit="return false;">
		<div class="sub_blue_01">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						항목 목록
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="report_doc_seq" name="report_doc_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub3">
			<table id="reportApprovalItemGrid"></table>
		</div>
	</form>
</div>

<div id="dialog" class="sub_blue_01 w100p" style="display: none; margin-top: 0px;"></div>