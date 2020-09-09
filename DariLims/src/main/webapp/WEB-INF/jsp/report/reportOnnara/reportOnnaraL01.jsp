
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 업무관리시스템 (온나라)연계
	 * 파일명 		: reportOnnaraL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.03.10
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.10    진영민		최초 프로그램 작성         
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
	var req_type;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		req_type = fnGridCommonCombo('C23', null);

		/* ajaxComboForm("test_goal", "C05", "ALL", null, "reportOnnaraForm"); */
		ajaxComboForm("report_type", "C15", "ALL", null, "reportOnnaraForm");
		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reportOnnaraForm");
		ajaxComboForm("dept_cd", "", "ALL", null, 'reportOnnaraForm');
		$('#reportOnnaraForm').find("#dept_cd").change(function() {
			ajaxComboForm("unit_work_cd", $('#reportReqForm').find("#dept_cd").val(), "ALL", null, 'reportOnnaraForm');
		});
		$('#reportOnnaraForm').find('#endDate').val(fnGetToday(0,0));
		$('#reportOnnaraForm').find('#startDate').val(fnGetToday(1,0));

		reportOnnaraGrid('report/selectReportOnnaraList.lims', 'reportOnnaraForm', 'reportOnnaraGrid');
		$('#reportOnnaraGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		reportOnnaraSampleGrid('report/selectReportWriteSampleList.lims', 'reportOnnaraSampleForm', 'reportOnnaraSampleGrid');

		fn_Enter_Search('reportOnnaraForm', 'reportOnnaraGrid');

		$(window).bind('resize', function() {
			$("#reportOnnaraGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#reportOnnaraSampleGrid").setGridWidth($('#view_grid_sub_1').width(), false);
		}).trigger('resize');
	});

	function reportOnnaraGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'report_doc_seq',
				name : 'report_doc_seq',
				hidden : true,
				key : true
			}, {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80',
				edittype : "select",
				editoptions : {
					value : req_type
				},
				formatter : 'select'
			}, {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '80'
			}, {
				label : '의뢰일자',
				name : 'req_date',
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
				label : '단위업무',
				name : 'unit_work_cd'
			}, {
				label : '검사목적',
				name : 'test_goal'
			}, 
// 			{
// 				label : '성적서종류',
// 				name : 'report_type',
// 				align : 'center'
// 			},
			{
				label : 'report_file_nm',
				name : 'report_file_nm',
				hidden : true
			}, {
				label : '제목',
				name : 'title',
				width : '300'
			}, {
				label : '수신처',
				name : 'destination_nm'
			}, {
				label : '우편번호',
				name : 'zip_code',
				width : '60',
				align : 'center'
			}, {
				label : '주소',
				name : 'addr1'
			}, {
				label : '상세 주소',
				name : 'addr2'
			}, {
				label : '성적서작성자',
				name : 'user_nm',
				width : '80',
				align : 'center'
			}, {
				label : '상태',
				name : 'onnara_appv_state',
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Z:기안요청대기;S:기안요청;T:전송완료;U:승인중;V:승인완료;W:반려'
				},
				formatter : 'select'
			}, {
				label : '파일생성',
				name : 'onnara_file_flag',
				width : '60',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Y:완료;N:생성중'
				},
				formatter : 'select'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#reportOnnaraSampleForm").find('#report_doc_seq').val(rowId);
				$('#reportOnnaraSampleGrid').trigger('reloadGrid');
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'req_type',
				numberOfColumns : 5,
				titleText : '의뢰정보'
			}, {
				startColumnName : 'dept_nm',
				numberOfColumns : 3,
				titleText : '검사정보'
			}, {
				startColumnName : 'report_type',
				numberOfColumns : 10,
				titleText : '성적서정보'
			} ]
		});
	}

	function reportOnnaraSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#report_doc_seq').val() != '') {
					fnGridData(url, form, grid);
				} else {
					$('#' + grid).clearGridData();
				}
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시료번호',
				name : 'test_sample_seq',
				width : '100',
				align : 'center'
			}, {
				label : '시료명',
				name : 'sample_reg_nm'
			}, {
				label : '시료유형',
				name : 'sample_nm'
			}, {
				label : '접수일자',
				name : 'req_date',
				width : '100',
				align : 'center'
			}, {
				label : '채수일자',
				name : 'sampling_date',
				width : '100',
				align : 'center'
			}, {
				label : '시',
				name : 'sampling_hour',
				width : '30',
				align : 'center'
			}, {
				label : '분',
				name : 'sampling_min',
				width : '30',
				align : 'center'
			}, {
				label : '처리기한',
				name : 'deadline_date',
				width : '100',
				align : 'center'
			}, {
				label : '채수자',
				name : 'sampling_id',
				width : '60',
				align : 'center'
			}, {
				label : '채수장소',
				name : 'sampling_point_nm'
			}, {
				label : '채수방법',
				name : 'sampling_method'
			}, {
				label : '시험기준',
				name : 'test_std_nm',
				width : '200'
			}, {
				label : '비고',
				name : 'etc_desc'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}

	function btn_Select_onclick() {
		$('#reportOnnaraGrid').trigger('reloadGrid');
	}

	function btn_View_onclick() {
		var rowId = $('#reportOnnaraGrid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#reportOnnaraGrid').getRowData(rowId);
			fn_RDView(row.report_file_nm, rowId, false, false, 800, 900);
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="reportOnnaraForm" name="reportOnnaraForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					업무관리시스템 연계 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_select" id="btn_View" onclick="btn_View_onclick();">
						<button type="button">미리보기</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
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
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='btn_Pop_ReqOrgChoice("reportOnnaraForm")'/>
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
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
				</td>
				<th>단위업무</th>
				<td>
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>
				<th>업무관리시스템연계상태</th>
				<td>
					<select name="onnara_appv_state" id="onnara_appv_state" class="w200px">
						<option value="" selected="selected">전체</option>
						<option value="Z">기안요청대기</option>
						<option value="S">기안요청</option>
						<option value="T">전송완료</option>
						<option value="U">승인중</option>
						<option value="V">승인완료</option>
						<option value="W">반려</option>
					</select>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reportOnnaraGrid"></table>
		</div>
	</form>
</div>
<div class="sub_purple_01 w100p">
	<form id="reportOnnaraSampleForm" name="reportOnnaraSampleForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;"></td>
			</tr>
		</table>
		<input type="hidden" id="report_doc_seq" name="report_doc_seq" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_1">
			<table id="reportOnnaraSampleGrid"></table>
		</div>
	</form>
</div>

<div id="dialog" class="sub_blue_01 w100p" style="display: none; margin-top: 0px;">
	<form id="onnaraWriteform" name="onnaraWriteform" onsubmit="return false;">
		<table  class="list_table"  style="border-top: solid 1px #82bbce;">
			<tr>
				<th>제목</th>
				<td>
					<input name="onnara_title" id="onnara_title" type="hidden" class="inputhan w300p" />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="3" name="onnara_con" id="onnara_con">
					</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>