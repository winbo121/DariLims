
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 과별단위업무실적
	 * 파일명 		: deptUnitWorkPerfL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.03.25
	 * 설  명		: 과별단위업무 실적 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.25   석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var colModel;
	var groupHeaders;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'deptUnitWorkPerfForm');
		ajaxComboForm("supv_dept_cd", "", "ALL", null, 'deptUnitWorkPerfForm');
		ajaxComboForm("req_type", "C23", "ALL", 'EX1', 'deptUnitWorkPerfForm');
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "deptUnitWorkPerfForm");

		//올해년도조회
		checkYear('ALL', new Date().getFullYear(), 'year');

		// 그리드 사이즈 
		$(window).bind('resize', function() {
			$("#deptUnitWorkPerfGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(구매목록 그리드 조회)
		fn_Enter_Search('deptUnitWorkPerfForm', 'deptUnitWorkPerfGrid');
	});

	// 실적 및 통계 그리드
	function deptUnitWorkPerfGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '431',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : colModel,
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : groupHeaders
		});

	}
	//컬럼 전환
	function columnShowHide(grid, type) {
		var arr = new Array();
		var q_arr = new Array();
		for (var i = 1; i < 13; i++) {
			var k = '';
			if (i < 10)
				k = '0' + i;
			else
				k = i;
			arr.push('a' + k);
			arr.push('b' + k);
			arr.push('c' + k);
			if (i < 5) {
				q_arr.push('qa' + k);
				q_arr.push('qb' + k);
				q_arr.push('qc' + k);
			}
		}
		switch (type) {
		case 'month':
			$('#' + grid).showCol(arr);
			$('#' + grid).hideCol(q_arr);
			break;
		default:
			$('#' + grid).hideCol(arr);
			$('#' + grid).showCol(q_arr);
			break;
		}

		$(window).bind('resize', function() {
			$("#deptUnitWorkPerfGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	}
	//시료구분 콤보박스
	function ajaxSampleComboForm(obj, form) {
		var url = 'resultStatistical/selectSampleCombo.lims';
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
				select.append("<option value=''>전체</option>");

				$(json).each(function(index, entry) {
					select.append("<option value='" + entry["sample_cd"] + "'>" + entry["sample_nm"] + "</option>");
				});
				select.trigger('change');// 강제로 이벤트 시키기
			}
		});
	}
	//조회버튼
	function btn_Select_onclick() {
		colModel = new Array();
		groupHeaders = new Array();
		colModel.push({
			label : '주관과',
			name : 'supv_dept_cd',
			width : '100',
			hidden : true
		});
		colModel.push({
			label : '주관과',
			name : 'dept_nm',
			width : '100',
			align : 'center',
			hidden : true
		});
		colModel.push({
			label : '시험구분코드',
			name : 'req_type',
			width : '80',
			hidden : true
		});
		colModel.push({
			label : '시험구분',
			name : 'req_type_nm',
			width : '150',
			align : 'center'
		});
		colModel.push({
			label : '단위업무코드',
			name : 'unit_work_cd',
			hidden : true
		});
		colModel.push({
			label : '단위업무',
			name : 'unit_work_nm',
			width : '200'
		});
		colModel.push({
			label : '시료정보코드',
			name : 'sample_cd',
			hidden : true
		});
		colModel.push({
			label : '시료정보',
			name : 'sample_nm',
			hidden : true
		});

		var type = $("#deptUnitWorkPerfForm input[type='radio']:checked").val();
		switch (type) {
		case 'month':
			colModel.push({
				label : '의뢰',
				name : 'a01',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b01',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c01',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a02',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b02',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c02',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a03',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b03',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c03',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a04',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b04',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c04',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a05',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b05',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c05',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a06',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b06',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c06',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a07',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b07',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c07',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a08',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b08',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c08',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a09',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b09',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c09',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a10',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b10',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c10',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a11',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b11',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c11',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'a12',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'b12',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'c12',
				width : '40',
				align : 'right'
			});
			groupHeaders.push({
				startColumnName : 'a01',
				numberOfColumns : 3,
				titleText : '1월'
			});
			groupHeaders.push({
				startColumnName : 'a02',
				numberOfColumns : 3,
				titleText : '2월'
			});
			groupHeaders.push({
				startColumnName : 'a03',
				numberOfColumns : 3,
				titleText : '3월'
			});
			groupHeaders.push({
				startColumnName : 'a04',
				numberOfColumns : 3,
				titleText : '4월'
			});
			groupHeaders.push({
				startColumnName : 'a05',
				numberOfColumns : 3,
				titleText : '5월'
			});
			groupHeaders.push({
				startColumnName : 'a06',
				numberOfColumns : 3,
				titleText : '6월'
			});
			groupHeaders.push({
				startColumnName : 'a07',
				numberOfColumns : 3,
				titleText : '7월'
			});
			groupHeaders.push({
				startColumnName : 'a08',
				numberOfColumns : 3,
				titleText : '8월'
			});
			groupHeaders.push({
				startColumnName : 'a09',
				numberOfColumns : 3,
				titleText : '9월'
			});
			groupHeaders.push({
				startColumnName : 'a10',
				numberOfColumns : 3,
				titleText : '10월'
			});
			groupHeaders.push({
				startColumnName : 'a11',
				numberOfColumns : 3,
				titleText : '11월'
			});
			groupHeaders.push({
				startColumnName : 'a12',
				numberOfColumns : 3,
				titleText : '12월'
			});
			break;
		default:
			colModel.push({
				label : '의뢰',
				name : 'qa01',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'qb01',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'qc01',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'qa02',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'qb02',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'qc02',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'qa03',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'qb03',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'qc03',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '의뢰',
				name : 'qa04',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '시료',
				name : 'qb04',
				width : '40',
				align : 'right'
			});
			colModel.push({
				label : '항목',
				name : 'qc04',
				width : '40',
				align : 'right'
			});
			groupHeaders.push({
				startColumnName : 'qa01',
				numberOfColumns : 3,
				titleText : '1분기'
			});
			groupHeaders.push({
				startColumnName : 'qa02',
				numberOfColumns : 3,
				titleText : '2분기'
			});
			groupHeaders.push({
				startColumnName : 'qa03',
				numberOfColumns : 3,
				titleText : '3분기'
			});
			groupHeaders.push({
				startColumnName : 'qa04',
				numberOfColumns : 3,
				titleText : '4분기'
			});
			break;
		}
		colModel.push({
			label : '의뢰',
			name : 'a_total',
			width : '40',
			align : 'right'
		});
		colModel.push({
			label : '시료',
			name : 'b_total',
			width : '40',
			align : 'right'
		});
		colModel.push({
			label : '항목',
			name : 'c_total',
			width : '40',
			align : 'right'
		});
		groupHeaders.push({
			startColumnName : 'a_total',
			numberOfColumns : 3,
			titleText : '총계'
		});
		
		$('#deptUnitWorkPerfGrid').jqGrid('GridUnload');
		deptUnitWorkPerfGrid('resultStatistical/selectDeptUnitWorkPerfList.lims', 'deptUnitWorkPerfForm', 'deptUnitWorkPerfGrid');
		//$('#deptUnitWorkPerfGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$("#deptUnitWorkPerfGrid").setGridWidth($('#view_grid_main').width(), false);
	}

	//구매년도 콤보박스
	function checkYear(type, year, id) {
		var name = id;
		if (type == 'ALL') {
			$('#' + name).append($('<option />').val('').html('전체'));
		}
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 6; i--) {
			if (year == i) {
				$('#' + name).append($('<option selected />').val(i).html(i + ' 년'));
			} else
				$('#' + name).append($('<option />').val(i).html(i + ' 년'));
		}
	}
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('deptUnitWorkPerfGrid');
		fn_Excel_Download(data);
	}
</script>

<!-- 실적 및 통계 그리드 -->
<div class="sub_purple_01 w100p" id="view_grid_main">
	<form id="deptUnitWorkPerfForm" name="deptUnitWorkPerfForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					과별단위업무실적
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
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
				<th>구분</th>
				<td>
					<input type="radio" name="type" id="type" style="margin-left: 15px; top: 1px;" class="w15" value="month" checked="checked" />
					월별
					<input type="radio" name="type" id="type" style="margin-left: 15px; top: 1px;" class="w15" value="quarter" />
					분기
				</td>
				<th>단위업무</th>
				<td>
					<select id="unit_work_cd" name="unit_work_cd" class="w200px"></select>
				</td>
				<th>시험구분</th>
				<td>
					<select id="req_type" name="req_type" class="w120px"></select>
				</td>
			</tr>
			<tr>
				<th>품목구분</th>
				<td>
					<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
				</td>
				<th>조회년도</th>
				<td colspan="5">
					<select name="year" id="year" class="w120px"></select>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<table id="deptUnitWorkPerfGrid"></table>
	</form>
</div>