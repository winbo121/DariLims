<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 성적서작성
	 * 파일명 		: reportWriteL01.jsp
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
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		var cntType="${cntType}"
		if(cntType=='5'){
			$("#report_class_code1").attr("checked",true)
		}
			
		$('#report_class_code1').val('${resultData.report_class_code}');		
		ajaxComboForm("dept_cd", "", "All", null, 'reportReqForm');
		
		
		ajaxComboForm("test_goal", "C05", "ALL", null, "reportReqForm");
		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reportReqForm");
		
		ajaxComboForm("supv_dept_cd", "", "${session.dept_cd }", null, 'reportReqForm');

		$('#reportReqForm').find("#dept_cd").change(function() {
			ajaxComboForm("unit_work_cd", $('#reportReqForm').find("#dept_cd").val(), "ALL", null, 'reportReqForm');
		});
		$('#reportReqForm').find('#endDate').val(fnGetToday(0,0));
		$('#reportReqForm').find('#startDate').val(fnGetToday(3,0));

		reportReqGrid('report/selectReportReqList.lims?commission_flag='+$("#commission_flag").val(), 'reportReqForm', 'reportReqGrid');
		//$('#reportReqGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		reportSampleGrid('report/selectReportSampleList.lims', 'reportSampleForm', 'reportSampleGrid');

		fn_Enter_Search('reportReqForm', 'reportReqGrid');

		$(window).bind('resize', function() {
			$("#reportReqGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#reportSampleGrid").setGridWidth($('#view_grid_sub_1').width(), false);
		}).trigger('resize');
	});

	function reportReqGrid(url, form, grid) {
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
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true,
				key : true
			}, {
				label : 'pick_no',
				name : 'pick_no',
				hidden : true
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '100',
				align : 'center'
			}, {
				label : '제목',
				name : 'title',
				width : '300'
			}, {
				label : '의뢰업체명',
				name : 'req_org_nm'
			}, {
				label : '의뢰자',
				name : 'req_nm',
				width : '60',
				align : 'center'
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
			}, {
				label : '접수자',
				name : 'user_nm',
				width : '60',
				align : 'center'
			}, {
				label : '반려여부',
				name : 'return_flag',
				width : '60',
				align : 'center',
				editoptions : {
					value : 'Y:반려됨;N:'		
				},
				formatter : 'select'
			}, {
				label : '반려사유',
				name : 'return_comment'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#reportReqGrid').getRowData(rowId);
				$("#reportSampleForm").find('#test_req_seq').val(rowId);
				$("#reportSampleForm").find('#pick_no').val(row.pick_no);
				$('#reportSampleGrid').trigger('reloadGrid');
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'req_type',
				numberOfColumns : 6,
				titleText : '의뢰정보'
			}, {
				startColumnName : 'dept_nm',
				numberOfColumns : 3,
				titleText : '검사정보'
			} ]
		});
	}

	function reportSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_seq').val() != '') {
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
			multiselect : true,
			colModel : [ {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : '시료번호',
				name : 'test_sample_seq',
				width : '100',
				align : 'center',
				key : true
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
			}, {
				label : '비고',
				name : 'etc_desc'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#reportSampleForm').find('#test_sample_seq').val(jQuery("#"+grid).jqGrid('getGridParam','selarrrow'));
				$('#resultGrid').trigger('reloadGrid');		
			}
		});
	}	

	// 조회 이벤트
	function btn_Select_onclick() {
		$('#reportReqGrid').trigger('reloadGrid');
		$('#reportSampleForm').find('#test_req_seq').val('');
		$('#reportSampleForm').find('#test_sample_seq').val('');
		$('#reportSampleForm').find('#pick_no').val('');
		$('#reportSampleGrid').clearGridData();
	}

	function btn_Write_onclick() {
		var reqRow = $('#reportReqGrid').getRowData($('#reportReqGrid').getGridParam('selrow'));
		var rowArr = $('#reportSampleGrid').getGridParam('selarrrow');

		if (rowArr != '') {
			$("#dialog").dialog({
				width : 700,
				height :200,
				resizable : false,
				title : '성적서작성 정보',
				modal : true,
				open : function(event, ui) {
					$(".ui-dialog-titlebar-close").hide();
					var data = "test_req_seq=" + reqRow.test_req_seq + "&viewGbn=WRITE";
					fnViewPage('report/selectReportDetail.lims', 'dialog', data);
				},
				buttons : [
				{
					text : "미리보기",
					click : function() {
						// 필수 체크
						if(formValidationCheck("reportWritePopForm")){
							return;
						} else {
							var reportGbn;
							
							var formNm = $("#reportWritePopForm").find("#doc_seq").val();
							var formVersion = $("#reportWritePopForm").find("#doc_seq option:checked").text();
							var form_seq = $("#reportWritePopForm").find("#form_seq").val();
							
							var fileNm = formNm + "_V" + formVersion + ".mrd";

							var test_req_seq = $('#reportSampleForm').find('#test_req_seq').val(); 
							var test_sample_seq = rowArr;
							var pick_no = $('#reportSampleForm').find('#pick_no').val();
							var req_etc = $("#reportWritePopForm").find("#req_etc").val();
							var plusNum ="";
											
							if(req_etc.indexOf("+")!= -1){
								for(var i=0; i<req_etc.length; i++){
									if(req_etc[i]=="+"){
										plusNum = plusNum + String(i)+",";
										req_etc = req_etc.replace("+","-"); 
									}
									
								}
								plusNum = plusNum.substr(0, plusNum.length -1);
							
							}
							
							if(req_etc.indexOf("%")!= -1){
								req_etc = req_etc.replace(/%/gi, escape("%")); 
							}
							if(req_etc.indexOf("&")!= -1){
								req_etc = req_etc.replace(/&/gi, escape("&")); 
							}
							
						
								
							//성적서 기준 비고 저장
							var data = "test_req_seq=" + test_req_seq + "&req_etc=" + req_etc + "&plusNum="+plusNum;
							var json = fnAjaxAction('report/updateReqEtc.lims', data);

							//바이오고형연료성적서구분
							if(form_seq == "19-025" || form_seq == "19-026"|| form_seq == "19-028"|| form_seq == "19-029"){
								
									if(pick_no == ""){
										alert("시료 채취 정보가 없습니다.");
										return false;
									}
									if(test_sample_seq.length > 1){
										alert("고형연료 성적서는 하나의 시료만 작성 가능합니다.");
										return false;
									} else {
										html5Viewer(fileNm, "/rp ["+test_req_seq+"] ["+pick_no+"] [TEST_REQ] [TEST_SAMPLE] [TEST_SAMPLE_ITEM] [TEST_REQ_SEQ] " , false);
									}
							//목재제품규격품질검사구분
							}else if(form_seq == "19-002" || form_seq == "19-003" || form_seq == "19-004" || form_seq == "19-005" ) {
								var reportChk = $("#reportWritePopForm").find("#doc_seq").val().match(/Wooden/); 

								if(test_sample_seq.length > 1){
									alert("목재제품 성적서는 하나의 시료만 작성 가능합니다.");
									return false;
								} else {
									html5Viewer(fileNm, "/rp ["+test_req_seq+"]["+test_sample_seq+"][TEST_REQ] [TEST_SAMPLE] [TEST_SAMPLE_ITEM] [TEST_REQ_SEQ] " , false);
								}
							}else {
								var reportChk = $("#reportWritePopForm").find("#doc_seq").val().match(/multiplex/);
								var reportChkSingle = $("#reportWritePopForm").find("#doc_seq").val().match(/single/); 

								
								if(reportChkSingle == "single" && test_sample_seq.length > 20) {
									alert("시료 선택은 최대 20개입니다.");
									return false;
								}
								//기준치 구분
								var std_flag = "N";
								if ( form_seq == "19-011" || form_seq == "19-012" || form_seq == "19-019" || form_seq == "19-020" || form_seq == "20-005"){
									std_flag = "Y";
								}
								//다항목
								if(reportChk == "multiplex"){
									
									//공인 - 일반 Mix
									if (form_seq == "20-005"||form_seq == "20-006"){
										if (test_sample_seq.length > 3){
											alert("공인/일반 성적서의 시료는 2개까지 가능합니다.")
											return false;
										} else if (test_sample_seq.length == 1){
											alert("공인/일반 성적서는 2개의 시료를 선택해야합니다.")
											return false;
										} else {
										
											var arrReportFile = new Array();
											
											arrReportFile[0] = "TestResultKOLAS-multiplexEN_V01.mrd";
											arrReportFile[1] = "TestResult-multiplexEN_V01.mrd";
											
											if(test_sample_seq.length > 1){
												var arr_sample = test_sample_seq;
												var separation = new Array();
		
												for (i = 1; i <test_sample_seq.length+1; i++ ){
													var add = i;
													separation[i-1]=add;
												}
												html5Viewer3(arrReportFile, test_req_seq, arr_sample, "TEST_REQ", "TEST_SAMPLE", "TEST_SAMPLE_ITEM", std_flag, "TEST_REQ_SEQ", separation);
											}
										}
									} else {
										//분리발행
										if(test_sample_seq.length > 1){
											var arr_sample = test_sample_seq;
											var separation = new Array();
	
											for (i = 1; i <test_sample_seq.length+1; i++ ){
												var add = i;
												separation[i-1]=add;
											}
	
											html5Viewer2(fileNm, test_req_seq, arr_sample, "TEST_REQ", "TEST_SAMPLE", "TEST_SAMPLE_ITEM", std_flag, "TEST_REQ_SEQ", separation);
										} else {
											//다항목 - 시료 1개
											var separation = null;
											html5Viewer(fileNm, "/rp ["+test_req_seq+"]["+test_sample_seq+"][TEST_REQ] [TEST_SAMPLE] [TEST_SAMPLE_ITEM]["+std_flag+"][TEST_REQ_SEQ]["+separation+"] " , false);
										}
									}
								}
								//단일항목
								if( reportChkSingle == "single"){
									html5Viewer(fileNm, "/rp ["+test_req_seq+"]["+test_sample_seq+"][TEST_REQ] [TEST_SAMPLE] [TEST_SAMPLE_ITEM]["+std_flag+"][TEST_REQ_SEQ] " , false);
								}								
							}
						}
					}
				},  
				{
					text : "작성완료",
					click : function() {
						if(formValidationCheck("reportWritePopForm")){
							return;
						} else {
							//성적서 기준 비고 저장
							var test_req_seq = $('#reportSampleForm').find('#test_req_seq').val(); 
							var req_etc = $("#reportWritePopForm").find("#req_etc").val();
							
							var plusNum ="";
							
							if(req_etc.indexOf("+")!= -1){
								for(var i=0; i<req_etc.length; i++){
									if(req_etc[i]=="+"){
										plusNum = plusNum + String(i)+",";
										req_etc = req_etc.replace("+","-"); 
									}
									
								}
								plusNum = plusNum.substr(0, plusNum.length -1);
							
							}
							
							if(req_etc.indexOf("%")!= -1){
								req_etc = req_etc.replace(/%/gi, escape("%")); 
							}
							if(req_etc.indexOf("&")!= -1){
								req_etc = req_etc.replace(/&/gi, escape("&")); 
							}
							
						
								
							//성적서 기준 비고 저장
							var data = "test_req_seq=" + test_req_seq + "&req_etc=" + req_etc + "&plusNum="+plusNum;
							
							
							var json = fnAjaxAction('report/updateReqEtc.lims', data);
							
						 	var data = $('#reportWritePopForm').serialize() + '&test_sample_seq=' + rowArr;
							data += '&state=X';
							data += '&doc_seq='+$("#reportWritePopForm").find("#form_seq").val()+"-"+$("#reportWritePopForm").find("#doc_seq option:checked").text();
							var json = fnAjaxAction('report/insertReportWrite.lims', data); 
					  		if (json == null) {
								$.showAlert('성적서작성을 실패하였습니다.');
							} else {
								$.showAlert('선택된 시료의 성적서작성이 완료되었습니다.');
							}
							$('#reportReqGrid').trigger('reloadGrid');
							$('#reportSampleGrid').clearGridData();
							$('#dialog').dialog("destroy") ;    
							
						 	var test_sample_seq = rowArr;
							var reportChk = $("#reportWritePopForm").find("#doc_seq").val().match(/multiplex/);
							//분리발행 
							if(reportChk == "multiplex" && test_sample_seq.length > 1){
								var data = "report_doc_seq=" + json + "&separation=" + "Y";
								var sjson = fnAjaxAction('report/updateSeparation.lims', data);
							}
							//성적서 기준 비고 저장
/* 							var req_etc = $("#reportWritePopForm").find("#req_etc").val();
							var data = "report_doc_seq=" + json + "&req_etc=" + req_etc;
							var json = fnAjaxAction('report/updateReqEtc.lims', data); */
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

	// 의뢰처 팝업
	function fnpop_reqOrgChoice(name, width, hight, text){		
		
		fnpop_reqOrgChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}
	
	// 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}
	
	// 반려(성적서삭제)
	function btn_Return_onclick(){
		var rowId = $('#reportReqGrid').getGridParam('selrow');
		var row = $('#reportReqGrid').getRowData(rowId);
		
		if(rowId == ''){
			$.showAlert('선택된 행이 없습니다.');
			return false;
		}
		if(row.return_flag == 'Y'){
			var row = $('#reportReqGrid').getRowData(rowId);
			var obj = new Object();
			obj.msg1 = 'showReturnComment.lims';
			obj.type = 'show';
			obj.return_comment = row.return_comment;
			fnBasicStartLoading();
			fnpop_return (obj, '900', '630');			
		}else{
			$.showAlert('선택된 행은 반려되지 않았습니다.');
			return false;
		}
	}

</script>
<div class="sub_purple_01 w100p">
	<form id="reportReqForm" name="reportReqForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					의뢰목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlarger auth_select" id="btn_Return" onclick="btn_Return_onclick();">
						<button type="button">반려사유</button>
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
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reportReqForm", "750", "1000", "성적서작성")'>
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
				<th>성적서작성여부</th>
				<td>
					<input type="radio" id="report_flag" name="report_flag" value="N" checked="checked">
					작성중
					<input type="radio" id="report_flag" name="report_flag" value="Y">
					작성완료
				</td>
				<th>검사목적</th>
				<td>
					<select name="test_goal" id="test_goal" class="w200px"></select>
				</td>
			</tr>
			<tr>
			<th>담당자</th>
				<td colspan='5'>
				 <label><input type="radio" id="report_class_code1" name="report_class_code" value="" > ${resultData.user_nm}</label>
			     <label><input type="radio" id="report_class_code2" name="report_class_code" value="E,F,K,D" checked="checked"> 전체</label>
				</td>
			</tr>
		</table>		
		<input type="hidden" id="state" name="state" value="F">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reportReqGrid"></table>
		</div>
	</form>
</div>
<div class="sub_purple_01 w100p">
	<form id="reportSampleForm" name="reportSampleForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_save" id="btn_Write" onclick="btn_Write_onclick();">
						<button type="button">성적서작성</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="report_doc_seq" name="report_doc_seq" />
		<input type="hidden" id="test_req_seq" name="test_req_seq" />
		<input type="hidden" id="pick_no" name="pick_no" >
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" >		
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_1">
			<table id="reportSampleGrid"></table>
		</div>
	</form>
</div>

<div id="dialog" class="sub_blue_01 w100p" style="display: none; margin-top: 0px;"></div>