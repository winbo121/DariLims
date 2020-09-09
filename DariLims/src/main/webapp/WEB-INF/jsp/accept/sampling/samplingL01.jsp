
<%
	/***************************************************************************************
	 * 업무명 		: 시료채취 목록
	 * 파일명 		: samplingL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2019.11.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.26   허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
$(function() {
	/* 세부권한검사 */
	fn_auth_check();

	fnDatePickerImg('startDate');
	fnDatePickerImg('endDate');
	
	ajaxComboForm("req_type", "C23", "ALL", "EX1", "mainForm");	
	ajaxComboForm("unit_work_cd", "", "ALL", null, 'mainForm');
	ajaxComboForm("dept_cd", "", "ALL", "ALLNAME", 'mainForm');
	
	mainGrid('accept/selectSamplingList.lims', 'mainForm', 'mainGrid');
	$('#mainGrid').clearGridData(); // 최초 조회시 데이터 안나옴
	
	$(window).bind('resize', function() {
		$("#mainGrid").setGridWidth($('#mainForm').width(), false);
	}).trigger('resize');
	
	// 엔터키 눌렀을 경우 조회 이벤트
	fn_Enter_Search('mainForm', 'mainGrid');
});

//접수 리스트
function mainGrid(url, form, grid) {
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridData(url, form, grid);
		},
		height : '200',
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
			}
		}, {
			label : 'process',
			name : 'process',
			hidden : true
		}, {
			label : '채취여부',
			name : 'sampling_yn',
			width : '80',
			align : 'center',
			formatter : function(value) {
				if (value == "Y") {
					return '채취함';
				} else if (value == "N") {
					return '채취안함';
				}
			}
		}, {
			label : '진행상태',
			name : 'state',
			width : '80',
			align : 'center'
		}, {
			label : '의뢰구분',
			name : 'req_type',
			align : 'center',
			width : '80'
		}, {
			label : '관능검사',
			name : 'sensory_test',
			align : 'center',
			width : '80'
		}, {
			label : '의뢰일련번호(HIDDEN)',
			name : 'test_req_seq',
			align : 'center',
			width : '150',
			hidden : true,
			key : true
		}, {
			label : '의뢰번호',
			name : 'test_req_no',
			align : 'center',
			width : '80',
		}, {
			label : '제목',
			name : 'title',
			width : '300',
			align : 'center'
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
			name : 'req_org_nm',
			align : 'center'
		}, {
			label : '의뢰자',
				name : 'req_nm',
			width : '60',
			align : 'center'
		}, {
			label : '접수부서',
			name : 'dept_nm',
			width : '100',
			align : 'center'
		}, {
			label : '단위업무',
			name : 'unit_work_cd',
			align : 'center'
		}, {
			label : '검사목적',
			name : 'test_goal',
			align : 'center'
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
			label : 'creater_id',
			name : 'creater_id',
			hidden : true
		}, {
			label : 'dept_cd',
			name : 'dept_cd',
			hidden : true
		}, {
			label : 'rec_req_no',
			name : 'rec_req_no',
			hidden : true
		}, {
			label : 'commission_type',
			name : 'commission_type',
			hidden : true
		}, {
			label : 'commission_amt_flag',
			name : 'commission_amt_flag',
			hidden : true
		}, {
			label : 'pick_no',
			name : 'pick_no',
			hidden : true
		}, {
			label : 'process',
			name : 'process',
			hidden : true
		}],
		gridComplete : function() {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
		},
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			
			var param = 'test_req_seq=' + rowId;
			param += '&pick_no=' + row.pick_no;
			param += '&state=' + row.process;
			fnViewPage('accept/selectSamplingDetail.lims', 'detail', param);
		}
	});
	$('#' + grid).jqGrid('setGroupHeaders', {
		useColSpanStyle : true,
		groupHeaders : [ {
			startColumnName : 'req_type',
			numberOfColumns : 9,
			titleText : '의뢰정보'
		}, {
			startColumnName : 'dept_nm',
			numberOfColumns : 3,
			titleText : '검사정보'
		} ]
	});
}

function btnSearch_onclick() {
	$('#mainGrid').trigger('reloadGrid');
	$('#detail').empty();
}

// 의뢰처 팝업
function fnpop_reqOrgChoice(name, width, hight, text){		
	fnpop_reqOrgChoicePop(name, width, hight, text);
	fnBasicStartLoading();
}

// 자식 -> 부모창 함수 호출
function fnpop_callback(returnParam){
	$('#resultGrid').trigger('reloadGrid');
	fnBasicEndLoading();
}

</script>
<form id="mainForm" name="mainForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					접수완료 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btnSearch" onclick="btnSearch_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>의뢰번호</th>
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
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "시료조회의뢰")'/>
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
				<td colspan="3">
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="mainGrid"></table>
	</div>
</form>
<form id="detail" name="detail" enctype="multipart/form-data" onsubmit="return false;"></form>