
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험진행조회
	 * 파일명 		: testSampleStateL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.25
	 * 설  명		: 시험진행조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
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
		
		if ('${rsVO.pageType}' == 'main') {
			// 의뢰부서
			ajaxComboForm("dept_cd", "", "${rsVO.dept_cd}", "", 'testSampleStateForm');
			//부장승인완료이외, 시험완료여부 -- 시험중
			$('#testSampleStateForm').find('#dept_appr_flag').val('N');
			//삼일 후 날짜
			$('#testSampleStateForm').find('#endDate').val(caldate(-3));
		} else {
			ajaxComboForm("dept_cd", "", "ALL", "", 'testSampleStateForm'); // 의뢰부서
			//일주일 전 날짜
			$('#testSampleStateForm').find('#startDate').val(caldate(7));
			//오늘날짜
			$('#testSampleStateForm').find('#endDate').val(caldate(0));
		}
		ajaxComboForm("supv_dept_cd", "", "ALL", "", 'testSampleStateForm'); // 주관부서
		ajaxComboForm("req_type", "C23", "ALL", "EX1", 'testSampleStateForm'); // 의뢰구분
		ajaxComboForm("test_goal", "C05", "ALL", "", 'testSampleStateForm'); // 검사목적
		ajaxComboForm("test_sample_result", "C37", "ALL", null, 'testSampleStateForm'); //선택값판정
		ajaxComboForm("state", "", "ALL", "", 'testSampleStateForm'); // 진행상태
		ajaxUnitWorkComboForm("unit_work_cd", "ALL", 'testSampleStateForm'); //단위업무 
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "testSampleStateForm");

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		fnDatePickerImg('reqStartDate');
		fnDatePickerImg('reqEndDate');

		testSampleStateGrid('resultStatistical/selectTestSampleStateList.lims', 'testSampleStateForm', 'testSampleStateGrid');
		$('#testSampleStateGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('testSampleStateForm', 'testSampleStateGrid');
		
		// 그리드 사이즈 
		$(window).bind('resize', function() {
			$("#testSampleStateGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	function testSampleStateGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '362',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '80'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '80',
				align : 'center'
			}, {
				label : '의뢰제목',
				name : 'title',
				width : '150',
			}, {
				label : '접수부서',
				name : 'dept_nm',
				align : 'center',
				width : '100'
/* 			}, {
				label : '주관부서',
				name : 'supv_dept_cd',
				width : '100',
				align : 'center' */
			}, {
				label : '단위업무코드',
				name : 'unit_work_cd',
				hidden : true
			}, {
				label : '단위업무',
				name : 'unit_work_nm',
				width : '100'
			}, {
				label : '의뢰업체명',
				width : '100',
				name : 'org_nm'
			}, {
				label : '의뢰자',
				width : '80',
				align : 'center',
				name : 'req_nm'
			}, {
				label : '결과승인완료일자',
				width : '80',
				name : 'last_approval_date'
			}, {
				label : '성적서발행여부',
				width : '100',
				name : 'report_flag'
			}, {
				label : '성적서발행일',
				width : '100',
				name : 'last_report_date'
			}, {
				label : '최종 수수료(VAT 포함)',
				width : '150',
				name : 'commission_amt_det',
				align : 'right',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '시료접수번호',
				name : 'test_sample_seq',
				width : '80',
				align : 'center'
			}, {
				label : '접수일자',
				name : 'req_date',
				align : 'center',
				width : '80',
				hidden : true
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				width : '100'
			}, {
				label : '시료등록명',
				name : 'sample_reg_nm',
				width : '100'
			}, {
				label : '진행상태',
				width : '100',
				name : 'state'
			}, {
				label : '시험완료여부',
				width : '80',
				align : 'center',
				name : 'dept_appr_flag'
			}, {
				label : '시료판정',
				width : '80',
				align : 'center',
				name : 'test_sample_result_nm'
			}, {
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '80',
				align : 'center'
			/* }, {
				label : '채수일자',
				name : 'sampling_date',
				align : 'center',
				width : '80'
			}, {
				label : '시',
				width : '30',
				align : 'center',
				name : 'sampling_hour'
			}, {
				label : '분',
				name : 'sampling_min',
				width : '30',
				align : 'center'
			}, {
				label : '채수장소코드',
				name : 'sampling_point_no',
				hidden : true
			}, {
				label : '채수장소',
				name : 'sampling_point_nm',
				width : '100'
			}, {
				label : '채수방법',
				name : 'sampling_method',
				hidden : true
			}, {
				label : '채수방법',
				name : 'sampling_method_nm',
				width : '100'
			}, {
				label : '채수자',
				name : 'sampling_id',
				align : 'center',
				width : '80' */
			}, {
				label : '시료판정코드',
				width : '80',
				name : 'test_sample_result',
				hidden : true
			}, {
				label : '기준정보번호',
				align : 'center',
				name : 'test_std_no',
				hidden : true
			}, {
				label : '기준정보',
				width : '100',
				name : 'test_std_nm'
			}, {
				label : '기타사항',
				width : '100',
				name : 'etc_desc'
			}, {
				label : '지연사유',
				width: '150',
				name: 'exceed_reason'
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

		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'req_type',
				numberOfColumns : 14,
				titleText : '의뢰정보'
			}, {
				startColumnName : 'test_sample_seq',
				numberOfColumns : 22,
				titleText : '시료정보'
			} ]
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
			if (row.test_sample_result == 'C37001' || row.test_sample_result == 'C37003') {
				$('#' + grid).jqGrid('setCell', ids[i], 'test_sample_result_nm', '', cssBlue);
			} else
				$('#' + grid).jqGrid('setCell', ids[i], 'test_sample_result_nm', '', cssRed);
		}
	}
	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#testSampleStateGrid').trigger('reloadGrid');
	}
	function caldate(day) {
		var caledmonth, caledday, caledYear;
		var loadDt = new Date();
		var v = new Date(Date.parse(loadDt) - day * 1000 * 60 * 60 * 24);

		caledYear = v.getFullYear();

		if (v.getMonth() + 1 < 10) {
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
	//의뢰정보 상세보기 팝업
	function btn_pop_req_info() {
		var rowId = $('#testSampleStateGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('시료를 선택해주세요.');
		} else {
			var row = $('#testSampleStateGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_reqInfoPop("testSampleStateGrid", "900" , "660" , rowId, row.test_req_seq, true);
		}
	}
	//진행상황 상세보기 팝업
	function btn_pop_state_info() {
		var rowId = $('#testSampleStateGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('시료를 선택해주세요.');
		} else {
			var row = $('#testSampleStateGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_stateInfoPop("testSampleStateGrid", "1000", "560", rowId, row.test_req_seq, row.test_req_no, row.test_sample_seq);
		}
	}
	//시료유형 검색 팝업
	function btn_Pop_SampleChoice() {
		fnpop_sampleChoicePop("720", "500", 'testSampleStateForm', true, 'sampleStatistics');
		fnBasicStartLoading();
	}
	
	function fnpop_callback(){
		
	}
	
	//단위업무 코드
	function ajaxUnitWorkComboForm(obj, type, form) {
		var url = fn_getConTextPath() + '/resultStatistical/selectCommonCodeUnitWork.lims';
		$.ajax({
			url : url,
			type : 'POST',
			async : false,
			dataType : 'json',
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				var select = $("#" + form).find("#" + obj);
				select.empty();
				if (type == "ALL") {
					select.append("<option value=''>전체</option>");
				}
				$(json).each(function(index, entry) {
					select.append("<option value='" + entry["code"] + "'>" + entry["code_Name"] + "</option>");
				});
				select.trigger('change');// 강제로 이벤트 시키기
			}
		});
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('testSampleStateGrid');
		fn_Excel_Download(data);
	}
	
</script>
<div id="testSampleStateDiv">
	<form id="testSampleStateForm" name="testSampleStateForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						시험진행조회
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargep auth_select" id="reqViewBtn" onclick="btn_pop_req_info();">
							<button type="button">의뢰정보</button>
						</span>
						<span class="button white mlargep auth_select" id="stateViewBtn" onclick="btn_pop_state_info();">
							<button type="button">진행상황</button>
						</span>
						<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>의뢰구분</th>
					<td>
						<select name="req_type" id="req_type" class="w120px"></select>
					</td>
					<th>제목</th>
					<td colspan="3">
						<input name="title" id="title" type="text" class="inputhan w300px" />
					</td>
				</tr>
				<tr>
					<th>외뢰/접수번호</th>
					<td>
						<input name="test_sample_seq" id="test_sample_seq" type="text" class="inputhan" style="width: 108px;" />
					</td>
					<th>의뢰업체/의뢰자</th>
					<td>
						<input name="org_nm" id="org_nm" type="text" class="inputhan w200px" />
					</td>
					<th>시험완료여부</th>
					<td>
						<select name="dept_appr_flag" id="dept_appr_flag" class="w100px">
							<option value="">전체</option>
							<option value='Y'>시험완료</option>
							<option value='N'>시험중</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>검사목적</th>
					<td>
						<select name="test_goal" id="test_goal" class="w200px"></select>
					</td>
					<th>접수일자</th>
					<td>
						<input name="reqStartDate" id="reqStartDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="reqStartDateStop" style="cursor: pointer;" onClick='fn_TextClear("reqStartDate")' /> ~
						<input name="reqEndDate" id="reqEndDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="reqEndDateStop" style="cursor: pointer;" onClick='fn_TextClear("reqEndDate")' />
					</td>
					<th>진행상태</th>
					<td>
						<select name="state" id="state" class="w100px"></select>
					</td>
				</tr>
				<tr>
					<th>품목구분</th>
					<td>
						<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
					</td>
					<th>처리기한</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
					<th>시료판정</th>
					<td>
						<select name="test_sample_result" id="test_sample_result" class="w100px"></select>
					</td>
				</tr>
				<tr>
					<th>접수부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w120px"></select>
					</td>
					<!-- 
					<th>주관부서</th>
					<td>
						<select name="supv_dept_cd" id="supv_dept_cd" class="w120px"></select>
					</td>
					-->
					<th>단위업무</th>
					<td>
						<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
					</td>
					<th>성적서발행여부</th>
					<td>
						<label><input type='radio' name='report_flag' value='' style="width: 20px" checked="checked"/>전체</label>
						<label><input type='radio' name='report_flag' value='Y' style="width: 20px"/>발행</label>
						<label><input type='radio' name='report_flag' value='N' style="width: 20px"/>미발행</label>
					</td>					
					
				
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName" />
		<input type="hidden" id="sortType" name="sortType" />
		<div id="view_grid_main">
			<table id="testSampleStateGrid"></table>
		</div>
	</form>
</div>



