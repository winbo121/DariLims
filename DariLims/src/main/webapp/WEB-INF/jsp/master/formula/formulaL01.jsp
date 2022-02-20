<%
	/***************************************************************************************
	 * 시스템명 	: 실험실정보관리시스템
	 * 업무명 		: 계산식관리
	 * 파일명 		: formulaL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2020.02.17
	 * 설  명		: 계산식등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.02.17   허태원	최초 프로그램 작성  
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
		
		ajaxComboForm("unit", "C08", "", "", "formulaForm");

		gridMain('master/selectFormulaList.lims', 'mainForm', 'gridMain');
		$('#gridMain').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('mainForm', 'gridMain');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#gridMain").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	
	function btn_New_onclick() {
		$("#detailDiv").empty();
		fnViewPage('master/selectFormulaDetail.lims', 'detailDiv', 'pageType=insert');
	}

	// 계산식조회목록
	function gridMain(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '계산식번호',
				name : 'formula_no',
				key : true,
				hidden : true
			}, {
				label : '계산식명',
				width : '150',
				name : 'formula_nm'
			}, {
				label : '계산식',
				width : '150',
				name : 'formula_disp'
			}, {
				label : '계산식 설명',
				width : '450',
				name : 'formula_desc'
			}, {
				label : '사용여부',
				width : '60',
				name : 'use_flag',
				align : 'center'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('master/selectFormulaDetail.lims', 'detailDiv', 'pageType=detail&formula_no=' + rowId);
			}
		});
	}
	
	function btn_Search_onclick(){
		$('#gridMain').trigger('reloadGrid');
	}

</script>

<form id="mainForm" name="mainForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					계산식그룹 조회
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_New" onclick="btn_New_onclick();">
						<button type="button">추가</button>
					</span>
				</td>
			</tr>
		</table>
		<!-- 조회 테이블 -->
		<table class="list_table" >
			<tr>
				<th>계산식명</th>
				<td>
					<input type="text" name="formula_nm" id="formula_nm" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용</label> 
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" />미사용</label>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="gridMain"></table>
	</div>
</form>
<div id="detailDiv"></div>
