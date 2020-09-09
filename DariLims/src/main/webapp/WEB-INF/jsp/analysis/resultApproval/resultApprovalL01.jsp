
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험결과승인
	 * 파일명 		: resultApprovalL01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.02.16
	 * 설  명		: 시험부서결과승인
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.16	    정우용		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
</style>
<script type="text/javascript">
	var result_type;
	var unit;
	var jdg_type;
	var hval_type;
	var lval_type;
	var std_type;
	var fit_val;
	var fnGridInit = false;
	
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

		commonReqGrid('resultApproval/selectSampleList.lims', 'reqListForm', 'reqListGrid', true);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		fn_absence_change_color('reqListGrid');

		result_type = fnGridCommonCombo('C31', 'NON');
		unit = fnGridCommonCombo('C08', null);
		jdg_type = fnGridCommonCombo('C37', 'NON');
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);

		testSampleGrid('analysis/selectSampleList.lims', 'resultForm', 'inputItemGrid');
		
		itemGrid('analysis/selectResultSampleList.lims', 'resultForm', 'resultGrid');
		// 시료별 성적서 리스트
		sampleReportListGrid('analysis/selectsampleReportList.lims', 'sampleReportListForm', 'sampleReportListGrid');


		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_main').width()*.600);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#sampleReportListGrid").setGridWidth($('#view_grid_main').width()*.350);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub3').width(), true);
		}).trigger('resize');
		
	});

	function testSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '150',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료번호',
				name : 'test_sample_seq',
				align : 'center',
				width : '80',
				hidden : false
			}, {
				label : '시료명',
				name : 'sample_reg_nm',
				width : '150'
			} , {
				label : '시험결과',
				name : 'test_sample_result_nm',
				align : 'center',
				width : '100'
			}, {
				label : '시료유형',
				name : 'sample_nm',
				width : '100'
			}, {
				label : '검사기준',
				name : 'test_std_nm',
				width : '100'
			}, {
				label : '시료판정',
				name : 'test_sample_result_nm',
				width : '150'
			}, {
				label : '시료판정코드',
				name : 'test_sample_result_cd',
				hidden : true
			}, {
				label : '판정수정사유',
				name : 'test_sample_result_reason',
				width : '150'
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
				
				$('#sampleReportListForm').find('#test_sample_seq').val(row.test_sample_seq);
				$('#sampleReportListGrid').trigger('reloadGrid'); // 성적서리스트
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
			height : '350',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : true,
			multiselect : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true
			}, {
				index : 'not',
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				index : 'not',
				label : 'colla_flag',
				name : 'colla_flag',
				hidden : true
			}, {
				index : 'not',
				label : '시험항목',
				name : 'test_item_nm',
				width : '180'
			}, {
				index : 'not',
				label : '항목유형',
				name : 'test_item_type',
				width : '220',
				hidden : true
			}, {
				index : 'not',
				label : '기준값',
				name : 'std_val',
				width : '110'
			}, {
				index : 'not',
				label : '단위',
				name : 'unit',
				width : '80',
				edittype : "select",
				editoptions : {
					value : unit
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : '표기자리',
				name : 'valid_position',
				width : '60',
				align : 'right',
				hidden : true
			}, {
				index : 'not',
				label : '결과값',
				name : 'result_val',
				align : 'right',
				width : '100',
				hidden : true
			}, {
				index : 'not',
				label : '성적서표기값',
				name : 'report_disp_val',
				width : '80',
				align : 'right'
			}, {
				index : 'not',
				label : '결과판정',
				name : 'jdg_type',
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : jdg_type
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : 'inst_no',
				name : 'inst_no',
				hidden : true
			}, {
				index : 'not',
				label : '시험기기',
				name : 'inst_kor_nm'
			}, {
				index : 'not',
				label : 'test_method_no',
				name : 'test_method_no',
				hidden : true
			}, {
				index : 'not',
				label : '시험방법',
				name : 'test_method_nm'
			}, {
				type : 'not',
				label : '첨부문서',
				name : 'file_nm',
				formatter : displayAlink
			}, {
				index : 'not',
				label : '상태',
				name : 'state',
				width : '90'
			}, {
				type : 'not',
				label : 'RDMS',
				name : 'rawdata',
				sortable : false,
				width : '50',
				align : 'center',
				formatter : rawdataImageFormat
			}, {
				index : 'not',
				label : '기준',
				name : 'std_type',
				align : 'center',
				width : '100',
				edittype : "select",
				editoptions : {
					value : std_type
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : '결과유형',
				name : 'result_type',
				align : 'center',
				width : '120',
				edittype : "select",
				editoptions : {
					value : result_type
				},
				formatter : 'select'
			}, {
				index : 'not',
				label : '기준하한',
				name : 'std_lval',
				align : 'right',
				width : '60',
				hidden : true
			}, {
				index : 'not',
				label : '하한구분',
				name : 'lval_type',
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : lval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				index : 'not',
				label : '기준상한',
				name : 'std_hval',
				align : 'right',
				width : '60',
				hidden : true
			}, {
				index : 'not',
				label : '상한구분',
				name : 'hval_type',
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : hval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				index : 'not',
				label : '정량상한',
				name : 'loq_hval',
				align : 'right',
				width : '60',
				hidden : true
			}, {
				index : 'not',
				label : '기준적합값',
				name : 'std_fit_val',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				index : 'not',
				label : '기준부적합값',
				name : 'std_unfit_val',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
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
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				fn_change_color(grid, rowId);
			}
		});
		fn_Result_setGroupHeaders2(grid);
	}

	// 시료별 성적서 리스트
	var lastRowId;
	function sampleReportListGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '150',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '성적서 번호',
				name : 'att_seq',
				hidden : true
			}, {
				label : '시료 번호',
				name : 'test_sample_seq',
				align : 'center',
				hidden : true
			}, {
				label : '항목 번호',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : '항목 이름',
				name : 'test_item_nm',
				hidden : true
			}, {
				label : '성적서 종류',
				name : 'sample_flag',
				hidden : true,
				align : 'center'
			}, {
				label : '첨부 문서명',
// 				name : 'file_nm'
				width : '300',
				formatter : displayAlink
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
				//$('#updateSampleBtn').show();
				//$('#insertSampleBtn').hide();
				//$('#sampleReportForm').find('#att_seq').val($('#sampleReportGrid').getRowData(rowId).att_seq);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				//btn_Sample_Report_onclick();
			}
		});
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
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'dept_cd') {
				$(this).val('');
			}
		});
		$('#inputItemGrid').clearGridData();
		$('#resultGrid').clearGridData();
		fn_absence_change_color('reqListGrid');
	}

	// 승인
	function btn_Appr_onclick() {
		var data = "";
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}
		if (!confirm("승인하시겠습니까?")) {
			return false;
		} else {
			data += '&test_req_seq=' + rowId;
			data += '&menu_cd=' + $('#menu_cd').val();
			var json = fnAjaxAction('resultApproval/updateAppr.lims', data);
			if (json == null) {
				$.showAlert("승인 실패하였습니다.");
			} else {
				alert('선택된 의뢰의 승인이 완료되었습니다.');
				btn_Select_onclick();
			}
		}
	}


	function btn_Return_onclick() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}

		var obj = new Object();
		obj.msg1 = 'showReturnComment.lims';
		obj.test_req_seq = rowId;
		obj.type = '${type}';
		obj.state = 'B';
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

	function commonReqGrid_rowClick(rowId){
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
		<c:if test="${type != 'dept' }">
			<input type="hidden" id="test_dept_cd" name="test_dept_cd" value="${session.dept_cd }">
		</c:if>
		<%-- <input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}" />--%>
		<input type="hidden" id="user_id" name="user_id" value="${session.user_id}" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reqListGrid"></table>
		</div>
	</form>
</div>
<div id="sampleDiv" class="w60p" style="padding-bottom:20px;">
	<div class="sub_purple_01 w100p">
		<table width="100%" border="0" class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료 목록
				</td>
			</tr>
		</table>
		<div id="view_grid_sub1">
			<table id="inputItemGrid"></table>
		</div>
	</div>
</div>

<div class="w35p" style="float:right; display:inline-block;">
	<form id="sampleReportListForm" name="sampleReportListForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시료별 성적서 목록
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub2">
			<table id="sampleReportListGrid"></table>
		</div>
	</form>
</div>

<div id="itemDiv">
	<form id="resultForm" name="resultForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
						항목목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="btn_Num_Show" onclick="fn_visible_column('resultGrid',1);">
							<button type="button">수치형기준 보기</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Choice_Show" onclick="fn_visible_column('resultGrid',0);">
							<button type="button">선택형기준 보기</button>
						</span>
					</td>
				</tr>
			</table>
		</div>
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
	</form>
</div>