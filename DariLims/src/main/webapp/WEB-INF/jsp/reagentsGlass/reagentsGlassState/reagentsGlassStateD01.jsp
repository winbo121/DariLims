
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수불현황
	 * 파일명 		: reagentsGlassStateD01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.03.02
	 * 설  명		: 수불현황 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.02    석은주		최초 프로그램 작성         
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
	var inout_flag;
	var trs_dept_cd;
	var inout_flag_detail;
	$(function() {
		trs_dept_cd = fnGridCombo('dept', null);
		inout_flag = fnGridCommonCombo('C50', null);

		var detail_C51 = fnGridCommonCombo('C51', null);
		var detail_C53 = fnGridCommonCombo('C53', null);
		detail_C53 = detail_C53.slice(1);
		inout_flag_detail = detail_C51 + detail_C53;

		stateGrid('reagents/selectReagentsGlassInOutDetail.lims?pageType=state', 'stateForm', 'stateGrid');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('stateForm', 'stateGrid');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#stateGrid").setGridWidth($('#view_grid_state').width(), false);
		}).trigger('resize');
	});
	
	function stateGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250',
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
				align : 'center',
				width : '100',
				hidden : true
			}, {
				label : '과장결재',
				name : 'appr_flag',
				width : '80',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '승인';
					} else if (value == "N") {
						return '미승인';
					} else {
						return '';
					}
				},
				hidden : true
			}, {
				label : '수급일자',
				name : 'in_date',
				align : 'center',
				width : '100',
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				}
			}, {
				label : '검수자',
				name : 'confirm_nm',
				align : 'center',
				width : '100',
			}, {
				label : '수급수량',
				name : 'in_qty',
				align : 'right',
				width : '80',
				classes : 'number_css',
				formatter : function(value) {
					if (value == 0) {
						return '';
					} else {
						return value;
					}
				}
			}, {
				label : '수불구분',
				name : 'inout_flag',
				align : 'center',
				width : '80',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : inout_flag,
					dataEvents : [ {
						type : 'change',
						fn : function(e) {
							inoutFlagDetailChange(e);
						}
					} ]
				}
			}, {
				label : '수불상세구분',
				name : 'inout_flag_detail',
				align : 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : inout_flag_detail,
					dataEvents : [ {
						type : 'change',
						fn : function(e) {
							editable(e);
						}
					} ]
				}
			}, {
				label : '가격',
				name : 'price',
				align : 'right',
				width : '100',
				classes : 'number_css',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '사용일자',
				name : 'out_date',
				align : 'center',
				width : '100',
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				}
			}, {
				label : '사용자',
				name : 'user_nm',
				align : 'center',
				width : '100',
			}, {
				label : '사용수량',
				name : 'out_qty',
				align : 'right',
				width : '80',
				classes : 'number_css',
				formatter : function(value) {
					if (value == 0) {
						return '';
					} else {
						return value;
					}
				}
			}, {
				label : '현보유량',
				name : 'tot_qty',
				align : 'right',
				width : '80',
				classes : 'number_css',
				hidden : true
			}, {
				label : '이관부서코드',
				name : 'trs_dept_cd',
				align : 'center',
				width : '100',
				hidden : true
			}, {
				label : '이관부서',
				name : 'trs_dept_nm',
				align : 'center',
				width : '150'
			}, {
				label : '수불적요',
				name : 'inout_txt',
				width : '250'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				sumQty(grid);
				
				// 하단 합계 부분
				var sum = $("#" + grid).jqGrid('getCol', 'in_qty', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'out_qty', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {in_date:'입&nbsp;&nbsp;고 : '+sum, confirm_nm:'출&nbsp;&nbsp;고 : '+sum2, in_qty:'재&nbsp;&nbsp;고 : '+(sum - sum2)} );
				
				// 스타일 주기 
				$('table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	// 배경색
				$('table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		// 폰트 스타일
				$('table.ui-jqgrid-ftable tr:first td:eq(5)').css('padding-top','8px');
				$('table.ui-jqgrid-ftable tr:first td:eq(5)').css('padding-bottom','8px');
				$('table.ui-jqgrid-ftable tr:first td:eq(5), table.ui-jqgrid-ftable tr:first td:eq(6), table.ui-jqgrid-ftable tr:first td:eq(7)').css('font-weight', 'bold');
				
				// td 병합
				$("table.ui-jqgrid-ftable td:eq(0)").hide();
				$("table.ui-jqgrid-ftable td:eq(1)").hide();
				$("table.ui-jqgrid-ftable td:eq(2)").hide();
				$("table.ui-jqgrid-ftable td:eq(3)").hide();
				$("table.ui-jqgrid-ftable td:eq(4)").hide();
				$("table.ui-jqgrid-ftable td:eq(8)").hide();
				$("table.ui-jqgrid-ftable td:eq(9)").hide();
				$("table.ui-jqgrid-ftable td:eq(10)").hide();
				$("table.ui-jqgrid-ftable td:eq(11)").hide();
				$("table.ui-jqgrid-ftable td:eq(12)").hide();
				$("table.ui-jqgrid-ftable td:eq(13)").hide();
				$("table.ui-jqgrid-ftable td:eq(14)").hide();
				$("table.ui-jqgrid-ftable td:eq(15)").hide();
				$("table.ui-jqgrid-ftable td:eq(16)").hide();
				$("table.ui-jqgrid-ftable td:eq(17)").hide();
				
				// 글꼴
				$('table.ui-jqgrid-ftable tr:first td:eq(5)').css("text-align","center");		
				$('table.ui-jqgrid-ftable tr:first td:eq(6)').css("text-align","center");
				$('table.ui-jqgrid-ftable tr:first td:eq(7)').css("text-align","center"); 
			},
			onSortCol : function(index, iCol, sortorder) {
				return 'stop';
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				stateGridEdit(grid, rowId);	
			}
		});

		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'out_date',
				numberOfColumns : 3,
				titleText : '사용내역'
			} ]
		});
	}
	
	function stateGridEdit(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
		editable('');
	}
	
	function editable(e) {
		var grid = 'stateGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
		var arr = new Array();
		// 결과값형태
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		arr.push('inout_txt');

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
		if (e != '') {
			for ( var column in row)
				if (column != 'test_item_nm' && column != 'test_item_cd' && column != 'crud' && column != 'icon')
					$("#" + grid).jqGrid('setCell', rowId, column, null);
		}
		$("#" + grid).jqGrid('editRow', rowId);
		// selectbox 막음
		$("#testStdDiv select").attr("disabled", "disabled");
	}
	
	// 상세 (현재 사용안함)
	function btn_Print_onclick() {
		var rowId = $('#reagentsStateGrid').getGridParam('selrow');
		var row = $('#reagentsStateGrid').getRowData(rowId);
		var param = '[' + row.dept_cd + '] [' + row.mtlr_no + ']';
		fn_RDView('reagentGlassInOut', param, true, false, 900, 700);
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var bigDivName = null;
		var bigDivData = null;
		var rowId = $('#reagentsStateGrid').getGridParam('selrow');  
		var row = $('#reagentsStateGrid').getRowData(rowId);
		bigDivName = '품명';
		bigDivData = row.item_nm;
		var data = fn_Excel_Data_Make2('stateGrid', bigDivName, bigDivData);
		fn_Excel_Download(data);
	}

	//저장 기능
	function btn_Insert_onclick(mode) {
		var grid = 'stateGrid';
		fnEditRelease(grid);

		var ids = $('#' + grid).jqGrid("getDataIDs");
 	 	
		if (ids.length == 0) {
			$.showAlert("시약/실험기구 수불상세목록이 없습니다.");
		} 
		
		if (mode == 'item') {
			for(var i=0; i<ids.length; i++){
				var ids = $('#' + grid).jqGrid("getDataIDs");

				var data = 'inout_no='+ids[i]+'&inout_txt='+$('#' + grid).getCell(ids[i],'inout_txt');
				
				var json = fnAjaxAction('reagents/updateReagentsGlassInOutDetail.lims', fnGetGridAllData(grid));
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} 
			}
			
		} 
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
	
</script>
<form id="stateForm" name="stateForm" onsubmit="return false;">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td width="40%" class="table_title">
					<span>■</span>
					시약/실험기구수불상세목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<!-- 
					<span class="button white mlargeb" id="btn_Prient" onclick="btn_Print_onclick();">
						<button type="button">상세</button>
					</span>
					 -->
					  <span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick('item');">
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
	<input type="hidden" id="mtlr_no" name="mtlr_no" value="${detail.mtlr_no }">
	<div id="view_grid_state">
		<table id="stateGrid"></table>
	</div>
</form>



