
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목별 시험기기
	 * 파일명 		: testItemInstrumentL02.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.22
	 * 설  명		: 항목별 시험기기 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    석은주		최초 프로그램 작성         
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
	var allselect = false;
	var test_std_no;
	$(function() {
		ajaxComboForm("dept_cd", "", "", null, 'allItemInstrumentForm');
		test_std_no = $("#test_std_no").val();
		itemInstGrid('master/selectTestItemInstList.lims?test_std_no='+ test_std_no, 'itemInstrumentForm', 'itemInstrumentGrid');
		
		itemInstrumentGrid('master/selectTestItemInstList.lims', 'allItemInstrumentForm', 'allItemInstrumentGrid');
		$('#allItemInstrumentGrid').setGridHeight('250', false);

		fn_Enter_Search('allItemInstrumentForm', 'allItemInstrumentGrid');
		
		$(window).bind('resize', function() {
			$("#allItemInstrumentGrid").setGridWidth($('#sub_blue_01').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#itemInstrumentGrid").setGridWidth($('#sub_purple_01').width(), false);
		}).trigger('resize');
	});

	function itemInstrumentGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '210',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			shrinkToFit : true,
			colModel : [ {
				label : '기기번호',
				name : 'inst_no',
				key : true,
				hidden : true
			}, {
				label : '장비관리번호',
				name : 'inst_mng_no',
				width : '290'
			}, {
				label : '기기명',
				name : 'inst_kor_nm',
				width : '290'
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				editChange = false;
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (grid == 'allItemInstrumentGrid') {
					var ids = $('#itemInstrumentGrid').jqGrid("getDataIDs");
					for ( var i in ids) {
						if (rowId == ids[i]) {
							alert('이미 존재합니다.');
							$('#' + grid).jqGrid('setSelection', rowId, false);
						}
					}
				}
			},
			onSelectAll : function(selar, status) {
				if (!allselect) {
					var i = 0;
					for ( var row in selar) {
						var sel_ids = $('#itemInstrumentGrid').jqGrid("getDataIDs");
						for ( var j in sel_ids) {
							if (sel_ids[j] == selar[row]) {
								$('#' + grid).jqGrid('setSelection', selar[row], false);
								i++;
							}
						}
					}
					if (i > 0) {
						if (selar.length == 0) {
							$.showAlert("모든 기기들이 추가되었습니다.");
							allselect = false;
							return 'stop';
						} else
							$.showAlert("이미 추가된 기기들이 있습니다.");
					}
				} else {
					$("#" + grid).jqGrid('resetSelection');
				}
				allselect = !allselect;
			}
		});
	}

	function itemInstGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '210px',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			multiselect : true,
			colModel : [ {
				label : '기기번호',
				name : 'inst_no',
				key : true,
				hidden : true
			}, {
				label : '기본',
				name : 'default_flag',
				formatter : 'checkbox',
				formatoptions : {
					disabled : false
				},
				width : '50',
				align : 'center',
				classes : "default_flag",
				editoptions : {
					value : 'Y:N'
				}
			}, {
				label : '장비관리번호',
				name : 'inst_mng_no',
				width : '200'
			}, {
				label : '기기명',
				name : 'inst_kor_nm',
				width : '320'
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
		});
		check_event(grid);
	}

	function check_event(grid) {
		$(".default_flag").change(function(e) {
			// e.target point to <input> DOM element
			var tr = $(e.target).closest('tr');
			var checked = $(e.target).is(":checked");
			if (checked) {
				var ids = $('#' + grid).jqGrid("getDataIDs");
				for ( var i in ids) {
					if (ids[i] == tr[0].id)
						continue;
					var row = $('#' + grid).getRowData(ids[i]);
					for ( var column in row) {
						if (column == 'default_flag') {
							$('#' + grid).jqGrid('setCell', ids[i], column, "N");
						}
					}
				}
			}
		});
	}
	
	// 기기목록 이동
	function btn_Move(m) {
		var left = 'allItemInstrumentGrid';
		var right = 'itemInstrumentGrid';
		switch (m) {
		case 1:
			var rowArr = $('#' + left).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				editChange = true;
				for ( var i in rowArr) {
					var row = $('#' + left).getRowData(rowArr[i]);
					$('#' + right).jqGrid('addRowData', rowArr[i], row, 'last');
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + left).jqGrid('setSelection', rowArr[i], false);
				}
				check_event(right);
			} else {
				alert('선택된 행이 없습니다.');
			}
			allselect = false;
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				editChange = true;
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		}
	}

	// 저장버튼 클릭 이벤트
	function btn_Insert_onclick() {

		var grid = 'itemInstrumentGrid';
		var data = '';
		var row = $('#' + grid).jqGrid("getRowData");
		if (row.length > 0) {
			data = fnGetGridAllData(grid);
		} else {
			data = 'gridData=☆★☆★';
		}
		data += '&test_item_cd=' + $('#itemInstrumentForm').find('#test_item_cd').val() + '&dept_cd=' + $('#itemInstrumentForm').find('#dept_cd').val() 
				+ '&test_std_no=' + $('#itemInstrumentForm').find('#test_std_no').val();

		var json = fnAjaxAction('master/insertTestItemInst.lims', data);

		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#itemInstrumentGrid').trigger('reloadGrid');
			$('#allItemInstrumentGrid').trigger('reloadGrid');
		}
	}

	// 조회 이벤트
	function btn_Search_Sub1_onclick() {
		$('#allItemInstrumentGrid').trigger('reloadGrid');
	}
</script>

<div class="sub_blue_01 w100p">
	<form id="allItemInstrumentForm" name="allItemInstrumentForm" onsubmit="return false;">
	<input name="test_std_no" id="test_std_no" type="hidden" value="001"/>
		<table  class="select_table" >
			<tr>
				<td width="100%" class="table_title">
					<span>■</span>
					시험기기목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>관리부서</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
				</td>
				<th class='w80px'>관리번호</th>
				<td>
					<input name="inst_mng_no" type="text" class="inputhan" />
				</td>
				<th class='w80px'>기기명</th>
				<td>
					<input name="inst_kor_nm" type="text" class="inputhan" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="pageType" name="pageType" value="all">
		<input type="hidden" id="test_item_cd" name="test_item_cd" value="${detail.test_item_cd }" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_Inst_sub1 w100p">
			<table id="allItemInstrumentGrid"></table>
		</div>
	</form>
</div>

<div style="clear:both; padding-top:25px; text-align:center;">
	<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnDown"></button>
	<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnUp"></button>
</div>

<div class="sub_blue_01">
	<form id="itemInstrumentForm" name="itemInstrumentForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="100%" class="table_title">
					<span>■</span>
					선택시험기기목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="test_item_cd" name="test_item_cd" value="${detail.test_item_cd }" />
		<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no }" />
		<input type="hidden" id="dept_cd" name="dept_cd" value="${detail.dept_cd }" />
		<input type="hidden" id="test_std_no" name="test_std_no" value="${detail.test_std_no}" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_Inst_sub2">
			<table id="itemInstrumentGrid"></table>
		</div>
	</form>
</div>
