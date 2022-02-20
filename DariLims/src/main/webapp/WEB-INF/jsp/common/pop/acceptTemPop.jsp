
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료템플릿
	 * 파일명 		: acceptTemPop.jsp
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var tempItemMsg = '<div class="txt_accept"><span class="txt_accept04"></span></div>';
	var deptEdit;
	var popupName = window.name; // 팝업창 이름 가져오기
	var arrTem = new Array;
	
	var popImg = '<img style="width: 16px;" src="../images/common/icon_search.png"  class="auth_select"/>';
	var deleteImg = '<img style="width: 16px;" src="../images/common/icon_stop.png"/>';
	$(function() {
		arrTem = popupName.split("★●★");
		deptEdit = fnGridCombo('dept', 'NON');

		ajaxComboForm("dept_cd", "", "${session.dept_cd}", 'ALLNAME', 'templeteForm');
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", 'ALLNAME', 'templeteItemForm');

		templeteGrid('selectTempleteSampleList.lims', 'templeteForm', 'templeteGrid');

		templeteItemGrid('selectPopAllTestItemList.lims', 'templeteItemForm', 'templeteItemGrid');
		templeteItemGrid('selectTempleteItemList.lims', 'templeteItemFormSub', 'templeteItemGridSub');

		/* $(window).bind('resize', function() {
			$("#templeteGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#templeteItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#templeteItemGridSub").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize'); */

		fn_Enter_Search('templeteForm', 'templeteGrid');
		fn_Enter_Search('templeteItemForm', 'templeteItemGrid');
	});
	
	var lastRowId;
	function templeteGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				//if(arrTem[3] == null || arrTem[3] == '' || arrTem[3] == 'undefined'){
					fnGridData(url, form, grid);
				//}
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료템플릿명',
				name : 'sample_temp_nm',
				width : '200',
				editable : true
			}, {
				label : 'sample_temp_cd',
				name : 'sample_temp_cd',
				key : true,
				hidden : true
			}, {
				label : '부서',
				name : 'dept_cd',
				width : '80',
				align : 'center',
				editable : true,
				edittype : "select",
				editoptions : {
					value : deptEdit
				},
				formatter : 'select'
			}, {
				label : 'sample_cd',
				name : 'sample_cd',
				classes : 'sample_cd',
				hidden : true
			}, {
				type : 'not',
				label : '시료유형',
				width : '200',
				name : 'sample_nm',
				classes : 'sample_nm',
				editoptions : {
					readonly : "readonly"
				}
			}, {
				type : 'not',
				label : ' ',
				name : 'sample_pop',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'sample_del',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				formatter : deleteImageFormat
			}, {
				label : '사용여부',
				name : 'use_flag',
				width : '80',
				align : 'center',
				editable : true,
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:사용안함'
				},
				formatter : 'select'
			}, {
				label : '비고',
				name : 'etc',
				width : '430',
				editable : true

			} ],
			gridComplete : function() {
				$('#btn_Save').hide();
				$('#btn_Delete').hide();
				$('#btn_Save_Sub1').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var row = $('#' + grid).getRowData(rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				if (col == 'sample_pop') {
					
					fnpop_sampleChoicePop("720", "500", rowId, false);
					fnBasicStartLoading();
// 					var ret = btn_Pop_SampleChoice();
// 					if (ret != null && ret != '') {
// 						var arr = ret.split('◆★◆');
// 						$('#' + grid).jqGrid('setCell', rowId, 'sample_nm', arr[0]);
// 						$('#' + grid).jqGrid('setCell', rowId, 'sample_cd', arr[1]);
// 					}
					
				} else if (col == 'sample_del') {
					$('#' + grid).jqGrid('setCell', rowId, 'sample_nm', null);
					$('#' + grid).jqGrid('setCell', rowId, 'sample_cd', null);
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					fnStopLoading('itemDiv');
					if (rowId != 0) {
						$('#templeteItemFormSub').find('#sample_temp_cd').val(rowId);
						//$('#templeteItemGrid').trigger('reloadGrid');
						$('#templeteItemGridSub').trigger('reloadGrid');
					}
					$('#btn_Choice').show();
					$('#btn_AddLine').show();
					$('#btn_Save_Sub1').show();
					$('#btn_Save').hide();
					$('#btn_Delete').hide();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null)
				$('#btn_Choice').show();
				$('#btn_AddLine').show();
				$('#btn_Save').show();
				$('#btn_Delete').show();
				$('#btn_Save_Sub1').hide();
				fn_Div_Block('itemDiv', tempItemMsg);
				$('#templeteItemGridSub').clearGridData();
			}
		});
	}
	
	function templeteItemGrid(url, form, grid) {
		var height = '400';
		if (grid == 'templeteItemGridSub') {
			height = '430';
		}
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if (grid == 'templeteItemGridSub') {
					if ($('#templeteItemFormSub').find('#sample_temp_cd').val() != '') {
						fnGridData(url, form, grid);
					} 
					else if (arrTem[3] != null && arrTem[3] != '' && arrTem[3] != 'undefined') {
						if (arrTem[4] == null || arrTem[4] == '' || arrTem[4] == 'undefined'){
							arrTem[4] = '';
							arrTem[5] = '';
						}
// 						$('#templeteGrid').jqGrid('addRow', {
// 							rowID : 0,
// 							position : 'last',
// 							addRowParams : {
// 								oneditfunc : opener.fn_Row_Click()
// 							},
// 							initdata : {
// 								sample_cd : arrTem[4],
// 								sample_nm : arrTem[5]
// 							}
// 						});
						$('#templeteItemFormSub').find('#test_sample_seq').val(arrTem[3]);
						fnGridData('selectAcceptItemList.lims', form, grid);
						$('#btn_Choice').hide();
						$('#btn_AddLine').hide();
						$('#btn_Save').show();
						$('#btn_Delete').hide();
						$('#btn_Save_Sub1').hide();
					}
				} 
				else {
					fnGridData(url, form, grid);
				}
			},
			height : height,
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			sortable : false,
			colModel : [ {
				label : 'sample_temp_cd',
				name : 'sample_temp_cd',
				editable : true,
				hidden : true
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : '항목',
				name : 'test_item_nm'
			}, {
				label : '부서',
				name : 'dept_nm',
				width : '100',
				align : 'center'
			}, {
				label : 'user_id',
				name : 'user_id',
				hidden : true
			}, {
				label : '시험자',
				name : 'user_nm',
				width : '70',
				align : 'center'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm'
			}, {
				label : '항목유형',
				name : 'test_item_type'
			}, {
				label : 'KOLAS',
				name : 'kolas_flag',
				width : '50',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
				var b = false;
				if (grid == 'templeteItemGrid') {
					var b = false;
					var nowRow = $('#' + grid).getRowData(rowId);
					var test_item_cd = nowRow.test_item_cd;
					var ids = $('#templeteItemGridSub').jqGrid("getDataIDs");
					if (ids.length > 0) {
						for ( var r in ids) {
							var row = $('#templeteItemGridSub').getRowData(ids[r]);
							if (test_item_cd == row.test_item_cd) {
								b = true;
							}
						}
					}
					ids = $('#' + grid).getGridParam('selarrrow');
					if (ids.length > 1) {
						for ( var r in ids) {
							if (ids[r] != rowId) {
								var row = $('#' + grid).getRowData(ids[r]);
								if (test_item_cd == row.test_item_cd) {
									b = true;
								}
							}
						}
					}
					if (b) {
						$.showAlert('이미 선택된 항목입니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
				}
			}
		});
		if (grid == 'templeteItemGridSub') {
			$('#' + grid).sortableRows(null);
		}
	}
	
	function btn_Move(m) {
		var left = 'templeteItemGrid';
		var right = 'templeteItemGridSub';
		switch (m) {
		case 1:
			var rowArr = $('#' + left).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for ( var i in rowArr) {
					var row = $('#' + left).getRowData(rowArr[i]);
					var test_item_cd = row.test_item_cd;
					var bool = true;
					var rightRowArr = $('#' + right).jqGrid("getDataIDs");
					for ( var z in rightRowArr) {
						var rightRow = $('#' + right).getRowData(rightRowArr[z]);
						if (test_item_cd == rightRow.test_item_cd) {
							bool = false;
						}
					}
					if (bool) {
						var id = fnNextRowId(right);
						$('#' + right).jqGrid('addRowData', id, row, 'last');
						$('#' + right).setCell(id, 'sample_temp_cd', $('#templeteItemFormSub').find('#sample_temp_cd').val());
					}
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + left).jqGrid('setSelection', rowArr[i], false);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		}
	}
	
	// 조회 이벤트
	function btn_Tem_Select_onclick() {
		var rowId = $('#templeteGrid').getGridParam('selrow');
		$('#templeteGrid').jqGrid('restoreRow', rowId);
		$('#templeteGrid').trigger('reloadGrid');
		$('#btn_Choice').show();
		$('#btn_AddLine').show();
		$('#btn_Save').hide();
		$('#btn_Delete').hide();
		$('#btn_Save_Sub1').hide();
		$('#templeteItemGridSub').clearGridData();
		lastRowId = null;
	}
	
	function btn_AddLine_onclick() {
		var grid = 'templeteGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		$('#' + grid).jqGrid('restoreRow', rowId);
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		$('#' + grid).find('#0_dept_cd').val('${session.dept_cd}');

		$('#btn_Choice').hide();
		$('#btn_AddLine').hide();
		$('#btn_Save').show();
		$('#btn_Delete').hide();
		$('#btn_Save_Sub1').hide();
		$('#templeteItemGridSub').clearGridData();

		fn_Div_Block('itemDiv', tempItemMsg);
	}
	
	function fn_Div_Block(id, msg) {
		fnStartLoading(id, msg);
		$('.blockUI').click(function() {
			var grid = 'templeteGrid';
			if (!confirm('템플릿 추가를 취소하시겠습니까?')) {
				return false;
			} else {
				$('#' + grid).jqGrid('restoreRow', lastRowId);
				$('#btn_Choice').show();
				$('#btn_AddLine').show();
				fnStopLoading(id);
			}
		});
	}
	
	function btn_Save_onclick() {
		fnEditRelease('templeteGrid');
		var rowId = $('#templeteGrid').getGridParam('selrow');
		var row = $('#templeteGrid').getRowData(rowId);
		if (row.sample_cd == '') {
			$.showAlert('시료유형을 선택해주세요.');
		} else {
			var url;
			if (rowId == '0') {
				url = 'insertTemplete.lims';
			} else {
				url = 'updateTemplete.lims';
			}
			var json = fnAjaxAction(url, fnGetGridData('templeteGrid', rowId));
			if (json == null) {
				$.showAlert('저장실패하였습니다.');
			} else {
				if ($('#templeteItemFormSub').find('#sample_temp_cd').val() == '') {
					$('#templeteItemFormSub').find('#sample_temp_cd').val(json);
					var rowArr = $('#templeteItemGridSub').jqGrid("getDataIDs");
					if (rowArr.length > 0) {
						for ( var i in rowArr) {
							$('#templeteItemGridSub').setCell(rowArr[i], 'sample_temp_cd', $('#templeteItemFormSub').find('#sample_temp_cd').val());
						}
					}
				}
				$('#templeteGrid').trigger('reloadGrid');
				$('#btn_Choice').show();
				$('#btn_Save').hide();
				$('#btn_Delete').hide();
				lastRowId = null;
			}
		}
	}
	
	function btn_Save_Sub1_onclick() {
		var rowArr = $('#templeteItemGridSub').jqGrid("getDataIDs");
		if (rowArr.length > 0) {
			var data = fnGetGridAllData('templeteItemGridSub') + '&sample_temp_cd=' + $('#templeteItemFormSub').find('#sample_temp_cd').val();
			var json = fnAjaxAction('saveTemplete.lims', data);
			if (json == null) {
				$.showAlert('저장실패하였습니다.');
			} else {
				$.showAlert('저장완료되었습니다.');
			}
		}
	}
	
	// 선택
	function btn_Choice_onclick() {
		var grid = 'templeteGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId == null) {
			$.showAlert('선택된 행이 없습니다.');
		} else {
// 			var arr = popup.split('@');
//			var rowId = fnGridAddLine('reqSampleGrid');
//			$('#reqSampleGrid').setCell(rowId, 'test_req_no', $('#reqDetailForm').find('#test_req_no').val());
//			$('#reqSampleGrid').setCell(rowId, 'sample_temp_cd', arr[0]);
//			$('#reqSampleGrid').setCell(rowId, 'sample_reg_nm', arr[1]);
//			$('#reqSampleGrid').setCell(rowId, 'sample_cd', arr[2]);
//			var today = fnGetToday(0,0);
//			$('#reqSampleGrid').setCell(rowId, 'sampling_date', today);
//			fn_Div_Block('itemDiv', itemMsg, false);
			$('#' + grid).jqGrid('restoreRow', rowId);
			var row = $('#' + grid).getRowData(rowId);
			
			opener.tem_callback(row.sample_temp_cd + '@' + row.sample_temp_nm + '@' + row.sample_cd + '@' + row.sample_nm);
			window.close();
			fnBasicEndLoading();
		}

	}
	
	// 항목 그리드 조회
	function btn_Select_Sub1_onclick() {
		$('#templeteItemGrid').trigger('reloadGrid');
	}
	
	// 콜백함수
	function fnpop_callback(returnParam){
		$('#templeteItemGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>시료 템플릿</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="templeteForm" name="templeteForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시료 템플릿 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Tem_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Choice_onclick();">
									<button type="button">템플릿 선택</button>
								</span>
								<span class="button white mlargeb auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
									<button type="button">추가</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
									<button type="button">저장</button>
								</span>
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" class="list_table" >
						<tr>
							<th>템플릿명</th>
							<td>
								<input name="sample_temp_nm" type="text" class="inputhan" />
							</td>
							<th>부서</th>
							<td>
								<select name="dept_cd" id="dept_cd" class="w100px"></select>
							</td>
							<th>사용여부</th>
							<td nowrap="nowrap">
								<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="" />
								전체
								<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="Y" checked="checked" />
								사용
								<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="N" />
								사용안함
							</td>
						</tr>
					</table>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_main">
						<table id="templeteGrid"></table>
					</div>
				</form>
			</div>
			<div style="display:inline-block;" id="itemDiv">
				<div class="sub_purple_01 w45p">
					<form id="templeteItemForm" name="templeteItemForm" onsubmit="return false;">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									항목
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
										<button type="button">조회</button>
									</span>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" class="list_table" >
							<tr>
								<th>항목</th>
								<td>
									<input name="test_item_nm" type="text" class="inputhan" />
								</td>
								<th>부서</th>
								<td>
									<select name="dept_cd" id="dept_cd" class="w100px"></select>
								</td>
								<th>시험자</th>
								<td nowrap="nowrap">
									<input name="user_nm" id="user_nm" type="text" class="inputhan" />
								</td>
							</tr>
						</table>
						<input type="hidden" id="sortName" name="sortName">
						<input type="hidden" id="sortType" name="sortType">
						<div id="view_grid_sub1">
							<table id="templeteItemGrid"></table>
						</div>
					</form>
				</div>
				<div class="w10p">
					<span>
						<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnRight"></button>
					</span>
					<br>
					<br>
					<span>
						<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnLeft"></button>
					</span>
				</div>
				<div class="sub_purple_01 w45p">
					<form id="templeteItemFormSub" name="templeteItemFormSub" onsubmit="return false;">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title" nowrap="nowrap">
									<span>■</span>
									선택 항목
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub1_onclick();">
										<button type="button">저장</button>
									</span>
								</td>
							</tr>
						</table>
	
						<input type="hidden" id="sample_temp_cd" name="sample_temp_cd">
						<input type="hidden" id="test_sample_seq" name="test_sample_seq">
						<input type="hidden" id="sortName" name="sortName">
						<input type="hidden" id="sortType" name="sortType">
						<div id="view_grid_sub2">
							<table id="templeteItemGridSub"> </table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
