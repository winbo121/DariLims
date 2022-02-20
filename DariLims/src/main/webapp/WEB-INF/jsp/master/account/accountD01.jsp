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
		
		if($("#accountForm").find("#pageType").val() == "detail"){
			$("#btn_Delete_Sub1").show();
		}else{
			
		}
		accountGrid('master/selectAccountDetailList.lims', 'accountForm', 'accountGrid1');
		ajaxComboForm("unit", "C08", "${detail.unit}", "", "accountForm");
		

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#accountGrid1").setGridWidth($('#view_accountGrid1').width(), false);
		}).trigger('resize');

	});

	var lastSelectCell = {
			rowId: null,
			colIndex: null
	}
	
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
			colModel : setColModel(),
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (editCount()) {
					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
						return 'stop';
					}
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				fnGridEdit(grid, rowId, fn_account_event);
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				lastSelectCell.rowId = rowId;
				lastSelectCell.colIndex = iCol;
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
			var account_type = $("#" + rowId + "_account_type").val();
			// 계산구분이 있을경우
			if(!fnIsEmpty(account_type)){
				var account_disp ="";
				var account_cal_disp ="";
				var result = 0;
				/* if(account_type == "×" || account_type == "÷"){
					result = 1;
				} */
				var start_oper = $("#" + rowId + "_account_s_oper").val();
				account_disp += start_oper;
				if(account_type == "AVG"){
					account_disp += "((";
					account_cal_disp += "((";
					var tot = 0;
					for(var i = 1;i< 11; i++){
						var val = $("#" + rowId + "_x"+i).val();
						if(!fnIsEmpty(val)){
							account_disp += val + "+";
							var realVal = $("#" + rowId + "_x"+i+"_val").val();
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
						var val = $("#" + rowId + "_x"+i).val();
						if(!fnIsEmpty(val)){
							account_disp += val + ",";
						}
					}
					account_disp = account_disp.substring(0, account_disp.length - 1);
					account_disp += ")";
				}else if(account_type == "REF"){
					account_disp += "[REF].";
					for(var i = 1;i< 11; i++){
						var val = $("#" + rowId + "_x"+i).val();
						if(!fnIsEmpty(val)){
							account_disp += val + ",";
						}
					}
					account_disp = account_disp.substring(0, account_disp.length - 1);
				}else{
					account_disp += "(";
					account_cal_disp += "(";
					for(var i = 1;i< 11; i++){
						var val = $("#" + rowId + "_x"+i).val();
						if(!fnIsEmpty(val)){
							account_disp += val + account_type;
							var realVal = $("#" + rowId + "_x"+i+"_val").val();
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
				var end_oper = $("#" + rowId + "_account_e_oper").val();
				account_disp += end_oper;
				$('#' + grid).setCell(rowId, "account_disp", account_disp);
				$('#' + grid).setCell(rowId, "account_cal_disp", account_cal_disp);
				$('#' + grid).setCell(rowId, "account_result", result);
			}
		});
	}
	//채원 - 삭제 기능 추가
	function btn_Delete_Sub1(type){
		 if (!confirm("계산식을 삭제 하시겠습니까?")) {
			alert("작업중");			
			 return false;
		 }
		var json = fnAjaxAction('master/deleteAccount.lims', $('#accountForm').serialize());
		if (json == null) {
			alert('삭제 실패되었습니다.');
		} else {
			//$('#deptLimsGrid').trigger('reloadGrid');
			alert('삭제가 완료되었습니다.');
			$('#gridMain').trigger('reloadGrid');
			$("#detailDiv").empty();
		}
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
			var url = 'master/deleteAccountDetail.lims';
			var data = fnGetGridData(grid, rowId);
			if (confirm("계산식결과와 변수설명 자동저장을위해\n계산식정보도 함께 저장됩니다.\n삭제하시겠습니까?")) {
				var json = fnAjaxAction(url, data);
				if (json == null) {
					alert('삭제 실패되었습니다.');
				} else {
					$('#'+grid).trigger('reloadGrid');
					fn_account_valDesc(grid);
					var json = fnAjaxAction('master/updateAccount.lims', $('#accountForm').serialize());
					if (json == null) {
						alert('계산식정보 저장 실패되었습니다.');
						return;
					} 
					alert('삭제가 완료되었습니다.');
					$('#gridMain').trigger('reloadGrid');
					$('#'+grid).trigger('reloadGrid');
				}
			}
		}
	}
	
	function fn_Save_account(grid){
 		var rowId = $('#'+grid).getGridParam('selrow');
		if(rowId == null){
			alert("선택된 행이 없습니다.");
			return;
		}
		 
		// 변수설명 취합
		fn_account_valDesc(grid);
		 
		fnEditRelease(grid);
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.crud != '') {
				if(fnIsEmpty(row.account_type)){
					alert("계산구분을 선택해주세요.");
					return;
				}
				c++;
			}
		}
		if (c == 0) {
			alert('변경된 내역이 없습니다.');
		} else {
			if (!confirm("계산식결과와 변수설명 자동저장을위해\n계산식정보도 함께 저장됩니다.\n저장하시겠습니까?")) {
				return;
			}
			var data = fnGetGridAllData(grid);
			var json = fnAjaxAction("master/saveAccountDetail.lims", data);
			if (json == null) {
				alert('계산식 저장 실패되었습니다.');
			} else {
				var json = fnAjaxAction('master/updateAccount.lims', $('#accountForm').serialize());
				if (json == null) {
					alert('계산식정보 저장 실패되었습니다.');
					return;
				} 
				alert('저장이 완료되었습니다.');
				$('#btn_Add_'+grid).show();
				$('#gridMain').trigger('reloadGrid');
				$('#'+grid).trigger('reloadGrid');
			}
		}
	}
	
	
	//팝업 이벤트
	function fn_method_serach(){
		var grid = 'accountForm';
		//var test_item_cd = $('#subGrid').getGridParam('selrow'); 
		fnpop_methodPop('', '900', '395', '', '', grid);
		fnBasicStartLoading();
	}
	
	//콜백함수
	function fnpop_methodCallback(){
	}
	
	function open_pop_test_item () {
		var colIndex = lastSelectCell.colIndex;
		var col = $("#accountGrid1").jqGrid("getGridParam", "colModel")[colIndex];
		if( lastSelectCell.colIndex == null || !col.selectItemTarget ) {
			alert('항목 선택은 `변수`컬럼을 선택했을 때만 사용할 수 있습니다.');
			return false;
		}
		fnpop_select_test_item('selectTestItem', '800', '500');
	}
	
	function test_item_pop_onSelect (item, popupWindow) {
		var rowId = lastSelectCell.rowId;
		var colIndex = lastSelectCell.colIndex;
		$("#" + rowId).find('td').eq(colIndex-1).html(item.testitm_cd);
		$("#" + rowId).find('td').eq(colIndex).html(item.testitm_nm); 
	}

</script>

<form id="accountForm" name="accountForm" onsubmit="return false;">
<input type="hidden" id="pageType" name="pageType" value="${pageType}">
<input type="hidden" id="account_no" name="account_no" value="${detail.account_no}">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					계산식 정보 등록
				</td>
				<td class="table_button">
				<span class="button white mlarger auth_save" id="btn_Delete_Sub1" style="display: none;" onclick="btn_Delete_Sub1('main')">
						<button type="button">삭제</button>
					</span>
					<span class="button white mlargeb auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub1('main')">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>

		<table  class="list_table" >
			<tr>
				<th class="indispensable">계산식명</th>
				<td>
					<input name="account_nm" type="text" class="inputCheck" value="${detail.account_nm}"/>
				</td>
			</tr>

			<tr>
				<th class="indispensable">단위</th>
				<td>
					<select name="unit" id="unit" class="w100px inputCheck"></select>
				</td>
				<th class="indispensable">사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" <c:if test="${detail.use_flag != 'N'}">checked="checked"</c:if>/>사용</label> 
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if>/>미사용</label>
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
				</td>
				<th>참고사항</th>
				<td colspan="">
					<textarea name="account_desc" id="account_desc" class="w100p" id="" rows="5">${detail.account_desc}</textarea>
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
					계산식 등록
					<span class="button white mlargeb auth_select" id="btn_Show_accountGrid1" onclick="fn_Show_account('accountGrid1');">
						<button type="button">변수모두보기</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_Show_desc_accountGrid1" style="margin-left: 1px;" onclick="fn_Show_desc_account('accountGrid1');">
						<button type="button">변수설명숨김</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_Show_val_accountGrid1" style="margin-left: 1px;" onclick="fn_Show_val_account('accountGrid1');">
						<button type="button">결과값숨김</button>
					</span>
					<!-- <span class="button white mlargeb auth_select" id="btn_Ex_accountGrid1" style="margin-left: 1px;" onclick="fn_Ex_account();">
						<button type="button">계산식예제</button>
					</span> -->
				</td>
				<td class="table_button">
				<!-- fnpop_reqOrgChoice  -->
					<span class="button white mlargep auth_save" id="btn_Select_sampleItem" onclick="open_pop_test_item();">
						<button type="button">항목 선택</button>
					</span>
<!-- 					<span class="button white mlargep auth_save" id="btn_Add_accountGrid1">
						<button type="button">행추가</button>
					</span> -->
					<span class="button white mlargep auth_save" id="btn_Add_accountGrid1" onclick="fn_Add_account('accountGrid1');">
						<button type="button">행추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Del_accountGrid1" onclick="fn_Del_account('accountGrid1');">
						<button type="button">행삭제</button>
					</span>
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
	</div>
</form>
