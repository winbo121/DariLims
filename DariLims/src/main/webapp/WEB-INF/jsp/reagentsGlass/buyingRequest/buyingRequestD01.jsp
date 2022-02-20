
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매요청
	 * 파일명 		: buyingRequestL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.16
	 * 설  명		: 구매요청 목록 조회 화면
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
	var user_id;
	var user_dept;
	var deptNm;
	var userNm;

	$(function() {
		user_id = '${session.user_id}';
		user_dept = '${session.dept_cd}';
		deptNm = '${session.dept_nm}';
		userNm = '${session.user_nm}';

		/* var m_mtlr_C42 = fnGridCommonCombo('C42', null);
		var m_mtlr_C43 = fnGridCommonCombo('C43', null);
		m_mtlr_C43 = m_mtlr_C43.slice(1);
		m_mtlr_info = m_mtlr_C42 + m_mtlr_C43; */

		reqGrid('reagents/selectBuyingRequestList.lims', 'reqForm', 'reqGrid');
		//$('#reqGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('reqForm', 'reqGrid');

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
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [
			/*
			{
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
			}, */
			{
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				frozen : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
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
				width : '100',
				key : true,
				hidden : true
			}, {
				type : 'not',
				label : '마스터여부',
				width : '100',
				align : 'center',
				name : 'master_yn'
			}, {
				type : 'not',
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info',
			/* formatter : 'select',
			edittype : "select",
			editoptions : {
				value : h_mtlr_info
			} */
			}, {
				type : 'not',
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info',
			/* formatter : 'select',
			edittype : "select",
			editoptions : {
				value : m_mtlr_info
			} */
			}, {
				type : 'not',
				label : '품명',
				width : '200',
				name : 'item_nm'
			}, {
				/* label : '영문품명',
				width : '200',
				name : 'item_eng_nm'
				}, { */
				/* 	label : '승인구분',
					name : 'appr_flag'
				}, { */
				label : '요청수량<span class="indispensableGrid"></span>',
				name : 'req_qty',
				width : '90',
				align : 'right',
				editable : true,
				classes : 'number_css'
			/* 	editrules : {
					required : true,
					number : true
				} */
			}, {
				type : 'not',
				label : '제조사',
				width : '150',
				align : 'center',
				name : 'spec1'
			}, {
				type : 'not',
				label : 'state',
				width : '150',
				align : 'center',
				name : 'state',
				hidden : true
			}, {
				type : 'not',
				label : 'Cas no.',
				width : '150',
				align : 'center',
				name : 'spec2'
			}, {
				type : 'not',
				label : 'Cat # (제품번호)',
				width : '200',
				align : 'center',
				name : 'spec_etc'
			}, {
				/* label : '영문품명',
				width : '200',
				name : 'item_eng_nm'
				}, { */
				type : 'not',
				label : '단위',
				width : '100',
				name : 'unit',
				align : 'center'
			}, {
				label : '요청일자',
				name : 'create_date',
				align : 'center',
				width : '100'
			}, {
				label : '요청부서코드',
				name : 'create_dept',
				hidden : true
			}, {
				type : 'not',
				label : '요청부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : '요청자아이디',
				name : 'creater_id',
				hidden : true
			}, {
				type : 'not',
				label : '요청자',
				name : 'user_nm',
				align : 'center',
				width : '100'
			/*}, {
				type : 'not',
				label : '구매상태',
				name : 'state',
				align : 'center',
				width : '100'
			}, {
			 	label : '정렬순서',
				name : 'ord_no'
			}, {  
				label : '구매그룹코드',
				name : 'buy_grp_cd' */
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				allselect = false;
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
					fnEditRelease(grid);
					lastRowId = rowId;
					
					var selRowId = $('#' + grid).getGridParam('selrow');
					var rowData = $('#' + grid).jqGrid('getRowData', selRowId);
					if(rowData.creater_id != user_id){
						$('#' + grid).jqGrid('setSelection', rowId, false);
						$.showAlert("사용자가 요청한 리스트만 수정할 수 있습니다.");
					}
				}				
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				var selRowId = $('#grid').getGridParam('selrow');
				var rowData = $('#grid').jqGrid('getRowData', selRowId);
				
				var subRowData = $('#reqGrid').jqGrid('getRowData', rowId);
				
				if (rowData.buy_sts == 'C39001') {
					
					// 본인 글만 수정 가능
					if (subRowData.creater_id == user_id && subRowData.state != 'C39005'){
						if (!todayCheck())
							return;
						buyingGridEdit(grid, rowId, buying_Row_Click);
					}else{
						alert("요청자가 아닌 사용자와 검수가  완료된 구매요청건은 수정할 수 없습니다.");
					}
				} else {
					alert("구매가 확정된 목록은 수정할 수 없습니다.");
				}
			},
			onSelectAll : function(selar, status) {
				var grid = '#reqGrid';
				var cnt = 0;
				// 본인 글만 삭제 가능
				if (!allselect) {
					var sel_ids = $(grid).jqGrid("getDataIDs");
					for ( var row in sel_ids) {
						var id = $(grid).getRowData(sel_ids[row]).creater_id;
						if(id != user_id){
							$(grid).jqGrid('setSelection', sel_ids[row], false); // 본인 작성글이 아닌 글은 체크해지
							cnt++;
						}
					}
					if(cnt > 0){
						$.showAlert("사용자가 요청한 리스트만 수정할 수 있습니다.");
					}
				}
				allselect = false;
			}
		});
	}
	
	// 에디트모드
	function buyingGridEdit(grid, rowId, fnRowClick) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
		$('#' + grid).jqGrid('editRow', rowId, true, fnRowClick, null, 'clientArray');
	}
	
	// validation
	function buying_Row_Click(rowId) {
		var req_qty_id = rowId + "_req_qty";
		// 		alert(req_qty_id);
		$('#' + req_qty_id).keyup(function() {
			var reqQty = $('#' + req_qty_id).val();
			if (!fnIsNumeric(reqQty) && reqQty != '') {
				$.showAlert("숫자만 입력가능합니다.", {
					callback : function() {
						$('#' + req_qty_id).val('');
						$('#' + req_qty_id).focus();
					}
				});
			}
		});
		$('#' + req_qty_id).blur(function() {
			var reqQty = $('#' + req_qty_id).val();
			if (reqQty == '') {
				$('#' + req_qty_id).val(0);
			}
		});
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_sub_onclick() {
		$('#reqGrid').trigger('reloadGrid');
	}
	
	// 구매요청(시약/실험기구) 목록 추가이벤트
	function btn_Reagents_Info_onclick() {
		if (!todayCheck())
			return;
		fnEditRelease('reqGrid');
		
		fnBasicStartLoading();
		
		fnpop_buyingRequestPop('buyingRequest', 900, 765, 'reqGrid');
		
		/* var obj = new Object();
		obj.msg1 = 'reagents/popReagentsInfo.lims';
		obj.ids = $('#reqGrid').jqGrid("getDataIDs");
		var popup = fnShowModalWindow("popMain.lims", obj, 900, 755);
		if (popup != null) {
			for (var i = 0; i < popup.length; i++) {
				var row = popup[i];
				//테스트중...
				row.creater_id = user_id;
				row.create_dept = user_dept;
				row.user_nm = userNm;
				row.dept_nm = deptNm;
				row.icon = gridC;
				row.crud = 'n'; //추가모드
				var yyyy = new Date().getFullYear().toString();
				var mm = (new Date().getMonth() + 1).toString(); // getMonth() is zero-based
				var dd = new Date().getDate().toString();
				row.create_date = yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]);
				//-------------
				$('#reqGrid').jqGrid('addRowData', row.mtlr_no, row, 'last');
			}
		} */
	}
	
	function fnpop_callback(returnValue){
		var popup = returnValue;
		if (popup != null) {
			for (var i = 0; i < popup.length; i++) {
				var row = popup[i];
				//테스트중...
				row.creater_id = user_id;
				row.create_dept = user_dept;
				row.user_nm = userNm;
				row.dept_nm = deptNm;
				row.icon = gridC;
				row.crud = 'n'; //추가모드
				var yyyy = new Date().getFullYear().toString();
				var mm = (new Date().getMonth() + 1).toString(); // getMonth() is zero-based
				var dd = new Date().getDate().toString();
				row.create_date = yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]);
				//-------------
				$('#reqGrid').jqGrid('addRowData', row.mtlr_no, row, 'last');
			}
		}
	}
	
	// 구매요청(시약/실험기구) 목록 삭제이벤트
	function btn_Delete_onclick() {
		if (!todayCheck())
			return;
		var b = false;
		//var ids = $('#reqGrid').jqGrid("getDataIDs");
		var ids = $('#reqGrid').getGridParam('selarrrow');
		if (ids.length > 0) {
				b = true;
		}
		if (b) {
			buyingGridDeleteMultiLine('reqGrid');
		} else {
			$.showAlert('선택된 행이 없습니다. 체크박스를 선택해주세요');
		}		
	}
	
	// 삭제실행
	function buyingGridDeleteMultiLine(grid) {		
		//var ids = $('#' + grid).jqGrid("getDataIDs");
		var ids = $('#reqGrid').getGridParam('selarrrow');
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.crud != 'n') {
					$('#' + grid).setCell(ids[i], 'icon', gridD);
					$('#' + grid).setCell(ids[i], 'crud', 'd');
					$('#' + grid).setCell(ids[i], 'chk', 'No');
				} else {
					$('#' + grid).jqGrid('delRowData', ids[i]);
				}
			}
		}
	}
	
	// 저장(구매요청목록 일괄저장 클릭 이벤트)
	function btn_Insert_onclick() {
		
		if (!editCount()) {
			alert("변경된 구매요청 목록이 없습니다.");
			return;
		}
		if (!todayCheck())
			return;
		var grid = 'reqGrid';
		fnEditRelease(grid);
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			if (!validationQty(ids))
				return;
			data = fnGetGridAllData(grid);
		} else {
			$.showAlert("시험항목 목록이 존재하지 않습니다.");
		}
		//구매목록 중복되지 않도록 함
		var order = new Array();
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			var mtlr_no = row.mtlr_no;
			order[i] = mtlr_no; 
		}	
 		for (i = 0 ; i < ids.length ; i++ ){
			for(j = 1; j < ids.length-i+1; j++) {
				if (order[i] == order[i + j] ){
					$.showAlert("중복된 목록이 존재합니다. 삭제 후 다시 진행해 주세요");
					return false;
				}
			}
		} 
 		data += '&mtlr_mst_no=' + $("#reqForm").find("#mtlr_mst_no").val() + '&dept_cd=' + $("#reqForm").find("#dept_cd").val();
		var json = fnAjaxAction('reagents/insertBuyingRequestList.lims', data);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Search_sub_onclick();
		}  
	}
	
	// validation 체크
	function validationQty(ids) {
		var check = true;
		for ( var i in ids) {
			var row = $('#reqGrid').getRowData(ids[i]);
			if (row.req_qty == null || row.req_qty == '' || row.req_qty == 0) {
				/* $.showAlert("요청수량이 입력되지 않았습니다.", {callback:function() {
					$("#reqGrid").jqGrid('editRow', ids[i]);	
					$('#' + ids[i] + '_req_qty').focus();
					check = false;
				}}); */
				alert("요청수량이 입력되지 않았습니다.");
				$('#reqGrid').jqGrid("setSelection", ids[i], true);
				buyingGridEdit('reqGrid', ids[i], buying_Row_Click);
				//     			$("#reqGrid").jqGrid('editRow', ids[i]);
				$('#' + ids[i] + '_req_qty').val(null);
				$('#' + ids[i] + '_req_qty').focus();
				check = false;
				break;
			}
		}
		return check;
	}
	
	// 추가, 삭제, 저장시 수요조사시작일과 수요조사종료일 사이가 아닐때 팝업처리
	function todayCheck() {
		var check = false;
		var selRowId = $('#grid').getGridParam('selrow');
		var rowData = $('#grid').jqGrid('getRowData', selRowId);

		var startDate = rowData.buy_date;
		startDate = startDate.replace(/\-/g, '');
		var endDate = rowData.dmd_date;
		endDate = endDate.replace(/\-/g, '');
		var toDay = fnGetToday(0,0);
		toDay = toDay.replace(/\-/g, '');
		// 		alert(startDate + ", " + endDate + ", " + toDay);
		if (endDate == null || endDate == '') {
			if ((eval(toDay) >= eval(startDate)))
				check = true;
		} else if (startDate == null || startDate == '') {
			if ((eval(toDay) <= eval(endDate)))
				check = true;
		} else {
			if ((eval(toDay) >= eval(startDate)) && ((eval(toDay) <= eval(endDate))))
				check = true;
		}
		if (!check)
			alert("수요조사 기간이 아닙니다.");
		return check;
	}

	// 엑셀다운로드
	function btn_Excel_onclick() {
		var grid = 'reqGrid';
		var arr = new Array();
		arr.push('chk');
		arr.push('icon');
		$('#' + grid).hideCol(arr);
 
		var data = fn_Excel_Data_Make('reqGrid');
		fn_Excel_Download(data);
		$('#' + grid).showCol(arr);
	}
</script>
<form id="reqForm" name="reqForm" onsubmit="return false;">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					구매요청목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<!-- <span class="button white mlargeb" id="btn_Select" onclick="btn_Search_Sub_onclick();">
						<button type="button">조회</button>
					</span>  -->
					<!-- <span class="button white mlargeb" id="btn_Select" onclick="todayCheck();">
						<button type="button">날짜체크</button>
					</span> -->
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Reagents_Info" onclick="btn_Reagents_Info_onclick();">
						<button type="button">추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">삭제</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}">
	<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no" value="${detail.mtlr_mst_no }">
	<div id="view_grid_sub">
		<table id="reqGrid"></table>
	</div>
</form>