
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험결과검색
	 * 파일명 		: testResultBL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.25
	 * 설  명		: 시험결과검색 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.25    석은주		최초 프로그램 작성         
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
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("supv_dept_cd", "", "${session.dept_cd}", "", 'testReultBForm'); // 주관부서

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		//오늘날짜
		$('#testReultBForm').find('#endDate').val(caldate(0));

		//일주일 전 날짜
		$('#testReultBForm').find('#startDate').val(caldate(6));

		testReultBGrid('resultStatistical/selectTestReultBList.lims', 'testReultBForm', 'testReultBGrid');
		$('#testReultBGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('testReultBForm', 'testReultBGrid');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#testReultBGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	function testReultBGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '367',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '100'
			}, {
				label : '의뢰일자',
				name : 'req_date',
				width : '100',
				align : 'center'
			}, {
				label : '주관부서',
				name : 'dept_nm',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '접수번호',
				name : 'test_sample_seq',
				width : '100',
				align : 'center'
			}, {
				label : '단위업무코드',
				name : 'unit_work_cd',
				hidden : true
			}, {
				label : '채수장소',
				name : 'sampling_point_nm',
				width : '150'
			}, {
				label : '시험항목',
				name : 'test_item_nm',
				width : '150'
			}, {
				label : '측정항목',
				name : 'msrnm',
				width : '150'
			}, {
				label : '결과값',
				width : '100',
				name : 'result_val'
			}, {
				label : '단위',
				width : '80',
				name : 'unit'
			}, {
				label : '검사기준',
				name : 'std_val'
			}, {
				label : '시험원',
				width : '80',
				align : 'center',
				name : 'user_nm'
			}, {
				label : '판정',
				name : 'jdg_type',
				width : '80',
				align : 'center'
			/* formatter : function(value) {					
				if(value == '')
					return '';
				else if(value == '0')
					return '적합';
				else 
					return '부적합';
			} */
			/* }, {				
				label : '판정',
				width : '80',
				align : 'center',
				name : 'jdg_type'
			}, {				
				label : '시험자아이디',
				width : '80',
				name : 'tester_id',
				hidden : true
			}, {
				label : '단위업무',
				name : 'unit_work_nm',
				width : '200'
			}, {
				label : '시료유형코드',
				name : 'sample_cd',
				hidden : true
			}, {
				label : '시료유형',
				name : 'sample_nm',
				align : 'center',
				width : '100'
			}, {
				label : '채수장소코드',
				name : 'sampling_point_no',
				hidden : true		 */
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				jdgColorChange(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}
	//판정에 따른 결과값 색상 변경
	function jdgColorChange(grid) {
		var cssBlue = {
			'color' : '#0033FF',
			'font-weight' : 'bold'
		};
		var cssRed = {
			'color' : '#FF0033',
			'font-weight' : 'bold'
		};
		var ids = $('#' + grid).jqGrid('getDataIDs');
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.jdg_type == '적합' || row.jdg_type == '') {
				$('#' + grid).jqGrid('setCell', ids[i], 'result_val', '', cssBlue);
			} else
				$('#' + grid).jqGrid('setCell', ids[i], 'result_val', '', cssRed);
		}
	}
	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#testReultBGrid').trigger('reloadGrid');
	}
	function caldate(day) {
		var caledmonth, caledday, caledYear;
		var loadDt = new Date();
		var v = new Date(Date.parse(loadDt) - day * 1000 * 60 * 60 * 24);

		caledYear = v.getFullYear();

		if (v.getMonth() < 10) {
			caledmonth = '0' + (v.getMonth() + 1);
		} else {
			caledmonth = v.getMonth() + 1;
		}

		if (v.getDate() < 10) {
			caledday = '0' + v.getDate();
		} else {
			caledday = v.getDate();
		}
		return caledYear + '-' + caledmonth + '-' + caledday;
	}
	//시료유형 검색 팝업
	function btn_Pop_SampleChoice() {
		var obj = new Object();
		obj.msg1 = 'resultStatistical/popSampleChoice.lims';
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 375);
		if (popup != null && popup != '') {
			var arr = popup.split('◆★◆');
			$('#testReultBForm').find('#sample_nm').val(arr[0]);
			$('#testReultBForm').find('#sample_cd').val(arr[1]);
		}
	}
	//단위업무 검색 팝업
	function btn_Pop_UnitWorkChoice() {
		var obj = new Object();
		obj.msg1 = 'resultStatistical/popUnitWork.lims';
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 375);
		if (popup != null && popup != '') {
			var arr = popup.split('◆★◆');
			$('#testReultBForm').find('#unit_work_nm').val(arr[0]);
			$('#testReultBForm').find('#unit_work_cd').val(arr[1]);
		}
	}
	//시험항목 검색 팝업
	function btn_Pop_TestItemChoice() {
		var obj = new Object();
		obj.msg1 = 'resultStatistical/popTestItemSearch.lims';
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 375);
		if (popup != null && popup != '') {
			var arr = popup.split('◆★◆');
			$('#testReultBForm').find('#test_item_nm').val(arr[0]);
			$('#testReultBForm').find('#test_item_cd').val(arr[1]);
		}
	}
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('testReultBGrid');
		fn_Excel_Download(data);
	}
</script>
<div id="testReultDiv">
	<form id="testReultBForm" name="testReultBForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						시험결과검색
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>조회조건</th>
					<td>
						<select name="req_type" id="req_type" style="width: 133px;">
							<option value="">전체</option>
							<option value="1">정기</option>
							<option value="2">수시</option>
							<option value="3">민원</option>
						</select>
					</td>
					<th>접수일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
					<th>주관과</th>
					<td>
						<select name="supv_dept_cd" id="supv_dept_cd" class="w120px"></select>
					</td>
				</tr>
				<tr>
					<th>접수번호</th>
					<td>
						<input name="test_sample_seq" type="text" class="w120px" />
					</td>
					<th>시험항목</th>
					<td>
						<input name="test_item_cd" id="test_item_cd" type="hidden" />
						<input name="test_item_nm" id="test_item_nm" type="text" class="inputhan w200px" readonly="readonly" />
						<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="testItemAdd" style="cursor: pointer;" onClick='btn_Pop_TestItemChoice()' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="testItemDel" style="cursor: pointer;" onClick='fn_TextClear("test_item_cd"), fn_TextClear("test_item_nm")' />
					</td>
					<th>진행상태</th>
					<td>
						<select name="state" id="state" class="w120px">
							<option value="">전체</option>
							<option value="'400','650'">시험중</option>
							<option value="'700'">시험완료</option>
							<!-- <option value="'800'">성적승인</option>
						<option value="'900'">성적서발행</option> -->
						</select>
					</td>
				</tr>
				<tr>
					<th>시료유형</th>
					<td>
						<input name="sample_cd" id="sample_cd" type="hidden" />
						<input name="sample_nm" id="sample_nm" type="text" class="inputhan w120px" readonly="readonly" />
						<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="sampleAdd" style="cursor: pointer;" onClick='btn_Pop_SampleChoice()' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="sampleDel" style="cursor: pointer;" onClick='fn_TextClear("sample_cd"), fn_TextClear("sample_nm")' />
					</td>
					<th>단위업무</th>
					<td>
						<input name="unit_work_cd" id="unit_work_cd" type="hidden" />
						<input name="unit_work_nm" id="unit_work_nm" type="text" class="inputhan w200px" readonly="readonly" />
						<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="unitWorkAdd" style="cursor: pointer;" onClick='btn_Pop_UnitWorkChoice()' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="unitWorkDel" style="cursor: pointer;" onClick='fn_TextClear("unit_work_cd"), fn_TextClear("unit_work_nm")' />
					</td>
					<th>적부여부</th>
					<td>
						<select name="jdg_type" id="jdg_type" class="w120px">
							<option value="">전체</option>
							<option value="0">적합</option>
							<option value="1">부적합</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName" />
		<input type="hidden" id="sortType" name="sortType" />
		<div id="view_grid_main">
			<table id="testReultBGrid"></table>
		</div>
	</form>
</div>



