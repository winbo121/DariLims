
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목관리
	 * 파일명 		: testItemL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
	 * 2016.02.04    윤상준       개선
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
	var unit;
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "testItemForm"); // 항목 대분류
		ajaxComboForm("oxide_cd", "", "ALL", "", "testItemForm"); // 산화물 표기

		grid('master/selectTestItemAllList.lims', 'testItemForm', 'testItemGrid');
		$('#testItemGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#testItemGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

		fn_Enter_Search('testItemForm', 'testItemGrid');

	});
	
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '300',
			autowidth : true,
			gridview : true,
			shrinkToFit : false,
			rowNum : 5000,
			rownumbers : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			rowList:[50,100,200],
			prmNames : {
				id : 'KEY',
				page : 'pageNum',
				rows : 'pageSize',
				sort : 'sortTarget',
				order : 'sortValue'
			},
				jsonReader : {        
				root : 'rows',        
				page : 'pageNum',        
				rowNum : 'pageSize',        
				records : 'total',        
				total : 'totalPage',        
				id : 'row_num',     
				repeatitems : true        
			},
			colModel : [ {
				label : 'test_item_cd',
				name : 'test_item_cd',
				key : true,
				search : false,
				hidden : true 
			}, {
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '200'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '200'
			}, {
				label : '항목',
				name : 'test_item_nm',
				width : '250'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '250'
			}, {
				label : '이명',
				name : 'ncknm',
				width : '150'
			}, {
				label : '약어',
				name : 'abrv',
				width : '100'
			}, {
				label : '원소의 파장',
				name : 'testitm_wave',
				width : '100'
			}, {
				label : '사용여부',
				name : 'use_flag',
				width : '250'
			}, {
				label : '최종수정일',
				width : '100',
				name : 'last_updt_dtm',
				align : 'center'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('master/selectTestItemDetail.lims', 'detailDiv', 'pageType=detail&test_item_cd=' + rowId);
				$('#btn_Save_Sub1').show();
				$('#btn_Delete_Sub1').show();
			}
		});
	}
	
	function btn_Select_Sub1_onclick() {
		$('#testItemGrid').setGridParam({page: 1});
		$('#testItemGrid').trigger('reloadGrid');
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
	}
	
	function btn_New_Sub1_onclick() {
		fnViewPage('master/selectTestItemDetail.lims', 'detailDiv', null);
		$('#btn_Save_Sub1').show();
		$('#btn_Delete_Sub1').hide();
	}

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "testItemForm"); // 항목 중분류
	}
	
	function btn_Fee_onclick(mode) {
		fnpop_testItemPop('detail', 700, 500, mode);
		fnBasicStartLoading();
	}
	
	function fnpop_callback(){		
		btn_Select_Sub1_onclick();
		fnBasicEndLoading();
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('testItemGrid');
		fn_Excel_Download(data);
	}
	
</script>
<div class="sub_purple_01 w100p">
	<form id="testItemForm" name="testItemForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					항목 
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
<!-- 					<span class="button white mlargeg auth_save" id="btn_Fee" onclick="btn_Fee_onclick(1);">
						<button type="button">수수료관리</button>
					</span> -->
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_New_Sub1" onclick="btn_New_Sub1_onclick();">
						<button type="button">추가</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>항목유형</th>
				<td>
					<select name="testitm_lclas_cd" id="testitm_lclas_cd" class="w200px" onchange="fnListLclasChange(this)"></select>
					<select name="testitm_mlsfc_cd" id="testitm_mlsfc_cd" class="w200px"></select>
				</td>
				<th>항목명</th>
				<td>
					<input name="test_item_nm" type="text" class="inputhan w200px" />
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px"/>전체</label> 
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용</label>
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" />미사용</label>
				</td>
				<th style='display:none;'>식약처기준 여부</th>
				<td style='display:none;'> 
					<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px"/>예</label>
					<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
				</td>
			</tr>
		</table>
		<input type="hidden" id="test_item_cd" name="test_item_cd">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type='hidden' id='pageNum' name='pageNum'/>
		<input type='hidden' id='pageSize' name='pageSize'/>
		<input type='hidden' id='sortTarget' name='sortTarget'/>
		<input type='hidden' id='sortValue' name='sortValue'/>
		<input type='hidden' id='oxide_cd' name='oxide_cd' />
		<div id="view_grid_main">
			<table id="testItemGrid"></table>
			<div id="testItemGridPager"></div>
		</div>
	</form>
</div>
<div id="detailDiv"></div>