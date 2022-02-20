<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<%
	/***************************************************************************************
	 * 시스템명 		: 통합장비관제시스템
	 * 업무명 		: 의뢰승인 
	 * 파일명 		: acceptApproval.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명			: 미사용
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.18    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "ALL", "ALLNAME", 'reqListForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');

		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		approvalReqGrid('accept/selectReqList.lims', 'reqListForm', 'reqListGrid', false);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		fn_absence_change_color('reqListGrid');
		
		testSampleGrid('accept/selectAcceptSampleList.lims', 'resultForm', 'inputItemGrid');
		
		itemGrid('accept/selectAcceptItemList.lims', 'resultForm', 'resultGrid');


		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub3').width(), false);
		}).trigger('resize');
		
	});


	function approvalReqGrid(url, form, grid, multi) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '350',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : multi,
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
				}
			}, {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : '접수번호',
				name : 'test_req_seq',
				align : 'center',
				width : '80'
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				align : 'center',
				key : true,
				hidden : true
			}, {
				label : '제목',
				name : 'title',
				width : '300'
			}, {
				label : '의뢰일자',
				name : 'req_date',
				width : '100',
				align : 'center'
			}, {
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '110',
				align : 'center'
			}, {
				label : '의뢰업체명',
				name : 'req_org_nm'
			}, {
				label : '의뢰자',
				name : 'req_nm',
				width : '60',
				align : 'center'
			}, {
				label : '접수부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : 'supv_dept_cd',
				name : 'supv_dept_cd',
				hidden : true
			}, {
				label : '단위업무',
				name : 'unit_work_cd'
			}, {
				label : '검사목적',
				name : 'test_goal'
			}, {
				label : '접수자',
				name : 'user_nm',
				width : '60',
				align : 'center'
			}, {
				label : '생성자',
				name : 'creater_nm',
				width : '60',
				align : 'center'
			}, {
				label : '상태',
				name : 'state',
				hidden : true
			}, {
				label : '백업상태',
				name : 'backup_state',
				hidden : true
			}, {
				label : 'temp_min',
				name : 'temp_min',
				hidden : true
			}, {
				label : 'temp_max',
				name : 'temp_max',
				hidden : true
			}, {
				label : 'hum_min',
				name : 'hum_min',
				hidden : true
			}, {
				label : 'hum_max',
				name : 'hum_max',
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				approvalReqGrid_rowClick(rowId);
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'req_type',
				numberOfColumns : 7,
				titleText : '의뢰정보'
			}, {
				startColumnName : 'dept_nm',
				numberOfColumns : 5,
				titleText : '검사정보'
			} ]
		});
	}	
	
	
	function testSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료번호',
				name : 'test_sample_seq',
				align : 'center',
				width : '80',
				hidden : false
			}, {
				label : '검체명',
				width : '150',
				name : 'sample_reg_nm',
				editable : true
			}, {
				label : '품목코드',
				name : 'prdlst_cd',
				classes : 'prdlst_cd',
				hidden : true
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				classes : 'prdlst_nm',
				width : '200'
			}, {
				label : '검체수수료',
				name : 'sample_fee',
				width : '100',
				align : 'right'
			}, {
				label : '비고',
				width : '300',
				name : 'etc_desc'
			}, {
				label : '식약처_자가_구분',
				width : '100',
				name : 'kfda_yn',
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#resultForm').find('#test_sample_seq').val(row.test_sample_seq);
				$('#resultGrid').trigger('reloadGrid');
			},
		});
	}

	var lastRowId;
	function itemGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_sample_seq').val() != '') {
					fnGridData(url, form, grid);
				} else {
					$('#' + grid).clearGridData();
				}
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true,
				key : true
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				type : 'not',
				label : '항목대분류',
				name : 'test_item_type',
				width : '140'
			}, {
				type : 'not',
				label : '항목명',
				name : 'test_item_nm',
				width : '200'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '200'
			}, {
				label : 'user_id',
				classes : 'user_id',
				name : 'user_id',
				hidden : true
			}, {
				label : '최종수수료',
				name : 'fee',
				width : '100',
				align : 'right'
			}, {
				label : '1.품목수수료',
				name : 'prdlst_fee',
				width : '100',
				align : 'right'
			}, {
				label : '2.부서기본수수료',
				name : 'dept_fee',
				width : '120',
				align : 'right'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
		fn_Result_setGroupHeaders2(grid);
	}

	
	// 각각 ROW에 첨부파일 다운로드 링크 걸기
	function displayAlink(cellvalue, options, rowObject) {
		var edit;
		if (rowObject.file_nm == undefined)
			edit = '<label></label>';
		else
			edit = "<label><a href='analysis/reportDown.lims?att_seq=" + rowObject.att_seq + "'>" + rowObject.file_nm + "</a></label>";
		return edit;
	}
	
	// 조회 이벤트
	function btn_Select_onclick() {
		$('#reqListGrid').trigger('reloadGrid');
		$('#inputItemGrid').clearGridData();
		$('#resultGrid').clearGridData();
		fn_absence_change_color('reqListGrid');
	}

	// 승인
	function btn_Appr_onclick() {
		var ids = $('#reqListGrid').jqGrid("getDataIDs");
		var c = 0;
		var req_list = "";
		for (var i in ids) {
			var row = $('#reqListGrid').getRowData(ids[i]);
			if (row.chk == 'Yes') {
				req_list += row.test_req_seq + "■★■";
				c++;
			}		
		}

		if (c == 0) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}

		var data = "";
		if (!confirm("승인하시겠습니까?")) {
			return false;
		} else {
			req_list = req_list.substring(0, req_list.length-3);
			data = '&test_req_seq=' + req_list + '&menu_cd=' + $('#menu_cd').val();
			var json = fnAjaxAction('accept/updateAppr.lims', data);
			if (json == null) {
				$.showAlert("승인 실패하였습니다.");
			} else {
				alert('선택된 의뢰의 승인이 완료되었습니다.');
				btn_Select_onclick();
			}
		}
	}


	function btn_Return_onclick() {
		var ids = $('#reqListGrid').jqGrid("getDataIDs");
		var c = 0;
		var test_req_seq = "";
		for (var i in ids) {
			var row = $('#reqListGrid').getRowData(ids[i]);
			if (row.chk == 'Yes') {
				test_req_seq = row.test_req_seq;
				c++;
			}		
		}

		if (c == 0) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}else if (c > 1) {
			alert('반려진행은 한건씩 진행해야 합니다.');
			return false;
		}

		var obj = new Object();
		obj.msg1 = 'showReturnComment.lims';
		obj.test_req_seq = test_req_seq;
		obj.type = '${type}';
		obj.state = 'A';
		fnBasicStartLoading();
		fnpop_return (obj, '900', '630');
		
	}

	
	// [대리] 건 색상 변경
	function fn_absence_change_color(grid) {
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			var row = $('#' + grid).getRowData(ids[0]);
			if (row.absence_flag == '${session.user_id}') {
				$('#' + grid).jqGrid('setCell', ids[0], 'title', '[대리]' + row.title, {
					color : 'orange'
				});
				for (key in row) {
					$('#' + grid).jqGrid('setCell', ids[0], key, '', {
						color : 'orange'
					});
				}
			}
		}
	}
	
	// 의뢰정보 팝업
	function fnpop_reqInfo(grid) { //btn_pop_req_info
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var ret = 'reloadGrid';
			
			fnBasicStartLoading();
			fnpop_reqInfoPop(grid, "900" , "660" , 'reloadGrid', rowId, true);
			
		}
	}

	// 진행상황 팝업
	function fnpop_stateInfo() { // btn_pop_state_info
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('시료를 선택해주세요.');
		} else {
			var row = $('#reqListGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_stateInfoPop("reqListGrid", "1000", "560", rowId, row.test_req_seq, row.test_req_no, null);
		}
	}
	
	
	// 결과보기 팝업
	function fnpop_reqResultInfo() { // btn_pop_req_result_info
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var row = $('#reqListGrid').getRowData(rowId);
			
			fnBasicStartLoading();
			fnpop_reqResultInfoPop("reqListGrid", "900", "700", row.test_req_seq, row.test_req_no);
			
		}
	}
	
	// 의뢰처 팝업
	function fnpop_reqOrgChoice(name, width, hight, text){		
		fnpop_reqOrgChoicePop(name, width, hight, text);
		fnBasicStartLoading();
	}
	
	// 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
		btn_Select_onclick();
	}

	// 항목별결과보기
	function fnpop_itemHistory() {
		var rowId = $('#inputItemGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var row = $('#inputItemGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_itemResultHistoryPop('resultForm', '800', '600', row.test_sample_seq);
		}
	}

	function approvalReqGrid_rowClick(rowId){
		$('#resultForm').find('#test_req_seq').val(rowId);
		$('#inputItemGrid').trigger('reloadGrid');
		$('#resultGrid').clearGridData();
	}

</script>
<div>
	<input type="hidden" id="pageType" value="${pageType }">
	<form id="reqListForm" name="reqListForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						접수목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="reqViewBtn" onclick="fnpop_reqInfo('reqListGrid');">
							<button type="button">의뢰정보</button>
						</span>
						<span class="button white mlargeb auth_select" id="stateViewBtn" onclick="fnpop_stateInfo();">
							<button type="button">진행상황</button>
						</span>
						<span class="button white mlargeb auth_select" id="resultViewBtn" onclick="fnpop_reqResultInfo();">
							<button type="button">결과보기</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlarger auth_save" id="returnBtn" onclick="btn_Return_onclick();">
							<button type="button">반려</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Appr" onclick="btn_Appr_onclick()">
							<button type="button">승인</button>
						</span>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" class="list_table" >
				<tr>
					<th>접수번호</th>
					<td>
						<input name="test_req_no" id="test_req_no" type="text" class="w100px" />
					</td>
					<th>의뢰구분</th>
					<td>
						<select name="req_type" id="req_type" class="w100px"></select>
					</td>
					<th>제목</th>
					<td>
						<input name="title" id="title" type="text" class="w300px" />
					</td>
				</tr>
				<tr>
					<th>의뢰업체명</th>
					<td>
						<input name="req_org_nm" id="req_org_nm" type="text" class="w100px" />
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqListForm", "750", "550", "결과입력")'/>
					</td>
					<th>의뢰자</th>
					<td>
						<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
					</td>
					<th>의뢰일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
				<tr>
					<th>접수부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w200px"></select>
					</td>
					<th>단위업무</th>
					<td colspan="3">
						<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="user_id" name="user_id" value="${session.user_id}" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reqListGrid"></table>
		</div>
	</form>
</div>



<div>
	<form id="resultForm" name="resultForm" onsubmit="return false;">
		<div class="sub_purple_01" style="width: 15%; float: left;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						검체 목록
					</td>
				</tr>
			</table>
			<div id="view_grid_sub1">
				<table id="inputItemGrid"></table>
			</div>
		</div>
		<div class="sub_purple_01" style="margin-left: 3%; width: 82%; float: left;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
						선택 항목
					</td>
				</tr>
			</table>
			<c:if test="${type != 'dept'}">
				<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}">
			</c:if>
			<input type="hidden" id="test_req_seq" name="test_req_seq" />
			<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
			<input type="hidden" id="sortName" name="sortName" />
			<input type="hidden" id="sortType" name="sortType" />
			<div id="view_grid_sub3">
				<table id="resultGrid"></table>
			</div>
		</div>
	</form>
</div>