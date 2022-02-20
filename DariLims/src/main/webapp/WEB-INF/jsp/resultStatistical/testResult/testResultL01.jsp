
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험결과조회
	 * 파일명 		: testResultL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.25
	 * 설  명		: 시험결과조회 화면
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
<style type="text/css">
.rNum {
	background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
	color: #2e6e9e !important;
}
</style>
<script type="text/javascript">
	var jdg_type;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		jdg_type = fnGridCommonCombo('C37', null);
		ajaxComboForm("supv_dept_cd", "", "ALL", "", 'testReultForm'); // 주관부서
		ajaxComboForm("req_type", "C23", "ALL", "EX1", 'testReultForm'); // 의뢰구분
		// 		ajaxComboForm("unit_work_cd", "", "ALL", null, 'testReultForm'); //단위업무
		ajaxUnitWorkComboForm("unit_work_cd", "ALL", 'testReultForm'); //단위업무 
		ajaxComboForm("state", "", "ALL", "", 'testReultForm'); // 진행상태
		ajaxComboForm("jdg_type", "C37", "ALL", null, 'testReultForm'); //선택값판정
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "testReultForm");

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		// 오늘날짜
		$('#testReultForm').find('#endDate').val(caldate(0));

		// 일주일 전 날짜
		$('#testReultForm').find('#startDate').val(caldate(7));

		testReultGrid('resultStatistical/selectTestReultList.lims', 'testReultForm', 'testReultGrid');
		$('#testReultGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		fnViewPage('resultStatistical/selectTestReultListPaging.lims', 'paging', $('#testReultForm').serialize());
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('testReultForm', 'testReultGrid');
		
		// 그리드 사이즈
		$(window).bind('resize', function() {
			$("#testReultGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');
	});
	
	function testReultGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '460',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : false,
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '30',
				align : 'center',
				classes : 'rNum',
				sortable : false
			}, {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '80'
			}, {
				index : 'not',
				label : '상태',
				name : 'state'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '80',
				align : 'center'
			}, {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '150'
			}, {
				label : '담당자',
				width : '80',
				align : 'center',
				name : 'real_user_nm'
			}, {
				label : '시험자',
				width : '80',
				align : 'center',
				name : 'user_nm'
			}, {
				label : '시험항목',
				name : 'test_item_nm',
				width : '100'
			}, {
				index : 'not',
				label : '기준값',
				name : 'std_val',
				width : '110'
			}, {
				index : 'not',
				label : '단위',
				name : 'unit',
				width : '110'
			}, {
				index : 'not',
				label : '표기자리',
				name : 'valid_position',
				width : '80'
			}, {
				label : '결과값',
				width : '120',
				name : 'result_val'
			}, {
				label : '성적서표기값',
				width : '100',
				name : 'report_disp_val'
			}, {
				label : '이전 결과값',
				width : '120',
				name : 'result_val_his'
			}, {
				label : '이전 성적서표기값',
				width : '120',
				name : 'report_disp_val_his' 
			}, {
				index : 'not',
				label : '등급판정',
				name : 'jdg_type_grade',
				width : '110'
			}, {
				index : 'not',
				label : '결과판정',
				name : 'jdg_type',
				width : '110'				
			}, {
				label : '적용계산식',
				name : 'formula_disp',
				width : '200'
			}, {
				label : '계산결과내역',
				name : 'formula_result_disp',
				width : '150',
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
			}, {
				label : 'att_seq',
				name : 'att_seq',
				hidden : true
			}, {
				type : 'not',
				label : 'RDMS',
				name : 'rawdata',
				sortable : false,
				width : '50',
				align : 'center',
				formatter : rawdataImageFormat,
				hidden : true
			}, {
				index : 'not',
				label : '결과유형',
				name : 'result_type',
				align : 'center',
				width : '120'
			}, {
				label : '의뢰제목',
				name : 'title',
				width : '150'
			}, {
				label : '시료접수번호',
				name : 'test_sample_seq',
				width : '80',
				align : 'center'
			}, {
				label : '단위업무코드',
				name : 'unit_work_cd',
				hidden : true
			}, {
				label : '단위업무',
				name : 'unit_work_nm',
				width : '100'
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : '시험자아이디',
				width : '80',
				name : 'tester_id',
				hidden : true
			}],
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
	
	// 페이징 이벤트(하단 >, >> 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#testReultGrid').trigger('reloadGrid');
		fnViewPage('resultStatistical/selectTestReultListPaging.lims', 'paging', $('#testReultForm').serialize()); // 하단 게시글 번호
	}	
	
	// 판정에 따른 결과값 색상 변경
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
			if (row.jdg_type == 'C37001' || row.jdg_type == 'C37003') {
				$('#' + grid).jqGrid('setCell', ids[i], 'result_val', '', cssBlue);
			} else
				$('#' + grid).jqGrid('setCell', ids[i], 'result_val', '', cssRed);
		}
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#testReultGrid').trigger('reloadGrid');
		fnViewPage('resultStatistical/selectTestReultListPaging.lims', 'paging', $('#testReultForm').serialize()); // 하단 게시글 번호
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
	
	// 시료유형 검색 팝업
	function btn_Pop_SampleChoice() {
		fnpop_sampleChoicePop("720", "500", 'testReultForm', true, 'sampleStatistics');
		fnBasicStartLoading();
	}
	
	function fnpop_callback(){
		fnBasicEndLoading();
	}
	
	// 단위업무 코드
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
	
	// 엑셀 다운로드 이벤트
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('testReultGrid');
		fn_Excel_Download(data);
	}
	
	
	function infoUser(){
		fnpop_UserInfoPop('reqItemGrid', "500", "500", 'acceptNreceit', '');
	}
	function fnpop_callback_testItemUser(dept_cd, dept_nm, user_id, user_nm, rowId){
		$("#setUser_nm").val(user_nm);
		
	}
	
	function infoUser1(){
		fnpop_UserInfoPop('reqItemGrid', "500", "500", 'acceptNreceit1', '');
	}
	function fnpop_callback_testItemUser1(dept_cd, dept_nm, user_id, user_nm, rowId){
		$("#setReal_User_nm").val(user_nm);
		
	}
	
</script>
<div id="testReultDiv">
	<form id="testReultForm" name="testReultForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						시험결과조회
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
					<th>의뢰구분</th>
					<td>
						<select name="req_type" id="req_type" style="width: 113px;"></select>
					</td>
					<th>접수일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="inputhan w80px" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
					<!-- 부장승인 -->
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
					<!-- 
					<th>주관부서</th>
					<td>
						<select name="supv_dept_cd" id="supv_dept_cd" class="w120px"></select>
					</td>
					 -->
					<th>진행상태</th>
					<td>
						<select name="state" id="state" class="w120px"></select>
					</td>
					<th>의뢰/접수번호</th>
					<td>
						<input name="test_sample_seq" type="text" class="inputhan w100px" />
					</td>
					<th>시험항목</th>
					<td>
						<input name="test_item_nm" id="test_item_nm" type="text" class="inputhan w200px" />
					</td>
				</tr>
				<tr>
					<th>적부여부</th>
					<td>
						<select name="jdg_type" id="jdg_type" class="w120px"></select>
					</td>
					<th>품목구분</th>
					<td>
						<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
					</td>
					<th>단위업무</th>
					<td colspan='3'>
						<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
					</td>
				</tr>
				<tr>
				<th>담당자</th>
					<td>
						<input name="user_nm" type="text" id="setUser_nm" class="w30px" style="width:110px "/>
						<img style="width: 16px;" src="images/common/icon_search.png" class="auth_select" onclick='infoUser();'>
					</td>	
					<th>시험자</th>
					<td colspan='4'>
						<input name="real_user_nm" type="text" id="setReal_User_nm" class="w30px" style="width:110px "/>
						<img style="width: 16px;" src="images/common/icon_search.png" class="auth_select" onclick='infoUser1();'>
						
					</td>	
				</tr>
				
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName" />
		<input type="hidden" id="sortType" name="sortType" />
		<input type="hidden" id="pageNo" name="pageNo" value="1">
		<input type="hidden" id="totalCount" name="totalCount" value="0">
		<div id="view_grid_main">
			<table id="testReultGrid"></table>
			<div id="paging"></div>
		</div>
	</form>
</div>



