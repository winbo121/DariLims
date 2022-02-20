<%
	/***************************************************************************************
	 * 시스템명 	: 실험실정보관리시스템
	 * 업무명 		: 계산식관리
	 * 파일명 		: formulaPop.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2020.02.18
	 * 설  명		: 계산식등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.02.18   허태원	최초 프로그램 작성  
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	$(function() {
		
		arr = popupName.split("★●★");

		/*arr[0]; // 그리드명
		arr[1]; // 그리드로우ID
		arr[2]; // 항목코드
		arr[3]; // 메뉴구분 
		arr[4]; // 계산식번호 */
		
		$('#popMainForm').find("#testitm_cd").val(arr[2]);
		$('#popMainForm').find("#formula_no").val(arr[4]);
		
		if(arr[3] == "M"){
			$('input:radio[name=formula_yn]:input[value="UA"]').attr("checked", true);
			$('input:radio[name=formula_yn]:input[value="Y"]').attr("disabled", "disabled")
		}else{
			if(arr[4] == ""){
				$('input:radio[name=formula_yn]:input[value="UA"]').attr("checked", true);
				$('input:radio[name=formula_yn]:input[value="Y"]').attr("disabled", "disabled")
			}else{
				$('input:radio[name=formula_yn]:input[value="Y"]').attr("checked", true);
			}
		} /*계산식을  펼쳤을때 기준으로 고정시켜놓기*/
		
		popMainGrid('master/selectFormulaList.lims','popMainForm', 'popMainGrid');		
		popLeftGrid('master/selectFormulaDetailList.lims', 'popSubForm', 'popLeftGrid');
		popRightGrid('', 'popSubForm', 'popRightGrid');
		
		
		window.onkeydown = function()	{
 			 			
 			if(event.keyCode == 13){
 				btn_right_onclick();
			}

		}
		
		$('#tabs').tabs({
			create : function(event, ui) {
				if($('#popSubForm').find('#formula_no').val() != '' && $('#popSubForm').find('#formula_no').val() != null ){
					$('#tabs').tabs("disable", 2);					
					$('#btn_reset').show();
				} else {
					$('#tabs').tabs("enable", 2);
					$('#btn_reset').hide();
				}
				
				if(arr[3] == "M"){
					$("#btn_apply").show();
					$("#btn_send").hide();
				}else{
					$("#btn_apply").hide();
					$("#btn_send").show();
				}
				
				$(window).bind('resize', function() {
					$("#popMainGrid").setGridWidth($('#view_grid_popMain').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#popLeftGrid").setGridWidth($('#view_grid_popSubL').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#popRigtGrid").setGridWidth($('#view_grid_popSubR').width(), false);
				}).trigger('resize');
			},
			activate : function(event, ui) {
				// 다시 작업 예정
			 	if ($('#tabs').tabs('option', 'active') == 1){
					if($('#popSubForm').find('#formula_no').val() == '' || $('#popSubForm').find('#formula_no').val() == null ){
						$('#tabs').tabs({active : 0});						
						alert("선택된 계산식그룹이 없습니다.");
						return false;
					}
					$('#btn_reset').show();
				}else{
					$('#btn_reset').hide();
				}
				
			 	if(arr[3] == "M"){
					$("#btn_apply").show();
					$("#btn_send").hide();
				}else{
					$("#btn_apply").hide();
					$("#btn_send").show();
				}
				
				$(window).bind('resize', function() {
					$("#popMainGrid").setGridWidth($('#view_grid_popMain').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#popLeftGrid").setGridWidth($('#view_grid_popSubL').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#popRigtGrid").setGridWidth($('#view_grid_popSubR').width(), false);
				}).trigger('resize');
			}
		});
		
		$('#formula_nm').keypress(function(e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
				btn_select_onclick();
			}
		});
	});
	
	// 계산식조회목록
	function popMainGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '계산식번호',
				name : 'formula_no',
				key : true,
				hidden : true
			}, {
				label : '계산식명',
				width : '150',
				name : 'formula_nm'
			}, {
				label : '계산식',
				width : '150',
				name : 'formula_disp'
			}, {
				label : '계산식 설명',
				width : '432',
				name : 'formula_desc'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {			
				// 텝 이동
				btn_choice_onclick();
			}
		});
	}
	
	// 계산식조회목록
	function popLeftGrid(url, form, grid) {
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
				label : '변수번호',
				name : 'variable_no',
				key : true,
				hidden : true
			}, {
				label : '변수명',
				width : '50',
				name : 'variable_nm'
			}, {
				label : '변수설명',
				width : '100',
				name : 'variable_desc'
			}, {
				label : '입력값',
				width : '50',
				name : 'input_val',
				editable : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			},
			afterEditCell: function(rowid, cellname, value, iRow, iCol) {
	            var e = jQuery.Event("keydown");
	            e.keyCode = $.ui.keyCode.ENTER;
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {
	                edit.trigger(e);
	            });
           }
		});
	}
	
	// 계산식조회목록
	function popRightGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				//fnGridData(url, form, grid);
			},
			height : '190',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'result_no',
				name : 'result_no',
				hidden : true,
				key : true
			}, {
				label : '결과값',
				width : '50',
				name : 'result_val',
				align : 'center'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}
	
	function btn_choice_onclick(){
		var rowId = $('#popMainGrid').getGridParam('selrow');
		if(rowId == null){
			alert("계산식 그룹을 선택해주세요.");
		}else{
			var row = $('#popMainGrid').getRowData(rowId);
			$('#popSubForm').find("#formula_no").val(rowId);
			$('#popSubForm').find("#formula_disp").val(row.formula_disp);
			$('#tabs').tabs({active : 1});
			$('#popLeftGrid').trigger('reloadGrid');
			$('#popRightGrid').clearGridData();
		}
	}
	
	function btn_select_onclick(){
		$('#popMainGrid').trigger('reloadGrid');
		$('#popLeftGrid').clearGridData();
		$('#popRightGrid').clearGridData();
		$('#popSubForm').find("#formula_no").val("");
		$('#popSubForm').find("#formula_disp").val("");
	}
		
	function btn_right_onclick(){
		var grid = "popLeftGrid";
		fnEditRelease(grid);
		
		var gridCnt = $("#"+grid).getGridParam("reccount");
		if(gridCnt == 0){
			alert("변수 리스트가 없습니다.");
			return;
		}
		
		var arrKey = [gridCnt];
		var arrVal = [gridCnt];
		
		var inputTF = true;
		var ids = $("#"+grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $("#"+grid).getRowData(ids[i]);
			arrKey[i] = row.variable_nm.trim();
			arrVal[i] = row.input_val.trim();
			if(row.input_val.trim() == ""){
				inputTF = false;
			}
		}
		
		if(inputTF == false){
			//alert("입력되지 않은 변수가 있습니다.");
			var grid = "popLeftGrid";
			if($("#"+grid).getGridParam("reccount") != 0){
				var ids = $("#"+grid).jqGrid("getDataIDs");
				for(var i=ids.length; i>-1; i--) {
					$('#' + grid).jqGrid('editRow', ids[i], false);
				}
				$("#1_input_val").focus();
			}
			return;
		}
		
		var formula_disp_temp = $('#popSubForm').find("#formula_disp").val();
		for(var i=0; i<arrKey.length; i++){
			formula_disp_temp = replaceAll(formula_disp_temp,arrKey[i],arrVal[i]);
		}
		
		var formula_disp = eval(formula_disp_temp);
		formula_disp = formula_disp.toFixed(4);
		
		var rowId = fnNextRowId("popRightGrid");
		$('#popRightGrid').jqGrid('addRow', {
			rowID : rowId,
			position : 'last',
			initdata : {
				'result_no' : rowId,
				'result_val' : formula_disp
			}
		});
		fn_clac_average();
		$('#popLeftGrid').trigger('reloadGrid');
		var gridCnt = $("#popLeftGrid").getGridParam("reccount");
		if(gridCnt > 0){
			var ids = $("#popLeftGrid").jqGrid("getDataIDs");
			for ( var i in ids) {
				$("#popLeftGrid").setCell(ids[i], "input_val", "");
			}
		}
	}
		
	function btn_left_onclick(){
		var rowId = $('#popRightGrid').getGridParam('selrow');
		if(rowId == null){
			alert("결과리스트를 선택해주세요.");
		}else{
			$("#popRightGrid").jqGrid("delRowData", rowId);
		}
		fn_clac_average();
	}
	
	function btn_reset_onclick(){
		$('#popLeftGrid').trigger('reloadGrid');
		var gridCnt = $("#popLeftGrid").getGridParam("reccount");
		if(gridCnt > 0){
			var ids = $("#popLeftGrid").jqGrid("getDataIDs");
			for ( var i in ids) {
				$("#popLeftGrid").setCell(ids[i], "input_val", "");
			}
		}
		$("#popRightGrid").clearGridData();
	}
		
	function fn_clac_average(){
		var gridCnt = $("#popRightGrid").getGridParam("reccount");
		
		if(gridCnt != 0){
			var avgResult = 0;
			var avgCalc_temp = "";
			var avgCalc = "";
			var arrAvg = [gridCnt];
			var ids = $("#popRightGrid").jqGrid("getDataIDs");
			for ( var i in ids) {
				var row = $("#popRightGrid").getRowData(ids[i]);
				arrAvg[i] = row.result_val;
			}
			
			for(var i=0; i<arrAvg.length; i++){
				avgCalc_temp += arrAvg[i] + "+";
			}

			avgCalc = "("+avgCalc_temp.substr(0, avgCalc_temp.length -1)+")" + '/' + gridCnt.toString();
			
			$("#average").val(eval(avgCalc).toFixed(4));
		}else{
			$("#average").val("");
		}
	}
	
	function btn_send_onclick(){
		var average = $("#average").val();
		if(average == ""){
			alert("평균값이 없습니다.");
			return;
		}
		
		var ids = $("#popRightGrid").jqGrid("getDataIDs");
		var arrResult = new Array();
		for ( var i in ids) {
			var row = $("#popRightGrid").getRowData(ids[i]);
			arrResult.push(row.result_val);
		}
		
		var formula_no = $('#popSubForm').find("#formula_no").val();
		var formula_disp = $('#popSubForm').find("#formula_disp").val();
		
		opener.fnpop_formula_callback(arr[0], arr[1], formula_no, formula_disp, average, arrResult);
		window.close();
	}
	
	function btn_apply_onclick(){
		var rowId = $('#popMainGrid').getGridParam('selrow');
		if(rowId == ""){
			alert("계산식을 선택해주세요.");
			return;
		}
		var row = $('#popMainGrid').getRowData(rowId);
		opener.fnpop_formula_callback(arr[0], arr[1], rowId, row.formula_disp, "");
		window.close();
	}
	
	function btn_close_onclick(){
		window.close();
	}
	
	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}
	
	function btn_input_onclick(){
		var grid = "popLeftGrid";
		if($("#"+grid).getGridParam("reccount") != 0){
			var ids = $("#"+grid).jqGrid("getDataIDs");
			for(var i=ids.length; i>-1; i--) {
				$('#' + grid).jqGrid('editRow', ids[i], false);
			}
			$("#1_input_val").focus();
		}
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>계산식</h2>
			<div id="tabs">
				<ul>
					<li><a href="#tabDiv1">계산식 그룹</a></li>
					<li><a href="#tabDiv2">계산식</a></li>
					<li style="float: right;">
						<span class="button white mlargeg auth_save" style="vertical-align: middle;">
							<button type="button" id="btn_apply" onclick="btn_apply_onclick()" style="display: none;">적용</button>
							<button type="button" id="btn_reset" onclick="btn_reset_onclick()" style="display: none;">초기화</button>
							<button type="button" id="btn_close" onclick="btn_close_onclick()">닫기</button>
						</span>
					</li>
				</ul>
				<div id="tabDiv1">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="popMainForm" name="popMainForm" onsubmit="return false;">
							<table class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										계산식그룹 조회
									</td>
									<td class="table_button" style="text-align: right; padding-right: 10px;">
										<span class="button white mlargeg auth_select" id="btn_choice" onclick="btn_choice_onclick();">
											<button type="button">선택</button>
										</span>
										<span class="button white mlargeb auth_select" id="btn_select" onclick="btn_select_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<!-- 조회 테이블 -->
							<table  class="list_table" >
								<tr>
									<th>계산식명</th>
									<td>
										<input type="text" name="formula_nm" id="formula_nm" />
									</td>
									<th>마스터기준여부</th>
									<td>
										<label><input type='radio' name='formula_yn' value='Y' style="width: 20px"  checked="checked" />기준</label> 
										<label><input type='radio' name='formula_yn' value='UA' style="width: 20px" />사용가능 계산식</label>
										<label><input type='radio' name='formula_yn' value='N' style="width: 20px" />전체</label>
									</td>									
								</tr>
							</table>
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">							
							<input type="hidden" id="testitm_cd" name="testitm_cd">
							<input type="hidden" id="formula_no" name="formula_no">
							<div id="view_grid_popMain">
								<table id="popMainGrid"></table>
							</div>
						</form>
					</div>
				</div>
				<div id="tabDiv2" style="padding-bottom: 20px; overflow: hidden;">
					<form id="popSubForm" name="popSubForm" onsubmit="return false;">
					<input type="hidden" id="formula_no" name="formula_no">
					<div class="w60p">
						<div class="sub_purple_01" style="margin-top: 0px;">							
							<table width="100%" border="0" class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										계산식상세조회	
									</td>
									<td class="table_button" style="text-align: right; padding-right: 10px;">										
										<span class="button white mlargeb auth_select" id="btn_input" onclick="btn_input_onclick();">
											<button type="button">입력</button>
										</span>
									</td>
								</tr>
							</table>
							<table class="list_table" >
								<tr>
									<th>계산식</th>
									<td>
										<input name="formula_disp" id="formula_disp" type="text" style="width: 95%;" readonly="readonly"/>
									</td>
								</tr>
							</table>
							<div id="view_grid_popSubL">
								<table id="popLeftGrid"></table>
							</div>	
						</div>
					</div>
					<div class="w10p">
						<span>
							<button type="button" onclick="btn_right_onclick();" id="btn_right" class="btnRight auth_save"></button>
						</span>
						<br>
						<br>
						<span>
							<button type="button" onclick="btn_left_onclick();" id="btn_left" class="btnLeft auth_save"></button>
						</span>
					</div>
					<div class="w30p" style="float:right;">
						<div class="sub_purple_01" style="margin-top: 0px;">							
							<table width="100%" border="0" class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										계산식결과	
									</td>
								</tr>
							</table>
							<div id="view_grid_popSubR">
								<table id="popRightGrid"></table>
							</div>
						</div>
						<div class="sub_purple_01" style="margin-top: 0px;">							
							<table width="100%" border="0" class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										계산식결과평균	
									</td>
									<td class="table_button" style="text-align: right; padding-right: 10px;">										
										<span class="button white mlargeb auth_select" id="btn_send" onclick="btn_send_onclick();">
											<button type="button">보내기</button>
										</span>
									</td>
								</tr>
							</table>
							<table class="list_table" >
								<tr>
									<th>평균</th>
									<td>
										<input name="average" id="average" type="text" style="width: 95%;" readonly="readonly"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
					</form>
				</div>			
			</div>
		</div>
	</div>
</body>
</html>