
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 요청에 의한 시험 중지/시작
	 * 파일명 		: reqStartStopL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.19
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.19    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
#stopEtcDiv {
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
input[type=text] {
	ime-mode: auto;
}
</style>
<script type="text/javascript">
	var result_type;
	var unit;
	var jdg_type;
	var hval_type;
	var lval_type;
	var std_type;
	var fit_val;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		$('#stopEtcDiv').hide();
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "${session.dept_cd }", "ALLNAME", 'reqListForm');
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');

		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		$('#reqListForm').find('#endDate').val(fnGetToday(0,0));
		$('#reqListForm').find('#startDate').val(fnGetToday(1,0));

		reqGrid('analysis/selectModifyReqList.lims', 'reqListForm', 'reqListGrid', true);
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		result_type = fnGridCommonCombo('C31', 'NON');
		unit = fnGridCommonCombo('C08', null);
		jdg_type = fnGridCommonCombo('C37', null);
		hval_type = fnGridCommonCombo('C36', null);
		lval_type = fnGridCommonCombo('C35', null);
		std_type = fnGridCommonCombo('C38', 'NON');
		fit_val = fnGridCommonCombo('C34', null);

		testSampleGrid('analysis/selectSampleList.lims', 'resultForm', 'inputItemGrid');
		
		resultGrid('analysis/selectModifyResultList.lims', 'resultForm', 'resultGrid');


		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#inputItemGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		fn_stop_flag($(":input:radio[name=stop_flag]:checked").val());

	});
	
	// 중지/시작 선택
	function fn_stop_flag(stop_flag) {
		if(stop_flag == 'Y'){
			$('#reqListForm').find('#stopBtn').hide();
			$('#reqListForm').find('#startBtn').show();
		} else {
			$('#reqListForm').find('#startBtn').hide();
			$('#reqListForm').find('#stopBtn').show();
		}
	}

	// 접수 리스트(공통에서 가져옴)
	function reqGrid(url, form, grid, multi) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '200',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			multiselect : multi,
			colModel : [ {
				label : '시험진행상태',
				name : 'stop_flag',
				width : '80',
				hidden : false,
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '시험중지';
					} else {
						return '시험진행중';
					}
				}
			}, {
				label : '시험중지사유',
				name : 'stop_reason',
				width : '120'
			}, {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : '접수SEQ',
				name : 'test_req_seq',
				hidden : true,
				key : true
			}, {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '80'
			}, {
				label : '제목',
				name : 'title',
				width : '300'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '100',
				align : 'center'
			}, {
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '100',
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
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#resultForm').find('#test_req_seq').val(rowId);
				$('#inputItemGrid').trigger('reloadGrid');
				$('#resultGrid').clearGridData();
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
				if ($('#' + form).find('#test_req_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '372',
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
				label : '시료명',
				name : 'sample_reg_nm',
				width : '200'
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
				width : '150'
			}, {
				label : '비고',
				name : 'etc_desc',
				width : '300'
			}, {
				label : '특이사항',
				name : 'req_message',
				width : '300'
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
	function resultGrid(url, form, grid) {
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
				}
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : 'colla_flag',
				name : 'colla_flag',
				hidden : true
			}, {
				type : 'not',
				label : '시험항목',
				name : 'test_item_nm',
				sortable : false,
				width : '160'
			}, {
				type : 'not',
				label : '항목유형',
				name : 'test_item_type',
				sortable : false,
				width : '220',
				hidden : true
			}, {
				label : '기준',
				name : 'std_type',
				sortable : false,
				align : 'center',
				width : '75',
				editable : true,
				edittype : "select",
				editoptions : {
					value : std_type
				},
				formatter : 'select'
			}, {
				label : '결과유형',
				name : 'result_type',
				sortable : false,
				align : 'center',
				width : '120',
				editable : true,
				edittype : "select",
				editoptions : {
					value : result_type
				},
				formatter : 'select'
			}, {
				label : '기준값',
				name : 'std_val',
				sortable : false,
				width : '110'
			}, {

				label : '단위',
				name : 'unit',
				sortable : false,
				width : '100',
				edittype : "select",
				editoptions : {
					value : unit
				},
				formatter : 'select'
			}, {
				label : '표기자리',
				name : 'valid_position',
				sortable : false,
				width : '60',
				align : 'right'
			}, {
				label : 'result_cd',
				name : 'result_cd',
				hidden : true
			}, {
				label : '결과값',
				name : 'result_val',
				sortable : false,
				align : 'right',
				width : '80'
			}, {
				label : '성적서표기값',
				name : 'report_disp_val',
				width : '80',
				sortable : false,
				align : 'right',
				editable : true
			}, {
				label : '결과판정',
				name : 'jdg_type',
				width : '110',
				sortable : false,
				align : 'center',
				edittype : "select",
				editoptions : {
					value : jdg_type
				},
				formatter : 'select'
			}, {
				label : '기준하한',
				name : 'std_lval',
				sortable : false,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '하한구분',
				name : 'lval_type',
				sortable : false,
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : lval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '기준상한',
				name : 'std_hval',
				sortable : false,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '상한구분',
				name : 'hval_type',
				sortable : false,
				width : '80',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : hval_type
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '정량상한',
				name : 'loq_hval',
				sortable : false,
				align : 'right',
				width : '60',
				hidden : true
			}, {
				label : '기준적합값',
				name : 'std_fit_val',
				sortable : false,
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				label : '기준부적합값',
				name : 'std_unfit_val',
				sortable : false,
				align : 'center',
				edittype : "select",
				editoptions : {
					value : fit_val
				},
				formatter : 'select',
				hidden : true
			}, {
				label : 'test_method_no',
				name : 'test_method_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험방법',
				name : 'test_method_nm',
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : 'inst_no',
				name : 'inst_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험기기',
				name : 'inst_kor_nm',
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_kor_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				type : 'not',
				label : 'RDMS',
				name : 'rawdata',
				sortable : false,
				width : '50',
				align : 'center',
				formatter : rawdataImageFormat
			}, {
				type : 'not',
				label : '상태',
				name : 'state',
				sortable : false,
				align : 'center',
				width : '80'
			}, {
				label : 'return_flag',
				name : 'return_flag',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				fn_Result_onCellSelect(grid, rowId, iCol);
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fn_Result_onSelectRow(grid, lastRowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				//fn_Result_ondblClickRow(grid, rowId, iCol);
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				fn_Result_afterInsertRow(grid, rowId);
			}
		});
		fn_Result_setGroupHeaders(grid);
		$('#' + grid).bind("jqGridInlineAfterRestoreRow", function(e, rowId, orgClickEvent) {
			var row = $('#' + grid).getRowData(rowId);
			$('#' + grid).jqGrid('setCell', rowId, 'result_cd', row.result_val);
			return e.result === undefined ? true : e.result;
		});
	}

	// 조회 이벤트
	function btn_Select_onclick() {
		$('#reqListGrid').trigger('reloadGrid');
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'state') {
				$(this).val('');
			}
		});
		$('#resultForm').find('#test_sample_seq').val('');
		$('#resultGrid').clearGridData();
	}

	function btn_Save_onclick() {
		var grid = 'resultGrid';
		fnEditRelease(grid);

		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				fn_editable(grid, ids[i]);
				if (row.result_type != 'C31004') {
					if ($.trim(row.result_cd) == '') {
						alert(row.test_item_nm + '\n항목의 결과값을 입력해주세요.');
						fnGridEdit(grid, ids[i], fn_Result_Row_Click);
						$("#" + ids[i] + "_result_val").focus();
						return false;
					}
				}			
				c++;
			}
		}
		if (c == 0) {
			alert('선택된 항목이 없습니다.');
		} else {
			var data = fnGetGridCheckData(grid) + "&pageType=item" + '&test_req_seq=' + $('#reqListGrid').getGridParam('selrow');
			var json = fnAjaxAction('analysis/updateItemResult.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 항목의 저장이 완료되었습니다.');
			}
		}
	}

	function fn_selectOriginalSTD(grid, rowId) {
		var url = 'analysis/selectOriginalSTD.lims';
		var data = 'test_std_no=' + $('#resultForm').find('#test_std_no').val();
		var row = $('#' + grid).getRowData(rowId);
		data += '&test_item_cd=' + row.test_item_cd;
		$.ajax({
			url : url,
			type : 'post',
			dataType : 'json',
			async : false,
			data : data,
			success : function(json) {
				$(json).each(function(index, entry) {
					$("#" + rowId + "_std_lval").val(entry["std_lval"]);
					$("#" + rowId + "_std_hval").val(entry["std_hval"]);
					$("#" + rowId + "_result_type").val(entry["result_type"]);
					$("#" + rowId + "_valid_position").val(entry["valid_position"]);
					$("#" + rowId + "_unit").val(entry["unit"]);
					$("#" + rowId + "_std_fit_val").val(entry["std_fit_val"]);
					$("#" + rowId + "_std_unfit_val").val(entry["std_unfit_val"]);
					$("#" + rowId + "_hval_type").val(entry["hval_type"]);
					$("#" + rowId + "_lval_type").val(entry["lval_type"]);
					$("#" + rowId + "_loq_hval").val(entry["loq_hval"]);
					//$("#" + rowId + "_std_val").val(entry["std_val"]);
					$('#' + grid).jqGrid('setCell', rowId, 'std_val', entry["std_val"]);
				});
			},
			error : function() {
				alert('fn_selectOriginalSTD error');
			}
		});
	}
	
	// 중지 & 시작
	function btn_StopStart_onclick(state) {
		//$('#stopEtcDiv').find('#stop_reason').val('');
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('접수목록을 선택해주세요.');
		} else {
			var row = $('#reqListGrid').getRowData(rowId);				
			//'sample_cd=' + $('#mainGrid').getGridParam('selrow');			
			if(state == 'stop'){
				$('#stopEtcDiv').css("top", ($(window).height() / 2.5) - ($('#stopEtcDiv').outerHeight() / 2));
				$('#stopEtcDiv').css("left", ($(window).width() / 2) - ($('#stopEtcDiv').outerWidth() / 2));
				$('#stopEtcDiv').show();				
				fnBasicStartLoading();
			} else{
				var param = 'state=' + row.state + '&backup_state=' + row.backup_state + '&test_req_seq=' + row.test_req_seq;
				if(state == 'ETC'){
					var stop_reason = $('#stopEtcDiv').find('#stop_reason').val();
					param += '&stop_reason=' + stop_reason;
				}
				
				var json = fnAjaxAction('analysis/updateStopStart.lims?stop_flag='+state, param);				
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					$('#stopEtcDiv').find('#stop_reason').val('');
					btn_Close_onclick();
					btn_Select_onclick();
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
	}
	
	// 중지 사유 추가 div 닫기버튼 이벤트
	function btn_Close_onclick() {
		$('#stopEtcDiv').hide();
		fnBasicEndLoading();
	}
</script>
<div>
	<form id="reqListForm" name="reqListForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						접수목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlarger auth_save" id="stopBtn" onclick="btn_StopStart_onclick('stop');">
							<button type="button">시험중지</button>
						</span>
						<span class="button white mlargeb auth_save" id="startBtn" onclick="btn_StopStart_onclick('start');">
							<button type="button">시험재시작</button>
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
					<th>접수일자</th>
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
					<td>
						<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
					</td>
					<th>시험진행상태</th>
					<td>					
						<input name="stop_flag" id="stop_flag_y" type="radio" value="Y" onClick="fn_stop_flag($(this).val())"<c:if test="${detail.stop_flag != 'N'}">checked="checked"</c:if>/>
						<label for="stop_flag_y">시험중지</label>
						<input name="stop_flag" id="stop_flag_n" type="radio" value="N" onClick="fn_stop_flag($(this).val())"<c:if test="${detail.stop_flag == 'N'}">checked="checked"</c:if>/>
						<label for="stop_flag_n">시험진행중</label>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reqListGrid"></table>
		</div>
		
		<div id='stopEtcDiv'>
			<div class="sub_purple_01" style="width: 90%">
				<table  class="select_table" >
					<tr>
						<td width="40%" class="table_title">
							<span>■</span>
							시험중지
						</td>
						<td class="table_button" style="text-align: right;">
							<span class="button white mlarger auth_save" id="btn_Test_Std_Insert" onclick="btn_StopStart_onclick('ETC');">
								<button type="button">시험중지</button>
							</span>
							<span class="button white mlargep auth_select" id="btn_Test_Std_Insert" onclick="btn_Close_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table" >				
					<tr>
						<th>중지사유</th>
						<td width="30%">
							<input type="text" name="stop_reason" id="stop_reason" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</div>
<div id="itemDiv">
	<form id="resultForm" name="resultForm" onsubmit="return false;">
		<div class="sub_blue_01" style="width: 15%; float: left;">
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
		<div class="sub_blue_01" style="margin-left: 3%; width: 82%; float: left;">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시험결과
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="btn_Num_Show" onclick="fn_visible_column('resultGrid',1);">
							<button type="button">수치형기준 보기</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Choice_Show" onclick="fn_visible_column('resultGrid',0);">
							<button type="button">선택형기준 보기</button>
						</span>
						<!-- 
						<span class="button white mlargeg" id="btn_Save" onclick="btn_Save_onclick();">
							<button type="button">저장</button>
						</span>
						 -->
					</td>
				</tr>
			</table>
			<div id="view_grid_sub2">
				<table id="resultGrid"></table>
			</div>
		</div>
		<input type="hidden" id="test_req_seq" name="test_req_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" name="test_std_no" id="test_std_no"/>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
	</form>
</div>