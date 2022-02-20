
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
	.w65p .list_table th {min-width:100px; max-width:110px;}
	.w65p .list_table td {min-width:300px;}
	.w65p .list_table td.td_min2 {min-width:200px;}
/* 	.w65p .list_table td.td_min3 {min-width:260px; max-width:265px;} */
	
	.w34p .ui-tabs .ui-tabs-nav .ui-tabs-anchor {padding:.5em .5em;}
	.w34p .list_table th, .w34p .list_table td {border:none;}
	.w34p .list_table th {height:24px;}
/* 	.last_height {height:93px;}
	.last_height2 {height:130px;}
 */	#tabComDiv1 th, #tabComDiv2 th, #tabComDiv3 th, #tabComDiv4 th {min-width:80px;}
</style>
<script type="text/javascript">	
	$(function() {		
		/* 세부권한검사 */
		fn_auth_check();
		
		var feeArr = new Array();
		feeArr.push('fee_group_nm');
		feeArr.push('fee');

		fnDatePickerImg('req_date');
		fnDatePickerImg('sample_arrival_date');
		fnDatePickerImg('deadline_date');

		ajaxComboForm("test_goal", "C05", "${detail.test_goal}", "", "reqDetailForm");
		ajaxComboForm("req_type", "C23", "${detail.req_type}", "EX1", "reqDetailForm");
		ajaxComboForm("commission_type", "C61", "${detail.commission_type}", "", "reqDetailForm");
		ajaxComboForm("sensory_test", "C65", "${detail.sensory_test}", "EX1", "reqDetailForm");
		ajaxStdComboForm("test_std_no", "", "${detail.test_std_no}", "", "reqDetailForm");
		//alert($(":input:radio[name=fee_auto_flag]:checked").val());
		fn_show_type($(":input:radio[name=fee_auto_flag]:checked").val());
		//fn_testStdChage($('#reqDetailForm').find('#test_std_no option:selected').val());
		fn_testStdChage($('#reqDetailForm').find('#test_std_no').val());

		// 처리기한 넣기
		$('#reqDetailForm').find("#sample_arrival_date").change(function() {
			if ('${detail.deadline_date}' == '' || '${detail.deadline_date}' == null){
				// 검체 도착일 + 14
				var day = $('#reqDetailForm').find('#sample_arrival_date').val();
				var d = new Date(day);				
				d.setDate(Number(day.substring(8,10)) + 14);
				
				var year = (d.getFullYear()).toString();
				var month = (d.getMonth()+1).toString();
				var date = (d.getDate()).toString();
				
				if (month.length == 1) {
					month = '0' + month;
				}
				if (date.length == 1) {
					date = '0' + date;
				}				
				$('#reqDetailForm').find('#deadline_date').val(year+'-'+month+'-'+date);
			}
		});
		
		// 수입한약재인경우 관능검사를 선택한다.
		if('${detail.req_type}' == 'E'){
			$("#sensory_test").attr("disabled", false);
		}
		
		if ('${detail.dept_cd }' == '') {
			if ('${type}' == 'receipt') {
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
		ajaxComboForm("unit_work_cd", $('#reqDetailForm').find("#dept_cd").val(), null, null, 'reqDetailForm');
		$('#reqDetailForm').find("#unit_work_cd").val("${detail.unit_work_cd }");

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
				fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
			}
		});
		
		// 할인률 변경시
		$('#reqDetailForm').find("#discount_rate").keyup(function() {
			var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				$.showAlert('숫자만 입력가능합니다.');
				$(this).val(val.substring(0, val.length - 1));
			} else {
				//alert($('#reqDetailForm').find("#discount_flag").val);
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
		if ('${type}' == 'receipt') {
			$('#btn_Req_Org1').show();
			$('#btn_Req_Org2').show();
			$('#btn_Req_Org3').show();
			$('#btn_Req_Org4').show();
			$('#reqDetailForm').find('#btn_Accept').hide();
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
		fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());		
		
		$('#tabsCom').tabs({
			create : function(event, ui) {
			},
			activate : function(event, ui) {
				var TabNo = $('#tabsCom').tabs('option', 'active');
				TabNo ++;
// 				window["fn_tabAct"+TabNo]();
			}
		});
	});
	
	// 항목 수수료 입력 종류 선택
	function fn_show_type(fee_auto_flag) {
		// 항목수수료 자동 계산
		if(fee_auto_flag == 'Y'){
			var ids = $('#reqSampleGrid').jqGrid("getDataIDs");
			if (ids.length > 0) {
				var subids = $('#reqItemGrid').jqGrid("getDataIDs");
				if(subids.length > 0) {
					$('#reqItemGrid').trigger('reloadGrid');
				}else{
					fnSelectFirst("reqSampleGrid");
				}
			}
			var test_req_seq = $('#reqDetailForm').find('#test_req_seq').val();	
			$('#reqDetailForm').find("#fee_tot_item").show();			
			$('#reqDetailForm').find("#fee_tot_est").hide();
			if(test_req_seq != '' && test_req_seq != null){
				fn_Item_Count();
				fn_Fee_Calculate();
			}
		// 항목수수료 수동 입력
		} else {
			$('#reqDetailForm').find("#fee_tot_est").show();			
			$('#reqDetailForm').find("#fee_tot_item").hide();
		}
		fn_Item_Count();
		fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
	}
	
	// 전체 적용
	function fn_reqOrgChoice(num, radioNum){
		
		var req_org_no = $('#reqDetailForm').find("#req_org_no"+radioNum).val();
		var req_org_nm = $('#reqDetailForm').find("#req_org_nm"+radioNum).val();
		//alert(req_org_no);
		
		if(num == "0"){
			
			if( req_org_no != null && req_org_no != ""){
				if( confirm("업체정보를 초기화 하고 다시 선택하시겠습니까?")){
					$('#reqDetailForm').find("#req_org_no").val("");
					$('#reqDetailForm').find("#req_org_nm").val("");
					$('#reqDetailForm').find("#req_org_no2").val("");
					$('#reqDetailForm').find("#req_org_nm2").val("");
					$('#reqDetailForm').find("#req_org_no3").val("");
					$('#reqDetailForm').find("#req_org_nm3").val("");
					$('#reqDetailForm').find("#req_org_no4").val("");
					$('#reqDetailForm').find("#req_org_nm4").val("");
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
				$('#reqDetailForm').find("#req_org_no3").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm3").val(req_org_nm);
				$('#reqDetailForm').find("#req_org_no4").val(req_org_no);
				$('#reqDetailForm').find("#req_org_nm4").val(req_org_nm);
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
	
	// 의뢰처 콜백
	function fnpop_reqOrgcallback(flag){
		// 
		if(flag == 'Y'){
			//alert(flag);
			$('#reqDetailForm').find('#discount_flag_n').removeAttr('checked');
			$('#reqDetailForm').find('#discount_flag_y').prop('checked', true);
		} else {
			$('#reqDetailForm').find('#discount_flag_y').removeAttr('checked');
			$('#reqDetailForm').find('#discount_flag_n').prop('checked', true);
		}
		fn_Tot_Calculate($(":input:radio[name=discount_flag]:checked").val());
		//fnBasicEndLoading();
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

	
	// 기준 변경
	function fn_testStdChage(test_std_no){
		if(fnIsEmpty(test_std_no)){
			$("#btn_Add_MFDS").hide();
			$("#btn_Add_Self").hide();
			return false;
		}else{
			if ( test_std_no == 'I01' ) {
				$("#btn_Add_MFDS").show();
				$("#btn_Add_Self").hide();
			} else {			
				$("#btn_Add_MFDS").hide();
				$("#btn_Add_Self").show();
			}	
		}
	}
</script>

<form id="reqDetailForm" name="reqDetailForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table class="select_table">
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
				<th class="indispensable">의뢰구분</th>
				<td class="td_min2">
					<select name="req_type" id="req_type" class="inputCheck w100px"></select>
					<select name="sensory_test" id="sensory_test" class="w80px" disabled="disabled"></select>
				</td>
			</tr>
			<tr>
				<th>의뢰접수자</th>
				<td>
					<c:if test="${detail.test_req_no == '' or detail.test_req_no == null}">
						<label >${session.user_nm}</label>
					</c:if>
					<c:if test="${detail.test_req_no != '' and detail.test_req_no != null}">
						<input name="creater_id" id="creater_id" type="hidden" value="${detail.creater_id}" />
						<input name="creater_nm" id="creater_nm" type="text" class="w100px" value="${detail.creater_nm}" readonly="readonly" />
					</c:if>
				</td>
				<th class="indispensable">의뢰일자</th>
				<td class="td_min2">
					<input name="req_date" id="req_date" type="text" class="w100px inputCheck" value="${detail.req_date}" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("req_date")' />
				</td>						
			</tr>
			<tr>
				<th>의뢰번호</th>
				<td>
					<input name="test_req_no" id="test_req_no" type="hidden" value="${detail.test_req_no }" />
					<input name="test_req_seq" id="test_req_seq" type="hidden" value="${detail.test_req_seq}" />
					<input name="state" id="state" type="hidden" value="${detail.process }" />
					<label id="vw_test_req_no">${detail.test_req_no }</label> &nbsp; <label id="vw_state">${detail.state}</label>
				</td>
				<th>난이도조정</th>
				<td class="td_min2">
					<input name="discount_rate" id="discount_rate" type="text" class="inputhan w30" value="${detail.discount_rate}" /> %
					<input name="discount_flag" id="discount_flag_y" type="radio" value="Y" onClick="fn_Tot_Calculate($(this).val())" <c:if test="${detail.discount_flag == 'Y'}">checked="checked"</c:if>/>
					<label for="discount_flag_y">적용</label>
					<input name="discount_flag" id="discount_flag_n" type="radio" value="N" onClick="fn_Tot_Calculate($(this).val())" <c:if test="${detail.discount_flag != 'Y'}">checked="checked"</c:if>/>
					<label for="discount_flag_n">적용안함</label>
				</td>	
			</tr>
			<!-- 업체정보 자리 -->
			<tr>
				<th>회원구분</th>
				<td>
					<input name="member_flag" id="member_flag_y" type="radio" value="Y" onClick="" <c:if test="${detail.member_flag == 'Y'}">checked="checked"</c:if>/>
					<label for="rmember_flag_y">회원사</label>
					<input name="member_flag" id="member_flag_n" type="radio" value="N" onClick="" <c:if test="${detail.member_flag != 'Y'}">checked="checked"</c:if>/>
					<label for="member_flag_n">비회원</label>
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
					<input name="fee_tot_item" id="fee_tot_item" type="text" class="w80px" style="vertical-align: text-bottom;" value="${detail.fee_tot_item}"  readonly="readonly"/> 
					<input name="fee_tot_est" id="fee_tot_est" type="text" class="w80px" style="vertical-align: text-bottom;padding-right:0px;"  value="${detail.fee_tot_est}"/>원
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
					<label id="tot"></label> &nbsp; 원	
					<input name="fee_tot" id="fee_tot" type="hidden" value="${detail.fee_tot}"/>				
					<label style="padding-left:15px;">수수료 납입 : </label> 
					<select name="commission_type" id="commission_type" class="w80px"></select>
				</td>
				<th>검체반납정보</th>
				<td class="td_min2">
					<input name="return_flag" id="return_flag_y" type="radio" value="Y" onClick="fn_Return_Flag($(this).val(), 'reqSampleGrid')" <c:if test="${detail.return_flag == 'Y'}">checked="checked"</c:if>/>
					<label for="return_flag_y">반납</label>
					<input name="return_flag" id="return_flag_n" type="radio" value="N" onClick="fn_Return_Flag($(this).val(), 'reqSampleGrid')" <c:if test="${detail.return_flag != 'Y'}">checked="checked"</c:if>/>
					<label for="return_flag_n">폐기</label>
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
				<th class="indispensable">시험부서</th>
				<td>
					<label id="dept_nm" style="display: none;"></label>
					<select name="dept_cd" id="dept_cd" class="w200px inputCheck"></select>
					<input name="test_std_no" id="test_std_no" type="hidden" class="w100px" value="001"/>
				</td>
				<th>검사목적</th>
				<td class="td_min2">
					<select name="test_goal" id="test_goal" class="w200px"></select>
				</td>
			</tr>
			<tr>
				<th>의뢰근거</th>
				<td>
					<input name="req_basis" id="req_basis" type="text" class="inputhan w200px" value="${detail.req_basis}" />
				</td>
				<th>단위업무</th>
				<td class="td_min2">
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>				
			</tr>
			<tr>
				<th class="indispensable">검체도착일</th>
				<td>
					<input name="sample_arrival_date" id="sample_arrival_date" type="text" class="w100px inputCheck" value="${detail.sample_arrival_date }" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="sampleDateStop" style="cursor: pointer;" onClick='fn_TextClear("sample_arrival_date")' />
				</td>
				<th class="indispensable">처리기한</th>
				<td class="td_min2">
					<input name="deadline_date" id="deadline_date" type="text" class="w100px inputCheck" value="${detail.deadline_date }" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("deadline_date")' />
				</td>
			</tr>
			<tr>				
				<th>특기사항</th>
				<td colspan="5">
					<textarea rows="3" name="req_message" id="req_message" class="w100p">${detail.req_message}</textarea>
				</td>
			</tr>
		</table>	
	</div>
	
	<div style="margin-left:1%; width: 24%; height: 99%; float: left; position: absolute; display: inline-block; padding-top: 1px;">
					<c:set var="tabName1" value="의뢰업체" />
					<c:set var="tabName2" value="소유업체" />
					<c:set var="tabName3" value="계산서발행업체" />
					<c:set var="tabName4" value="성적서발행업체" />
					<div id="tabsCom" class="tabsCom" style="height: 99%;">
						<ul>
							<li id="tab1" style="width: 48%;">
								<a href="#tabComDiv1">${tabName1}</a>
							</li>
							<li id="tab2" style="width: 48%;">
								<a href="#tabComDiv2">${tabName2}</a>
							</li>
							<li id="tab3" style="width: 48%;">
								<a href="#tabComDiv3">${tabName3}</a>
							</li>
							<li id="tab4" style="width: 48%;">
								<a href="#tabComDiv4">${tabName4}</a>
							</li>
						</ul>
						<div id="tabComDiv1" style="height: 100%;">
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
									<th>의뢰자</th>
									<td class="td_min3_">
										<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" value="${detail.req_nm}" />
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
									<th>대표번호</th>
									<td class="td_min3_">
										<input name="req_org_tel" id="req_org_tel" type="text" value="${detail.req_org_tel}" class="" readonly="readonly" disabled="disabled"/>
									</td>								
								</tr>
							</table>
							<div style="margin-top: 10px;">
								<input name="req_org1" id="req_org1" type="radio" value="Y" class="req_org1" style="margin-left:15px;" onclick='fn_reqOrgChoice("1", "")'/> 의뢰업체와 모두동일
								<br/>
								<input name="req_org1" id="req_org_cancle" type="radio" value="Y" class="req_org1" style="margin-left:15px;" onclick='fn_reqOrgChoice("0", "")'/> 업체 재선택
							</div>
						</div>
						<div id="tabComDiv2">
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
									<th>대표번호</th>
									<td>
										<input name="req_org_tel2" id="req_org_tel2" type="text" value="${detail.req_org_tel2}" class="" readonly="readonly" disabled="disabled"/>
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
						<div id="tabComDiv3">
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
									<th>대표번호</th>
									<td>
										<input name="req_org_tel3" id="req_org_tel3" type="text" value="${detail.req_org_tel3}" class="" readonly="readonly" disabled="disabled"/>
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
						<div id="tabComDiv4">
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
									<th>대표번호</th>
									<td>
										<input name="req_org_tel4" id="req_org_tel4" type="text" value="${detail.req_org_tel4}" class="" readonly="readonly" disabled="disabled"/>
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
					</div>
		</div>
	</div>
	<input name="act_date" id="act_date" type="hidden" value="${detail.act_date}" />
</form>