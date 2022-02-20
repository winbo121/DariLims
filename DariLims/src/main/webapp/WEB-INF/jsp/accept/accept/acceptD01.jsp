
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 접수
	 * 파일명 		: acceptD01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<style>
 	.w75p .list_table th {min-width:120px; max-width:200px;}
	.w75p .list_table td {min-width:320px;}
	.w75p .list_table td.td_min2 {min-width:240px;}
	
	.org .ui-tabs .ui-tabs-nav .ui-tabs-anchor {padding:.5em .5em;}
	.org .list_table th, .org .list_table td {border:none;}
	.org .list_table th {height:24px;}
	#tabOrgDiv1 th, #tabOrgDiv2 th, #tabOrgDiv3 th, #tabOrgDiv4 th, #tabOrgDiv5 th {min-width:80px;}
</style>
<script type="text/javascript">	
	$(function() {		
		/* 세부권한검사 */
		fn_auth_check();
		
		var feeArr = new Array();
		feeArr.push('fee_group_nm');
		//feeArr.push('fee');

		
		fnDatePickerImg2('sample_arrival_date');
		fnDatePickerImg2('deadline_date');
		fnDatePickerImg2('test_end');
		
		var stateWay=$('#reqDetailForm').find('#state').val()
	
		
		if(stateWay==null || stateWay =="" || stateWay=="A" ){
			ajaxCheckboxForm('collect_method_checkbox', "C71", 'ALL', 'collect_method', 'reqDetailForm', collectList);
			ajaxCheckboxForm('collect_div_checkbox', "C72", 'ALL', 'collect_div', 'reqDetailForm', collectList);
			fnDatePickerImg('req_date');
			gotoEdit1()
			
		}
		else{
		    $("#title").attr("readonly",true)
		    $("input[name=express_flag]").attr("disabled",true)
			$("#reg_type").attr("disabled",true)
			$("input[name=fee_auto_flag]").attr("disabled",true)
			$("#est_title").attr("readonly",true)
			$("#commission_type").attr("disabled",true)
			$("input[name=est_check]").attr("disabled",true)
			$("input[name=rawdata_flag]").attr("disabled",true)
			$("input[name=accept_method]").attr("disabled",true)
			$('#QR_file_upload').prop('disabled', true);
			$("#calculation").attr("readonly",true) 
			$("#req_message").attr("readonly",true)
			$("#sales_dept_cd").attr("disabled",true)
			$("#sales_user_id").attr("disabled",true)
			$("#req_basis").attr("readonly",true) 
			$("#dept_cd").attr("disabled",true)
			$("#unit_work_cd").attr("disabled",true)
			$("#quality_dept_cd1").attr("disabled",true)
			$("#quality_user_id1").attr("disabled",true)
			$("#quality_dept_cd2").attr("disabled",true)
			$("#quality_user_id2").attr("disabled",true)
			$("#test_count").attr("readonly",true) 
			$("#sampling_no").attr("readonly",true) 
			$("#sample_num").attr("readonly",true)
			$("input[name=test_place]").attr("disabled",true)
			$("#addr_report").attr("readonly",true) 
			$("#tel_report").attr("readonly",true) 
			$("#fax_report").attr("readonly",true)
			$("#collect_method_checkbox").attr("disabled",true)
			$("#collect_div_checkbox").attr("disabled",true)
			$("#barcode_desc").attr("readonly",true)
			$("#req_nm").attr("readonly",true)
			$("#req_plant_nm").attr("readonly",true)
			$("#req_plant_addr").attr("readonly",true)
			$("#req_plant_tel").attr("readonly",true)
			$("#admin_message").attr("readonly",true)
			$("#test_goal").attr("disabled",true)
			$("#zip_code").attr("readonly",true)
			$("#addr1").attr("readonly",true)
			$("#addr2").attr("readonly",true)
			$("input[name=req_org1]").attr("disabled",true)
			$("input[name=req_org2]").attr("disabled",true)
			$("input[name=req_org3]").attr("disabled",true)
			$("input[name=req_org4]").attr("disabled",true)
			$("#startDateStop").attr("src", "");
			$("#est_pop").attr("src", "");
			$("#clear_add_file").attr("src", "");
			$("#btn_test_place").attr("src", "");
			$("#btn_Req_Org1").attr("src", "");
			$("#btn_Req_Org2").attr("src", "");
			$("#btn_Req_Org3").attr("src", "");
			$("#btn_Req_Org4").attr("src", "");
			ajaxCheckboxForm1('collect_method_checkbox', "C71", 'ALL', 'collect_method', 'reqDetailForm', collectList);
			ajaxCheckboxForm1('collect_div_checkbox', "C72", 'ALL', 'collect_div', 'reqDetailForm', collectList);
			gotoEdit2()
		
			
				
		}	
			
			/*
			var e = document.forms;
			$("#reqDetailForm").attr('readonly', true);
				for(i=0; i<e.length; i++){
					for(j=0; j<e[i].elements.length; j++){
						if(e[i].id=='reqDetailForm'){

						
							e[i].elements[j].style.backgroundColor = "#E2E2E2";
						}
					}
				}
				*/
		ajaxComboForm("req_class", "C70", "${detail.req_class}", "", "reqDetailForm");

<c:choose>								
	<c:when test="${empty detail.test_req_seq}">
		$("#reqDetailForm").find("#req_class").removeAttr("disabled");
		ajaxComboForm("commission_type", "C61", "C61002", "NON", "reqDetailForm");
	</c:when>
	<c:otherwise>
		ajaxComboForm("commission_type", "C61", "${detail.commission_type}", "NON", "reqDetailForm");
		//최초입력이 아닐땐 변경불가
		$("#reqDetailForm").find("#req_class").attr("disabled",true);
	</c:otherwise>
</c:choose>
		

		ajaxComboForm("test_goal", "C05", "${detail.test_goal}", "", "reqDetailForm");
		ajaxComboForm("req_type", "C23", "${detail.req_type}", "EX1", "reqDetailForm");
		
		ajaxComboForm("sensory_test", "C65", "${detail.sensory_test}", "EX1", "reqDetailForm");
		ajaxStdComboForm("test_std_no", "", "${detail.test_std_no}", "", "reqDetailForm");
		fn_show_type($(":input:radio[name=fee_auto_flag]:checked").val());
		
		attGbnEdit = fnGridCommonCombo("C83", "NON");	
		
		// 성적서 발행예정일 넣기
		$('#reqDetailForm').find("#sample_arrival_date").change(function() {
			var express_flag = $(":input:radio[name=express_flag]:checked").val();
			dateSetting(express_flag);			
		});
		
		// 수입한약재인경우 관능검사를 선택한다.
		if('${detail.req_type}' == 'E'){
			$("#sensory_test").attr("disabled", false);
		}

		//영업당담자 
		if ('${detail.sales_dept_cd }' == '') {
			ajaxComboForm("sales_dept_cd", "", "", null, 'reqDetailForm');
		} else {
			ajaxComboForm("sales_dept_cd", "", "${detail.sales_dept_cd }", null, 'reqDetailForm');
		}
		ajaxComboForm("sales_user_id", $('#reqDetailForm').find("#sales_dept_cd").val(), "${detail.sales_user_id }", "", 'reqDetailForm');
		$('#reqDetailForm').find("#sales_dept_cd").change(function() {
			ajaxComboForm("sales_user_id", $('#reqDetailForm').find("#sales_dept_cd").val(), "CHOICE", "", 'reqDetailForm');
		});

		//품질검사원 1
		if ('${detail.quality_dept_cd1 }' == '') {
			ajaxComboForm("quality_dept_cd1", "", "", null, 'reqDetailForm');
		} else {
			ajaxComboForm("quality_dept_cd1", "", "${detail.quality_dept_cd1 }", null, 'reqDetailForm');
		}

		ajaxComboForm("quality_user_id1", $('#reqDetailForm').find("#quality_dept_cd1").val(), "${detail.quality_user_id1 }", "", 'reqDetailForm');
		$('#reqDetailForm').find("#quality_dept_cd1").change(function() {
			ajaxComboForm("quality_user_id1", $('#reqDetailForm').find("#quality_dept_cd1").val(), "CHOICE", "", 'reqDetailForm');
		});

 		//품질검사원 2
		if ('${detail.quality_dept_cd2 }' == '') {
			ajaxComboForm("quality_dept_cd2", "", "", null, 'reqDetailForm');
		} else {
			ajaxComboForm("quality_dept_cd2", "", "${detail.quality_dept_cd2 }", null, 'reqDetailForm');
		}

		ajaxComboForm("quality_user_id2", $('#reqDetailForm').find("#quality_dept_cd2").val(), "${detail.quality_user_id2 }", "", 'reqDetailForm');

		$('#reqDetailForm').find("#quality_dept_cd2").change(function() {
			ajaxComboForm("quality_user_id2", $('#reqDetailForm').find("#quality_dept_cd2").val(), "CHOICE", "", 'reqDetailForm');
		});
		 
		
		if ('${detail.dept_cd }' == '') {
			if ($("#saveType").val() == 'receipt') {
				ajaxComboForm("dept_cd", "", "", null, 'reqDetailForm');
			} else {
				ajaxComboForm("dept_cd", "", "${session.dept_cd }", null, 'reqDetailForm');
			}
		} else {
			ajaxComboForm("dept_cd", "", "${detail.dept_cd }", null, 'reqDetailForm');
		}

		//부서별 단위업무 연동안함
		//ajaxComboForm("unit_work_cd", '', null, null, 'reqDetailForm');
		//부서별 단위업무 연동
		ajaxComboForm("unit_work_cd", $('#reqDetailForm').find("#dept_cd").val(), "${detail.unit_work_cd }", null, 'reqDetailForm');

		$('#reqDetailForm').find("#dept_cd").change(function() {
			ajaxComboForm("unit_work_cd", $('#reqDetailForm').find("#dept_cd").val(), "CHOICE", null, 'reqDetailForm');
		});

		// '의뢰 구분' 이 바뀔때 마다
		$('#reqDetailForm').find("#req_type").change(function() {
			var req_type = $(this).val();
			if(req_type =='E'){
				$("#sensory_test").attr("disabled", false);
				alert("수입한약재 관능검사 필수선택");
			}else{
				$("#sensory_test").val("");
				$("#sensory_test").attr("disabled", "disabled");
			}
		});
		
		// 수수료 변경시
		$('#reqDetailForm').find("#fee_tot_est").keyup(function() {			
			var val = $(this).val().replace(',', '');
			
			$('#reqDetailForm').find("#fee_tot_est").val(val);
			$('#reqDetailForm').find("#fee_tot_est").text(val);
			//var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				$.showAlert('숫자만 입력가능합니다.');
				$(this).val(val.substring(0, val.length - 1));
			} else {
				fn_Tot_Calculate_1($(":input:radio[name=discount_flag]:checked").val());
			}
		});
		
		// 할인률 변경시
		$('#reqDetailForm').find("#discount_rate").keyup(function() {
			var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				$.showAlert('숫자만 입력가능합니다.');
				$(this).val(val.substring(0, val.length - 1));
			} else {
				fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
			}
		});
		
		
		$('#reqDetailForm').find("#travel_exp").keyup(function() {
			var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				$.showAlert('숫자만 입력가능합니다.');
				$(this).val(val.substring(0, val.length - 1));
			} else {
				fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
			}
		});

		$('#reqDetailForm').find('#req_type option[value=]').remove();
		
		// 의뢰 페이지
		if ($("#saveType").val() == 'receipt') {
			$('#btn_Req_Org1').show();
			$('#btn_Req_Org2').show();
			$('#btn_Req_Org3').show();
			$('#btn_Req_Org4').show();
			$('#btn_Accept').hide();
			if ('${detail.req_type}' == '') {
				$('#reqDetailForm').find('#req_org_nm').val('');
			}
			var state = $('#reqDetailForm').find('#state').val();
			if (state == '') {
				$('#reqDetailForm').find('#req_id').val('');
				$('#reqDetailForm').find('#req_nm').val('');
			}
			$('#reqItemGrid').showCol(feeArr);
		} else {
			$('#reqItemGrid').hideCol(feeArr);
			if ('${detail.req_type}' == '') {
			} else if ('${detail.req_type}' == 'C23001') {
				$('#reqItemGrid').showCol(feeArr);
			}
			var state = $('#reqDetailForm').find('#state').val();
			if (state == 'B' || state == 'A') {
				$('#reqDetailForm').find('#dept_nm').text($('#reqDetailForm').find('#dept_cd option:selected').text());
				$('#reqDetailForm').find('#dept_cd').hide();
				$('#reqDetailForm').find('#dept_nm').show();
			}
		}
		if ($('#reqDetailForm').find('#req_date').val() == '') {
			$('#reqDetailForm').find('#req_date').val(fnGetToday(0,0));
		}
		if ($('#reqDetailForm').find('#sample_arrival_date').val() == '') {
			$('#reqDetailForm').find('#sample_arrival_date').val(fnGetToday(0,0));
			
			var express_flag = $(":input:radio[name=express_flag]:checked").val();
			dateSetting(express_flag);		
		}

		$('#reqDetailForm').find("#zip_code").keyup(function() {
			var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				$.showAlert('숫자만 입력가능합니다.');
				$(this).val(val.substring(0, val.length - 1));
			}
			if (val.length == 3) {
				$(this).val(val + '-');
			}
		});
		fn_Item_Count();
		fn_Tot_Calculate_1($(":input:radio[name=discount_flag]:checked").val());		
		
		$('#tabsCom').tabs({
			create : function(event, ui) {
			},
			activate : function(event, ui) {
				var TabNo = $('#tabsCom').tabs('option', 'active');
				TabNo ++;
			}
		});
		
		//의뢰별 문서 리스트
		requestFileGrid('accept/selectRequestFileList.lims', 'requestFileForm', 'requestFileGrid'); 	
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');

		$(window).bind('resize', function() {
			$("#requestFileGrid").setGridWidth($('#view_grid_request_file').width(), false);
		}).trigger('resize');
		
		$('#orgTab1').click(function(){
			$('#orgTabHref1').get(0).click();
		});
		$('#orgTab2').click(function(){
			$('#orgTabHref2').get(0).click();
		});
		$('#orgTab3').click(function(){
			$('#orgTabHref3').get(0).click();
		});
		$('#orgTab4').click(function(){
			$('#orgTabHref4').get(0).click();
		});
		$('#orgTab5').click(function(){
			$('#orgTabHref5').get(0).click();
		});
	});
	
	// 의뢰별 문서 리스트
	var lastRowId;
	function requestFileGrid(url, form, grid) {
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
				label : '의뢰 문서 번호',
				name : 'att_seq',
				hidden : true,
				key : true
			}, {
				label : '의뢰 번호',
				name : 'test_req_seq',
				align : 'center',
				hidden : true
			}, {
				label : '첨부 문서명',
 				name : 'file_nm',
				width : '200',
				formatter : displayRequestAlink,
				align : 'center'
			}, {
				index : 'not',
				label : '문서 구분',
				name : 'req_att_gbn',
				sortable : false,
				align : 'center',
				editable : true,
				edittype : "select",
				editoptions : {
					value : attGbnEdit
				},
				formatter : 'select',
				width : '120',
				align : 'center'
			}],
			
			gridComplete : function() {
				$('#requestFileForm').find('#insertRequestBtn').show();
				$('#requestFileForm').find('#updateRequestBtn').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#requestFileForm').find('#att_seq').val(row.att_seq);
				$('#requestFileForm').find('#insertRequestBtn').hide();
				$('#requestFileForm').find('#updateRequestBtn').show();

				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null);
			}
		});
		
	}
	
	// 항목 수수료 입력 종류 선택
	function fn_show_type(fee_auto_flag) {
		// 항목수수료 자동 계산
		if(fee_auto_flag == 'Y'){
// 			var ids = $('#reqSampleGrid').jqGrid("getDataIDs");
// 			if (ids.length > 0) {
// 				var subids = $('#reqItemGrid').jqGrid("getDataIDs");
// 				if(subids.length > 0) {
// 					$('#reqItemGrid').trigger('reloadGrid');
// 				}else{
// 					fnSelectFirst("reqSampleGrid");
// 				}
// 			}
			var test_req_seq = $('#reqDetailForm').find('#test_req_seq').val();	
			$('#reqDetailForm').find("#fee_tot_item").show();			
			$('#reqDetailForm').find("#fee_tot_est").hide();
			if(test_req_seq != '' && test_req_seq != null){
				fn_Item_Count();
				fn_Fee_Calculate();
			}
		// 항목수수료 수동 입력
		}else {
			$('#reqDetailForm').find("#fee_tot_est").show();			
			$('#reqDetailForm').find("#fee_tot_item").hide();
		}
		fn_Item_Count();
		fn_Tot_Calculate_1($(":input:radio[name=discount_flag]:checked").val());
	}
	
	// 전체 적용
	function fn_reqOrgChoice(num, radioNum){
		var req_org_no = $('#reqDetailForm').find("#req_org_no"+radioNum).val();
		var req_org_nm = $('#reqDetailForm').find("#req_org_nm"+radioNum).val();
		var req_org_addr = $('#reqDetailForm').find("#req_org_addr"+radioNum).val();
		var charger_tel = $('#reqDetailForm').find("#charger_tel"+radioNum).val();
		if(num == "0"){
			if( req_org_no != null && req_org_no != ""){
				if( confirm("업체정보를 초기화 하고 다시 선택하시겠습니까?")){
					$('#reqDetailForm').find("#req_org_no").val("");
					$('#reqDetailForm').find("#req_org_nm").val("");
					$('#reqDetailForm').find("#req_nm").val("");
					$('#reqDetailForm').find("#req_org_addr").val("");
					$('#reqDetailForm').find("#charger_tel").val("");
					$('#reqDetailForm').find("#email").val("");
					$('#reqDetailForm').find("#req_org_no2").val("");
					$('#reqDetailForm').find("#req_org_nm2").val("");
					$('#reqDetailForm').find("#req_nm2").val("");
					$('#reqDetailForm').find("#req_org_addr2").val("");
					$('#reqDetailForm').find("#charger_tel2").val("");
					$('#reqDetailForm').find("#req_org_no3").val("");
					$('#reqDetailForm').find("#req_org_nm3").val("");
					$('#reqDetailForm').find("#req_nm3").val("");
					$('#reqDetailForm').find("#req_org_addr3").val("");
					$('#reqDetailForm').find("#charger_tel3").val("");
					$('#reqDetailForm').find("#req_org_no4").val("");
					$('#reqDetailForm').find("#req_org_nm4").val("");
					$('#reqDetailForm').find("#req_nm4").val("");
					$('#reqDetailForm').find("#req_org_addr4").val("");
					$('#reqDetailForm').find("#charger_tel4").val("");
					$('#reqDetailForm').find("#btn_Req_Org1").show();
					$('#reqDetailForm').find("#btn_Req_Org2").show();
					$('#reqDetailForm').find("#btn_Req_Org3").show();
					$('#reqDetailForm').find("#btn_Req_Org4").show();
				}
			} else {
				$(":input:radio[name=req_org1]").removeAttr("checked");
				alert("선택한 업체 정보가 없습니다.");
				return false;
			}
		}
		if(num == "1"){
			if( req_org_no != null && req_org_no != ""){
				$('#reqDetailForm').find("#req_org_no2").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm2").val(req_org_nm);
				$('#reqDetailForm').find("#charger_tel2").val(charger_tel);
				$('#reqDetailForm').find("#req_org_addr2").val(req_org_addr);
				$('#reqDetailForm').find("#req_org_no3").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm3").val(req_org_nm);
				$('#reqDetailForm').find("#charger_tel3").val(charger_tel);
				$('#reqDetailForm').find("#req_org_addr3").val(req_org_addr);
				$('#reqDetailForm').find("#req_org_no4").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm4").val(req_org_nm);
				$('#reqDetailForm').find("#charger_tel4").val(charger_tel);
				$('#reqDetailForm').find("#req_org_addr4").val(req_org_addr);
			} else {
				$(":input:radio[name=req_org1]").removeAttr("checked");
				alert("선택한 업체 정보가 없습니다.");
				return false;
			}
			$('#reqDetailForm').find("#btn_Req_Org1").hide();
			$('#reqDetailForm').find("#btn_Req_Org2").hide();
			$('#reqDetailForm').find("#btn_Req_Org3").hide();
			$('#reqDetailForm').find("#btn_Req_Org4").hide();
		}
		if( num == "2" ){
			if( req_org_no != null && req_org_no != ""){
				$('#reqDetailForm').find("#req_org_no2").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm2").val(req_org_nm);
				$('#reqDetailForm').find("#charger_tel2").val(charger_tel);
				$('#reqDetailForm').find("#req_org_addr2").val(req_org_addr);
			} else {
				$(":input:radio[name=req_org2]").removeAttr("checked");
				alert("선택한 업체 정보가 없습니다.");
				return false;
			}
			$('#reqDetailForm').find("#btn_Req_Org2").hide();
		} 
		if ( num == "3" ) {
			if( req_org_no != null && req_org_no != ""){
				$('#reqDetailForm').find("#req_org_no3").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm3").val(req_org_nm);
				$('#reqDetailForm').find("#charger_tel3").val(charger_tel);
				$('#reqDetailForm').find("#req_org_addr3").val(req_org_addr);
			} else {
				$(":input:radio[name=req_org3]").removeAttr("checked");
				alert("선택한 업체 정보가 없습니다.");
				return false;
			}
			$("#req_org_nm3").attr("disabled", "disabled");
			$('#reqDetailForm').find("#btn_Req_Org3").hide();
		}
		if ( num == "4" ) {
			if( req_org_no != null && req_org_no != "" ){
				$('#reqDetailForm').find("#req_org_no4").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm4").val(req_org_nm);
				$('#reqDetailForm').find("#charger_tel4").val(charger_tel);
				$('#reqDetailForm').find("#req_org_addr4").val(req_org_addr);
			} else {
				$(":input:radio[name=req_org4]").removeAttr("checked");
				alert("선택한 업체 정보가 없습니다.");
				return false;
			}
			$('#reqDetailForm').find("#btn_Req_Org4").hide();
		}
	}	
	
	// 의뢰처 팝업
	function fnpop_reqOrgChoice(name, width, hight, text){		
		fnpop_reqOrgChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}	
	//기타 선택하면 텍스트 상자 나오게하는것
	function EtcCheck(e){
		if(e.checked){
			if(e.id === "smp_mtd_etc"){
				document.getElementById('smp_mtd_etctext').style.display = "inline"
			}else if(e.id === "smp_class_etc"){
				document.getElementById('smp_class_etctext').style.display = "inline"
			}
		}else{
			if(e.id === "smp_mtd_etc"){
				document.getElementById('smp_mtd_etctext').value = "";
				document.getElementById('smp_mtd_etctext').style.display = "none"
			}else if(e.id === "smp_class_etc"){
				document.getElementById('smp_class_etctext').value = "";
				document.getElementById('smp_class_etctext').style.display = "none"
			}
		}
	}
	
	// 의뢰처 콜백
	function fnpop_reqOrgcallback(flag){

		if(flag == 'Y'){
			//alert(flag);
			$('#reqDetailForm').find('#discount_flag_n').removeAttr('checked');
			$('#reqDetailForm').find('#discount_flag_y').prop('checked', true);
		} else {
			$('#reqDetailForm').find('#discount_flag_y').removeAttr('checked');
			$('#reqDetailForm').find('#discount_flag_n').prop('checked', true);
		}
		//fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
		fnReqOrgUnpaidCheck();
		fnBasicEndLoading();
	}


	// 미수금 체크
	function fnReqOrgUnpaidCheck(){
		var data = "req_org_no=" + $('#reqDetailForm').find('#req_org_no').val();
		$.ajax({
			url : "accept/selectOrgUnpaid.lims",
			dataType : 'json',
			type : 'POST',
			async : false,
			data : data,
			success : function(json) {
				if(json.default_amt > 0){
					$('#req_org_unpaid').html("<font color=red>"+json.default_amt+"</font>");
				}else{
					$('#req_org_unpaid').html(""+json.default_amt);
				}
			},
			error : function() {
				$.showAlert('[010]서버에 접속할 수 없습니다.');
			}
		});
	}
	
	// 견적서 팝업
	function fnpop_estChoice(name, width, hight, text){		
		fnpop_estChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}		
	
	// 견적서 콜백
	function fnpop_estcallback(){
		// 견적서 체크
		$('#reqDetailForm').find("#fee_auto_flag_N").prop('checked',true);
		$('#reqDetailForm').find("#fee_auto_flag_Y").removeAttr('checekd');
		fn_show_type('N');
		fnBasicEndLoading();
	}
	
	// 기준 콤보
	function ajaxStdComboForm(obj, thisCode, type, name, form) {		
		var masterUrl = fn_getConTextPath();
		masterUrl += '/master/selectTestStdList.lims';
		v = "test_std_no";
		t = "test_std_nm";
		
		$.ajax({
			url : masterUrl,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : "test_std_no=" + thisCode,
			//data : data,
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				$("#" + obj).empty();
				$("#" + obj).append("<option selected value=''>선택</option>");
				$(json).each(function(index, entry) {
					if (type == entry[v] || type == entry[t]) {
						$("#" + obj).append("<option selected value='" + entry[v] + "'>" + entry[t] + "</option>");
					} else {
						$("#" + obj).append("<option value='" + entry[v] + "'>" + entry[t] + "</option>");
					}
					//$("#" + obj).append("<option selected value='" + entry[v] + "'>" + entry[t] + "</option>");
				});
				$("#" + obj).trigger('change');// 강제로 이벤트 시키기
			}
		});
	}

	function fn_member_flag_click(){
		fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
	}
	
	
	// 수수료 총액
	function fn_Tot_Calculate_1(rate_flag) {

			var fee_tot = 0;
			var fee_tot_est = $('#reqDetailForm').find('#fee_tot_est').val().replace(/[,]/g, '');
			var fee_tot_item = $('#reqDetailForm').find('#fee_tot_item').val().replace(/[,]/g, '');
			var fee_tot_precost = $('#reqDetailForm').find('#fee_tot_precost').val().replace(/[,]/g, '');
			
			fee_tot_est = fee_tot_est.replace( /(\s*)/g, "");
			fee_tot_item = fee_tot_item.replace( /(\s*)/g, "");
			fee_tot_precost = fee_tot_precost.replace( /(\s*)/g, "");
			
			if (fee_tot_est == undefined) {
				fee_tot_est = '0';
			}
			if (fee_tot_item == undefined) {
				fee_tot_item = '0';
			}
			if (fee_tot_precost == undefined) {
				fee_tot_precost = '0';
			}
			
			var travel_exp = $('#reqDetailForm').find('#travel_exp').val();
			if (travel_exp == undefined) {
				travel_exp = '0';
			}
			var discount_rate = $('#reqDetailForm').find('#discount_rate').val();
			if (discount_rate == undefined) {
				discount_rate = '0';
			}			
			
			// 항목수수료/견적수수료
			if($(":input:radio[name=fee_auto_flag]:checked").val() == 'Y'){
				if( fee_tot_item == '0' || fee_tot_item == '' ){
					fee_tot = fee_tot_item;
				}else{
					fee_tot = Number(fee_tot_item) + (Math.floor(Number(fee_tot_item) * 0.1));
				}
			} else {
				//fee_tot = fee_tot_est;
				if( fee_tot_est == '0' || fee_tot_est == '' ){
					fee_tot = fee_tot_est;
				}else{
					fee_tot = Number(fee_tot_est) + (Math.floor(Number(fee_tot_est) * 0.1));
				}
			}
			
			var tot = 0;

			// 할인 적용
			if( rate_flag == 'Y' ){
				if( discount_rate == '0' || discount_rate == '' ){
					fee_tot = fee_tot.replace(/[,]/g, '');
					travel_exp = travel_exp.replace(/[,]/g, '');
					tot = Number(fee_tot) + Number(travel_exp);
				} else {				
					if(travel_exp.replace(/[,]/g, '') == "" || travel_exp.replace(/[,]/g, '') == null){
						travel_exp = '0';
					} else {
						travel_exp = travel_exp.replace(/[,]/g, '');
					}
					
					if(discount_rate.replace(/[,]/g, '') == "" || discount_rate.replace(/[,]/g, '') == null){
						discount_rate = '0';
					} else {
						discount_rate = discount_rate.replace(/[,]/g, '');
					}
					// 할인율 계산
					tot = Number(fee_tot) + Number(travel_exp) + ((Number(fee_tot) + Number(travel_exp)) * (discount_rate * 0.01));
				}
			// 자동 수수료 계산 적용안함
			} else {			
				//fee_tot = fee_tot.replace(/[,]/g, '');
				
				travel_exp = travel_exp.replace(/[,]/g, '');
				
				tot = Number(fee_tot) + Number(travel_exp);
				
			}
			// 회원사 할인적용 
			var member_flag = $(":input:radio[name=member_flag]:checked").val();
			if(member_flag == 'Y'){
				tot = tot - (tot / 100 * 30);
			}
			
			// RAWDATA 발급비용적용 
// 			var rawdata_flag = $(":input:radio[name=rawdata_flag]:checked").val();
// 			if(rawdata_flag == 'Y'){
// 				tot = tot + (tot / 100 * 5);
// 			}
			// 원단위 절삭
			tot = (Math.floor(tot/10) * 10);
			//항목수수료일때만 일반 지급 입회 붙음 
			if($(":input:radio[name=fee_auto_flag]:checked").val() == 'Y'){
				var express_flag = $(":input:radio[name=express_flag]:checked").val();
				if(express_flag == 'N') {
					tot = tot;
					//dateSetting(express_flag);
				} else if(express_flag == 'Y') {
					tot = tot * 1.5;
					//dateSetting(express_flag);
				} else if(express_flag == 'X') {
					tot = tot * 2;
					//dateSetting(express_flag);
				}
			}
			//전처리비용
			tot = tot + Number(fee_tot_precost)
			//결과 값 넣기
			$('#reqDetailForm').find('#tot').text(commaNum(tot));
			$('#reqDetailForm').find('#fee_tot').val(commaNum(tot));
			if($(":input:radio[name=fee_auto_flag]:checked").val()== 'Y'){
				$('#reqDetailForm').find('#fee_tot_item').text(commaNum(tot));
			} else {
				$('#reqDetailForm').find('#fee_tot_est').text(commaNum(tot));
			}
	}
	
	function click_express() {
		fn_Tot_Calculate_1($(":input:radio[name=discount_flag]:checked").val());
		
		var express_flag = $(":input:radio[name=express_flag]:checked").val();
		if(express_flag == 'N') {
			tot = tot;
			dateSetting(express_flag);
		} else if(express_flag == 'Y') {
			tot = tot * 1.5;
			dateSetting(express_flag);
		} else if(express_flag == 'X') {
			tot = tot * 2;
			dateSetting(express_flag);
		}
	}
	
	/**
	*  2019-10-01 정언구
	*  채취 방법/구분에 세팅할 데이터를 서버에서 가져온 뒤 배열로 변환합니다.
	*/
	var collectList = [];
	var obj = null;
	<c:forEach var="vo" items="${collect}">
		obj = {};
		obj.preCode = "${vo.collect_pre_code}";
		obj.code = "${vo.collect_code}";
		obj.etc = "${vo.etc}";
		collectList.push(obj);
	</c:forEach>

	/**
	*  2019-10-01 정언구
	*  채취 방법/구분 체크박스를 생성합니다. 위에서 배열로 변환한 세팅 데이터를 인자로 넘겨줍니다.
	*/

	
	//시험 장소
	function fn_zipcode(form){
		fnpop_zipCodePop(form, '800', '500');
		fnBasicStartLoading();
	}	
	
	
	/* 	유지보수 리스트 775
	 *	일반 : 접수일 포함 5일 / ex) 일반 / 접수일 : 2020-05-11, 시험완료예정일 : 2020-05-14, 성적서발행예정일 : 2020-05-15
	 *	지급 : 접수일 포함 3일 / ex) 지급 / 접수일 : 2020-05-11, 시험완료예정일 : 2020-05-12, 성적서발행예정일 : 2020-05-13
	 *	입회 : 접수일 포함 2일 / ex) 입회 / 접수일 : 2020-05-11, 시험완료예정일 : 2020-05-12, 성적서발행예정일 : 2020-05-12
	 *	(입회의 경우 시험완료예정일과, 성적서 발행예정일이 동일합니다.)
	 *	(주말이나 연휴의 경우 빼고 계산합니다.)
	 *
	 *  주말은 fnDatePickerImg2 로 체크 불가하게하고, dayOfWeek로 넘김
	 *  공휴일은 disableSomeDay함수로 넘기게 함
	 *  공휴일 중, 일반 일 경우 날짜를 연산으로 하기 어려워서, 일반에 날짜 직접 작성해서 넣어줌
	 */
	
	function dateSetting(express_flag){//N:일반,Y:지급:X:입회<-현재 이거                Y:일반,N:지급:X:입회
		var addDate;//시험완료예정일
		var addDate2;//성적서발행예정일
		var week = ['일', '월', '화', '수', '목', '금', '토'];
		
		var date = $('#reqDetailForm').find('#sample_arrival_date').val();
		var dt = new Date(date);
		var dt1 = new Date(date);
		
		/*  일반    */
		if(express_flag == "N" || express_flag == "") {
			//설날 및 추석 (날짜 계산식 직접 넣어주기)
			var disabledAnotherDays = ["2020-09-28", "2020-09-29", "2021-02-08", "2021-02-09", "2021-02-10", "2021-09-15", "2021-09-16", "2021-09-17",
				  					   "2022-01-26", "2022-01-27", "2022-01-28" ];
			var test_end;
			var deadline_date;
				
			if ($.inArray(date,disabledAnotherDays)  != -1) {
				if (date == "2020-09-28") {test_end = '2020-10-06';deadline_date = '2020-10-07';}
				if (date == "2020-09-29") {test_end = '2020-10-07';deadline_date = '2020-10-08';}
				if (date == "2021-02-08") {test_end = '2021-02-15';deadline_date = '2021-02-16';}
				if (date == "2021-02-09") {test_end = '2021-02-16';deadline_date = '2021-02-17';}
				if (date == "2021-02-10") {test_end = '2021-02-17';deadline_date = '2021-02-18';}
				if (date == "2021-09-15") {test_end = '2021-09-23';deadline_date = '2021-09-24';}
				if (date == "2021-09-16") {test_end = '2021-09-24';deadline_date = '2021-09-27';}
				if (date == "2021-09-17") {test_end = '2021-09-27';deadline_date = '2021-09-28';}
				if (date == "2022-01-26") {test_end = '2022-02-03';deadline_date = '2022-02-04';}
				if (date == "2022-01-27") {test_end = '2022-02-04';deadline_date = '2022-02-07';}
				if (date == "2022-01-28") {test_end = '2022-02-07';deadline_date = '2022-02-08';}

				$('#reqDetailForm').find('#test_end').val(test_end);
				$('#reqDetailForm').find('#deadline_date').val(deadline_date);
				
			} else {
				addDate = 3;//시험완료예정일
				addDate2 = 1;//성적서발행예정일
	
				dt1.setDate(dt1.getDate() + addDate);
	
				dt1 = (disableSomeDay(dt1));
	
				var dayOfWeek = week[new Date(dt).getDay()];
				var dayOfWeek1 = week[new Date(dt1).getDay()];		
				
				//시험완료 예정일이 주말이면
				if(dayOfWeek == "금" && (express_flag == "N" || express_flag == "")){
					dt1.setDate(dt1.getDate() + 2);
				}else{
					if(dayOfWeek1 == "토" || dayOfWeek1 == "일"){
						dt1.setDate(dt1.getDate() + 2);
					}	
				}
				
				dt1 = (disableSomeDay(dt1));
				
				var y1 = dt1.getFullYear();
				var m1 = dt1.getMonth()+1;
				var d1 = dt1.getDate();
	
				if(m1 < 10){
					m1 = '0'+m1;
				}
				if(d1 < 10){
					d1 = '0'+d1;
				}
				$('#reqDetailForm').find('#test_end').val(y1+'-'+m1+'-'+d1);
				
				/* 성적서발행 예정일 */
				var dt2 = new Date($('#reqDetailForm').find('#test_end').val());
				dt2.setDate(dt1.getDate() + addDate2);			
				
				dt2 = (disableSomeDay(dt2));
				
				var dayOfWeek2 = week[new Date(dt2).getDay()];		
	
				if(dayOfWeek2 == "토" || dayOfWeek2 == "일"){
					dt2.setDate(dt2.getDate() + 2);
				}	
				var  dt3 = new Date(disableSomeDay(dt2));
				
				var y2 = dt3.getFullYear();
				var m2 = dt3.getMonth()+1;
				var d2 = dt3.getDate(); 
				
				if(m2 < 10){
					m2 = '0'+m2;
				}
				if(d2 < 10){
					d2 = '0'+d2;
				}
				
				$('#reqDetailForm').find('#deadline_date').val(y2+'-'+m2+'-'+d2);
			}

			
		/*  지급    */
		} else if (express_flag == "Y") {
			addDate = 1;//시험완료예정일
			addDate2 = 1;//성적서발행예정일
			
			dt1.setDate(dt1.getDate() + addDate);
			
			dt1 = (disableSomeDay(dt1));
			
			var dayOfWeek = week[new Date(dt).getDay()];
			var dayOfWeek1 = week[new Date(dt1).getDay()];		
			
			//시험완료 예정일이 주말이면
			if(dayOfWeek == "금" && (express_flag == "N" || express_flag == "")){
				dt1.setDate(dt1.getDate() + 2);
			}else{
				if(dayOfWeek1 == "토" || dayOfWeek1 == "일"){
					dt1.setDate(dt1.getDate() + 2);
				}	
			}
			
			dt1 = (disableSomeDay(dt1));
			
			var y1 = dt1.getFullYear();
			var m1 = dt1.getMonth()+1;
			var d1 = dt1.getDate();

			if(m1 < 10){
				m1 = '0'+m1;
			}
			if(d1 < 10){
				d1 = '0'+d1;
			}
			$('#reqDetailForm').find('#test_end').val(y1+'-'+m1+'-'+d1);
			
			/* 성적서발행 예정일 */
			var dt2 = new Date($('#reqDetailForm').find('#test_end').val());
			dt2.setDate(dt1.getDate() + addDate2);				
			
			dt2 = (disableSomeDay(dt2));
			
			var dayOfWeek2 = week[new Date(dt2).getDay()];		

			if(dayOfWeek2 == "토" || dayOfWeek2 == "일"){
				dt2.setDate(dt2.getDate() + 2);
			}			
			var  dt3 = new Date(disableSomeDay(dt2));
			
			var y2 = dt3.getFullYear();
			var m2 = dt3.getMonth()+1;
			var d2 = dt3.getDate(); 
			
			if(m2 < 10){
				m2 = '0'+m2;
			}
			if(d2 < 10){
				d2 = '0'+d2;
			}
			
			$('#reqDetailForm').find('#deadline_date').val(y2+'-'+m2+'-'+d2);
			
		/*  입회    */
		} else if (express_flag == "X") {
			addDate = 1;//시험완료예정일
			addDate2 = 0;//성적서발행예정일
			
			dt1.setDate(dt1.getDate() + addDate);
			
			dt1 = (disableSomeDay(dt1));
			
			var dayOfWeek = week[new Date(dt).getDay()];
			var dayOfWeek1 = week[new Date(dt1).getDay()];		
			
			//시험완료 예정일이 주말이면
			if(dayOfWeek == "금" && (express_flag == "N" || express_flag == "")){
				dt1.setDate(dt1.getDate() + 2);
			}else{
				if(dayOfWeek1 == "토" || dayOfWeek1 == "일"){
					dt1.setDate(dt1.getDate() + 2);
				}	
			}
			
			dt1 = (disableSomeDay(dt1));
			
			var y1 = dt1.getFullYear();
			var m1 = dt1.getMonth()+1;
			var d1 = dt1.getDate();

			if(m1 < 10){
				m1 = '0'+m1;
			}
			if(d1 < 10){
				d1 = '0'+d1;
			}
			$('#reqDetailForm').find('#test_end').val(y1+'-'+m1+'-'+d1);
			
			/* 성적서발행 예정일 */
			var dt2 = new Date($('#reqDetailForm').find('#test_end').val());
			dt2.setDate(dt1.getDate() + addDate2);	
			
			dt2 = (disableSomeDay(dt2));
			
			var dayOfWeek2 = week[new Date(dt2).getDay()];		

			if(dayOfWeek2 == "토" || dayOfWeek2 == "일"){
				dt2.setDate(dt2.getDate() + 2);
			}
			
			var  dt3 = new Date(disableSomeDay(dt2));
			
			var y2 = dt3.getFullYear();
			var m2 = dt3.getMonth()+1;
			var d2 = dt3.getDate(); 
			
			if(m2 < 10){
				m2 = '0'+m2;
			}
			if(d2 < 10){
				d2 = '0'+d2;
			}
			
			$('#reqDetailForm').find('#deadline_date').val(y2+'-'+m2+'-'+d2);
			
		} 	
	 
// 		var addDate;
// 		var week = ['일', '월', '화', '수', '목', '금', '토'];
// 		if(express_flag == "N" || express_flag == ""){
// 			addDate = 3;
// 		}else if(express_flag == "Y" ||express_flag == "X" ){
// 			addDate = 1;
// 		}else {
// 			addDate = 0;
// 		}
		
// 		var date = $('#reqDetailForm').find('#sample_arrival_date').val();
// 		var dt = new Date(date);
// 		var dt1 = new Date(date);
// 		var dt2 = new Date(date);
// 		//시험 완료예정일
// 		dt1.setDate(dt1.getDate() + addDate);
		
// 		var dayOfWeek = week[new Date(dt).getDay()];
// 		var dayOfWeek1 = week[new Date(dt1).getDay()];		
		
// 		if(dayOfWeek == "금" && (express_flag == "N" || express_flag == "")){
// 			dt1.setDate(dt1.getDate() + 2);
// 		}else{
// 			if(dayOfWeek1 == "토" || dayOfWeek1 == "일"){
// 				dt1.setDate(dt1.getDate() + 2);
// 			}	
// 		}
		
// 		var y1 = dt1.getFullYear();
// 		var m1 = dt1.getMonth()+1;
// 		var d1 = dt1.getDate();

// 		if(m1 < 10){
// 			m1 = '0'+m1;
// 		}
// 		if(d1 < 10){
// 			d1 = '0'+d1;
// 		}
// 		//성적서발행예정일
// 		//dt2.setDate(dt1.getDate() + 1);
// 		dt2.setDate(dt2.getDate() + addDate + 1);			
		
// 		var dayOfWeek2 = week[new Date(dt2).getDay()];		

// 		if(dayOfWeek2 == "금"){
// 			dt2.setDate(dt2.getDate() + 3);
// 		}
// 		if(dayOfWeek2 == "토" || dayOfWeek2 == "일"){
// 			dt2.setDate(dt2.getDate() + 2);
// 		}
		
// 		var y2 = dt2.getFullYear();
// 		var m2 = dt2.getMonth()+1;
// 		var d2 = dt2.getDate();
		
// 		if(m2 < 10){
// 			m2 = '0'+m2;
// 		}
// 		if(d2 < 10){
// 			d2 = '0'+d2;
// 		}
		
// 		$('#reqDetailForm').find('#test_end').val(y1+'-'+m1+'-'+d1);
// 		$('#reqDetailForm').find('#deadline_date').val(y2+'-'+m2+'-'+d2);
	}
	
	//제외할 날짜 - 공휴일
	var disabledDays = ["2020-5-5", "2020-6-6", "2020-8-15", "2020-10-3", "2020-10-9", "2020-12-25",
						"2021-1-1", "2021-3-1", "2021-5-5", "2021-5-19", "2021-6-6", "2021-8-15", "2021-10-3", "2021-10-9", "2021-12-25",
						"2022-1-1", "2022-3-1", "2022-5-5", "2022-5-8", "2022-6-6", "2022-8-15"];
	//제외할 날짜 - 설 및 추석
	var disabledBigDays = ["2020-9-30", "2020-10-1", "2020-10-2", "2021-2-11", "2021-2-12", "2021-2-13", "2021-9-20", "2021-9-21", "2021-9-22",
						   "2022-1-31", "2022-2-1", "2022-2-2" ];
	
	// 날짜를 나타내기 전에(beforeShowDay) 실행할 함수
	function disableSomeDay(date){		
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var dates = date.getDate();
		
		var add = 0;
		//배열에 해당하는 날짜는 날짜를 하루 추가. (날짜가 disabledDays 배열 안에 있으면 0 없으면 -1(false))//설날 추석 제외
		for (i = 0; i < disabledDays.length; i++) {
 			if ($.inArray(year + '-' + (month) + '-' + dates,disabledDays)  != -1){
 				add = 1;
 				//return [false];
			}  
		}
		//설날 및 추석(지급, 입회일떄)
		for (i = 0; i < disabledBigDays.length; i++) {
 			if ($.inArray(year + '-' + (month) + '-' + dates,disabledBigDays)  != -1){
 				//첫째날
 				if (year + '-' + (month) + '-' + dates == "2020-9-30" 
 						|| year + '-' + (month) + '-' + dates == "2021-2-11"
 						|| year + '-' + (month) + '-' + dates == "2021-9-20"
 						|| year + '-' + (month) + '-' + dates == "2022-1-31"){
 					add = 3;
 				}
 				//둘째날
 				if (year + '-' + (month) + '-' + dates == "2020-10-1" 
						|| year + '-' + (month) + '-' + dates == "2021-2-12"
						|| year + '-' + (month) + '-' + dates == "2021-9-21"
						|| year + '-' + (month) + '-' + dates == "2022-2-1"){
					add = 2;
				}
 				//셋째날
 				if (year + '-' + (month) + '-' + dates == "2020-10-2" 
						|| year + '-' + (month) + '-' + dates == "2021-2-13"
						|| year + '-' + (month) + '-' + dates == "2021-9-22"
						|| year + '-' + (month) + '-' + dates == "2022-2-2"){
					add = 1;
				}

			}  
		}

		date.setDate(date.getDate() + add);
		
		return date;
	}
	
	//의뢰별 첨부문서 문서 구분 저장
	function btn_Request_check_onclick(grid) {
		fnEditRelease(grid); // 수정모드 해제
		//var grid = 'requestFileGrid' ;
		
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			
			var isPng = row.file_nm.match(/.png/);
			var isJpg = row.file_nm.match(/.jpg/);
			var isBmp = row.file_nm.match(/.bmp/);
			var isGif = row.file_nm.match(/.gif/);
			var isPNG = row.file_nm.match(/.PNG/);
			var isJPG = row.file_nm.match(/.JPG/);
			var isBMP = row.file_nm.match(/.BMP/);
			var isGIF = row.file_nm.match(/.GIF/);
			if ( (row.req_att_gbn == 'C83002') 
					&& (isPng == ".png" || isJpg == ".jpg" || isBmp == ".bmp" || isGif == ".gif" 
							|| isPNG == "..PNG" || isJPG == ".JPG" || isBMP == ".BMP" || isGIF == ".GIF" ) ) {
				c++;
			} else if (row.req_att_gbn == 'C83001') {
				
			} else if (row.req_att_gbn == null || row.req_att_gbn == '') {
				alert('문서구분을 선택해 주시기 바랍니다.');
				$('#' + grid).trigger('reloadGrid');
				return false;	
			}else {
				alert('성적서 출력용 이미지는 png, jpg, bmp, gif 만 가능합니다.');
				$('#' + grid).trigger('reloadGrid');
				return false;	
			}
		}
		var json;
 		//성적서 이미지 중복 선택 불가
		if (c > 2) {
			alert('성적서 출력용 이미지는 두 개만 선택하실 수 있습니다.');
			$('#' + grid).trigger('reloadGrid');
			return false;
		} else {
			for ( var i in ids) {
 				var row = $('#' + grid).getRowData(ids[i]);
				// 문서 구분 저장
				var data = {
						'att_seq' : row.att_seq
						, 'req_att_gbn' : row.req_att_gbn
				};
	 			json = fnAjaxAction('accept/updateFileDivision.lims', data);
			}	
			if (json == null) {
				$.showAlert('저장 실패하였습니다.');
				$('#' + grid).trigger('reloadGrid');
			} else {				
				$.showAlert('저장 완료하였습니다.');
				fnpop_callback();
				fnEditRelease(grid); 
			} 	
		}
	}
	
</script>

<form id="reqDetailForm" name="reqDetailForm" onsubmit="return false;" enctype="multipart/form-data">
<input name="test_std_no" id="test_std_no" type="hidden" value="001"/>
	<div class="sub_purple_01" style="margin-top: 0px;">
		<table class="select_table" >
			<tr>
				<td  class="table_title">
					<span>■</span>
					의뢰 정보
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;" id="detailBtn">
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick('List');">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<div style="width: 100%; height: 100%; float: left; position: relative;">
	<div class="sub_purple_01 w75p" style="margin-top:0px; float: left;">
		<table class="list_table">
			<tr>
				<th>제목</th>
				<td>
					<input name="title" id="title" type="text" class="inputhan  w200px" value="${detail.title}"/>
					<input name="commission_amt_flag" id="commission_amt_flag" type="hidden" value="${detail.commission_amt_flag }"/>
				</td>
				<th class="indispensable">의뢰분류</th>
				<td class="td_min2">
					<input name="creater_id" id="creater_id" type="hidden" value="${detail.creater_id}" />
					<select name="req_class" id="req_class" class="inputCheck w150px" ></select>
					<input name="express_flag" id="express_flag_n" type="radio" value="N" <c:if test="${detail.express_flag == 'N'}">checked="checked"</c:if>
						<c:if test="${detail.express_flag == null}">checked="checked"</c:if> onclick="click_express()"/>
					<label for="express_flag_n">일반</label>	
					<input name="express_flag" id="express_flag_y" type="radio" value="Y" <c:if test="${detail.express_flag == 'Y'}">checked="checked"</c:if>
						 onclick="click_express()"/>
					<label for="express_flag_y">지급</label>
					<input name="express_flag" id="express_flag_x" type="radio" value="X" <c:if test="${detail.express_flag == 'X'}">checked="checked"</c:if>
						onclick="click_express()"/>
					<label for="express_flag_y">입회</label>				
				</td>
				
			</tr>
			<tr>
				<th class="indispensable">의뢰구분</th>
				<td >
					<select name="req_type" id="req_type" class="inputCheck w150px"></select>
					<select name="sensory_test" id="sensory_test" class="w100px" disabled="disabled"></select>
				</td>
				<th>의뢰번호/상태</th>
				<td class="td_min2">
					<c:if test="${detail.test_req_no == '' or detail.test_req_no == null}">
						<label id="vw_test_req_no2">저장후 의뢰번호가 생성됩니다.</label> &nbsp;&nbsp; <label id="vw_state2"></label>
					</c:if>
					<c:if test="${detail.test_req_no != '' and detail.test_req_no != null}">
						<label id="vw_test_req_no">${detail.test_req_no }</label> &nbsp;&nbsp; <label id="vw_state">진행상태 : ${detail.state}</label>
					</c:if>
					<input name="test_req_no" id="test_req_no" type="hidden" value="${detail.test_req_no }" />
					<input name="test_req_seq" id="test_req_seq" type="hidden" value="${detail.test_req_seq}" />
					<input name="state" id="state" type="hidden" value="${detail.process }" />
				</td>	
			</tr>
			<tr>
				<th class="indispensable">의뢰등록일자</th>
				<td class="td_min2">
					<input name="req_date" id="req_date" type="text" class="w100px inputCheck" value="${detail.req_date}" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("req_date")' />
				</td>
				<th>검체수/시험항목수</th>
				<td class="td_min2">
					&nbsp;검체 : <label id="sampleCnt"></label> &nbsp;개
					&nbsp;시험항목 : <label id="itemCnt"></label> &nbsp;항목
				</td>
			</tr>
			<tr id="feeTr">
				<th>
					검사수수료
				</th>
				<td>
					<!-- 항목수수료 fee_tot_item -->
					<input name="fee_tot_item" id="fee_tot_item" type="text" class="w80px ta_right" style="vertical-align: text-bottom;" value="${detail.fee_tot_item}"  readonly="readonly"/> 
					<input name="fee_tot_est" id="fee_tot_est" type="text" class="w80px ta_right" style="vertical-align: text-bottom;padding-right:0px;"  value="${detail.fee_tot_est}"/>원
					<input name="fee_tot_precost" id="fee_tot_precost" type="hidden" value="${detail.fee_tot_precost}"/>
					<input name="fee_auto_flag" id="fee_auto_flag_Y" type="radio" value="Y" onClick="fn_show_type($(this).val())"<c:if test="${detail.fee_auto_flag != 'N'}">checked="checked"</c:if>/>
					<label for="fee_auto_flag_Y">항목수수료</label>
					<input name="fee_auto_flag" id="fee_auto_flag_N" type="radio" value="N" onClick="fn_show_type($(this).val())"<c:if test="${detail.fee_auto_flag == 'N'}">checked="checked"</c:if>/>
					<label for="fee_auto_flag_N">견적수수료</label>
				</td>
				<th>견적서</th>
				<td class="td_min2">
					<input name="est_no" id="est_no" type="hidden" value="${detail.est_no}"/>
					<input name="est_title" id="est_title" type="text" value="${detail.est_title}"/>
					<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" id="est_pop" class="auth_select" onclick='fnpop_estChoice("reqDetailForm", "1000", "780")'/>
				</td>
			</tr>
			<tr>
				<th>최종수수료금액</th>
				<td>
					<label id="tot" style="text-align: right; margin-left: 10px;"></label> &nbsp; 원	
					<input name="fee_tot" id="fee_tot" type="hidden" class="ta_right" value="${detail.fee_tot}"/>				
					<label style="padding-left:15px;">수수료 납입 방법 : </label> 
					<select name="commission_type" id="commission_type" class="w80px"></select>
				</td>
				<th>견적서 전송여부</th>
				<td>
					<input name="est_check" id="est_check_n" type="radio" value="N" <c:if test="${detail.est_check != 'Y'}">checked="checked"</c:if>/>
					<label for="accept_method_n">전송안함</label>	
					<input name="est_check" id="est_check_y" type="radio" value="Y" <c:if test="${detail.est_check == 'Y'}">checked="checked"</c:if>/>
					<label for="est_check_y">전송함</label>
				</td>
			</tr>
			<tr>
				<th>RAWDATA 발급</th>
				<td>
					<input name="rawdata_flag" id="rawdata_flag_n" type="radio" value="N" onClick="fn_Rawdata_Flag($(this).val(), 'reqSampleGrid')" <c:if test="${detail.rawdata_flag != 'Y'}">checked="checked"</c:if>/>
					<label for="rawdata_flag_n">미발급</label>
					<input name="rawdata_flag" id="rawdata_flag_y" type="radio" value="Y" onClick="fn_Rawdata_Flag($(this).val(), 'reqSampleGrid')" <c:if test="${detail.rawdata_flag == 'Y'}">checked="checked"</c:if>/>
					<label for="rawdata_flag_y">발급</label>
				</td>
				<th>접수 방법</th>
				<td>
					<input name="accept_method" id="accept_method_a" type="radio" value="A" <c:if test="${detail.accept_method != 'B'}">checked="checked"</c:if>/>
					<label for="accept_method_a">방문 접수</label>	
					<input name="accept_method" id="accept_method_b" type="radio" value="B" <c:if test="${detail.accept_method == 'B'}">checked="checked"</c:if>/>
					<label for="accept_method_b">택배, 등기</label>
				</td>
				
			</tr>
			<tr>
				<th>QR코드 등록</th>
				<td colspan="5">
					<input name="QR_nm" id="QR_nm" type="hidden" value="${detail.QR_nm }" />
					 <c:if test="${detail.QR_nm == null ||  detail.QR_nm == ''}">
						<label id="file_name">첨부파일이 없습니다.</label>
					</c:if> 
					<c:if test="${detail.QR_nm != null && detail.QR_nm != ''}">
					 	<label id="file_name">${detail.QR_nm }</a></label>
						<img src="<c:url value='../images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("QR_file_upload"), fn_TextClear("QR_nm")' />
					</c:if>
					<input name="QR_file_upload" id="QR_file_upload" type="file" />  
				</td>
			</tr>
			<tr>
				<th>산출내역</th>
				<td colspan="5" style="padding:5px;">
					<textarea rows="3" name="calculation" id="calculation" class="w100p">${detail.calculation}</textarea>
				</td>
			</tr>
			<tr>				
				<th>비고</th>
				<td colspan="5" style="padding:5px;">
					<textarea rows="3" name="req_message" id="req_message" class="w100p">${detail.req_message}</textarea>
				</td>
			</tr>
			<tr>				
				<th>관리자 메모</th>
				<td colspan="5" style="padding:5px;">
					<textarea rows="3" name="admin_message" id="admin_message" class="w100p">${detail.admin_message}</textarea>
				</td>
			</tr>
		</table>
		<table class="select_table">
			<tr>
				<td width="20%" class="table_title" style="border-width: 0px;">
					<span>■</span>
					검사 정보
				</td>
			</tr>
		</table>	
		<table class="list_table" style="border-top: solid 1px #82bbce;">
			<tr>
				<th>영업담당자</th>
				<td >
					<select name="sales_dept_cd" id="sales_dept_cd" class="w150px "></select>
					<select name="sales_user_id" id="sales_user_id" class="w150px "></select>
				</td>
				<th>의뢰근거</th>
				<td>
					<input name="req_basis" id="req_basis" type="text" class="inputhan w200px" value="${detail.req_basis}" />
				</td>
			</tr>
			<tr>
				<th>주관부서</th>
				<td>
					<label id="dept_nm" style="display: none;"></label>
					<select name="dept_cd" id="dept_cd" class="w200px "></select>
				</td>
				<th class="indispensable">접수일자</th>
				<td class="td_min2">
					<input name="sample_arrival_date" id="sample_arrival_date" type="text" class="w100px inputCheck" value="${detail.sample_arrival_date }" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="sampleDateStop" style="cursor: pointer;" onClick='fn_TextClear("sample_arrival_date")' />
				</td>		
			</tr>
			<tr>
				<th>단위업무</th>
				<td>
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>
				<th class="indispensable">시험 완료예정일</th>
				<td class="td_min2">
					<input name="test_end" id="test_end" type="text" class="w100px inputCheck" value="${detail.test_end }" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startTestStop" style="cursor: pointer;" onClick='fn_TextClear("test_end")' />
				</td>		
			</tr>
			<tr>
				<th>검사목적</th>
				<td>
					<select name="test_goal" id="test_goal" class="w200px"></select>
				</td>
				<th class="indispensable">성적서 발행예정일</th>
				<td class="td_min2">
					<input name="deadline_date" id="deadline_date" type="text" class="w100px inputCheck" value="${detail.deadline_date }" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("deadline_date")' />
				</td>	
			</tr>
		</table>
		
		<table class="select_table">
			<tr>
				<td width="20%" class="table_title" style="border-width: 0px;">
					<span>■</span>
					검사 내용
				</td>
			</tr>
		</table>
		<table class="list_table" style="border-top: solid 1px #82bbce;">
		 	<tr>
				<th >품질검사원1</th>
				<td>
					<select name="quality_dept_cd1" id="quality_dept_cd1" class="w150px "></select>
					<select name="quality_user_id1" id="quality_user_id1" class="w150px "></select>
				</td>
				<th >품질검사원2</th>
				<td>
					<select name="quality_dept_cd2" id="quality_dept_cd2" class="w150px "></select>
					<select name="quality_user_id2" id="quality_user_id2" class="w150px "></select>
				</td>
			</tr>
			<tr>
				<th>수량</th>
				<td colspan = "10">
					<input name="test_count" id="test_count" type="text" class="inputhan w200px" value="${detail.test_count}" />
				</td>
			</tr>
			<tr>
				<th>Sampling NO </th>
				<td>
					<input name="sampling_no" id="sampling_no" type="text" class="inputhan w200px" value="${detail.sampling_no}"  />
				</td>
				<th>Sample Number</th>
				<td>
					<input name="sample_num" id="sample_num" type="text" class="inputhan w200px" value="${detail.sample_num}"  />
				</td>
			</tr> 
			<tr>
				<th>시험장소구분</th>
				<td colspan = "6">
					<input name="test_place" id="test_place_a" type="radio" value="A" <c:if test="${empty detail.test_place || detail.test_place == 'A'}">checked="checked"</c:if> />
					<label for="test_place_a">고정실험실</label>
					<input name="test_place" id="test_place_b" type="radio" value="B" <c:if test="${!empty detail.test_place && detail.test_place == 'B'}">checked="checked"</c:if> />
					<label for="test_place_b">현장실험</label>					
				</td>
			</tr>
			<tr>
				<th>시험장소</th>
				<td colspan = "6">
				<input name="zip_code" id="zip_code" type="text" style="width: 80px;"
				<c:if test="${empty detail.zip_code}">value="34141"</c:if>
				<c:if test="${!empty detail.zip_code}">value="${detail.zip_code }"</c:if>/> 
				<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="btn_test_place" onclick="fn_zipcode('reqDetailForm');">
				<input style="width: 350px;" name="addr1" id="addr1" type="text" class="inputhan" 
				<c:if test="${empty detail.addr1}">value="대전광역시 유성구 대학로 291"</c:if>
				<c:if test="${!empty detail.addr1}">value="${detail.addr1 }"</c:if>/>
				<input style="width: 350px;" name="addr2" id="addr2" type="text" class="inputhan"
				<c:if test="${empty detail.addr2}">value="N28동 에너지환경연구센터"</c:if>
				<c:if test="${!empty detail.addr2}">value="${detail.addr2 }"</c:if>/>
				</td>
			</tr>
			<tr>
				<th>시험장소(영문)</th>
				<td colspan = "6">
				<input style="width: 350px;" name="addr1_eng" id="addr1_eng" type="text" class="inputhan" 
				<c:if test="${empty detail.addr1_eng}">value="N28-dong KAIST, 291, Daehak-ro,"</c:if>
				<c:if test="${!empty detail.addr1_eng}">value="${detail.addr1_eng }"</c:if>/>
				<input style="width: 350px;" name="addr2_eng" id="addr2_eng" type="text" class="inputhan"
					<c:if test="${empty detail.addr2_eng}">value="Yuseong-gu, Daejeon"</c:if>
				<c:if test="${!empty detail.addr2_eng}">value="${detail.addr2_eng }"</c:if>/>
				</td>
			</tr>
			<tr>
				<th>성적서 주소 </th>
				<td colspan = "5">
					<input name="addr_report" id="addr_report" type="text" class="inputhan w600px" value="${detail.addr_report}"  />
				</td>
			</tr>
			<tr>
 				<th>성적서 전화번호 </th>
				<td >
					<input name="tel_report" id="tel_report" type="text" class="inputhan w300px" value="${detail.tel_report}"  />
				</td>
				<th>성적서 팩스</th>
				<td >
					<input name="fax_report" id="fax_report" type="text" class="inputhan w300px" value="${detail.fax_report}"  />
				</td>
			</tr> 
			<tr>
				<th>채취 방법</th>
				<td colspan="3">
					<span id="collect_method_checkbox"></span>
				</td>
			</tr>
			<tr>
				<th>채취 구분</th>
				<td colspan="3">
					<span id="collect_div_checkbox"></span>
				</td>
			</tr>
			<tr>				
				<th>라벨 설명</th>
				<td colspan="5" style="padding:5px;">
					<textarea rows="3" name="barcode_desc" id="barcode_desc" class="w100p">${detail.barcode_desc}</textarea>
				</td>
			</tr>
		</table> 

		<%-- <table class="select_table">
			<tr>
				<td width="20%" class="table_title" style="border-width: 0px;">
					<span>■</span>
					SMS 발송
				</td>
			</tr>
		</table>
		<table class="list_table" style="border-top: solid 1px #82bbce;">
			<tr>
				<th class="indispensable">발송여부</th>
				<td>
					<input name="sms_flag" id="sms_flag_n" type="radio" value="N" <c:if test="${detail.sms_flag != 'Y'}">checked="checked"</c:if>/>
					<label for="sms_flag_n">발송안함</label>	
					<input name="sms_flag" id="sms_flag_y" type="radio" value="Y" <c:if test="${detail.sms_flag == 'Y'}">checked="checked"</c:if>/>
					<label for="sms_flag_y">발송함</label>
				</td>		
				<th>메세지타입</th>
				<td>
					<input name="sms_type" id="sms_type_a" type="radio" value="A" <c:if test="${detail.sms_type != 'B'}">checked="checked"</c:if>/>
					<label for="sms_type_a">일반</label>	
					<input name="sms_type" id="sms_type_b" type="radio" value="B" <c:if test="${detail.sms_type == 'B'}">checked="checked"</c:if>/>
					<label for="sms_type_b">잔류농약</label>
				</td>
			</tr>
			<tr>
				<th>발송번호</th>
				<td colspan="3">
					<input name="sms_target" id="sms_target" type="text" class="inputhan w200px" value="${detail.sms_target}" />
				</td>
			</tr>
		</table> --%>
	</div>

	<div class="org" style="margin-left:1%; width: 24%; float: left; position: absolute; display: inline-block; padding-top: 1px;">
		<c:set var="tabName1" value="의뢰업체" />
		<c:set var="tabName2" value="소유업체" />
		<c:set var="tabName3" value="계산서발행업체" />
		<c:set var="tabName4" value="성적서발행업체" />
		<c:set var="tabName5" value="공장정보" />
		<div id="tabsCom" class="tabsCom" style="height: 99%;">
			<ul>
				<li id="orgTab1" style="width: 49%; cursor: pointer;">
					<a href="#tabOrgDiv1" id="orgTabHref1">${tabName1}</a>
				</li>
				<li id="orgTab2" style="width: 49%; cursor: pointer;">
					<a href="#tabOrgDiv2" id="orgTabHref2">${tabName2}</a>
				</li>
				<li id="orgTab3" style="width: 49%; cursor: pointer;">
					<a href="#tabOrgDiv3" id="orgTabHref3">${tabName3}</a>
				</li>
				<li id="orgTab4" style="width: 49%; cursor: pointer;">
					<a href="#tabOrgDiv4" id="orgTabHref4">${tabName4}</a>
				</li>
				<li id="orgTab5" style="width: 99%; cursor: pointer;">
					<a href="#tabOrgDiv5" id="orgTabHref5">${tabName5}</a>
				</li>
			</ul>
			<div id="tabOrgDiv1" style="height: 100%;">
				<table class="list_table">
					<tr>
						<th class="indispensable">업체명</th>
						<td>
							<input name="req_org_nm" id="req_org_nm" type="text" value="${detail.req_org_nm }" disabled="disabled"/>
							<input name="req_org_no" id="req_org_no" type="hidden" value="${detail.req_org_no }"  class="inputCheck"/>
							<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" id="btn_Req_Org1" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "의뢰업체")'/>
						</td>
					</tr>

					<tr>
						<th class="indispensable">의뢰자</th>
						<td class="td_min3_">
							<input name="req_nm" id="req_nm" type="text" class="inputhan inputCheck" value="${detail.req_nm}" />
							<input name="req_id" id="req_id" type="hidden" value="${detail.req_id}" />
						</td>									
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input name="req_org_addr" id="req_org_addr" type="text" value="${detail.req_org_addr}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td class="td_min3_">
							<input name="charger_tel" id="charger_tel" type="text" value="${detail.charger_tel}" class="" readonly="readonly" disabled="disabled"/>
						</td>								
					</tr>
					<tr>
						<th>EMAIL</th>
						<td class="td_min3_">
							<input name="email" id="email" type="text" value="${detail.email}" class="" readonly="readonly" disabled="disabled"/>
						</td>								
					</tr>
					<tr>
						<th>미납금액(원)</th>
						<td class="td_min3_" id="req_org_unpaid">
						</td>								
					</tr>
				</table>
				<div style="margin-top: 10px;">
					<input name="req_org1" id="req_org1" type="radio" value="Y" class="req_org1" onclick='fn_reqOrgChoice("1", "")'/> 의뢰업체와 모두동일
					<br/>
					<input name="req_org1" id="req_org_cancle" type="radio" value="Y" class="req_org1" onclick='fn_reqOrgChoice("0", "")'/> 업체 재선택
				</div>
			</div>
			<div id="tabOrgDiv2">
				<table class="list_table">
					<tr>
						<th class="indispensable">업체명</th>
						<td>
							<input name="req_org_nm2" id="req_org_nm2" type="text" value="${detail.req_org_nm2}" class="" readonly="readonly" disabled="disabled"/>
							<input name="req_org_no2" id="req_org_no2" type="hidden" value="${detail.req_org_no2}" class="inputCheck"/>
							<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" id="btn_Req_Org2" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "소유업체")'/>
							
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input name="req_org_addr2" id="req_org_addr2" type="text" value="${detail.req_org_addr2}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input name="charger_tel2" id="charger_tel2" type="text" value="${detail.charger_tel2}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
				</table>
				<div style="margin-top: 10px;">
					<input name="req_org2" id="req_org1" type="radio" value="Y" class="req_org2" onclick='fn_reqOrgChoice("2", "")'/> 의뢰업체와 동일
					<br/>
					<input name="req_org2" id="req_org3" type="radio" value="Y" class="req_org2" onclick='fn_reqOrgChoice("2", "3")'/> 계산서발행업체와 동일
					<br/>
					<input name="req_org2" id="req_org4" type="radio" value="Y" class="req_org2" onclick='fn_reqOrgChoice("2", "4")'/> 성적서발행업체와 동일
				</div>
			</div>
			<div id="tabOrgDiv3">
				<table class="list_table">
					<tr>
						<th class="indispensable">업체명</th>
						<td>
							<input name="req_org_nm3" id="req_org_nm3" type="text" value="${detail.req_org_nm3}" class="" readonly="readonly" disabled="disabled"/>
							<input name="req_org_no3" id="req_org_no3" type="hidden" value="${detail.req_org_no3}" class="inputCheck"/>
							<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" id="btn_Req_Org3" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "계산서발행업체")'/>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input name="req_org_addr3" id="req_org_addr3" type="text" value="${detail.req_org_addr3}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input name="charger_tel3" id="charger_tel3" type="text" value="${detail.charger_tel3}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
				</table>
				<div style="margin-top: 10px;">
					<input name="req_org3" id="req_org1" type="radio" value="Y" class="req_org3" onclick='fn_reqOrgChoice("3", "")'/> 의뢰업체와 동일
					<br/>
					<input name="req_org3" id="req_org2" type="radio" value="Y" class="req_org3" onclick='fn_reqOrgChoice("3", "2")'/> 소유업체와 동일
					<br/>
					<input name="req_org3" id="req_org4" type="radio" value="Y" class="req_org3" onclick='fn_reqOrgChoice("3", "4")'/> 성적서발행업체와 동일
				</div>
			</div>
			<div id="tabOrgDiv4">
				<table class="list_table">
					<tr>
						<th class="indispensable">업체명</th>
						<td>
							<input name="req_org_nm4" id="req_org_nm4" type="text" value="${detail.req_org_nm4}" class="" readonly="readonly" disabled="disabled"/>
							<input name="req_org_no4" id="req_org_no4" type="hidden" value="${detail.req_org_no4}" class="inputCheck"/>
							<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" id="btn_Req_Org4" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "성적서발행업체")'/>
							
						</td>								
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input name="req_org_addr4" id="req_org_addr4" type="text" value="${detail.req_org_addr4}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input name="charger_tel4" id="charger_tel4" type="text" value="${detail.charger_tel4}" class="" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
				</table>
				<div style="margin-top: 10px;">
					<input name="req_org4" id="req_org1" type="radio" value="Y" class="req_org4" onclick='fn_reqOrgChoice("4", "")'/> 의뢰업체와 동일
					<br/>
					<input name="req_org4" id="req_org2" type="radio" value="Y" class="req_org4" onclick='fn_reqOrgChoice("4", "2")'/> 소유업체와 동일
					<br/>
					<input name="req_org4" id="req_org3" type="radio" value="Y" class="req_org4" onclick='fn_reqOrgChoice("4", "3")'/> 계산서발행업체와 동일
				</div>
			</div>
			<div id="tabOrgDiv5">
				<table class="list_table">
					<tr>
						<th>공장명</th>
						<td>
							<input name="req_plant_nm" id="req_plant_nm" type="text" value="${detail.req_plant_nm}"/>
						</td>								
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input name="req_plant_addr" id="req_plant_addr" type="text" value="${detail.req_plant_addr}"/>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input name="req_plant_tel" id="req_plant_tel" type="text" value="${detail.req_plant_tel}"/>
						</td>
					</tr>
				</table>
			</div>							
		</div>
	</div>
</form>
<form id="requestFileForm" name="requestFileForm" onsubmit="return false;">
	<div class="req_file" style="margin-left:1%; width: 24%; height:50%; float: left; display: inline-block; padding-top: 350px;">
		<div id="tabsCom" class="tabsCom" style="height: 99%;">
			<div class="sub_purple_01">
				<table class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							의뢰별 첨부문서
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;" id="reqFile">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Request_Select_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_save" id="insertRequestBtn" onclick="btn_Request_File_onclick();">
								<button type="button">등록</button>
							</span>
							<span class="button white mlargep auth_save" id="updateRequestBtn" onclick="btn_Request_File_onclick();">
								<button type="button">수정</button>
							</span>
							<span class="button white mlargep auth_check" id="btn_check" onclick="btn_Request_check_onclick('requestFileGrid');">
								<button type="button">저장</button>
							</span> 
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="test_req_seq" name="test_req_seq" value="${detail.test_req_seq}"  />
			<input type="hidden" id="att_seq" name="att_seq" />
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_request_file">
				<table id="requestFileGrid"></table>
			</div>  
		</div>
	</div>	
</form>
<form>
	<div class="req_file" style="margin-left:1%; width: 24%; height:50%; float: left; display: inline-block; padding-top: 5px;">
		<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 위첨자 : <sup>첨자</sup>, 아래첨자 : <sub>첨자</sub>" > 
		<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 줄바꿈 : <br>" > 
	</div>
</form>

	
