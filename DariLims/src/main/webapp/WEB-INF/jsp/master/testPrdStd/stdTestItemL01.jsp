
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 	: 기준별시험항목
	 * 파일명 	: stdTestPrdItemL01.jsp
	 * 작성자 	: 최은향
	 * 작성일 	: 2015.12.22
	 * 설  명		: 시험기준분류에 따른 시험항목 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.22    최은향		최초 프로그램 작성         
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
	var unit_sel;
	var result_type;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		unit_sel = fnGridCommonCombo('C08', '', null);
		result_type = fnGridCommonCombo('C31', '', null);
		
		stdTestPrdItemGrid('master/selectStdTestPrdItemList.lims', 'stdTestPrdItemForm', 'stdTestPrdItemGrid');	
		$('#stdTestPrdItemGrid').clearGridData(); // 최초 조회시 데이터 안나옴
	});
	
	function testItemGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250px',
			width : 'auto',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : false,
			multiselect : true,
			colModel : [ {
				label : '항목명',
				name : 'test_item_nm'
			}, {
				label : '항목약어',
				name : 'test_item_abbr'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm'
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : true
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
// 				fnCheckAction(grid);
			},
			onSortCol : function(index, iCol, sortorder) {	
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var ids = $('#stdTestPrdItemGrid').jqGrid("getDataIDs");
				for ( var i in ids) {
					if (rowId == ids[i]) {
						alert('이미 존재합니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
				}				
			}
		});	
	}
	
	function stdTestPrdItemGrid(url, form, grid) {
// 		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '279px',
			width : 'auto',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : false,
			multiselect : true,
			colModel : [ {
				label : '항목명',
				name : 'test_item_nm'
			}, {
				label : '기준상한',
				name : 'std_hval',
				editable : true
			}, {
				label : '기준하한',
				name : 'std_lval',
				editable : true
			}, {				
				label : '결과값형태',
				name : 'result_type',
				editable : true,
				edittype : "select",
				editoptions : {
					value : result_type
				}
			}, {
				label : '표기자리수',
				name : 'valid_position',
				editable : true
			}, {
				label : '단위',
				name : 'unit',
				editable : true,
				edittype : "select",
				editoptions : {
					value : unit_sel
				}
			}, {
				label : '기준적합값',
				name : 'std_fit_val',
				editable : true				
			}, {
				label : '기준부적합값',
				name : 'std_unfit_val',
				editable : true
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : true,
				editable : true
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {	
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}				
			},
			onSelectRow : function(rowId, status, e) {				
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId);
			}
		});		
	}
	
	//이동
	function btn_Move(m) {
		var left = 'testItemGrid';
		var right = 'stdTestPrdItemGrid';
		switch (m) {
		case 1:
			var rowArr = $('#' + left).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for ( var i in rowArr) {
					var row = $('#' + left).getRowData(rowArr[i]);
					$('#' + right).jqGrid('addRowData', rowArr[i], row, 'last');
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + left).jqGrid('setSelection', rowArr[i], false);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		}
	}
	
	//저장버튼 클릭 이벤트 서브2
	function btn_Insert_Sub2_onclick(){	
		var grid = 'stdTestPrdItemGrid';
		fnEditRelease(grid);
		
		var row = $('#' + grid).jqGrid("getRowData");
		if(row.length > 0) {
			data = fnGetGridAllData(grid);		
		} else {
			data = 'gridData=☆★☆★';	
		}
		data += '&test_std_no=' + $("#stdTestPrdItemForm").find("#test_std_no").val() + '&rev_no=' + $("#stdTestPrdItemForm").find("#rev_no").val();
//  		alert(data);	
		var json=fnAjaxAction('master/insertStdTestItem.lims', data);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$('#stdTestPrdItemGrid').trigger('reloadGrid');
			$('#testItemGrid').trigger('reloadGrid');
			$.showAlert("", {type:'insert'});
		}
	}
	
	function btn_Search_Sub1_onclick() {		
		$('#testItemGrid').trigger('reloadGrid');
	}	
</script>

<!-- 기준별시험항목기준정보 -->
<div>

	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td width="50%" class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #27aeea;">■</span>
					선택항목
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_save" id="btn_Insert_Sub2" onclick="btn_Insert_Sub2_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
		<form id="stdTestPrdItemForm" name="stdTestPrdItemForm" onsubmit="return false;">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<input type="hidden" id="test_std_no" name="test_std_no" value="${detail.test_std_no }" />
			<input type="hidden" name="rev_no" id="rev_no" value="${detail.rev_no }" />
			<table id="stdTestPrdItemGrid"></table>
		</form>

	</div>
</div>