
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 품목별수수료관리
	 * 파일명 		: commissionPrdL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2016.01.25
	 * 설  명		: 수수료 조회/등록 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2016.01.25    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>

<style>
.not-editable-cell {
	background-color: gray;
}
/* 한글우선입력 */
.imeon input {
	ime-mode: active;
}
#CommissionUpdateDiv {
	background-color: white;
	border: 2px;
	border-radius: 8px;
	border-style: solid;
	border-color: #b27ce0;
	width: 300px;
	position: absolute;
	padding-bottom: 15px;
	z-index:2000;
}
</style>
<script type="text/javascript">
	var fnGridInit = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "commissionPrdForm");
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", "NON", 'commissionPrdForm');
		//$("#dept_cd option").not(":selected").attr("disabled", "disabled");
		
		commissionPrdGrid('accept/commissionPrdList.lims', 'commissionPrdForm', 'commissionPrdGrid');
		
		if($("#commission_flag").val() == 'Y'){
			$('#commission_flag_n').removeAttr('checked');
			$('#commission_flag_y').prop('checked', true);
		} else {
			$('#commission_flag_Y').removeAttr('checked');
			$('#commission_flag_n').prop('checked', true);
		}
		
		$('#CommissionUpdateDiv').hide(); // 수수료 사용 여부 수정 DIV
		
		// 그리드 사이즈 
		$(window).bind('resize', function() {
			$("#commissionPrdGrid").setGridWidth($('#view_grid_rev').width(), false);
		}).trigger('resize');

		fnDatePicker('rev_date');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('commissionPrdForm', 'commissionPrdGrid');	
	});

	function commissionPrdGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
				//fnGridData(url, form, grid);
			},
			height : '368px',
			// 			width : 'auto',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				},
				frozen : true
			}, {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				sortable : false,
				frozen : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true,
				width : '250'
				
			}, {
				label : 'prdlst_cd',
				name : 'prdlst_cd',
				hidden : true,
				width : '250'
				
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				width : '250'
			}, {
				label : '항목명',
				name : 'test_item_nm',
				width : '250'
			}, {
				label : '영문명',
				name : 'test_item_eng_nm',
				width : '250'
			}, {
				label : '수수료',
				name : 'fee',
				classes : 'fee',
				width : '80',
				align : 'right',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : true,
				editable : true
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
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fnEditRelease(grid);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				commissionPrdGridEdit(grid, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
			},
		});

	}
	
	// 시험기준별시험항목에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount() {
		var grid = 'commissionPrdGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#reqGrid').getRowData(ids[i]);
			if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}
	
	// 에디트모드
	function commissionPrdGridEdit(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
		editable('');
	}
	
	// 업데이트 아이콘 생성
	function commissionPrdGridEditCell(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
	}
	
	// 셀 수정 여부
	function editable(e) {
		var grid = 'commissionPrdGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
		var arr = new Array();
		// 결과값형태
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		arr.push('fee');

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

	// 조회버튼 클릭 이벤트
	function btn_Search_onclick(type) {
		if (type == 1) {
			if (editCount()) {
				if (!confirm("수정중인 기준시험항목 목록은 사라집니다."))
					return 'stop';
			}
			//selectbox풀기
			$("#testStdDiv select").attr("disabled", false);
		}
		fnEditRelease('commissionPrdGrid');
		$('#commissionPrdGrid').trigger('reloadGrid');
	}

	// 기준별 시험항목 목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount() {
		var grid = 'commissionPrdGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#commissionPrdGrid').getRowData(ids[i]);
			if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}

	// 저장버튼 클릭이벤트
	function btn_Insert_onclick(mode) {
		var grid = 'commissionPrdGrid';
		fnEditRelease(grid);

		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			data = fnGetGridAllData(grid);
		} else {
			$.showAlert("시험항목 목록이 존재하지 않습니다.");
		}
		// 		alert(data)
		if (mode == 'item') {
			if (!editCount()) {
				alert("변경된 시험항목 목록이 없습니다.");
				return;
			}
// 			if ($("#commissionPrdForm").find("#rev_no").val() == null || $("#commissionPrdForm").find("#rev_no").val() == '') {
// 				$.showAlert("개정이력이 존재하지 않습니다. 개정추가를 해주세요.");
// 				// 				alert("개정이력이 존재하지 않습니다. 개정추가를 해주세요");
// 				return;
// 			}
// 			data += '&pageType=stdTestItemSave';
			data += '&pageType=PRDFEE';
			data += '&test_std_no=' + $("#commissionPrdForm").find("#test_std_no").val();
			var json = fnAjaxAction('accept/insertStdPrdItemCommission.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				//selectbox풀기
				$("#testStdDiv select").attr("disabled", false);
				btn_Search_onclick(2);
			}
		} else
			data += '&test_std_no=' + $("#commissionPrdForm").find("#test_std_no").val();
		return data;
	}
	
	// 시험항목추가 팝업
	function btn_Add_Test_Item_onclick() {
		fnEditRelease('commissionPrdGrid');		
		var ids = $('#commissionPrdGrid').jqGrid("getDataIDs");
		var param = "";
		var arr = new Array();
		var arrPrd = new Array();
		
		for ( var i in ids) {
			var row_ids = $('#commissionPrdGrid').getRowData(ids[i]);
			arr[i] = row_ids.test_item_cd;
		}
		
		for ( var j in ids) {
			var row_ids = $('#commissionPrdGrid').getRowData(ids[j]);
			arrPrd[j] = row_ids.prdlst_cd;
		}

		param = "" + "◆★◆" + removeArrayDuplicate(arr) 
				+ "◆★◆" +  $('#commissionPrdForm').find('#test_std_no').val() + "◆★◆" + "PRDFEE"
				+ "◆★◆" + "" + "◆★◆" + removeArrayDuplicate(arrPrd)
				+ "◆★◆" + ""+ "◆★◆" + "";
		fnpop_selfStdItemChoicePop("commissionPrdForm", "1000", "867", param);
		fnBasicStartLoading();
	}	
	
	// 자식 -> 부모창 함수 호출
	function fnpop_callback(returnParam){
		$('#commissionPrdGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	// 시험 항목 삭제 버튼 클릭
	function btn_Delete_onclick() {
		var b = false;
		var ids = $('#commissionPrdGrid').jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#commissionPrdGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					b = true;
				}
			}
			if (b) {
				testStdGridDeleteMultiLine('commissionPrdGrid');
			} else {
				$.showAlert('선택된 행이 없습니다. 체크박스를 선택해주세요');
			}
		}
	}
	
	// 삭제실행
	function testStdGridDeleteMultiLine(grid) {
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					if (row.crud != 'n') {
						$('#' + grid).setCell(ids[i], 'icon', gridD);
						$('#' + grid).setCell(ids[i], 'crud', 'd');
						$('#' + grid).setCell(ids[i], 'chk', 'No');
						// selectbox막기
						$("#testStdDiv select").attr("disabled", "disabled");
					} else {
						$('#' + grid).jqGrid('delRowData', ids[i]);
					}
				}
			}
		}
	}

	// 콤보박스
	function ajaxComboStdNo(obj, val) {
		var masterUrl = '';
		var v = '';
		var t = '';
		var data = '';
		if (obj == 'test_std_no') {
			masterUrl = 'master/selectTestStdList.lims';
			v = "test_std_no";
			t = "test_std_nm";
		} else {
			masterUrl = 'master/selectTestStdRevList.lims';
			v = "rev_no";
			t = "rev_date";
			data = 'test_std_no=' + $('#commissionPrdForm').find('#test_std_no').val();
		}
		$.ajax({
			url : masterUrl,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : data,
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				$("#" + obj).empty();
				$(json).each(function(index, entry) {
					if (val == entry[v] || val == entry[t])
						$("#" + obj).append("<option selected value='" + entry[v] + "'>" + entry[t] + "</option>");
					else
						$("#" + obj).append("<option value='" + entry[v] + "'>" + entry[t] + "</option>");
				});
				$("#" + obj).trigger('change');// 강제로 이벤트 시키기
			}
		});
	}
	
	// 수수료 사용 여부 수정
	function btn_Update_CommissionFlag_onclick(state) {		
		if(state == '0'){
			$('#CommissionUpdateDiv').css("top", ($(window).height() / 2.5) - ($('#CommissionUpdateDiv').outerHeight() / 2));
			$('#CommissionUpdateDiv').css("left", ($(window).width() / 2) - ($('#CommissionUpdateDiv').outerWidth() / 2));
			$('#CommissionUpdateDiv').show();
			fnBasicStartLoading();
		} else {
			var param = $('#commissionPrdForm').serialize();
			var json = fnAjaxAction('accept/updateCommissionFlag.lims', param);				
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {type : 'insert'});
				btn_Close_onclick();
			}
		}
	}
	
	// 수수료 사용 여부 수정 div 닫기버튼 이벤트
	function btn_Close_onclick() {
		$('#CommissionUpdateDiv').hide();
		fnBasicEndLoading();
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('commissionPrdGrid');
		fn_Excel_Download(data);
	}
	
</script>
<form id="commissionPrdForm" name="commissionPrdForm" onsubmit="return false;">
	<div id='CommissionUpdateDiv'>
		<div class="sub_purple_01" style="width: 90%">
			<table class="select_table">
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						수수료 사용여부
					</td>
					<td class="table_button" style="text-align: right;">
						<span class="button white mlargep auth_save" id="btn_CommissionFlag_Update" onclick="btn_Update_CommissionFlag_onclick(1);">
							<button type="button">수정</button>
						</span>
						<span class="button white mlargep" id="btn_CommissionFlag_Update_Close" onclick="btn_Close_onclick();">
							<button type="button">닫기</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table">
				<tr>
					<th>수수료 사용여부</th>
					<td width="30%">					
						<input name="commission_flag" id="commission_flag_y" type="radio" value="Y"/>
						<label for="commission_flag_y">적용</label>
						<input name="commission_flag" id="commission_flag_n" type="radio" value="N"/>
						<label for="commission_flag_n">적용안함</label>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="sub_purple_01">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					수수료관리
				</td>
				<td class="table_button" style="text-align: right;">
					<!-- 
					<span class="button white mlargeg auth_select" id="btn_UpdateFlag" onclick="btn_Update_CommissionFlag_onclick(0);">
						<button type="button">수수료사용여부</button>
					</span>
					-->
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick(1);">
						<button type="button">조회</button>
					</span>
					<!-- 
					<span class="button white mlargep" id="btn_Test_Std_Insert" onclick="btn_Test_Std_Insert_onclick();">
						<button type="button">검사기준등록</button>
					</span>
					-->
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_Add_Test_Item_onclick();">
						<button type="button">시험항목추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">시험항목삭제</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick('item');">
						<button type="button">저장</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
					<!-- 
					<span class="button white mlargep" id="btn_Test_Std_Insert" onclick="btn_Std_Rev_Insert_onclick(1);" style="margin-right: 20px;">
						<button type="button">개정</button>
					</span>
					 -->
				</td>
			</tr>
		</table>
		
		<div id="testStdDiv">
			<table width="100%" border="0" class="list_table">
				<tr>
					<th style="width:150px;">품목구분</th>
					<td>
						<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
					</td>
					<th style="width:150px;">품목명</th>
					<td>
						<input type="text" name="kor_nm" />
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td colspan="3">
						<select id='dept_cd' name="dept_cd" class="auth_select w200px" onChange="btn_Search_onclick();"></select>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="test_std_no" name="test_std_no" value="001">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_rev">
			<table id="commissionPrdGrid"></table>
		</div>
	</div>
</form>