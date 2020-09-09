
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매검수등록
	 * 파일명 		: buyingConfirmL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.05.20
	 * 설  명		: 구매검수등록 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.05.20   최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	//테스트중...
	var user_id;
	var user_dept;
	var deptNm;
	var userNm;
	var deptcd;
	var state;
	
	$(function() {
		//테스트중...
		user_id = '${session.user_id}';
		user_dept = '${session.dept_cd}';
		deptNm = '${session.dept_nm}';
		userNm = '${session.user_nm}';

		deptcd = fnGridCombo('dept', null);
		state = fnGridCommonCombo('C39', null);

		reqGrid('reagents/selectBuyingConfirmList.lims', 'reqForm', 'reqGrid');
		//$('#reqGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('reqForm', 'reqGrid');

		fnDatePickerImg('batchDate');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#reqGrid").setGridWidth($('#view_grid_sub').width(), true);
		}).trigger('resize');
	});

	function reqGrid(url, form, grid) {
		var lastRowId;
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [ {
				label : '상태',
				name : 'state',
				edittype : "select",
				editoptions : {
					value : state
				},
				formatter : "select",
				width : '70',
				align : 'center'
			}, {
				label : '구매확정코드',
				name : 'mtlr_cnfr_no',
				hidden : true
			}, {
				label : '구매정보번호',
				name : 'mtlr_mst_no',
				hidden : true,
				search : false
			}, {
				label : '구매요청번호',
				name : 'mtlr_req_no',
				hidden : true
			}, {
				label : '시약실험기구코드',
				name : 'mtlr_no',
				align : 'center',
				key : true,
				hidden : true
			}, {
				label : '요청부서명',
				width : '100',
				name : 'create_dept'
			}, {
				label : '요청부서코드',
				width : '100',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '요청자',
				width : '80',
				align : 'center',
				name : 'user_nm'
			}, {
				label : '마스터여부',
				width : '70',
				name : 'master_yn',
				align : 'center',
				formatter : function(value) {
					if (value == "Y" || value == "마스터") {
						return '마스터';
					} else {
						return '일반';
					}
				}
			}, {
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info',
			}, {
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info',
			}, {
				label : '품명',
				width : '200',
				name : 'item_nm'
			}, {
				label : '제조사',
				width : '100',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '100',
				align : 'center',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '100',
				align : 'center',
				name : 'spec_etc'
			}, {
				label : '요청수량',
				name : 'req_qty',
				width : '70',
				align : 'right',
			}, {
				label : '확정수량',
				name : 'fix_qty',
				width : '70',
				align : 'right'
			}, {
				label : '단가',
				name : 'cost',
				width : '60',
				align : 'right'
			}, {
				label : 'barcode',
				name : 'barcode',
				hidden : true
			}, {
				label : '검수일자',
				name : 'confirm_date',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				},
				width : '100'
			}, {
				label : '검수비고',
				name : 'confirm_etc',
				editable : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Reagents_Info').hide();
				var rowArr = $('#reqGrid').jqGrid("getDataIDs");

				// 검수입고가 하나라도 없으면
				if (rowArr.length > 0) {
					for ( var i in rowArr) {
						var row = $('#reqGrid').getRowData(rowArr[i]);
						if (row.state != '검수완료') {
							$('#btn_Reagents_Info').show();
						}
					}
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (editCount()) {
					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
						return 'stop';
					}
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fnEditRelease('reqGrid');
					lastRowId = rowId;
				}
				var selRowId = $('#' + grid).getGridParam('selrow');
				var rowData = $('#' + grid).jqGrid('getRowData', selRowId);
				
				// '검수완료' 안된것만 선택되게
 				if(rowData.state == 'C39005'){
					$('#' + grid).jqGrid('setSelection', rowId, false);
					$.showAlert("선택된 행은 검수완료되었습니다.");
				}
 				if(rowData.fix_qty == ''){
					$('#' + grid).jqGrid('setSelection', rowId, false);
					//$.showAlert("선택된 행은 확정수량,단가 정보가 없습니다.");
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease('reqGrid');
				var grid = 'reqGrid';
				fnGridEdit(grid, rowId, null);
			},
			onSelectAll : function(selar, status) {
				var cnt1 = 0;
				var cnt2 = 0;
				// '검수완료' 안된것만 선택되게
				if (!allselect) {
					var sel_ids = $("#"+grid).jqGrid("getDataIDs");
					for ( var row in sel_ids) {
						var state = $("#"+grid).getRowData(sel_ids[row]).state;
						var fix_qty = $("#"+grid).getRowData(sel_ids[row]).fix_qty;
						if(state == 'C39005'){
							$("#"+grid).jqGrid('setSelection', sel_ids[row], false); // '검수완료'된 글은 체크해지
							cnt1++;
						}
						if(fix_qty == ''){
							$("#"+grid).jqGrid('setSelection', sel_ids[row], false); // '검수완료'된 글은 체크해지
							cnt2++;
						}
					}
					if(cnt1 > 0){
						$.showAlert("검수완료 리스트가 존재합니다.");
					}
					if(cnt2 > 0){
						$.showAlert("확정수량,단가정보가 없는 리스트가 존재합니다.");
					}
				} 
				allselect = false;
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				if (rowdata.state == 'C39005') {
					for (key in rowdata) {
						$('#reqGrid').jqGrid('setCell', rowId, key, '', {
							color : 'blue'
						});
					}
				} else {
					for (key in rowdata) {
						$('#reqGrid').jqGrid('setCell', rowId, key, '', {
							color : 'red'
						});
					}
				}
			}
		});
	}

	// 조회버튼 클릭 이벤트
	function btn_Search_sub_onclick() {
		$('#reqGrid').trigger('reloadGrid');
	}

	function btn_Insert_onclick() {
		fnEditRelease('reqGrid');
		var cnt = 0;
		var ids = $('#reqGrid').jqGrid("getDataIDs");
		
		if (ids.length > 0) {
			if (!confirm('검수완료 하시겠습니까?')) {
				return false;
			} else {
				
				
				var json = fnAjaxAction('reagents/saveConfirm.lims', fnGetGridMultiCheckData('reqGrid'));
				 if (json == null) {
					alert("검수완료를 실패하였습니다.");
				} else {
					alert("검수완료되었습니다.");
					btn_Search_sub_onclick();
				} 
			}
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
	// 일괄입력 클릭 이벤트
	function btn_Batch_Date_onclick() {
		$("#dialog").dialog({
			buttons : [ {
				text : "일괄입력",
				click : function() {
					var date = $('#batchDate').val();
					fnEditRelease('reqGrid');
					var ids = $('#reqGrid').getGridParam('selarrrow');
					if (ids.length > 0) {
						for ( var i in ids) {
							var row = $('#reqGrid').getRowData(ids[i]);
							$('#reqGrid').jqGrid('setCell', ids[i], 'confirm_date', date);
						}
					} else {
						alert('선택된 행이 없습니다.');
					}
					$('#dialog').dialog("destroy");
				}
			}, {
				text : "취소",
				click : function() {
					$('#dialog').dialog("destroy");
				}
			} ]
		});
	}
	
	// 조회 키보드 이벤트
	function input_Reset(){
		$("#creater_id").val("");
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('reqGrid');
		fn_Excel_Download(data);
	}
	
	//라벨프린트
	function btn_label_onclick(){
		var rowId = $('#reqGrid').getGridParam('selrow');
		
		if(rowId == null){
			alert("선택된 행이 없습니다.");
			return false;
		}else{
// 			var gridRow = $('#reqGrid').getRowData(rowId);

			//rsetpageinfo [2@@@] 프린트시 방향전환
			html5Viewer("barcode.mrd", "/rsetpageinfo [2@@@] /rp [BARCODE] [BARCODE_DESC] [MTLR_INFO] [MTLR_NO] ["+rowId+"]", false);
		}
	}

</script>
<form id="reqForm" name="reqForm" onsubmit="return false;">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					구매검수목록
				</td>

				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb auth_select" id="btn_Date" onclick="btn_Batch_Date_onclick();">
						<button type="button">검수일자 일괄입력</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Reagents_Info" onclick="btn_Insert_onclick();">
						<button type="button">검수완료</button>
					</span>
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_sub_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_label_onclick();">
						<button type="button">라벨출력</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
				<tr>
					<th>요청자</th>
					<td>
						<input name="user_nm" id="user_nm" type="text" style="width: 160px;" onkeypress="input_Reset();"/>
						<input name="creater_id" id="creater_id" type="hidden" style="width: 160px;" />
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="btn_Pop_AdminChoice();">
					</td>
					<th>Cas no.</th>
					<td>
						<input name="spec2" id="spec2" type="text" style="width: 160px;" />
					</td>					
				</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}">
	<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no" value="${detail.mtlr_mst_no}">
	<div id="view_grid_sub">
		<table id="reqGrid"></table>
	</div>
</form>

<div id="dialog" style="display: none;">
	<table>
		<tr>
			<th>검수일자</th>
			<td>
				<input name="batchDate" id="batchDate" type="text" class="w80px" readonly="readonly" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("batchDate")' />
			</td>
		</tr>
	</table>
</div>


