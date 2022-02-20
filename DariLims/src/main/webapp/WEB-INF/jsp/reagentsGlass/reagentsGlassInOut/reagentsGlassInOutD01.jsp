
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약/실험기구 수불
	 * 파일명 		: reagentsGlassInOutD01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.16
	 * 설  명		: 시약/실험기구 수불 상세 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.16    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var inout_flag;
	var trs_dept_cd;
	var inout_flag_detail;
	var pre_out_qty = 0;
	
	$(function() {		
		trs_dept_cd = fnDeptCombo(deptCd);
		inout_flag = fnGridCommonCombo('C50', 'SELECT');
		
		var detail_C51 = fnGridCommonCombo('C51', 'SELECT');
		var detail_C53 = fnGridCommonCombo('C53', null);
		detail_C53 = detail_C53.slice(1);
		inout_flag_detail = detail_C51 + detail_C53;
		
		inOutGrid('reagents/selectReagentsGlassInOutDetail.lims', 'inOutForm', 'inOutGrid');	
				
		// 엔터키 눌렀을 경우
		fn_Enter_Search('inOutForm', 'inOutGrid');
		
	 	//그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#inOutGrid").setGridWidth($('#view_grid_sub').width(), false); 
		}).trigger('resize');
	 	
	});

	function inOutGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			footerrow: true,
			userDataOnFooter: true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시약실험기구수불번호',
				name : 'inout_no',
				key : true,
				hidden : true,
				search : false
			}, {
				label : '부서코드',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '시약실험기구코드',
				name : 'mtlr_no',
				width : '100',
				hidden : true
			}, {
				label : '품명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '수불구분<span class="indispensableGrid"></span>',
				name : 'inout_flag',
				align : 'center',
				width : '80',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : inout_flag,
					dataEvents:[{ 
						type:'change', 
						fn: function(e){
							inoutFlagDetailChange(e);								
				    	}
					}]
				}
			}, {
				label : '수불상세구분<span class="indispensableGrid"></span>',
				name : 'inout_flag_detail',
				align : 'center',
				width : '150',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : inout_flag_detail,  
					dataEvents:[{ 
						type:'change', 
						fn: function(e){
							editable(e);								
				    	}
					}]
				}
			}, {				
				label : '입고수량<span class="indispensableGrid"></span>',
				name : 'in_qty',
				align : 'right',
				width : '60',
				classes:'number_css',
				index : 'in_qty',				
				formatter : function(value){
					if(value == 0 || value == null){
						return '';  
					}else{
						return value;
					}
				},
				formatoptions : {
					thousandsSeparator:"," ,
					summaryType:'sum',
					summaryTpl:'Totals:'
				}
			}, {
				label : '출고수량<span class="indispensableGrid"></span>',
				name : 'out_qty',
				align : 'right',
				width : '60',
				classes:'number_css',
				index : 'out_qty',
				formatter : function(value){
					if(value == 0 || value == null){
						return '';  
					}else{
						return value;
					}
				},
				formatoptions : {
					thousandsSeparator:"," ,
					summaryType:'sum',
					summaryTpl:'Totals:'
				}
			}, {			
				label : '입/출고일자<span class="indispensableGrid"></span>',
				name : 'in_date',
				align : 'center',
				width : '100',
				editoptions : {
				 	dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}  
				}
			}, {
				label : '입고가격',
				name : 'price',
				align : 'right',
				width : '100',
				classes:'number_css',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator:","
				} 
			}, {
				label : '이관부서',
				name : 'trs_dept_cd',  
				formatter : 'select',
				edittype : "select",
				align : 'center',
				width : '130',
				editoptions : {
					value : trs_dept_cd
				}
			}, {
				label : '결재',
				name : 'appr_flag',
				width : '80',
				align : 'center',
				formatter : function(value){
					if(value == "Y"){
						return '승인';  
					}else if(value == "N") {
						return '미승인';
					}else{
						return '';
					}
				},
				hidden : true
			}, {
				label : '수불적요',
				name : 'inout_txt',
				width : '400'
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				editChange = false;		
				sumQty(grid);
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				
				// 하단 합계 부분
				var sum = $("#" + grid).jqGrid('getCol', 'in_qty', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'out_qty', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {item_nm: '합&nbsp;&nbsp;계', in_qty:sum, out_qty:sum2, in_date:'재고 : '+ (sum - sum2) + '개'} );
				
				// 스타일 주기 
				$('table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	// 배경색
				$('table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		// 폰트 스타일
				$('table.ui-jqgrid-ftable tr:first td:eq(0), table.ui-jqgrid-ftable tr:first td:eq(4)').css('padding-top','8px');
				$('table.ui-jqgrid-ftable tr:first td:eq(0), table.ui-jqgrid-ftable tr:first td:eq(4)').css('padding-bottom','8px');
				$('table.ui-jqgrid-ftable tr:first td:eq(4), table.ui-jqgrid-ftable tr:first td:eq(9)').css('font-weight', 'bold'); // 합계, 총계
				
				$('table.ui-jqgrid-ftable tr:first td:eq(4)').css('width','500px'); // 합계 width
				$('table.ui-jqgrid-ftable tr:first td:eq(9)').css('width','780px'); // 총계 width
				
				$('table.ui-jqgrid-ftable tr:first td:eq(7)').css('width','52px'); // 입고수량 width
				$('table.ui-jqgrid-ftable tr:first td:eq(8)').css('width','52px'); // 출고수량 width
				
				// td 병합
				$("table.ui-jqgrid-ftable td:eq(0)").hide();
				$("table.ui-jqgrid-ftable td:eq(5)").hide();
				$("table.ui-jqgrid-ftable td:eq(6)").hide();
				$("table.ui-jqgrid-ftable td:eq(10)").hide();
				$("table.ui-jqgrid-ftable td:eq(11)").hide();
				$("table.ui-jqgrid-ftable td:eq(12)").hide();
				$("table.ui-jqgrid-ftable td:eq(13)").hide();
				
				// 총계 공백
				$('table.ui-jqgrid-ftable tr:first td:eq(9)').css("padding-left","22px");
				
				// 총합계 정렬
				$('table.ui-jqgrid-ftable tr:first td:eq(4)').css("text-align","center");	// 합계
				$('table.ui-jqgrid-ftable tr:first td:eq(9)').css("text-align","left");		// 총계
				
				//마지막행 포커스 주기
				$('#' + grid + ' tr:last').focus();
			},
		 	onSortCol : function(index, iCol, sortorder) {
		 		return 'stop';
			}, 
			beforeSelectRow : function(rowId, e) {	
 				if (rowId && rowId != lastRowId) { 					
 					if(editChange) {	 						
 						if (!confirm('수정중인 수불현황은 사라집니다. 이동하시겠습니까?')) {
 							return 'stop';
 						}	 							
 						$('#' + grid).jqGrid('restoreRow', lastRowId);
						inoutDetail();
						$('#' + grid).trigger('reloadGrid'); 						
 					}
 					editChange = false;
				}  				
 				return true;
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {					
					fnEditRelease(grid);
					lastRowId = rowId;					
					$('#btn_AddLine').show();
					$('#btn_Insert').hide();
				}				
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				if(editChange) {
					if(!valiCheckNull(rowId))
						return;
				}
				fnEditRelease(grid);
				var row = $('#' + grid).jqGrid('getRowData', rowId); 			
				/* if(row.appr_flag == '승인') {
					$.showAlert("승인된 수불항목은 수정할 수 없습니다.");
					return 'stop';
				}  */
				//이관출고 및 이관입고 화면 수정 막음
				if(row.inout_flag_detail != 'C53001') {
					$.showAlert("검수입고, 부서구매입고, 이관입고는 및 이관출고  수정할 수 없습니다.");
					return;
				}
				if(row.out_qty != null && row.out_qty != '')
					pre_out_qty = parseInt(row.out_qty);	
				else
					pre_out_qty = -parseInt(row.in_qty);
				
				inoutFlagDetailChange('');	
				
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
				
				$('#btn_AddLine').hide();
				$('#btn_Insert').show();
			}
		});
	}
	//재고수수량 - 합계
	function sumQty(grid) {
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if(ids.length > 0) {
			var sum = 0;
			for(var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
// 				alert(row.out_qty + "," + row.in_qty)
				if(row.out_qty != null && row.out_qty != '')
					sum -= parseInt(row.out_qty);
				else if((row.in_qty != null && row.in_qty != ''))
					sum += parseInt(row.in_qty);
				$('#' + grid).setCell(ids[i], 'tot_qty', sum);
			}
		}
	}
	//수불상세구분 기본 콤보
	function inoutDetail() {
		var grid = 'inOutGrid';
		$("#" + grid).jqGrid('setColProp', 'inout_flag_detail', {
			editoptions : {
				value : inout_flag_detail
			}
		});
	}
	//수불구분에 따라 수불 상세구분 콤보 변경
	function inoutFlagDetailChange(e) {
		var grid = 'inOutGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');		
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		//수불상세구분
		var value = '';
		if (e == '')
			value = row.inout_flag;
		else {
			value = $(e.target).val();
			fnEditRelease(grid);
		}
		var change='';	
		switch (value) {		
		//입고
		case 'C50001' :			
			change = fnGridCommonComboChange('C51', 'in');
			break;
		//출고
		case 'C50002' :
			change = fnGridCommonComboChange('C53', 'out');
			break;
		}
		$("#" + grid).jqGrid('setColProp', 'inout_flag_detail', {
			editoptions : {
				value : change
			}
		});	
		if(e == '')
			editable('');
		else
			editable(e);
	}
	//수불 상세구분에 따른 셀 수정 여부
	function editable(e) {	
		var grid = 'inOutGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');	
		var arr = new Array();
		arr.push('inout_txt');	
		arr.push('inout_flag');
		arr.push('inout_flag_detail');
		//수불구분
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		var row_inout_flag_detail = '';
		if (e == '')
			row_inout_flag_detail = row.inout_flag_detail;
		else {
			row_inout_flag_detail = $(e.target).val();
			fnEditRelease(grid);
		}
		switch (row_inout_flag_detail) {
		//검수입고
		case 'C51001' :
			arr.push('price');
			arr.push('in_qty');
			arr.push('in_date');
			break;
		//부서구매입고
		case 'C51002' :
			arr.push('price');
			arr.push('in_qty');
			arr.push('in_date');
			break;
		//이관입고
		case 'C51003' :			
			arr.push('price');
			arr.push('in_qty');
			arr.push('in_date');
			arr.push('trs_dept_cd');
			break;
		//출고
		case 'C53001' :
			arr.push('out_qty');
			arr.push('in_date');
			break;
		//이관출고
		case 'C53002' :
			arr.push('out_qty');
			arr.push('in_date');
			arr.push('trs_dept_cd');
			break;
		}
		for ( var column in row) {
			if ($.inArray(column, arr) !== -1) {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : true
				});
			} else {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : false
				});
			}
		}
		if(e != '') {
			for(var column in row) 
	 			if(column == 'in_qty' || column == 'out_qty' || column == 'tot_qty' || column == 'in_date' || column == 'out_date' || column == 'inout_txt')
	 				$("#" + grid).jqGrid('setCell', rowId, column, null);
		}
		//에디트모드전환
		$("#" + grid).jqGrid('editRow', rowId, false, valiCheck, null, 'clientArray');
// 		$("#" + grid).jqGrid('editRow', rowId);
		editChange = true;
	}	
	//조회버튼 클릭 이벤트
	function btn_Search_sub_onclick() {		
		$('#inOutGrid').trigger('reloadGrid');		
	}
	//구매요청(시약/실험기구) 목록 삭제이벤트
	function btn_Delete_onclick() {
		var selRowId = $('#inOutGrid').jqGrid ('getGridParam', 'selrow');
		if(selRowId == null || selRowId == '') {
			alert("선택된 항목이 없습니다.");
			return;
		}			
		$('#inOutGrid').jqGrid('delRowData', selRowId);
	}
	function btn_Sub2_onclick() {
// 		editChange = false;
		inoutDetail();
		var rowId = $('#rgInOutGrid').jqGrid ('getGridParam', 'selrow');
		$('#rgInOutGrid').trigger('reloadGrid');
// 		$('#rgInOutGrid').jqGrid("setSelection", rowId, true);	
		var selar = $("#rgInOutGrid").jqGrid('getDataIDs');
	 	var check = false;
		for(var i in selar) {			
			if(selar[i] == rowId) {
				check = true;
			}
		} 
		if(check) {
			alert("저장되었습니다.");
			$('#rgInOutGrid').jqGrid("setSelection", rowId, true);	
		}
		else {
			alert("저장하신 시약/실험기구의 재고수량이 0개가 되었습니다.");
			$('#detail').empty();
		}
	}
	//행추가 클릭 이벤트
	function btn_AddLine_onclick() {
		var grid = 'inOutGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,			
			position : 'last'
		});
		//수불상세구분 콤보변경
		var change = fnGridCommonComboChange('C51', 'new');
		$("#" + grid).jqGrid('setColProp', 'inout_flag_detail', {
			editoptions : {
				value : change
			}
		});
		editable('');	
		
 		$('#' + 0 + '_inout_flag').focus();
 		
		pre_out_qty = 0;
		$('#btn_AddLine').hide();
		$('#btn_Insert').show();
		ediChange = true;
	}
	//저장, 수정 버튼 클릭 이벤트
	function btn_Insert_onclick() {
		var grid = 'inOutGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		
		if(!valiCheckNull(rowId))
			return;				
		var url = '';
		//저장
		if(rowId == 0){
			url = 'reagents/insertReagentsGlassInOut.lims';
		} else {
			url = 'reagents/updateReagentsGlassInOut.lims';
		}
		var row = $('#' + grid).jqGrid('getRowData', rowId);
		
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, url, {
			mtlr_no : $('#inOutForm').find('#mtlr_no').val(),
			dept_cd : $('#inOutForm').find('#dept_cd').val()
		}, btn_Sub2_onclick, null, null);
	}
	
	// 조건에 따른 수불 상세구분 콤보변경
	function fnGridCommonComboChange(code, val) {	
		var ret = ':선택;';
		if(val == 'new') {
			ret = ret.substring(0, ret.length - 1);
			return ret;
		}
		var url = '/commonCode/selectCommonCodeCombo.lims';
		$.ajax({
			url : url,
			dataType : 'json',
			type : 'POST',
			async : false,
			data : 'code=' + code,
			success : function(json) {
				$(json).each(function(index, entry) {
					ret += entry['code'] + ':' + entry["code_Name"] + ';';
				});
				ret = ret.substring(0, ret.length - 1);
			},
			error : function() {
				alert('fnGridCommonCombo error');
			}
		});
		return ret;
	}
	
	// 이관부서 콤보 - 본인의 부서는 나오지 않게....
	function fnDeptCombo(myDeptCode) {
		var ret = ':선택;';

		var url = fn_getConTextPath();
		if(deptCd.substring(0,4) == 'LIMS'){
			url += '/commonCode/selectCommonCodeOffice.lims';
		} else{
			url += '/commonCode/selectCommonCodeDept.lims';
		}
		
		$.ajax({
			url : url,
			dataType : 'json',
			type : 'POST',
			async : false,
			data : 'code=',
			success : function(json) {
				$(json).each(function(index, entry) {
					if(myDeptCode != entry['code'])
						ret += entry['code'] + ':' + entry["code_Name"] + ';';
				});
				ret = ret.substring(0, ret.length - 1);
			},
			error : function() {
				alert('fnGridCombo error');
			}
		});
		return ret;
	}
	
	//validation null체크
	function valiCheckNull(rowId) {
		var check = true;
		var inoutFlag = $('#' + rowId + '_inout_flag');
		var inQty = $('#' + rowId + '_in_qty');
		var outQty = $('#' + rowId + '_out_qty');
		var inoutFlagDetail = $('#' + rowId + '_inout_flag_detail');
		var trsDeptCd = $('#' + rowId + '_trs_dept_cd');
		var inDate = $('#' + rowId + '_in_date');
		//수불구분 null 체크
		if(inoutFlag.val() == '' || inoutFlag.val() == undefined) {
			alert("수불구분을 선택하세요.");
			inoutFlag.focus();
			check = false;
		}
		//수불상세구분체크
		if(check) {
			if(inoutFlagDetail.val() == '' || inoutFlagDetail.val() == undefined) {
				alert("수불구분을 선택하세요.");
				inoutFlagDetail.focus();
				check = false;
			}
		}
		//입출고 수량, 입출고 일자, 이관부서 null체크
		if(check) {			
			if(inoutFlag.val() == 'C50001') {			
				if(inQty.val() == null || inQty.val() == '') {
					alert("입고수량을 입력하세요.");
	                inQty.focus();
					check = false;
				} else if(inQty.val() == 0){
					alert("입고수량을 0개 이상 입력하세요.");
					inQty.val(null);
	                inQty.focus();
					check = false;
				} else if(inoutFlagDetail.val() == 'C51003') {
					if(trsDeptCd.val() == '' || trsDeptCd.val() == null) {
						alert("이관부서를 선택해 주세요.");
						trsDeptCd.focus();
						check = false;
					}
				}			
			} else if(inoutFlag.val() == 'C50002') {			
				if(outQty.val() == null || outQty.val() == '') {
					alert("출고수량을 입력하세요.");
					outQty.focus();
					check = false;
				} else if(outQty.val() == 0) {
					alert("출고수량을 0개 이상 입력하세요.");
					outQty.val(null);
					outQty.focus();
					check = false;
				} else {
					var rowId = $('#rgInOutGrid').jqGrid('getGridParam', 'selrow');
					var row = $('#rgInOutGrid').jqGrid('getRowData', rowId);
				 	if(outQty.val() > (parseInt(row.tot_qty) + parseInt(pre_out_qty))) {
						alert("재고수량이 부족합니다.");
						outQty.val(null);
						outQty.focus();
						check = false;
					} 
				}				
				if(check) {
					if(inoutFlagDetail.val() == 'C53002') {					
						if(trsDeptCd.val() == '' || trsDeptCd.val() == null) {
							alert("이관부서를 선택해 주세요.");
							trsDeptCd.focus();
							check = false;
						}
					}
				}
			}
			//입, 출고 일자 유효성검사
			if(check) {
				if(inDate.val() == null || inDate.val() == '') {
					alert("입/출고일자를 입력해 주세요.");
					inDate.focus();
					check = false;
				}
			}
		}
		if(!check)
			editChange = true;
		return check;
	}
	//validation체크
	function valiCheck(rowId) {
		$('#' + rowId + '_in_qty').keyup(function() {
			var inQty = $('#' + rowId + '_in_qty');
			if(!fnIsNumeric(inQty.val()) && inQty.val() != '') {
				alert("숫자만 입력가능합니다.");
				inQty.val(null);
				inQty.focus();
			}
		});
		$('#' + rowId + '_out_qty').keyup(function() {
			var outQty = $('#' + rowId + '_out_qty');
			if(!fnIsNumeric(outQty.val()) && outQty.val() != '') {
				alert("숫자만 입력가능합니다.");
				outQty.val(null);	
				outQty.focus();
			}
		});		
	}
		
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('inOutGrid');
		fn_Excel_Download(data);
	}
</script>
<form id="inOutForm" name="inOutForm" onsubmit="return false;">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td width="40%" class="table_title">
					<span>■</span>
					시약/실험기구수불
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<!-- <span class="button white mlargeb" id="btn_Select" onclick="btn_Search_Sub_onclick();">
						<button type="button">조회</button>
					</span> -->
					<span class="button white mlargeb auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
						<button type="button">수불추가</button>
					</span>
					<!-- <span class="button white mlargeb" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">구매요청삭제</button>
					</span> -->
					<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>					
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type="hidden" id="dept_cd" name="dept_cd" value="${detail.dept_cd}">
	<input type="hidden" id="mtlr_no" name="mtlr_no" value="${detail.mtlr_no}">
	<div id="view_grid_sub">
		<table id="inOutGrid"></table>
	</div>
</form>



