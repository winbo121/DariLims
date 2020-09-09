<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 계산식관리
	 * 파일명 		: accountD01.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.10.16
	 * 설  명		: 계산식등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.16    윤상준		최초 프로그램 작성  
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<script type="text/javascript" src="<c:url value='/script/lims.com.account.js'/>"></script>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	
	$(function() {
		
		$("#test_item_cd").val(arr[2]);
		$("#test_sample_seq").val(arr[3]);
		
		accountGrid('master/selectAccountApplyList.lims', 'accountForm', 'accountGrid1');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#accountGrid1").setGridWidth($('#view_accountGrid1').width(), false);
		}).trigger('resize');


	});

	var lastRowId;
	
	// 계산식 그리드
	function accountGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '200',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : setColModelApply(),
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				//fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
						return 'stop';
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				fnGridEdit(grid, rowId, fn_account_event);
				$('#' + grid).setCell(rowId, "test_sample_seq", $("#test_sample_seq").val());
				$('#' + grid).setCell(rowId, "test_item_cd", $("#test_item_cd").val());
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				fn_Account_onCellSelect(grid, rowId, iCol);
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
		
		fn_account_setGroupHeaders(grid);
	}
	
	function fn_Account_onCellSelect(grid, rowId, iCol){
	}
	
	
	// 편집이벤트
	function fn_account_event(rowId){
		var grid = 'accountGrid1';
		$('#' + rowId).change(function() {
			var account_type = $('#' + grid).getCell(rowId, "account_type");
			// 계산구분이 있을경우
			if(!fnIsEmpty(account_type)){
				var account_disp ="";
				var account_cal_disp ="";
				var result = 0;
				if(account_type == "×" || account_type == "÷"){
					result = 1;
				}
				var start_oper = $('#' + grid).getCell(rowId, "account_s_oper"); 
				account_disp += start_oper;
				if(account_type == "AVG"){
					account_disp += "((";
					account_cal_disp += "((";
					var tot = 0;
					for(var i = 1;i< 11; i++){
						var val = $('#' + grid).getCell(rowId, "x"+i); 
						if(!fnIsEmpty(val)){
							account_disp += val + "+";
							var realVal = $('#' + grid).getCell(rowId, "x" + i + "_val");
							if( isNaN(realVal) ){
								realVal = $("#" + rowId + "_x"+i+"_val").val();
							}
							account_cal_disp += realVal + "+";
							result = parseFloat(result) + parseFloat(realVal);
							tot ++;
						}
					}
					account_disp = account_disp.substring(0, account_disp.length - 1);
					account_cal_disp = account_cal_disp.substring(0, account_cal_disp.length - 1);
					account_disp += ")÷"+ tot + ")";
					account_cal_disp += ")÷"+ tot + ")";
					result = result / tot;
				}else if(account_type == "MOD"){
					account_disp += "MOD(";
					for(var i = 1;i< 11; i++){
						var val = $('#' + grid).getCell(rowId, "x"+i); 
						if(!fnIsEmpty(val)){
							account_disp += val + ",";
						}
					}
					account_disp = account_disp.substring(0, account_disp.length - 1);
					account_disp += ")";
				}else if(account_type == "REF"){
					account_disp += "[REF].";
					for(var i = 1;i< 11; i++){
						var val = $('#' + grid).getCell(rowId, "x"+i); 
						if(!fnIsEmpty(val)){
							account_disp += val + ",";
						}
					}
					account_disp = account_disp.substring(0, account_disp.length - 1);
				}else{
					account_disp += "(";
					account_cal_disp += "(";
					for(var i = 1;i< 11; i++){
						var val = $('#' + grid).getCell(rowId, "x"+i); 
						if(!fnIsEmpty(val)){
							account_disp += val + account_type;
							var realVal = $('#' + grid).getCell(rowId, "x" + i + "_val");
							if( isNaN(realVal) ){
								realVal = $("#" + rowId + "_x"+i+"_val").val();
							}
							account_cal_disp += realVal + account_type;
							if(i == 1){
								result = parseFloat(realVal);
							}else{
								if(account_type == "+"){
									result = parseFloat(result) + parseFloat(realVal);
								}else if(account_type == "－"){
									result = parseFloat(result) - parseFloat(realVal);
								}else if(account_type == "×"){
									result = parseFloat(result) * parseFloat(realVal);
								}else if(account_type == "÷"){
									result = parseFloat(result) / parseFloat(realVal);
								}
							}
						}
					}
					account_disp = account_disp.substring(0, account_disp.length - 1);
					account_cal_disp = account_cal_disp.substring(0, account_cal_disp.length - 1);
					account_disp += ")";
					account_cal_disp += ")";
				}
				var end_oper = $('#' + grid).getCell(rowId, "account_e_oper"); 
				account_disp += end_oper;
				$('#' + grid).setCell(rowId, "account_disp", account_disp);
				$('#' + grid).setCell(rowId, "account_cal_disp", account_cal_disp);
				$('#' + grid).setCell(rowId, "account_result", result);
			}
		});
	}
	

	
	
	// 계산식 저장
	function btn_Save_Sub1(type){
		
		if(formValidationCheck("accountForm")){
			return;
		}
		
		if("detail" == $('#accountForm').find('#pageType').val()){
			url = 'master/updateAccount.lims';
		}else{
		 	url = 'master/insertAccount.lims';
		}
		
		if (confirm("저장하시겠습니까?")) {
			var json = fnAjaxAction(url, $('#accountForm').serialize());
			if (json == null) {
				alert('저장 실패되었습니다.');
			} else {
				//$('#deptLimsGrid').trigger('reloadGrid');
				alert('저장이 완료되었습니다.');
				$('#gridMain').trigger('reloadGrid');
				$("#detailDiv").empty();
			}
		}
		
	}
	
	
	function fn_Add_account(grid){
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		$('#' + grid).setCell(0, 'crud', 'c');
		$('#' + grid).setCell(0, 'account_no', $("#account_no").val());
		
		fnEditRelease(grid);
		fnGridEdit(grid, 0, fn_account_event);
		
		
		$('#btn_Add_'+grid).hide();
	}
	
	function fn_Del_account(grid){
		var rowId = $('#'+grid).getGridParam('selrow');
		if(rowId == null){
			alert("선택된 행이 없습니다.");
			return;
		}
		
		var crud = $('#' + grid).getCell(rowId, 'crud');
		if(crud == "c"){
			$('#' + grid).jqGrid('delRowData', rowId);
			$('#btn_Add_'+grid).show();
		}else{
			// DATA 삭제 처리
			
		}
	}
	
	function fn_Save_account(grid){
 		var rowId = $('#'+grid).getGridParam('selrow');
		if(rowId == null){
			alert("선택된 행이 없습니다.");
			return;
		}
		 
		 
		var url = "master/saveAccountApply.lims";
		fnEditRelease(grid);
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.crud != '') {
				c++;
			}
		}
		if (c == 0) {
			alert('변경된 내역이 없습니다.');
		} else {
			if (!confirm("계산식적용 결과값을 저장하시겠습니까?")) {
				return;
			}
			// 최종결과값 계산
			fn_tot_account(grid);
			fn_account_valDescTot(grid);
			var data = fnGetGridAllData(grid);
			var json = fnAjaxAction(url, data);
			if (json == null) {
				alert('저장 실패되었습니다.');
			} else {
				alert('저장이 완료되었습니다.');
				$('#'+grid).trigger('reloadGrid');
			}
		}
	}
	
	// 최종결과값 계산
	function fn_tot_account(grid){
		var tot_val = 0;
		var tot_cal_disp = "";
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if(i == 0){
				tot_val = row.account_result;
				tot_cal_disp = row.account_cal_disp;
			}else{
				if (!fnIsEmpty(row.account_s_oper)) {
					if(row.account_s_oper == "+"){
						tot_val = parseFloat(tot_val) + parseFloat(row.account_result);
					}else if(row.account_s_oper == "－"){
						tot_val = parseFloat(tot_val) - parseFloat(row.account_result);
					}else if(row.account_s_oper == "×"){
						tot_val = parseFloat(tot_val) * parseFloat(row.account_result);
					}else if(row.account_s_oper == "÷"){
						tot_val = parseFloat(tot_val) / parseFloat(row.account_result);
					}
					tot_cal_disp += row.account_s_oper + row.account_cal_disp;
				}
			}
		}
		$("#account_tot_cal_disp").val(tot_cal_disp);
		$("#account_tot_result").val(tot_val);
	}
	
	function fn_Check_account_result(grid){
		fn_tot_account(grid);
		fn_account_valDescTot(grid);
	}
	
	//팝업 이벤트
	function fn_method_serach(){
		var grid = 'accountForm';
		//var test_item_cd = $('#subGrid').getGridParam('selrow'); 
		fnpop_methodPop('', '900', '395', '', '', grid);
		fnBasicStartLoading();
	}
	
	// 해당 row 선택시 이벤트
	function fn_Save_account_result(grid) {
		var tot_result = $('#account_tot_result').val();
		if(tot_result == "NaN" || tot_result == "" || tot_result == null){
			alert("결과값이 정상적으로 계산되지 않았습니다.\n계산식을 확인해 주세요.");
			return;
		}
		var account_no = $('#account_no').val();
		var account_tot_cal_disp = $('#account_tot_cal_disp').val();
		var account_val_desc_tot = $("#account_val_desc_tot").val();
		if (!fnIsEmpty(tot_result)){
			// 부모창에 던져주기
			alert(account_no);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .result_val").text(tot_result);			
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .result_val").val(tot_result);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .account_no").text(account_no);			
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .account_no").val(account_no);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .account_tot_cal_disp").text(account_tot_cal_disp);			
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .account_tot_cal_disp").val(account_tot_cal_disp);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .account_val_desc_tot").text(account_val_desc_tot);			
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .account_val_desc_tot").val(account_val_desc_tot);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .report_disp_val").val(tot_result);			
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .report_disp_val").text(tot_result);
			
			opener.fnpop_accountCallback(arr[1]);
			window.close();
		} else {
			$.showAlert('최종결과값이 없습니다.');
		}
	}
	

</script>

<form id="accountForm" name="accountForm" onsubmit="return false;">
<input type="hidden" id="pageType" name="pageType" value="${pageType}">
<input type="hidden" id="account_no" name="account_no" value="${detail.account_no}">
<input type="hidden" id="test_sample_seq" name="test_sample_seq" >
<input type="hidden" id="test_item_cd" name="test_item_cd" >
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					계산식 정보
				</td>
				<!-- <td class="table_button">
					<span class="button white mlargeb" id="btn_Save_Sub1" onclick="btn_Save_Sub1('main')">
						<button type="button">저장</button>
					</span>
				</td> -->
			</tr>
		</table>

		<table  class="list_table" >
			<tr>
				<th >시험방법</th>
				<td style="width: 40%">
					<input type="text" id="test_method_nm" name="test_method_nm" class="inputCheck" readonly="readonly" value="${detail.test_method_nm}"/>
					<input type="hidden" id="test_method_no" name="test_method_no" class="inputCheck" value="${detail.test_method_no}"/>
				</td>
				<th >계산식명</th>
				<td>
					<input id="account_nm" name="account_nm" type="text" class="inputCheck" value="${detail.account_nm}" readonly="readonly"/>
				</td>
			</tr>

			<tr>
				<th >단위</th>
				<td>
					<input name="unit_nm" id="unit_nm" type="text" value="${detail.unit_nm}" readonly="readonly"/>
					<input name="unit" id="unit" type="hidden" value="${detail.unit}"/>
				</td>
				<th >사용여부</th>
				<td>
					<input name="use_flag_nm" id="use_flag_nm" type="text" value="${detail.use_flag_nm}" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>계산식결과</th>
				<td colspan="3">
					<input name="account_tot_disp" id="account_tot_disp" type="text" value="${detail.account_tot_disp}" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>변수설명</th>
				<td colspan="">
					<textarea name="account_val_desc" id="account_val_desc" class="w100p" id="" rows="5" readonly="readonly">${detail.account_val_desc}</textarea>
					<textarea name="account_val_desc_tot" id="account_val_desc_tot" class="w100p" id="" rows="5" readonly="readonly" style="display: none;">${detail.account_val_desc_tot}</textarea>
					
				</td>
				<th>참고사항</th>
				<td colspan="">
					<textarea name="account_desc" id="account_desc" class="w100p" id="" rows="5" readonly="readonly">${detail.account_desc}</textarea>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	
	<div id="sub_grid">
		<div class="sub_blue_01">
			<table  class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						계산식 적용
						<span class="button white mlargeb auth_select" id="btn_Show_accountGrid1" onclick="fn_Show_account('accountGrid1');">
							<button type="button">변수모두보기</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Show_desc_accountGrid1" style="margin-left: 1px;" onclick="fn_Show_desc_account('accountGrid1');">
							<button type="button">변수설명보기</button>
						</span>
						<!-- <span class="button white mlargeb" id="btn_Show_val_accountGrid1" style="margin-left: 1px;" onclick="fn_Show_val_account('accountGrid1');">
							<button type="button">결과값숨김</button>
						</span> -->
						<!-- <span class="button white mlargeb auth_select" id="btn_Ex_accountGrid1" style="margin-left: 1px;" onclick="fn_Ex_account();">
							<button type="button">계산식예제</button>
						</span> -->
					</td>
					<td class="table_button">
						<!-- <span class="button white mlargeb" id="btn_Add_accountGrid1" onclick="fn_Add_account('accountGrid1');">
							<button type="button">행추가</button>
						</span>
						<span class="button white mlargeb" id="btn_Del_accountGrid1" onclick="fn_Del_account('accountGrid1');">
							<button type="button">행삭제</button>
						</span>-->
						<span class="button white mlargeg auth_save" id="btn_Save_accountGrid1" onclick="fn_Save_account('accountGrid1')">
							<button type="button">저장</button>
						</span> 
					</td>
				</tr>
			</table>
		</div>
		<div id="view_accountGrid1">
			<table id="accountGrid1"></table>
		</div>
		<div class="sub_blue_01">
			<table  class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						결과값 확인
					</td>
					<td class="table_button">
					<span class="button white mlargeb auth_select" id="btn_Check_result_accountGrid1" onclick="fn_Check_account_result('accountGrid1')">
							<button type="button">결과값확인</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save_result_accountGrid1" onclick="fn_Save_account_result('accountGrid1')">
						<button type="button">결과값저장</button>
					</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th >계산식결과</th>
					<td>
						<input name="account_tot_cal_disp" id="account_tot_cal_disp" type="text" class="inputCheck" value="${detail.account_tot_cal_disp}" readonly="readonly"/>
						<input name="account_tot_result" id="account_tot_result" type="text" class="inputCheck w100px" value="${detail.account_tot_result}" readonly="readonly"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>