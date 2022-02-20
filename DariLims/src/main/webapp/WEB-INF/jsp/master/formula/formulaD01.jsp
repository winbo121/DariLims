<%
	/***************************************************************************************
	 * 시스템명 	: 실험실정보관리시스템
	 * 업무명 		: 계산식관리
	 * 파일명 		: formulaD01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2020.02.17
	 * 설  명		: 계산식등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.02.17   허태원	최초 프로그램 작성  
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	
	$(function() {
		gridSub('master/selectFormulaDetailList.lims', 'subForm', 'gridSub');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#gridSub").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
	});

	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}
	
	// 계산식조회목록
	function gridSub(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				sortable : false,
				align : 'center'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : '계산식번호',
				name : 'formula_no',
				hidden : true
			}, {
				label : '변수번호',
				name : 'variable_no',
				key : true,
				hidden : true
			}, {
				label : '변수명',
				width : '50',
				name : 'variable_nm',
				editable : true
			}, {
				label : '변수설명',
				width : '550',
				name : 'variable_desc',
				editable : true
			}, {
				label : '임시입력값',
				width : '50',
				name : 'input_val',
				editable : true
			}  ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {			
				fnGridEdit(grid, rowId, null);
			}
		});
	}
	
	// 계산식 저장
	function btn_save_onclick(){
		
		if(formValidationCheck("subForm")){
			return;
		}
		
		fnEditRelease("gridSub");


	
		if("detail" == $('#subForm').find('#pageType').val()){
			url = 'master/updateFormula.lims';
			var data = $('#subForm').serialize() + "&" + fnGetGridAllData("gridSub");
			if (confirm("저장하시겠습니까?")) {
				var json = fnAjaxAction(url, data);
				
				var ids = $('#gridSub').jqGrid("getDataIDs");
				
			
				for ( var i in ids) {
					var row = $('#gridSub').getRowData(ids[i]);
						
					
					   var data = 'formula_no='+$('#gridMain').jqGrid('getGridParam', 'selrow')+"&variable_no="+row.variable_no.trim()+"&variable_nm="+row.variable_nm.trim()+"&variable_desc="+row.variable_desc.trim()+"&input_val="+row.input_val.trim();
				      
 
					   var json = fnAjaxAction('master/updateFormulaDetail.lims', data);
							
				}
				
				if (json == null) {
					alert('저장 실패되었습니다.');
				} else {
					alert('저장이 완료되었습니다.');
					$('#gridMain').trigger('reloadGrid');
					$("#detailDiv").empty();
				}
			}
				
		}else{
		 	url = 'master/insertFormula.lims';
		 	var data = $('#subForm').serialize() + "&" + fnGetGridAllData("gridSub");
			
			if (confirm("저장하시겠습니까?")) {
				var json = fnAjaxAction(url, data);
				var ids = $('#gridSub').jqGrid("getDataIDs");
				
				
				for ( var i in ids) {
					var row = $('#gridSub').getRowData(ids[i]);
						
					
					   var data = 'formula_no='+$('#gridMain').jqGrid('getGridParam', 'selrow')+"&variable_no="+row.variable_no.trim()+"&variable_nm="+row.variable_nm.trim()+"&variable_desc="+row.variable_desc.trim()+"&input_val="+row.input_val.trim();
				      
 
					   var json = fnAjaxAction('master/insertFormulaDetail.lims', data);
							
				}
				
				if (json == null) {
					alert('저장 실패되었습니다.');
				} else {
					alert('저장이 완료되었습니다.');
					$('#gridMain').trigger('reloadGrid');
					$("#detailDiv").empty();
				}
			}
		}
		
		
	}
	
	function btn_add_onclick(){
		fnGridAddLine("gridSub");
	}
	
	function btn_del_onclick(){
		var rowId = $('#gridSub').getGridParam('selrow');
		if(rowId == "" || rowId == null){
			alert("행을 선택해주세요.");
			return;
		}
		
		var row = $('#gridSub').getRowData(rowId);
		if(row.crud == "c" || row.crud == "u"){
			alert("선택된 행은 등록중이거나 수정중입니다.");
			return;
		}
		
		fnGridDellLine("gridSub", rowId);
	}
	
	function btn_reset_onclick(){
		$('#gridSub').trigger('reloadGrid');
	}
	
	function btn_calc_onclick(){
		fnEditRelease("gridSub");
		var gridCnt = $("#gridSub").getGridParam("reccount");
		if(gridCnt == 0){
			alert("변수 리스트가 없습니다.");
			return;
		}
		
		var arrKey = [gridCnt];
		var arrVal = [gridCnt];
		
		var ids = $("#gridSub").jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $("#gridSub").getRowData(ids[i]);
			arrKey[i] = row.variable_nm.trim();
			arrVal[i] = row.temp_inpt_val.trim();
		}
		
		var formula_disp = $("#formula_disp").val();
		for(var i=0; i<arrKey.length; i++){
			formula_disp = replaceAll(formula_disp,arrKey[i],arrVal[i]);
		}
		
		$("#formula_disp_result").val(eval(formula_disp));
	}
	
</script>

<form id="subForm" name="subForm" onsubmit="return false;">
	<input type="hidden" id="pageType" name="pageType" value="${pageType}">
	<input type="hidden" id="formula_no" name="formula_no" value="${detail.formula_no}">
	<div class="sub_purple_01">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					계산식 정보 등록
				</td>
				<td class="table_button">
					<span class="button white mlargeg auth_save" id="btn_calc" onclick="btn_calc_onclick()">
						<button type="button">계산</button>
					</span>
					<span class="button white mlargeb auth_save" id="btn_save" onclick="btn_save_onclick()">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	
		<table class="list_table" >
			<tr>
				<th class="indispensable">계산식명</th>
				<td>
					<input name="formula_nm" type="text" class="inputCheck" value="${detail.formula_nm}"/>
				</td>
				<th class="indispensable">사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" <c:if test="${detail.use_flag != 'N'}">checked="checked"</c:if>/>사용</label> 
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if>/>미사용</label>
				</td>
			</tr>
			<tr>
				<th>계산식</th>
				<td>
					<input name="formula_disp" id="formula_disp" type="text" value="${detail.formula_disp}"/>
				</td>
				<th>계산식결과</th>
				<td>
					<input name="formula_disp_result" id="formula_disp_result" type="text" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>계산식설명</th>
				<td colspan="3">
					<textarea name="formula_desc" id="formula_desc" class="w100p" id="" rows="5">${detail.formula_desc}</textarea>
				</td>
			</tr>
		</table>
	</div>
	<div id="sub_grid">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					계산식 등록
				</td>
				<td class="table_button">
					<span class="button white mlargeg auth_save" id="btn_add" onclick="btn_add_onclick()">
						<button type="button">행추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_del" onclick="btn_del_onclick()">
						<button type="button">행삭제</button>
					</span>
					<span class="button white mlargeb auth_save" id="btn_reset" onclick="btn_reset_onclick()">
						<button type="button">되돌리기</button>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<div id="view_grid_sub">
		<table id="gridSub"></table>
	</div>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
</form>
