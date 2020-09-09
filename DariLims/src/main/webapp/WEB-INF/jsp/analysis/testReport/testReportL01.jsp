
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 시험일지
 * 파일명 		: testReportL01.jsp
 * 작성자 		: 허태원
 * 작성일 		: 2015.10.16
 * 설  명		: 시험일지 리스트 화면
 *---------------------------------------------------------------------------------------
 * 변경일		변경자		변경내역 
 *---------------------------------------------------------------------------------------
 * 2015.10.16    허태원		최초 프로그램 작성         
 * 
 *---------------------------------------------------------------------------------------
 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html> 
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	var methodOpen = false;
	var calcOpen = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 등록일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		//일주일전 날짜
		$('#testReportMainForm').find('#startDate').val(caldate(7));
		//오늘날짜
		$('#testReportMainForm').find('#endDate').val(caldate(0));
		
		ajaxComboForm("doc_seq", "C60003", "CHOICE", "", "inputSampleForm");
		
		mainGrid('analysis/selectTestReportSampleList.lims', 'testReportMainForm', 'mainGrid');
		$('#mainGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		subGrid('analysis/selectTestReportItemList.lims', 'testReportSubForm', 'subGrid');

		$(window).bind('resize', function() {
			$("#mainGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#subGrid").setGridWidth($('#view_grid_main').width()*.200);
		}).trigger('resize');

		fn_Enter_Search('testReportMainForm', 'mainGrid');
		
		$('#methodTr').hide();
		$('#methodTr2').hide();
	});

	function mainGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '200px',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '의뢰번호',
				name : 'rec_req_no',
				hidden : true,
				align : 'center'
			},{
				label : '접수번호',
				name : 'test_req_no',
				width : '150',
				align : 'center'	
			},{
				label : '시료번호',
				name : 'test_sample_no',
				width : '200',
				align : 'center'	
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				align : 'center',
				width : '100',
				hidden : true,
				key : true
			},{
				label : '의뢰제목',
				name : 'title',
				width : '300',
				align : 'left'	

			}, {
				label : '업체명',
				name : 'req_org_nm',
				width : '200',
				align : 'left'
			}, {
				label : '의뢰자명',
				name : 'req_nm',
				hidden : true,
				align : 'left'
			}, {
				label : '시료명',
				name : 'sample_reg_nm',
				width : '200',
				align : 'left'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				align : 'center'
			}, {
				label : '진행상태',
				name : 'state',
				hidden : true,
				align : 'center'
			}, {
				label : '진행상태',
				name : 'state_nm',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if(rowId != null || rowId != ''){
					$('#testReportSubForm').find('#test_sample_seq').val(rowId);
					$('#subGrid').trigger('reloadGrid');	
					selectSampleDetail();
				}						
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}

	function subGrid(url, form, grid) {		
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '645px',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '항목코드',
				name : 'test_item_cd',
				hidden : true,
				key : true
			}, {
				label : '항목명',
				name : 'test_item_nm',
				align : 'center'
			}],
			gridComplete : function() {
				$("#subGrid").setGridWidth($('#view_grid_sub').width(), true);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {				
				selectTestReport();
			}
		});
	}
	
	//시료 목록 조회
	function btn_select_onclick(){	
		$('#mainGrid').trigger('reloadGrid');
		$('#testReportSubForm').find('#test_sample_seq').val('');
		$('#subGrid').trigger('reloadGrid');
		$('#inputSampleForm').find('label').text('');
		inputReset();
	}
	
	//시료 상세 데이터 조회
	function selectSampleDetail(){	
		inputReset();
		var param = 'test_sample_seq=' + $('#mainGrid').getGridParam('selrow');	
		var json = fnAjaxAction('analysis/selectTestReportSampleDetail.lims', param);
		
		if(json != null){
			$(json).each(function(index, entry) {
				$('#inputSampleForm').find('#vw_test_sample_no').text(entry["test_sample_no"]);
				$('#inputSampleForm').find('#vw_sample_reg_nm').text(entry["sample_reg_nm"]);
				$('#inputSampleForm').find('#vw_sample_nm').text(entry["sample_nm"]);
				$('#inputSampleForm').find('#vw_test_std_nm').text(entry["test_std_nm"]);
				$('#inputSampleForm').find('#test_std_no').val(entry["test_std_no"]);
			});
		}
	}
	
	//상세보기 이벤트
	function btn_detail_onclick(div){
		
		if(div == 'method'){
			if(methodOpen == false){
				$('#methodTr').show();
				$('#methodTr2').show();
				methodOpen = true;
			}else{
				$('#methodTr').hide();
				$('#methodTr2').hide();
				methodOpen = false;
			}	
		}
	}
	
	//본인조회 클릭 이벤트
	function use_flag_onclick(){
		if($('#testReportMainForm').find('#use_flag').is(":checked")){
			$('#testReportMainForm').find('#tester_id').attr("readonly", true);
			$('#testReportMainForm').find('#tester_id').val('${session.user_nm}');
			
		}else{
			$('#testReportMainForm').find('#tester_id').attr("readonly", false);
			$('#testReportMainForm').find('#tester_id').val('');
		}
	}
	
	//팝업 이벤트
	function btn_search_onclick(div){
		var grid = 'inputSampleForm';
		var test_item_cd = $('#subGrid').getGridParam('selrow'); 
		if(test_item_cd != null && test_item_cd != ''){
			if(div == 'method'){
				fnpop_methodPop('', '900', '500', test_item_cd, '', grid);
			}else if(div == 'equip'){
				fnpop_machinePop('', '900', '500', test_item_cd, '', grid);
			}else{
				
			}
			
			fnBasicStartLoading();
		}else{
			alert('항목을 선택하여 주십시오.');
			return;
		}		
	}
	
	//시험일지 저장 처리
	function btn_Insert_onclick(){
		var test_sample_seq = $('#mainGrid').getGridParam('selrow');
		var test_item_cd = $('#subGrid').getGridParam('selrow');
		var param;
		if(fnIsEmpty(test_sample_seq)){
			alert('시료를 선택하여 주십시오.');
			return;
		}
		var state = $('#mainGrid').getCell(test_sample_seq,'state');
		if(state != "B" &&  state != "C"){
			alert("시험중 상태에서만 시험일지저장이 가능합니다.");
			return;
		}
		if(!fnIsEmpty(test_item_cd)){
			if(confirm("시험일지를 저장하시겠습니까?")){
				param = $('#inputSampleForm').serialize() + '&test_sample_seq=' + test_sample_seq + '&test_item_cd=' + test_item_cd;
				var json = fnAjaxAction('analysis/saveTestReport.lims', param);
				if (json == null) {
					alert("저장이 실패되었습니다.");			
					return false;
				} else {				
					alert("저장이 완료되었습니다.");
					selectTestReport();
				}
			}
		}else{
			alert('항목을 선택하여 주십시오.');
			return;
		}
	}
	
	function selectTestReport(){
		inputReset();
		var test_sample_seq = $('#mainGrid').getGridParam('selrow');
		var test_item_cd = $('#subGrid').getGridParam('selrow');
		var test_std_no = $('#inputSampleForm').find('#test_std_no').val();
		var param = '&test_sample_seq=' + test_sample_seq + '&test_item_cd=' + test_item_cd + '&test_std_no=' + test_std_no;
		var json = fnAjaxAction('analysis/selectTestReport.lims', param);
		
		if(json != null){
			$(json).each(function(index, entry) {
				$('#inputSampleForm').find('#inst_no').val(entry["inst_no"]);
				$('#inputSampleForm').find('#inst_kor_nm').val(entry["inst_kor_nm"]);
				$('#inputSampleForm').find('#inst_eng_nm').val(entry["inst_eng_nm"]);
				$('#inputSampleForm').find('#test_method_no').val(entry["test_method_no"]);
				$('#inputSampleForm').find('#test_method_nm').val(entry["test_method_nm"]);
				$('#inputSampleForm').find('#test_method_preclean').text(entry["test_method_preclean"]);
				$('#inputSampleForm').find('#test_method_content').text(entry["test_method_content"]);
				$('#inputSampleForm').find('#test_report_content').text(entry["test_report_content"]);
				$('#inputSampleForm').find('#account_no').val(entry["account_no"]);
				$('#inputSampleForm').find('#account_nm').text(entry["account_nm"]);
				$('#inputSampleForm').find('#result_val').text(entry["result_val"]);
				$('#inputSampleForm').find('#account_tot_disp').text(entry["account_tot_disp"]);
				$('#inputSampleForm').find('#account_tot_cal_disp').text(entry["account_tot_cal_disp"]);
				$('#inputSampleForm').find('#account_val_desc').text(entry["account_val_desc"]);
				$('#inputSampleForm').find('#account_val_desc_tot').text(entry["account_val_desc_tot"]);
			});
		}
	}
	
	function inputReset(){
		$('#inputSampleForm').find('input, textarea').not('#test_std_no').val('');
		$('#inputSampleForm').find('#account_tot_disp').text('');
		$('#inputSampleForm').find('#account_tot_cal_disp').text('');
		$('#methodTr').hide();
		$('#methodTr2').hide();
		methodOpen = false;
		calcOpen = false;
	}
	
	//날짜 계산
	function caldate(day) {
		var caledmonth, caledday, caledYear;
		var loadDt = new Date();
		var v = new Date(Date.parse(loadDt) - day * 1000 * 60 * 60 * 24);

		caledYear = v.getFullYear();

		if (v.getMonth() + 1 < 10) {
			caledmonth = '0' + (v.getMonth() + 1);
		} else {
			caledmonth = v.getMonth() + 1;
		}

		if (v.getDate() < 10) {
			caledday = '0' + v.getDate();
		} else {
			caledday = v.getDate();
		}
		return caledYear + '-' + caledmonth + '-' + caledday;
	}
	
	// 시험일지출력
	function btn_Print_onclick(){
		
		var doc_seq = $("#doc_seq").val();
		var test_sample_seq = $('#mainGrid').getGridParam('selrow');
		var test_item_cd = $('#subGrid').getGridParam('selrow');
		if(fnIsEmpty(test_item_cd)){
			alert("선택된 항목이 없습니다.");
			return;
		}
		if(fnIsEmpty(doc_seq)){
			alert("출력하실 양식을 선택해주세요.");
			return;
		}
		var url = "testReportView.lims?test_sample_seq=" + test_sample_seq+ "&test_item_cd="+test_item_cd+"&doc_seq="+doc_seq;
		$('#excelReportForm').attr({action:url, method:'post'}).submit();
		
	}
	
	// 시험방법팝업 콜백
	function fnpop_methodCallback(rowId){
		
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('mainGrid');
		fn_Excel_Download(data);
	}
	
</script>

<div class="sub_purple_01 w100p">
	<table class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				시료 목록
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">				
				<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_select_onclick();">
					<button type="button">조회</button>
				</span>
				<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
					<button type="button">EXCEL</button>
				</span>
			</td>
		</tr>
	</table>
	<form id="testReportMainForm" name="testReportMainForm" onsubmit="return false;">		
		<table class="list_table" >
			<tr>
				<th>접수번호</th>
				<td>
					<input name="test_req_no" id="test_req_no" type="text" class="inputhan w200px" />
				</td>
				<th>업체명</th>
				<td>
					<input name="req_org_nm" id="req_org_nm" type="text" class="inputhan w200px" />
				</td>
				<th>접수일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" style="text-align: center; width: 80px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" style="text-align: center; width: 80px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>		
			</tr>
			<tr>
				<th>시료번호</th>
				<td>
					<input name="test_sample_seq" id="test_sample_seq" type="text" class="inputhan w200px" />
				</td>
				<th>시료명</th>
				<td>
					<input name="sample_reg_nm" id="sample_reg_nm" type="text" class="inputhan w200px" />
				</td>				
				<th>진행상태</th>
				<td>
					<label><input type='radio' id="state" name='state' value='' style="width: 20px" />전체</label> 
					<label><input type='radio' id="state" name='state' value='Y' style="width: 20px" checked="checked" />시험중</label> 
					<label><input type='radio' id="state" name='state' value='N' style="width: 20px" />시험완료</label>
				</td>
			</tr>
		</table>		
		<div id="view_grid_main">
			<table id="mainGrid"></table>
		</div>
	</form>
</div>

<div class="sub_blue_01 w20p" style="clear:both;">
	<table class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				시험 항목
			</td>			
		</tr>
	</table>
	<form id="testReportSubForm" name="testReportSubForm" onsubmit="return false;">
	<input type="hidden" id="test_sample_seq" name="test_sample_seq"/>
		<div id="view_grid_sub">
			<table id="subGrid"></table>
		</div>
	</form>
</div>
<div class="w5p">
</div>
<div class="sub_blue_01 w75p">
	<form id="inputSampleForm" name="inputSampleForm" onsubmit="return false;">
	<input type="hidden" id="test_std_no" name="test_std_no">
		<div class="sub_purple_01 w100p">
			<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						시료정보
					</td>
					<td class="table_button">
					<!-- <select id="doc_seq" name="doc_seq" class="w200px"></select>
					<span class="button white mlargeb auth_select" id="btn_print" onclick="btn_Print_onclick();">
						<button type="button">시험일지출력</button>
					</span> -->
					<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
				</tr>
			</table>
			<table class="list_table" >
				<tr>
					<th class="w150px">접수번호</th>
					<td>
						<label id="vw_test_sample_no"></label>
					</td>
					<th class="w150px">시료명</th>
					<td>
						<label id="vw_sample_reg_nm"></label>
					</td>
				</tr>
				<tr>
					<th class="w150px">시료유형</th>
					<td>
						<label id="vw_sample_nm"></label>
					</td>
					<th class="w150px">검사기준</th>
					<td>
						<label id="vw_test_std_nm"></label>
					</td>
				</tr>
			</table>
			<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						시험기기
					</td>				
				</tr>				
			</table>
			<table class="list_table" >
				<tr>
					<th class="w150px">시험기기명/영문명</th>
					<td>
						<input type="text" id="inst_kor_nm" name="inst_kor_nm" class="w200px" readonly="readonly" />
						<input type="text" id="inst_eng_nm" name="inst_eng_nm" class="w200px" readonly="readonly" />
						<input type="hidden" id="inst_no" name="inst_no" />
						<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_equip_view" onclick="btn_search_onclick('equip');"/>
					</td>
				</tr>
			</table>
			<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						시험방법
					</td>							
				</tr>			
			</table>
			<table class="list_table" >
				<tr>
					<th class="w150px">시험방법명</th>
					<td colspan="3">
						<input type="text" id="test_method_nm" name="test_method_nm" class="inputhan w200px" readonly="readonly"/>
						<input type="hidden" id="test_method_no" name="test_method_no" />
						<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_method_serach" onclick="btn_search_onclick('method');"/>
						<span class="button white mlargep auth_select" id="btn_method_View" style="float: right;" onclick="btn_detail_onclick('method');">
							<button type="button">상세보기</button>
						</span>
					</td>
				</tr>					
				<tr id="methodTr">
					<th class="w150px">전처리</th>
					<td colspan="3" style="padding: 0px;">
						<textarea id="test_method_preclean" name="test_method_preclean" rows="15" style="width: 100%" readonly="readonly"></textarea>
					</td>
				</tr>
				<tr id="methodTr2">
					<th class="w150px">시험방법</th>
					<td colspan="3" style="padding: 0px;">
						<textarea id="test_method_content" name="test_method_content" rows="15" style="width: 100%" readonly="readonly"></textarea>
					</td>
				</tr>
			</table>			
			<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						계산식
					</td>			
				</tr>				
			</table>
			<table class="list_table" >
				<tr>
					<th class="w150px">계산식명</th>
					<td class="w300px">
						<label id="account_nm"></label>
						<input type="hidden" id="account_no" name="account_no" />
						<img style="vertical-align: text-bottom; cursor: pointer; display: none;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_calc_view" onclick="btn_search_onclick('calc');"/>
					</td>
					<th class="w150px">결과값</th>
					<td class="w300px">
						<label id="result_val"></label>
					</td>
				</tr>
				<tr>
					<th class="w150px">계산식</th>
					<td>
						<label id="account_tot_disp"></label>
					</td>
					<th class="w150px">계산식결과(입력값)</th>
					<td>
						<label id="account_tot_cal_disp"></label>
					</td>
				</tr>
				<tr>
					<th class="w150px">변수설명</th>
					<td colspan="4" style="padding: 0px;">
						<textarea id="account_val_desc" name="account_val_desc" rows="5" style="width: 100%" readonly="readonly"></textarea>
					</td>
				</tr>
				<tr>
					<th class="w150px">변수입력값</th>
					<td colspan="4" style="padding: 0px;">
						<textarea id="account_val_desc_tot" name="account_val_desc_tot" rows="5" style="width: 100%" readonly="readonly"></textarea>
					</td>
				</tr>
			</table>
			<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						시험일지
					</td>		
				</tr>				
			</table>
			<table class="list_table" >
				<tr>
					<td colspan="4" style="padding: 0px;">					
						<textarea id="test_report_content" name="test_report_content" rows="15" style="width: 100%"></textarea>
					</td>
				</tr>
			</table>
		</div>
	</form>
	<form id="excelReportForm" name="excelReportForm"></form>
</div>
